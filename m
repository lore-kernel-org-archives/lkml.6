Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915672070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfAGSfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:35:21 -0500
Received: from shell.v3.sk ([90.176.6.54]:44519 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfAGSfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:35:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EB47FFFDA0;
        Mon,  7 Jan 2019 19:35:15 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5TBdAlPP3a4Y; Mon,  7 Jan 2019 19:34:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7B920FFD9A;
        Mon,  7 Jan 2019 19:34:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HK2S56C2ih31; Mon,  7 Jan 2019 19:34:45 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 59F5AFFD89;
        Mon,  7 Jan 2019 19:34:45 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 04/16] Platform: OLPC: Move OLPC config symbol out of x86 tree
Date:   Mon,  7 Jan 2019 19:34:27 +0100
Message-Id: <20190107183439.50626-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107183439.50626-1-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are ARM OLPC machines that use mostly the same drivers, including
EC infrastructure, DCON and Battery.

While at that, fix Kconfig to allow building this as a module.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Use 'depends on OLPC && X86' idiom (thanks Andy Shevchenko)

 arch/x86/Kconfig                  | 11 -----------
 drivers/input/mouse/Kconfig       |  3 ++-
 drivers/platform/Kconfig          |  2 ++
 drivers/platform/olpc/Kconfig     | 11 +++++++++++
 drivers/staging/olpc_dcon/Kconfig |  3 ++-
 5 files changed, 17 insertions(+), 13 deletions(-)
 create mode 100644 drivers/platform/olpc/Kconfig

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6185d4f33296..0a3fc97827cf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2707,17 +2707,6 @@ config SCx200HR_TIMER
 	  processor goes idle (as is done by the scheduler).  The
 	  other workaround is idle=3Dpoll boot option.
=20
-config OLPC
-	bool "One Laptop Per Child support"
-	depends on !X86_PAE
-	select GPIOLIB
-	select OF
-	select OF_PROMTREE
-	select IRQ_DOMAIN
-	---help---
-	  Add support for detecting the unique features of the OLPC
-	  XO hardware.
-
 config OLPC_XO1_PM
 	bool "OLPC XO-1 Power Management"
 	depends on OLPC && MFD_CS5535=3Dy && PM_SLEEP
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 566a1e3aa504..cf12d0e4fba2 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -165,7 +165,8 @@ config MOUSE_PS2_TOUCHKIT
=20
 config MOUSE_PS2_OLPC
 	bool "OLPC PS/2 mouse protocol extension"
-	depends on MOUSE_PS2 && OLPC
+	depends on MOUSE_PS2
+	depends on OLPC && X86
 	help
 	  Say Y here if you have an OLPC XO-1 laptop (with built-in
 	  PS/2 touchpad/tablet device).  The manufacturer calls the
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index d4c2e424a700..4313d73d3618 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -10,3 +10,5 @@ source "drivers/platform/goldfish/Kconfig"
 source "drivers/platform/chrome/Kconfig"
=20
 source "drivers/platform/mellanox/Kconfig"
+
+source "drivers/platform/olpc/Kconfig"
diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
new file mode 100644
index 000000000000..7b736c9e67ac
--- /dev/null
+++ b/drivers/platform/olpc/Kconfig
@@ -0,0 +1,11 @@
+config OLPC
+	tristate "One Laptop Per Child support"
+	depends on X86 || ARM || COMPILE_TEST
+	depends on !X86_PAE
+	select GPIOLIB
+	select OF
+	select OF_PROMTREE if X86
+	select IRQ_DOMAIN
+	help
+	  Add support for detecting the unique features of the OLPC
+	  XO hardware.
diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dco=
n/Kconfig
index 192cc8d0853f..ff540350f50f 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -1,8 +1,9 @@
 config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
-	depends on OLPC && FB
+	depends on FB
 	depends on I2C
 	depends on BACKLIGHT_LCD_SUPPORT
+	depends on OLPC && X86
 	depends on (GPIO_CS5535 || GPIO_CS5535=3Dn)
 	select BACKLIGHT_CLASS_DEVICE
 	help
--=20
2.20.1

