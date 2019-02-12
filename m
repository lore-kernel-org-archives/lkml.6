Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D228C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A58E218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gMFu8fFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfBLLKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:10:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42875 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbfBLLKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549969889; x=1581505889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dA6aSe5XZKK9jbqPUE7aSPe08mUJ7TsRaBX9UTEfvg4=;
  b=gMFu8fFAS2d5FkYeaAKs97wA8Xp3P9EMmmZ0Koe6Sx0SQv6EkwSHOD1d
   J3OdENDFPG2ZBqEq0h9rjVeY+iTswuIrYOq+U6WyFFxMXGx3ji0EokeZl
   4d/Gz8k7aW9RYTjO1QeJfy0TtV+nlSdX9lhBi1ysDbFHTboCwUPTDTN85
   pYqclYebcjOR0HqgWJGlYevNpfjIehfYbU0PB5dUghpQQmfnhn4FgOhGo
   UbM+3XxSz3Ts7K3Jy0ulB9Y/yn7fRYRrI221a1O7C2vFVIYpRRF0Irdqq
   xeqqZ5wMcN4Ll45zLb2l/z3t5IcZINuzv/CLfSLQzQs6kVTZdcFPiPgS0
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="199201829"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 19:11:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Feb 2019 02:50:57 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Feb 2019 03:10:21 -0800
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
Subject: [v4 PATCH 3/8] RISC-V: Remove NR_CPUs check during hartid search from DT
Date:   Tue, 12 Feb 2019 03:10:07 -0800
Message-Id: <1549969812-22502-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-smp configuration, hartid can be higher that NR_CPUS.
riscv_of_processor_hartid should not be compared to hartid to NR_CPUS in
that case. Moreover, this function checks all the DT properties of a
hart node. NR_CPUS comparison seems out of place.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index d1d9bfd5..cf2fca12 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -34,10 +34,6 @@ int riscv_of_processor_hartid(struct device_node *node)
 		pr_warn("Found CPU without hart ID\n");
 		return -ENODEV;
 	}
-	if (hart >= NR_CPUS) {
-		pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
-		return -ENODEV;
-	}
 
 	if (!of_device_is_available(node)) {
 		pr_info("CPU with hartid=%d is not available\n", hart);
-- 
2.7.4

