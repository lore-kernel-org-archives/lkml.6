Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeEDN4F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:56:05 -0400
Received: from foss.arm.com ([217.140.101.70]:53662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeEDNzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:55:45 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org
Subject: [PATCH 2/3] kcov: prefault the kcov_area
Date: Fri,  4 May 2018 14:55:34 +0100
Message-Id: <20180504135535.53744-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135535.53744-1-mark.rutland@arm.com>
References: <20180504135535.53744-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On many architectures the vmalloc area is lazily faulted in upon first
access. This is problematic for KCOV, as __sanitizer_cov_trace_pc
accesses the (vmalloc'd) kcov_area, and fault handling code may be
instrumented. If an access to kcov_area faults, this will result in
mutual recursion through the fault handling code and
__sanitizer_cov_trace_pc(), eventually leading to stack corruption
and/or overflow.

We can avoid this by faulting in the kcov_area before
__sanitizer_cov_trace_pc() is permitted to access it. Once it has been
faulted in, it will remain present in the process page tables, and will
not fault again.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/kcov.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 5be9a60a959f..3b82f8e258da 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -324,6 +324,17 @@ static int kcov_close(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+static void kcov_fault_in_area(struct kcov *kcov)
+{
+	unsigned long stride = PAGE_SIZE / sizeof(unsigned long);
+	unsigned long *area = kcov->area;
+	unsigned long offset;
+
+	for (offset = 0; offset < kcov->size; offset += stride) {
+		READ_ONCE(area[offset]);
+	}
+}
+
 static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			     unsigned long arg)
 {
@@ -372,6 +383,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 #endif
 		else
 			return -EINVAL;
+		kcov_fault_in_area(kcov);
 		/* Cache in task struct for performance. */
 		t->kcov_size = kcov->size;
 		t->kcov_area = kcov->area;
-- 
2.11.0
