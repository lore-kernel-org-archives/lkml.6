Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66392C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388A520864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388A520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeK2E4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:56:32 -0500
Received: from shell.v3.sk ([90.176.6.54]:39387 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729429AbeK2E4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:56:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 28241999DE;
        Wed, 28 Nov 2018 18:54:03 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6_Cd3_dyJWBx; Wed, 28 Nov 2018 18:53:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3D2D6999C5;
        Wed, 28 Nov 2018 18:53:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ysa8GWDGdrcW; Wed, 28 Nov 2018 18:53:36 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8D02799B07;
        Wed, 28 Nov 2018 18:53:31 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 12/20] irqchip/mmp: do not use of_address_to_resource() to get mux regs
Date:   Wed, 28 Nov 2018 18:53:16 +0100
Message-Id: <20181128175324.163202-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
are offsets from intc's base, not addresses on the parent bus. At this
point it probably can't be fixed.

On an OLPC XO-1.75 machine, the muxes are children of the intc, not the
axi bus, and thus of_address_to_resource() won't work. We should treat
the values as mere integers as opposed to bus addresses.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
Changes since v3:
- Added this patch

 drivers/irqchip/irq-mmp.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 1ed38f9f1d0a..e34b57f006e3 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -423,9 +423,9 @@ IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_=
init);
 static int __init mmp2_mux_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
-	struct resource res;
 	int i, ret, irq, j =3D 0;
 	u32 nr_irqs, mfp_irq;
+	u32 reg[4];
=20
 	if (!parent)
 		return -ENODEV;
@@ -437,18 +437,13 @@ static int __init mmp2_mux_of_init(struct device_no=
de *node,
 		pr_err("Not found mrvl,intc-nr-irqs property\n");
 		return -EINVAL;
 	}
-	ret =3D of_address_to_resource(node, 0, &res);
+	ret =3D of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
 	if (ret < 0) {
 		pr_err("Not found reg property\n");
 		return -EINVAL;
 	}
-	icu_data[i].reg_status =3D mmp_icu_base + res.start;
-	ret =3D of_address_to_resource(node, 1, &res);
-	if (ret < 0) {
-		pr_err("Not found reg property\n");
-		return -EINVAL;
-	}
-	icu_data[i].reg_mask =3D mmp_icu_base + res.start;
+	icu_data[i].reg_status =3D mmp_icu_base + reg[0];
+	icu_data[i].reg_mask =3D mmp_icu_base + reg[2];
 	icu_data[i].cascade_irq =3D irq_of_parse_and_map(node, 0);
 	if (!icu_data[i].cascade_irq)
 		return -EINVAL;
--=20
2.19.1

