Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08222218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550455514;
	bh=/mGFNJbtGmJTSdDdggZEk02tpiC75z3uSI06iya6mEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=djwTskJdw1+bL/5MoqavjnFfYK5jquj2Z1VwnLhg08XGRQbMeYh1k0vNWxq+zfja9
	 1EZ9U0yFR8aLj/I59E3W/0c4Klj3BtHP2PrlBwVlq2Zp2zQWF3cQIM3buWyvdgXfN8
	 HB1+gZAFFuOocWyprB2BlNFRbyEcX0UEiMnmNmLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfBRCFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbfBRCFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:05:08 -0500
Received: from localhost.localdomain (unknown [122.234.57.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAA79218E0;
        Mon, 18 Feb 2019 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550455508;
        bh=/mGFNJbtGmJTSdDdggZEk02tpiC75z3uSI06iya6mEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enfpsdtsIPBVs91OSKArcDLxPzh3B7ED6cgZJgZ8DsU9n7uuyIGkyx025Y/zvCvUk
         Pm8hTdb1NW78UwkgcpW5lQ/CJ/dSEw4eFMuFcncY/JHEPPA9nwaDa+Yd3eZj1B0sRX
         r+pNl6JaugIAAI7WbO2nQJYz7wbXS2v/GgWT4LcQ=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 7/7] irqchip/csky: Add support-vector-irq for apb-intc
Date:   Mon, 18 Feb 2019 10:04:43 +0800
Message-Id: <1550455483-11710-7-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550455483-11710-1-git-send-email-guoren@kernel.org>
References: <1550455483-11710-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Some socs don't provide pending registers, so we must make the intc
working at vector mode.
Add csky,support-vector-irq in dts.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-apb-intc.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index ae4c59b..14ef206 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -302,10 +302,17 @@ static void ck_irq_handler(struct pt_regs *regs)
 		pr_err("%s: none irq pending!\n", __func__);
 }
 
+static void ck_vec_irq_handler(struct pt_regs *regs)
+{
+	unsigned long vector = (mfcr("psr") >> 16) & 0xff;
+
+	handle_domain_irq(root_domain, vector - 32, regs);
+}
+
 static int __init
 ck_intc_init(struct device_node *node, struct device_node *parent)
 {
-	int ret;
+	int ret, i;
 
 	ret = ck_intc_init_comm(node, parent);
 	if (ret)
@@ -323,7 +330,16 @@ ck_intc_init(struct device_node *node, struct device_node *parent)
 
 	setup_irq_channel(0x00010203, reg_base + CK_INTC_SOURCE);
 
-	set_handle_irq(ck_irq_handler);
+	if (of_find_property(node, "csky,support-vector-irq", NULL)) {
+		set_handle_irq(ck_vec_irq_handler);
+
+		for (i = 32; i < 128; i++)
+			VEC_INIT(i, csky_irq);
+
+		writel(0, reg_base + CK_INTC_ICR);
+	} else {
+		set_handle_irq(ck_irq_handler);
+	}
 
 	return 0;
 }
-- 
2.7.4

