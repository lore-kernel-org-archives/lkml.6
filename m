Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeFDG7D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbeFDG7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 11/29] tools include: Adopt kernels refcount.h
Date: Mon,  4 Jun 2018 08:58:07 +0200
Message-Id: <20180604065802.606741436@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 73a9bf95ed1c05698ecabe2f28c47aedfa61b52b upstream.

To aid in catching bugs when using atomics as a reference count.

This is a trimmed down version with just what is used by tools/ at
this point.

After this, the patches submitted by Elena for tools/ doing the
conversion from atomic_ to recount_ methods can be applied and tested.

To activate it, buint perf with:

  make DEBUG=1 -C tools/perf

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-dqtxsumns9ov0l9r5x398f19@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/include/linux/refcount.h |  151 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/MANIFEST            |    1 
 2 files changed, 152 insertions(+)

--- /dev/null
+++ b/tools/include/linux/refcount.h
@@ -0,0 +1,151 @@
+#ifndef _TOOLS_LINUX_REFCOUNT_H
+#define _TOOLS_LINUX_REFCOUNT_H
+
+/*
+ * Variant of atomic_t specialized for reference counts.
+ *
+ * The interface matches the atomic_t interface (to aid in porting) but only
+ * provides the few functions one should use for reference counting.
+ *
+ * It differs in that the counter saturates at UINT_MAX and will not move once
+ * there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free issues.
+ *
+ * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
+ * and provide only what is strictly required for refcounts.
+ *
+ * The increments are fully relaxed; these will not provide ordering. The
+ * rationale is that whatever is used to obtain the object we're increasing the
+ * reference count on will provide the ordering. For locked data structures,
+ * its the lock acquire, for RCU/lockless data structures its the dependent
+ * load.
+ *
+ * Do note that inc_not_zero() provides a control dependency which will order
+ * future stores against the inc, this ensures we'll never modify the object
+ * if we did not in fact acquire a reference.
+ *
+ * The decrements will provide release order, such that all the prior loads and
+ * stores will be issued before, it also provides a control dependency, which
+ * will order us against the subsequent free().
+ *
+ * The control dependency is against the load of the cmpxchg (ll/sc) that
+ * succeeded. This means the stores aren't fully ordered, but this is fine
+ * because the 1->0 transition indicates no concurrency.
+ *
+ * Note that the allocator is responsible for ordering things between free()
+ * and alloc().
+ *
+ */
+
+#include <linux/atomic.h>
+#include <linux/kernel.h>
+
+#ifdef NDEBUG
+#define REFCOUNT_WARN(cond, str) (void)(cond)
+#define __refcount_check
+#else
+#define REFCOUNT_WARN(cond, str) BUG_ON(cond)
+#define __refcount_check	__must_check
+#endif
+
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+#define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
+
+static inline void refcount_set(refcount_t *r, unsigned int n)
+{
+	atomic_set(&r->refs, n);
+}
+
+static inline unsigned int refcount_read(const refcount_t *r)
+{
+	return atomic_read(&r->refs);
+}
+
+/*
+ * Similar to atomic_inc_not_zero(), will saturate at UINT_MAX and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller has guaranteed the
+ * object memory to be stable (RCU, etc.). It does provide a control dependency
+ * and thereby orders future stores. See the comment on top.
+ */
+static inline __refcount_check
+bool refcount_inc_not_zero(refcount_t *r)
+{
+	unsigned int old, new, val = atomic_read(&r->refs);
+
+	for (;;) {
+		new = val + 1;
+
+		if (!val)
+			return false;
+
+		if (unlikely(!new))
+			return true;
+
+		old = atomic_cmpxchg_relaxed(&r->refs, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+
+	REFCOUNT_WARN(new == UINT_MAX, "refcount_t: saturated; leaking memory.\n");
+
+	return true;
+}
+
+/*
+ * Similar to atomic_inc(), will saturate at UINT_MAX and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller already has a
+ * reference on the object, will WARN when this is not so.
+ */
+static inline void refcount_inc(refcount_t *r)
+{
+	REFCOUNT_WARN(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
+}
+
+/*
+ * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
+ * decrement when saturated at UINT_MAX.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ */
+static inline __refcount_check
+bool refcount_sub_and_test(unsigned int i, refcount_t *r)
+{
+	unsigned int old, new, val = atomic_read(&r->refs);
+
+	for (;;) {
+		if (unlikely(val == UINT_MAX))
+			return false;
+
+		new = val - i;
+		if (new > val) {
+			REFCOUNT_WARN(new > val, "refcount_t: underflow; use-after-free.\n");
+			return false;
+		}
+
+		old = atomic_cmpxchg_release(&r->refs, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+
+	return !new;
+}
+
+static inline __refcount_check
+bool refcount_dec_and_test(refcount_t *r)
+{
+	return refcount_sub_and_test(1, r);
+}
+
+
+#endif /* _ATOMIC_LINUX_REFCOUNT_H */
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -78,6 +78,7 @@ tools/include/uapi/linux/perf_event.h
 tools/include/linux/poison.h
 tools/include/linux/rbtree.h
 tools/include/linux/rbtree_augmented.h
+tools/include/linux/refcount.h
 tools/include/linux/string.h
 tools/include/linux/stringify.h
 tools/include/linux/types.h
