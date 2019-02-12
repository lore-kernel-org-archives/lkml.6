Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5B6C282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3E2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fQ+yGJcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfBLLKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:10:36 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42874 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbfBLLKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549969889; x=1581505889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BXPJoBB0Kgm4J4WvDGeNZxKZbFFkYo9XWYKOd8CvDv0=;
  b=fQ+yGJcVu0acRfVujvJ+qeJkaUSQ1Dm1hTxvbDO5Z+7aoyLMZ5XwfKvK
   7DYyiJIX3bvT/I3iqimFpz6suontY1Xca2pRAraCIrG4Bxb7mgfMp4XBS
   +9sbullD18We2n/pOOG1PB2V6XtbWVUf/vj9KgyPnKgAqi4WwVEf0ZDS6
   Mk65vUM1Cfs4VwEWRyFS8MiHheRHp/9pxldnISnEr3T9nuopvUqeVjCVx
   4H6fDaG6xPxmKVGm6o+iSIXQjTimhzG2mDElqgtkjNm0eSAcSllK0eyA7
   TEFlQyRhV2ajUhN67dX+d3rJIj+GEvoUXDP85ago/mWl62qFJwdmVN1iI
   g==;
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="199201831"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 19:11:11 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Feb 2019 02:50:57 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Feb 2019 03:10:22 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v4 PATCH 4/8] RISC-V: Allow hartid-to-cpuid function to fail.
Date:   Tue, 12 Feb 2019 03:10:08 -0800
Message-Id: <1549969812-22502-5-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
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

