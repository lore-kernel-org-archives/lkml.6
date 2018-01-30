Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeA3WiY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:38:24 -0500
Received: from terminus.zytor.com ([65.50.211.136]:43495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeA3WiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:38:19 -0500
Date: Tue, 30 Jan 2018 14:33:51 -0800
From: tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-f84a56f73dddaeac1dba8045b007f742f61cd2da@git.kernel.org>
Cc: mingo@kernel.org, peterz@infradead.org, corbet@lwn.net,
        tglx@linutronix.de, keescook@chromium.org, dan.j.williams@intel.com,
        will.deacon@arm.com, mark.rutland@arm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, corbet@lwn.net, mingo@kernel.org,
        mark.rutland@arm.com, will.deacon@arm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        keescook@chromium.org, dan.j.williams@intel.com
In-Reply-To: <151727413645.33451.15878817161436755393.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727413645.33451.15878817161436755393.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] Documentation: Document array_index_nospec
Git-Commit-ID: f84a56f73dddaeac1dba8045b007f742f61cd2da
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f84a56f73dddaeac1dba8045b007f742f61cd2da
Gitweb:     https://git.kernel.org/tip/f84a56f73dddaeac1dba8045b007f742f61cd2da
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Mon, 29 Jan 2018 17:02:16 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:28 +0100

Documentation: Document array_index_nospec

Document the rationale and usage of the new array_index_nospec() helper.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: linux-arch@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: gregkh@linuxfoundation.org
Cc: kernel-hardening@lists.openwall.com
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727413645.33451.15878817161436755393.stgit@dwillia2-desk3.amr.corp.intel.com

---
 Documentation/speculation.txt | 90 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/speculation.txt b/Documentation/speculation.txt
new file mode 100644
index 0000000..e9e6cba
--- /dev/null
+++ b/Documentation/speculation.txt
@@ -0,0 +1,90 @@
+This document explains potential effects of speculation, and how undesirable
+effects can be mitigated portably using common APIs.
+
+===========
+Speculation
+===========
+
+To improve performance and minimize average latencies, many contemporary CPUs
+employ speculative execution techniques such as branch prediction, performing
+work which may be discarded at a later stage.
+
+Typically speculative execution cannot be observed from architectural state,
+such as the contents of registers. However, in some cases it is possible to
+observe its impact on microarchitectural state, such as the presence or
+absence of data in caches. Such state may form side-channels which can be
+observed to extract secret information.
+
+For example, in the presence of branch prediction, it is possible for bounds
+checks to be ignored by code which is speculatively executed. Consider the
+following code:
+
+	int load_array(int *array, unsigned int index)
+	{
+		if (index >= MAX_ARRAY_ELEMS)
+			return 0;
+		else
+			return array[index];
+	}
+
+Which, on arm64, may be compiled to an assembly sequence such as:
+
+	CMP	<index>, #MAX_ARRAY_ELEMS
+	B.LT	less
+	MOV	<returnval>, #0
+	RET
+  less:
+	LDR	<returnval>, [<array>, <index>]
+	RET
+
+It is possible that a CPU mis-predicts the conditional branch, and
+speculatively loads array[index], even if index >= MAX_ARRAY_ELEMS. This
+value will subsequently be discarded, but the speculated load may affect
+microarchitectural state which can be subsequently measured.
+
+More complex sequences involving multiple dependent memory accesses may
+result in sensitive information being leaked. Consider the following
+code, building on the prior example:
+
+	int load_dependent_arrays(int *arr1, int *arr2, int index)
+	{
+		int val1, val2,
+
+		val1 = load_array(arr1, index);
+		val2 = load_array(arr2, val1);
+
+		return val2;
+	}
+
+Under speculation, the first call to load_array() may return the value
+of an out-of-bounds address, while the second call will influence
+microarchitectural state dependent on this value. This may provide an
+arbitrary read primitive.
+
+====================================
+Mitigating speculation side-channels
+====================================
+
+The kernel provides a generic API to ensure that bounds checks are
+respected even under speculation. Architectures which are affected by
+speculation-based side-channels are expected to implement these
+primitives.
+
+The array_index_nospec() helper in <linux/nospec.h> can be used to
+prevent information from being leaked via side-channels.
+
+A call to array_index_nospec(index, size) returns a sanitized index
+value that is bounded to [0, size) even under cpu speculation
+conditions.
+
+This can be used to protect the earlier load_array() example:
+
+	int load_array(int *array, unsigned int index)
+	{
+		if (index >= MAX_ARRAY_ELEMS)
+			return 0;
+		else {
+			index = array_index_nospec(index, MAX_ARRAY_ELEMS);
+			return array[index];
+		}
+	}
