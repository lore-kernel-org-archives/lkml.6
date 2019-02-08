Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77AC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F05521916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JTcx/Xfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBHBwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:52:08 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13327 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfBHBvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549590697; x=1581126697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7egq28/CSCkrSFqdZR+3wqM8pX3AZ5gSH/KN6l36VFg=;
  b=JTcx/XfhYATP7VQeMY32syV9GlSffhdsQByLVR51gV6V64bF9rbUTnzr
   sl9IXHDJyPhoS0EJXMVvbYX80r4hCwko5BD1jeb6TdxEFiNuc6zqCNmE2
   9dxW5YUMOxRcQ2DVz2vjQ+ufWNlOoE9nojW9B+b0SbFrn1jvJ1Vs5HAUJ
   yQiHhISA3T9dhYxB25oEOAhNSuQiNP4jXZPiOy5TNeiz/dL3THKct2Af5
   Ax0ELcLJpjUt8L7hiUaTzdmvoATacMBH+iFmoyC8C62NUE6kN8buB9770
   57koHu3oaYBCv8glxAqBMIC7KQGNPCJekmEYyb0w4sdKmN5Ue45s5W1kZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,346,1544457600"; 
   d="scan'208";a="100752800"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2019 09:51:36 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Feb 2019 17:32:19 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2019 17:51:36 -0800
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
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [v3 PATCH 3/8] RISC-V: Remove NR_CPUs check during hartid search from DT
Date:   Thu,  7 Feb 2019 17:51:16 -0800
Message-Id: <1549590681-24125-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-smp configuration, hartid can be higher that NR_CPUS.
riscv_of_processor_hartid should not be compared to hartid to
NR_CPUS in that case. Moreover, this function checks all the
DT properties of a hart node. NR_CPUS comparison seems out of
place.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f8fa2c63..19edaeae 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -34,10 +34,6 @@ int riscv_of_processor_hartid(struct device_node *node)
 		pr_warn("Found CPU without hart ID\n");
 		return -(ENODEV);
 	}
-	if (hart >= NR_CPUS) {
-		pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
-		return -(ENODEV);
-	}
 
 	if (of_property_read_string(node, "status", &status)) {
 		pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
-- 
2.7.4

