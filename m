Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeEAUz3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:55:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:38485 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbeEAUz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:55:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,352,1520924400";
   d="scan'208";a="195917648"
Subject: [PATCH 4/6] x86, memcpy_mcsafe: define copy_to_iter_mcsafe()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com
Date: Tue, 01 May 2018 13:45:29 -0700
Message-ID: <152520752986.36522.6608981678390805141.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the updated memcpy_mcsafe() implementation to define
copy_user_mcsafe() and copy_to_iter_mcsafe(). The most significant
difference from typical copy_to_iter() is that the ITER_KVEC and
ITER_BVEC iterator types can fail to complete a full transfer.

Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/uaccess_64.h |   11 +++++++
 include/linux/uio.h               |   10 ++++++
 lib/iov_iter.c                    |   59 +++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c064a77e8fcb..e0e2cbdf3e2b 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -47,6 +47,17 @@ copy_user_generic(void *to, const void *from, unsigned len)
 }
 
 static __always_inline __must_check unsigned long
+copy_to_user_mcsafe(void *to, const void *from, unsigned len)
+{
+	unsigned long ret;
+
+	__uaccess_begin();
+	ret = memcpy_mcsafe(to, from, len);
+	__uaccess_end();
+	return ret;
+}
+
+static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 {
 	int ret = 0;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index e67e12adb136..0f9923321983 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -92,6 +92,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
+size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
 bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
@@ -107,6 +108,15 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 }
 
 static __always_inline __must_check
+size_t copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (unlikely(!check_copy_size(addr, bytes, true)))
+		return 0;
+	else
+		return _copy_to_iter_mcsafe(addr, bytes, i);
+}
+
+static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(!check_copy_size(addr, bytes, false)))
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 970212670b6a..e1a52c49e79c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -139,6 +139,15 @@ static int copyout(void __user *to, const void *from, size_t n)
 	return n;
 }
 
+static int copyout_mcsafe(void __user *to, const void *from, size_t n)
+{
+	if (access_ok(VERIFY_WRITE, to, n)) {
+		kasan_check_read(from, n);
+		n = copy_to_user_mcsafe((__force void *) to, from, n);
+	}
+	return n;
+}
+
 static int copyin(void *to, const void __user *from, size_t n)
 {
 	if (access_ok(VERIFY_READ, from, n)) {
@@ -461,6 +470,19 @@ static void memcpy_to_page(struct page *page, size_t offset, const char *from, s
 	kunmap_atomic(to);
 }
 
+static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
+		const char *from, size_t len)
+{
+	unsigned long ret;
+	char *to;
+
+	to = kmap_atomic(page);
+	ret = memcpy_mcsafe(to + offset, from, len);
+	kunmap_atomic(to);
+
+	return ret;
+}
+
 static void memzero_page(struct page *page, size_t offset, size_t len)
 {
 	char *addr = kmap_atomic(page);
@@ -573,6 +595,43 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(_copy_to_iter);
 
+size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	const char *from = addr;
+	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
+
+	if (unlikely(i->type & ITER_PIPE)) {
+		WARN_ON(1);
+		return 0;
+	}
+	if (iter_is_iovec(i))
+		might_fault();
+	iterate_and_advance(i, bytes, v,
+		copyout_mcsafe(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
+		({
+		rem = memcpy_mcsafe_to_page(v.bv_page, v.bv_offset,
+                               (from += v.bv_len) - v.bv_len, v.bv_len);
+		if (rem) {
+			curr_addr = (unsigned long) from;
+			bytes = curr_addr - s_addr - rem;
+			return bytes;
+		}
+		}),
+		({
+		rem = memcpy_mcsafe(v.iov_base, (from += v.iov_len) - v.iov_len,
+				v.iov_len);
+		if (rem) {
+			curr_addr = (unsigned long) from;
+			bytes = curr_addr - s_addr - rem;
+			return bytes;
+		}
+		})
+	)
+
+	return bytes;
+}
+EXPORT_SYMBOL(_copy_to_iter_mcsafe);
+
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
