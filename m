Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723AEC64EBA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7CA20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LSlk9JBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7CA20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeJCCAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:00:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61573 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeJCCAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507711; x=1570043711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YFrlU3OmqRZtyf8NLoWNxfiOD2AxshO648ddxoKLstQ=;
  b=LSlk9JBwZGUs/z9/TiQAOKviOZeh0rY7lYpcI5grNRla67Yk+a74aUPS
   FnpwM6lSLnFtv/0fs2BO5MzURMY6nyZ6ZDHmPqmyQ24m0HOVNvHSm5UJ1
   W5P5T5pmLwgAoJolKvbx07E7/3F00gxO/4+32JHHg+XZmh1xdpJeO4nfz
   ZofTLcBvB9jJblbCRku/Cb2h041ddwBSO4bI+iej3K+lHVKD0IAIYtY8b
   D4bD5W+lYPb1HBxlp67P7wd1r2xkYHYso4+YRP5+pMJdjJdgIL6NnlJ9C
   XpbqiG8gYaacW2/RUHpLceKLkMd10stjJiQvC58HiMONS9RzShAcB/MS+
   w==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="91076749"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:09 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:51 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:10 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 09/14] RISC-V: Use mmgrab()
Date:   Tue,  2 Oct 2018 12:15:02 -0700
Message-Id: <1538507707-22299-10-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
References: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

commit f1f1007644ff ("mm: add new mmgrab() helper") added a
helper that we missed out on.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smpboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 4a232600..17e74831 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sched/mm.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -101,7 +102,7 @@ asmlinkage void __init smp_callin(void)
 	struct mm_struct *mm = &init_mm;
 
 	/* All kernel threads share the same mm context.  */
-	atomic_inc(&mm->mm_count);
+	mmgrab(mm);
 	current->active_mm = mm;
 
 	trap_init();
-- 
2.7.4

