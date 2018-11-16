Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B81C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8B320858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8B320858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbeKQCiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:38:13 -0500
Received: from shell.v3.sk ([90.176.6.54]:57111 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390040AbeKQCiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:38:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3160C52C13;
        Fri, 16 Nov 2018 17:25:07 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OWW3vXZg0E_7; Fri, 16 Nov 2018 17:24:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A772252C54;
        Fri, 16 Nov 2018 17:24:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LjF0DCxKA09F; Fri, 16 Nov 2018 17:24:23 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D56E952DBB;
        Fri, 16 Nov 2018 17:24:17 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 10/17] Platform: OLPC: add a regulator for the DCON
Date:   Fri, 16 Nov 2018 17:23:56 +0100
Message-Id: <20181116162403.49854-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All OLPC ECs are able to turn the power to the DCON on an off. Use the
regulator framework to expose the functionality.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Use idiomatic form of return on error
- Avoid mixing bool and int

 drivers/platform/olpc/Kconfig   |  1 +
 drivers/platform/olpc/olpc-ec.c | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
index 7c643d24ad0f..c5a872fb286f 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -6,6 +6,7 @@ config OLPC
 	select OF
 	select OF_PROMTREE if X86
 	select IRQ_DOMAIN
+	select REGULATOR
 	help
 	  Add support for detecting the unique features of the OLPC
 	  XO hardware.
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 2b80174b8f4b..f725ab2a2db9 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/regulator/driver.h>
 #include <linux/olpc-ec.h>
=20
 struct ec_cmd_desc {
@@ -34,6 +35,10 @@ struct olpc_ec_priv {
 	struct work_struct worker;
 	struct mutex cmd_lock;
=20
+	/* DCON regulator */
+	struct regulator_dev *dcon_rdev;
+	bool dcon_enabled;
+
 	/* Pending EC commands */
 	struct list_head cmd_q;
 	spinlock_t cmd_q_lock;
@@ -344,9 +349,61 @@ static struct dentry *olpc_ec_setup_debugfs(void)
=20
 #endif /* CONFIG_DEBUG_FS */
=20
+static int olpc_ec_set_dcon_power(struct olpc_ec_priv *ec, bool state)
+{
+	unsigned char ec_byte =3D state;
+	int ret;
+
+	if (ec->dcon_enabled =3D=3D state)
+		return 0;
+
+	ret =3D olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
+	if (ret)
+		return ret;
+
+	ec->dcon_enabled =3D state;
+	return 0;
+}
+
+static int dcon_regulator_enable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, true);
+}
+
+static int dcon_regulator_disable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, false);
+}
+
+static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return ec->dcon_enabled ? 1 : 0;
+}
+
+static struct regulator_ops dcon_regulator_ops =3D {
+	.enable		=3D dcon_regulator_enable,
+	.disable	=3D dcon_regulator_disable,
+	.is_enabled	=3D dcon_regulator_is_enabled,
+};
+
+static const struct regulator_desc dcon_desc =3D {
+	.name	=3D "dcon",
+	.id	=3D 0,
+	.ops	=3D &dcon_regulator_ops,
+	.type	=3D REGULATOR_VOLTAGE,
+	.owner	=3D THIS_MODULE,
+};
+
 static int olpc_ec_probe(struct platform_device *pdev)
 {
 	struct olpc_ec_priv *ec;
+	struct regulator_config config =3D { };
 	int err;
=20
 	if (!ec_driver)
@@ -374,6 +431,16 @@ static int olpc_ec_probe(struct platform_device *pde=
v)
 		return err;
 	}
=20
+	config.dev =3D pdev->dev.parent;
+	config.driver_data =3D ec;
+	ec->dcon_enabled =3D true;
+	ec->dcon_rdev =3D devm_regulator_register(&pdev->dev, &dcon_desc,
+								&config);
+	if (IS_ERR(ec->dcon_rdev)) {
+		dev_err(&pdev->dev, "failed to register DCON regulator\n");
+		return PTR_ERR(ec->dcon_rdev);
+	}
+
 	ec->dbgfs_dir =3D olpc_ec_setup_debugfs();
=20
 	return err;
--=20
2.19.1

