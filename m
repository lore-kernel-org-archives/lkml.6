Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7420877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB7420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeJEEY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:24:29 -0400
Received: from shell.v3.sk ([90.176.6.54]:37145 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbeJEEY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:24:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5E23ABC4A2;
        Thu,  4 Oct 2018 23:29:12 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oxBF065sA8i8; Thu,  4 Oct 2018 23:29:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6C6DFBC4A3;
        Thu,  4 Oct 2018 23:29:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wIHkBRRj8D_m; Thu,  4 Oct 2018 23:29:08 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A3AB1BC4A2;
        Thu,  4 Oct 2018 23:29:08 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
Subject: [PATCH] [media] ov7670: make "xclk" clock optional
Date:   Thu,  4 Oct 2018 23:29:03 +0200
Message-Id: <20181004212903.364064-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the "xclk" clock was added, it was made mandatory. This broke the
driver on an OLPC plaform which doesn't know such clock. Make it
optional.

Tested on a OLPC XO-1 laptop.

Cc: stable@vger.kernel.org # 4.11+
Fixes: 0a024d634cee ("[media] ov7670: get xclk")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/media/i2c/ov7670.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index 31bf577b0bd3..64d1402882c8 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -1808,17 +1808,24 @@ static int ov7670_probe(struct i2c_client *client=
,
 			info->pclk_hb_disable =3D true;
 	}
=20
-	info->clk =3D devm_clk_get(&client->dev, "xclk");
-	if (IS_ERR(info->clk))
-		return PTR_ERR(info->clk);
-	ret =3D clk_prepare_enable(info->clk);
-	if (ret)
-		return ret;
+	info->clk =3D devm_clk_get(&client->dev, "xclk"); /* optional */
+	if (IS_ERR(info->clk)) {
+		ret =3D PTR_ERR(info->clk);
+		if (ret =3D=3D -ENOENT)
+			info->clk =3D NULL;
+		else
+			return ret;
+	}
+	if (info->clk) {
+		ret =3D clk_prepare_enable(info->clk);
+		if (ret)
+			return ret;
=20
-	info->clock_speed =3D clk_get_rate(info->clk) / 1000000;
-	if (info->clock_speed < 10 || info->clock_speed > 48) {
-		ret =3D -EINVAL;
-		goto clk_disable;
+		info->clock_speed =3D clk_get_rate(info->clk) / 1000000;
+		if (info->clock_speed < 10 || info->clock_speed > 48) {
+			ret =3D -EINVAL;
+			goto clk_disable;
+		}
 	}
=20
 	ret =3D ov7670_init_gpio(client, info);
--=20
2.19.0

