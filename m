Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932419AbeD0JJx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:09:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932282AbeD0JJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:09:51 -0400
X-Mailbox-Line: From dyoung@redhat.com Fri Apr 27 17:00:45 2018
Message-Id: <20180427090045.532014306@redhat.com>
User-Agent: quilt/0.65
Date: Fri, 27 Apr 2018 17:00:37 +0800
From: dyoung@redhat.com
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, yinghai@kernel.org, akpm@linux-foundation.org,
        dyoung@redhat.com, vgoyal@redhat.com
Subject: [PATCH 1/2] kdump/x86: crashkernel=X try to reserve below 896M first then below 4G and MAXMEM
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x86-kdump-crashkernel-X-try-to-reserve-below-896M-fi.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now crashkernel=X will fail if there's not enough memory at low region
(below 896M) when trying to reserve large memory size.  One can use
crashkernel=xM,high to reserve it at high region (>4G) but it is more
convinient to improve crashkernel=X to:

 - First try to reserve X below 896M (for being compatible with old
   kexec-tools).
 - If fails, try to reserve X below 4G (swiotlb need to stay below 4G).
 - If fails, try to reserve X from MAXMEM top down.

It's more transparent and user-friendly.

If crashkernel is large and the reserved is beyond 896M, old kexec-tools
is not compatible with new kernel because old kexec-tools can not load
kernel at high memory region, there was an old discussion below:
https://lkml.org/lkml/2013/10/15/601

But actually the behavior is consistent during my test. Suppose
old kernel fail to reserve memory at low areas, kdump does not
work because no meory reserved. With this patch, suppose new kernel
successfully reserved memory at high areas, old kexec-tools still fail
to load kdump kernel (tested 2.0.2), so it is acceptable, no need to
worry about the compatibility.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/setup.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- linux-x86.orig/arch/x86/kernel/setup.c
+++ linux-x86/arch/x86/kernel/setup.c
@@ -545,6 +545,22 @@ static void __init reserve_crashkernel(v
 						    high ? CRASH_ADDR_HIGH_MAX
 							 : CRASH_ADDR_LOW_MAX,
 						    crash_size, CRASH_ALIGN);
+#ifdef CONFIG_X86_64
+		/*
+		 * crashkernel=X reserve below 896M fails? Try below 4G
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						(1ULL << 32),
+						crash_size, CRASH_ALIGN);
+		/*
+		 * crashkernel=X reserve below 4G fails? Try MAXMEM
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX,
+						crash_size, CRASH_ALIGN);
+#endif
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
