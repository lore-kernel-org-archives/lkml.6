Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6338BC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3739F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391840AbfAPJor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:44:47 -0500
Received: from shell.v3.sk ([90.176.6.54]:55939 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731948AbfAPJor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:44:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7BB6052853;
        Wed, 16 Jan 2019 10:44:44 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id t6xzB3nOPxrl; Wed, 16 Jan 2019 10:44:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 09BAD528F1;
        Wed, 16 Jan 2019 10:44:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XH_qDYQbu5pF; Wed, 16 Jan 2019 10:44:41 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5D77F52853;
        Wed, 16 Jan 2019 10:44:41 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
Subject: [PATCH] Input: olpc_apsp - assign priv->dev earlier
Date:   Wed, 16 Jan 2019 10:44:38 +0100
Message-Id: <20190116094438.1921667-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev field needs to be set when serio_register_port() is called,
because the open callback may use it (in the error handling path).

Cc: stable@vger.kernel.org # v4.18+
Fixes: commit af518342effd ("Input: olpc_apsp - check FIFO status on open=
(), not probe()")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/input/serio/olpc_apsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_a=
psp.c
index 0aece9777087..554f4b8228d2 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -198,6 +198,8 @@ static int olpc_apsp_probe(struct platform_device *pd=
ev)
 	if (!priv)
 		return -ENOMEM;
=20
+	priv->dev =3D &pdev->dev;
+
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base =3D devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->base)) {
@@ -261,7 +263,6 @@ static int olpc_apsp_probe(struct platform_device *pd=
ev)
 		goto err_irq;
 	}
=20
-	priv->dev =3D &pdev->dev;
 	device_init_wakeup(priv->dev, 1);
 	platform_set_drvdata(pdev, priv);
=20
--=20
2.20.1

