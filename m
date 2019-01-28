Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852B32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfA1R3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:29:46 -0500
Received: from shell.v3.sk ([90.176.6.54]:52605 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfA1P7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:59:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4EF1ACCC86;
        Mon, 28 Jan 2019 16:59:41 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BIcptqx8GDtg; Mon, 28 Jan 2019 16:59:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 69D7FCCC89;
        Mon, 28 Jan 2019 16:59:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M_1tj4jbHfF8; Mon, 28 Jan 2019 16:59:38 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9BC70CCC86;
        Mon, 28 Jan 2019 16:59:37 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, stable@kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v5] irqchip/mmp: only touch the PJ4 & FIQ bits on enable/disable
Date:   Mon, 28 Jan 2019 16:59:35 +0100
Message-Id: <20190128155935.15479-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resetting the bit 4 disables the interrupt delivery to the "secure
processor" core. This breaks the keyboard on a OLPC XO 1.75 laptop,
where the firmware running on the "secure processor" bit-bangs the
PS/2 protocol over the GPIO lines.

It is not clear what the rest of the bits are and Marvel was unhelpful
when asked for documentation. Aside from the SP bit, there are probably
priority bits.

Leaving the unknown bits as the firmware set them up seems to be a wiser
course of action compared to just turning them off.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v4:
- Remove unused ICU_INT_ROUTE_SP_IRQ define
- Try to further clarify the commit message

Changes since v3:
- Use #defined instead of integer literals

Changes since v2:
- Correct subsystem maintainers on Cc (irqchip)

Changes since v1:
- Adjusted wording & ack from Pavel
---
 drivers/irqchip/irq-mmp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 37a54797a137..fac8f1365f76 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -34,6 +34,9 @@
 #define SEL_INT_PENDING		(1 << 6)
 #define SEL_INT_NUM_MASK	0x3f
=20
+#define MMP2_ICU_INT_ROUTE_PJ4_IRQ	(1 << 5)
+#define MMP2_ICU_INT_ROUTE_PJ4_FIQ	(1 << 6)
+
 struct icu_chip_data {
 	int			nr_irqs;
 	unsigned int		virq_base;
@@ -190,7 +193,8 @@ static const struct mmp_intc_conf mmp_conf =3D {
 static const struct mmp_intc_conf mmp2_conf =3D {
 	.conf_enable	=3D 0x20,
 	.conf_disable	=3D 0x0,
-	.conf_mask	=3D 0x7f,
+	.conf_mask	=3D MMP2_ICU_INT_ROUTE_PJ4_IRQ |
+			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
 };
=20
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
--=20
2.20.1

