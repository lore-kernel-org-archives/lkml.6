Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4720C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A230120870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764725;
	bh=2PgrfES4YUnKgJPx4YNFcpfR+aGLQ2K4WjEZhAwCpZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4WeaEU0iqkx9JhofRL0RfGXQjyYbfkAjC+gokQyeh8E3u9ogsc9ue3tiaOtqRkOc
	 g1wuCVdWrxWd0kng0NSxmQDxL9EzdIpSH17bCaCeCOPjxNW5bCTX+h5h8Qjy8RatD6
	 33Bs94kwN5GebrWZwoh9kPZf2mqrP2sIM8RYKEhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfA2MZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbfA2MZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:25:22 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942122087E;
        Tue, 29 Jan 2019 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764721;
        bh=2PgrfES4YUnKgJPx4YNFcpfR+aGLQ2K4WjEZhAwCpZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qcby8E0k0A+jrP3PaQc/9UqaZTTb2wkOqazGabE5qf4fg9gCLq43vJi4wzp4D3co+
         wRHc3qRSVsejkyBvzIwx7gtsp4ia8Qp+u4l6133eLnGa5ClvuXm0qtyh1eMH+BP3da
         CCOOIHCLb/pR3Bumoxl7E+tPVpka1gO19emDjUbo=
From:   guoren@kernel.org
To:     arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 10/10] irqchip/csky: Add support-vector-irq for apb-intc
Date:   Tue, 29 Jan 2019 20:24:29 +0800
Message-Id: <1548764669-16656-10-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Some socs don't provide pending registers, so we must make the interrupt
controller working at vector mode. Add csky,support-vector-irq to
support this mode in dts.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
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

