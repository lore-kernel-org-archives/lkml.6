Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63362C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E10020989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbeLSR2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:28:38 -0500
Received: from shell.v3.sk ([90.176.6.54]:51047 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbeLSR2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:28:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5F13C68763;
        Wed, 19 Dec 2018 18:28:34 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HgWkK39FuToD; Wed, 19 Dec 2018 18:28:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B7E6668797;
        Wed, 19 Dec 2018 18:28:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p4-em-YuJTkv; Wed, 19 Dec 2018 18:28:29 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9771D68763;
        Wed, 19 Dec 2018 18:28:29 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3] irqchip/mmp: only touch the PJ4 & FIQ bits on enable/disable
Date:   Wed, 19 Dec 2018 18:28:22 +0100
Message-Id: <20181219172822.18349-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an OLPC XO 1.75 machine, the "security processor" handles the GPIO 71
and 72 interrupts. Don't reset the "route to SP" bit (4).

I'm just assuming the bit 4 is the "route to SP" bit -- it fixes the
SP-based keyboard for me and <mach-mmp/regs-icu.h> defines
ICU_INT_ROUTE_SP_IRQ to be 1 << 4. When asked for a data sheet, Marvell
was not helpful.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Correct subsystem maintainers on Cc (irqchip)

Changes since v1:
- Adjusted wording & ack from Pavel

 drivers/irqchip/irq-mmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 25f32e1d7764..1ed38f9f1d0a 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -190,7 +190,7 @@ static const struct mmp_intc_conf mmp_conf =3D {
 static const struct mmp_intc_conf mmp2_conf =3D {
 	.conf_enable	=3D 0x20,
 	.conf_disable	=3D 0x0,
-	.conf_mask	=3D 0x7f,
+	.conf_mask	=3D 0x60,
 };
=20
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
--=20
2.19.2

