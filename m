Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54809C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331BB2064C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfAJR72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:59:28 -0500
Received: from shell.v3.sk ([90.176.6.54]:58610 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbfAJR7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:59:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E88C61002F1;
        Thu, 10 Jan 2019 18:59:20 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CjwEAdZ_cx2t; Thu, 10 Jan 2019 18:59:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D67861002F0;
        Thu, 10 Jan 2019 18:59:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id goc6kLLtZsRL; Thu, 10 Jan 2019 18:58:59 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DD7B11002FF;
        Thu, 10 Jan 2019 18:58:55 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v5 10/10] Platform: OLPC: Add restart support to XO-1.75 EC driver
Date:   Thu, 10 Jan 2019 18:58:45 +0100
Message-Id: <20190110175845.1203986-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hooks to arm_pm_restart instead od utilizing a restart handler
notifier, because the reboot dance on XO 1.75 needs to sleep (it pokes a
GPIO and waits for the EC to initiate the command transaction) and the
restart handler is called in atomic context. Sad.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v4:
- Split off from the driver.

 drivers/platform/olpc/Kconfig         |  2 +-
 drivers/platform/olpc/olpc-xo175-ec.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
index 858ac1d2290a..02b232c34444 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -4,7 +4,7 @@ config OLPC_EC
=20
 config OLPC_XO175_EC
 	tristate "OLPC XO 1.75 Embedded Controller"
-	depends on ARCH_MMP || COMPILE_TEST
+	depends on ARM && (ARCH_MMP || COMPILE_TEST)
 	select SPI_SLAVE
 	select OLPC_EC
 	help
diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olp=
c/olpc-xo175-ec.c
index c3a176ce474d..74db06bacc44 100644
--- a/drivers/platform/olpc/olpc-xo175-ec.c
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
+#include <asm/system_misc.h>
=20
 struct ec_cmd_t {
 	u8 cmd;
@@ -578,6 +579,14 @@ static int olpc_xo175_ec_set_event_mask(unsigned int=
 mask)
 	return olpc_ec_cmd(CMD_WRITE_EXT_SCI_MASK, args, 2, NULL, 0);
 }
=20
+static void olpc_xo175_ec_restart(enum reboot_mode mode, const char *cmd=
)
+{
+	while (1) {
+		olpc_ec_cmd(CMD_POWER_CYCLE, NULL, 0, NULL, 0);
+		mdelay(1000);
+	}
+}
+
 static void olpc_xo175_ec_power_off(void)
 {
 	while (1) {
@@ -649,6 +658,8 @@ static int olpc_xo175_ec_remove(struct spi_device *sp=
i)
 {
 	if (pm_power_off =3D=3D olpc_xo175_ec_power_off)
 		pm_power_off =3D NULL;
+	if (arm_pm_restart =3D=3D olpc_xo175_ec_restart)
+		arm_pm_restart =3D NULL;
=20
 	spi_slave_abort(spi);
=20
@@ -716,6 +727,8 @@ static int olpc_xo175_ec_probe(struct spi_device *spi=
)
=20
 	if (pm_power_off =3D=3D NULL)
 		pm_power_off =3D olpc_xo175_ec_power_off;
+	if (arm_pm_restart =3D=3D NULL)
+		arm_pm_restart =3D olpc_xo175_ec_restart;
=20
 	dev_info(&spi->dev, "OLPC XO-1.75 Embedded Controller driver\n");
=20
--=20
2.20.1

