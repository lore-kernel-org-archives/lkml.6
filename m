Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qlC3DT+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfBVTmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:42:03 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9380 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfBVTlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550864505; x=1582400505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BXPJoBB0Kgm4J4WvDGeNZxKZbFFkYo9XWYKOd8CvDv0=;
  b=qlC3DT+LrLa1cBcgwtWMmF3fX5AYfwYrJClz7lbN/S0wQb+/GqARS2EL
   BKkBMrHNAHLueK/ivY/8LA288EWvYnmPWSMwTMY/TNUNuCZDI/rNGtRv1
   2bM2R/Boq70V92LFlpKJNQ4oPjUavvKwSf7EcEU2PiWDUA3syPHRiUrol
   ZeAq1u355nidTr+c4UtIaLj6BZY1Dy3XzExep1Q9hIXCO8MMLBEmKZ3Jh
   SqZvvJppHbY96Aa+Z6/PcHTaR40xrsm76AGyBPhnUznCh8QoU6+6S4Mab
   chQXh7Tlfk05wGPhgKcjqYvLgWv9Kl0g8jRTOEghKkXx71A6U620WIu2J
   g==;
X-IronPort-AV: E=Sophos;i="5.58,400,1544457600"; 
   d="scan'208";a="103727137"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2019 03:41:45 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 22 Feb 2019 11:22:04 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2019 11:41:45 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v6 PATCH 4/6] RISC-V: Allow hartid-to-cpuid function to fail.
Date:   Fri, 22 Feb 2019 11:41:38 -0800
Message-Id: <1550864500-13652-5-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550864500-13652-1-git-send-email-atish.patra@wdc.com>
References: <1550864500-13652-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is perfectly okay to call riscv_hartid_to_cpuid for a hartid that is
not mapped with an CPU id. It can happen if the calling functions
retrieves the hartid from DT.  However, that hartid was never brought
online by the firmware or kernel for any reasons.

No need to BUG() in the above case. A negative error return is
sufficient and the calling function should check for the return value
always.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b69883c6..ca99f0fb 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -60,7 +60,6 @@ int riscv_hartid_to_cpuid(int hartid)
 			return i;
 
 	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
-	BUG();
 	return i;
 }
 
-- 
2.7.4

