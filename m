Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73DCC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1CB2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1CB2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeKKR7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 12:59:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeKKR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 12:59:00 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gLkpm-00072n-Kp; Sun, 11 Nov 2018 09:11:06 +0100
Subject: [GIT pull] core fixes for 4.20
Message-ID: <154192381794.5458.5498732290895334242.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Date:   Sun, 11 Nov 2018 09:11:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

A couple of fixlets for the core:

  - Kernel doc function documentation fixes
  - Missing prototypes for weak watchdog functions

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      resource/docs: Complete kernel-doc style function documentation

Mathieu Malaterre (1):
      watchdog/core: Add missing prototypes for weak functions

Randy Dunlap (1):
      resource/docs: Fix new kernel-doc warnings


 include/linux/nmi.h |  2 ++
 kernel/resource.c   | 19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 08f9247e9827..9003e29cde46 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -119,6 +119,8 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
+int watchdog_nmi_enable(unsigned int cpu);
+void watchdog_nmi_disable(unsigned int cpu);
 
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
diff --git a/kernel/resource.c b/kernel/resource.c
index b3a3a1fc499e..b0fbf685c77a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -319,16 +319,23 @@ int release_resource(struct resource *old)
 EXPORT_SYMBOL(release_resource);
 
 /**
- * Finds the lowest iomem resource that covers part of [start..end].  The
- * caller must specify start, end, flags, and desc (which may be
+ * Finds the lowest iomem resource that covers part of [@start..@end].  The
+ * caller must specify @start, @end, @flags, and @desc (which may be
  * IORES_DESC_NONE).
  *
- * If a resource is found, returns 0 and *res is overwritten with the part
- * of the resource that's within [start..end]; if none is found, returns
- * -1.
+ * If a resource is found, returns 0 and @*res is overwritten with the part
+ * of the resource that's within [@start..@end]; if none is found, returns
+ * -1 or -EINVAL for other invalid parameters.
  *
  * This function walks the whole tree and not just first level children
  * unless @first_lvl is true.
+ *
+ * @start:	start address of the resource searched for
+ * @end:	end address of same resource
+ * @flags:	flags which the resource must have
+ * @desc:	descriptor the resource must have
+ * @first_lvl:	walk only the first level children, if set
+ * @res:	return ptr, if resource found
  */
 static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
@@ -399,6 +406,8 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
  * @flags: I/O resource flags
  * @start: start addr
  * @end: end addr
+ * @arg: function argument for the callback @func
+ * @func: callback function that is called for each qualifying resource area
  *
  * NOTE: For a new descriptor search, define a new IORES_DESC in
  * <linux/ioport.h> and set it in 'desc' of a target resource entry.

