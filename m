Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C544B20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="m6HaLnY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C544B20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbeKUWNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:13:22 -0500
Received: from mail-sender200.upb.ro ([141.85.13.200]:38932 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729525AbeKUWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:13:20 -0500
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id BE290B56006C;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id 9C292B560073;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro 9C292B560073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1542799733;
        bh=6nB+pwI71d1hh9MhycAUzgQkuCuLBlXbSC9Cfv8J7IM=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=m6HaLnY+37SKoYMSXmEOq/URcv1QHeHSbBYJPjlCXLjmsNApNHSIUDn9ftNIxa7nZ
         prjN3S0ch8UkefeAcQlAJDvrVzmvk+aKGvkkDdbEJQqdUtgOPRa0DAOQZpWNTWkFSd
         Sou71sHvpyG20+rmYMpnc7LxSElRl5+NfLoYHJXg=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jQ31SzndMltp; Wed, 21 Nov 2018 13:28:53 +0200 (EET)
Received: from asus-rog.localdomain (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id 73998B56006C;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     richard.genoud@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.co,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH 1/3] spi: at91-usart: add power management support
Date:   Wed, 21 Nov 2018 13:27:30 +0200
Message-Id: <20181121112732.15690-2-radu_nicolae.pirea@upb.ro>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements power management callback function for USART as
SPI driver.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
---
 drivers/spi/spi-at91-usart.c | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..0b07c746453d 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
=20
 #include <linux/spi/spi.h>
=20
@@ -399,6 +400,59 @@ static int at91_usart_spi_probe(struct platform_devi=
ce *pdev)
 	return ret;
 }
=20
+__maybe_unused static int at91_usart_spi_runtime_suspend(struct device *=
dev)
+{
+	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
+	struct at91_usart_spi *aus =3D spi_master_get_devdata(ctlr);
+
+	clk_disable_unprepare(aus->clk);
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+__maybe_unused static int at91_usart_spi_runtime_resume(struct device *d=
ev)
+{
+	struct spi_controller *ctrl =3D dev_get_drvdata(dev);
+	struct at91_usart_spi *aus =3D spi_master_get_devdata(ctrl);
+
+	pinctrl_pm_select_default_state(dev);
+
+	return clk_prepare_enable(aus->clk);
+}
+
+__maybe_unused static int at91_usart_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctrl =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D spi_controller_suspend(ctrl);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		at91_usart_spi_runtime_suspend(dev);
+
+	return 0;
+}
+
+__maybe_unused static int at91_usart_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctrl =3D dev_get_drvdata(dev);
+	struct at91_usart_spi *aus =3D spi_master_get_devdata(ctrl);
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		ret =3D at91_usart_spi_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	at91_usart_spi_init(aus);
+
+	return spi_controller_resume(ctrl);
+}
+
 static int at91_usart_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr =3D platform_get_drvdata(pdev);
@@ -409,6 +463,12 @@ static int at91_usart_spi_remove(struct platform_dev=
ice *pdev)
 	return 0;
 }
=20
+static const struct dev_pm_ops at91_usart_spi_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(at91_usart_spi_suspend, at91_usart_spi_resume)
+	SET_RUNTIME_PM_OPS(at91_usart_spi_runtime_suspend,
+			   at91_usart_spi_runtime_resume, NULL)
+};
+
 static const struct of_device_id at91_usart_spi_dt_ids[] =3D {
 	{ .compatible =3D "microchip,at91sam9g45-usart-spi"},
 	{ /* sentinel */}
@@ -419,6 +479,7 @@ MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
 static struct platform_driver at91_usart_spi_driver =3D {
 	.driver =3D {
 		.name =3D "at91_usart_spi",
+		.pm =3D &at91_usart_spi_pm_ops,
 	},
 	.probe =3D at91_usart_spi_probe,
 	.remove =3D at91_usart_spi_remove,
--=20
2.19.1

