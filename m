Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D259C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B05221916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IBf7WKps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBHBvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:51:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13327 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfBHBvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549590698; x=1581126698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yFxyFB1JVE6e5EMBaqk5nHsWdldjjgWU0zDphOBw+f8=;
  b=IBf7WKpsyRS1Xc/frW0W6c+9LHK4GVcRkqMlkNPPE/cbiyBfKZJaR0xf
   zCwPE8g5ABWJ6CAajTLUBmryp7hDFmqtQrulRpq/TKs1aU16Uqcrw6seD
   rjRiAG9pr50S7SPILEj91PEAtp21DpWqvHYRur05cxdZU+YDU2r+I/zH/
   fw7BsvzgIujfEI84ba0b9xxnl8Ko1nfFw0DYMJGExLj46tEP2jpPxHYj0
   XFcy/6c8Drna6rHb1I6KuJqSBlSDCGqfMYKfh4k4nrPeOOVPhybIasCA0
   g59V87Rd161cYIJ/3XiONsdmYlN2ZHOOMIdqJG/LQmOOMGC6MOkRyPeCG
   A==;
X-IronPort-AV: E=Sophos;i="5.58,346,1544457600"; 
   d="scan'208";a="100752820"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2019 09:51:38 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Feb 2019 17:32:21 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2019 17:51:37 -0800
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
Subject: [v3 PATCH 7/8] irqchip/irq-sifive-plic:: Check and continue in case of an invalid cpuid.
Date:   Thu,  7 Feb 2019 17:51:20 -0800
Message-Id: <1549590681-24125-8-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv_hartid_to_cpuid can return invalid cpuid for a hart
that is present in DT but was never brought up.

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

