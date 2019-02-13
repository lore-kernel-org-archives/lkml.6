Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6440C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82A9222AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VVxUIGPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394598AbfBMUS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:18:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65229 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394565AbfBMUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550089102; x=1581625102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8ACS64L8kLVdF8msWr97l0gsAFThAeL/KOxtN4a6b6E=;
  b=VVxUIGPnrPsTshRj2d39qcXvB8IUX9kdL1ZMD5cPZsKNOcCGyReuq97Z
   wbPGBVjJTV4AyrPlWj5dmbEoUL08aJzKiORZS8LH5zr9HhkXafg52y+V6
   mE/ly+kjyrNCZlLEndNH4ZNqg3J8vvo5ui27S6RQ78Ou7EGyyjdl729yE
   1Gy+A9BP1r49AXi8fxep25y+QlGcDUZykzTyGU/GaHug4reHSkVoCDJcS
   SvfG51aJvg0wzZqdBf6aBzq7NSq6XkC7waJ4UrBkeDEaqd5NH0C9im4SK
   u/H3EtBrqylJw80/ZROdOz5FW7DkIBCP2NJIF8aDXtnxbPMHiVWLehqB4
   w==;
X-IronPort-AV: E=Sophos;i="5.58,366,1544457600"; 
   d="scan'208";a="106167289"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 04:18:21 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Feb 2019 11:58:56 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2019 12:18:22 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v5 PATCH 7/8] irqchip/irq-sifive-plic: Check and continue in case of an invalid cpuid.
Date:   Wed, 13 Feb 2019 12:18:11 -0800
Message-Id: <1550089092-28783-8-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
References: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv_hartid_to_cpuid can return invalid cpuid for a hart that is
present in DT but was never brought up.

Print the appropriate warning message and continue.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/irq-sifive-plic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 357e9daf..254ecd76 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -237,6 +237,11 @@ static int __init plic_init(struct device_node *node,
 		}
 
 		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("Invalid cpuid for context %d\n", i);
+			continue;
+		}
+
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		handler->present = true;
 		handler->ctxid = i;
-- 
2.7.4

