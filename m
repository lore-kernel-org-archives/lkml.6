Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F41C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC66206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eEPDgjS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfAHJi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:38:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8878 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfAHJit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546940328; x=1578476328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bw1/Vq2gne9LAKNuyEBhQX+XTh+Fz0MdGc7HYnZ0izk=;
  b=eEPDgjS7mPcdMJtMOFXdfxbV5sYdEoysnHYQNYU5hMsS/PtpKmQOHOva
   LhEkFHz+maHoTJhr9DsTDWftleNIUWHs6klcT9L+M9+kAjnjNyfhDf3Xd
   4kzteiD6Fvjh42newv6wYYWY+tUkfDLW1xfIlOvkCzlBklwqOXTRrUfWU
   xEpmaQAGgb9B9G3qeqWtRe8yWKID+NRPCltuLSF02tztTXm6j9HsTDOrb
   rqQL+NKw2BDYGbOwTB2cdO2v7U2wd00zcSzc4c7LIUCZsRKr+z9mXSZH7
   IUOMHFxbMYINpiwPek2Fizmq1a7/qfu2VXvpOXUAbDuBkEIQ2W11yaiOm
   A==;
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="99458414"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2019 17:38:48 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 01:18:53 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2019 01:38:47 -0800
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
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v2 7/8] RISC-V: Check and continue in case of an invalid cpuid.
Date:   Tue,  8 Jan 2019 01:38:37 -0800
Message-Id: <1546940318-9752-8-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv_hartid_to_cpuid can return invalid cpuid for a hart
that is present in DT but was never brought up.

Print the appropriate warning message and continue.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
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

