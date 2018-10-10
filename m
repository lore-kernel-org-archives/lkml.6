Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470FAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198092086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198092086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJKArC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:47:02 -0400
Received: from shell.v3.sk ([90.176.6.54]:54589 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbeJKArA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:47:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D2927BCFE8;
        Wed, 10 Oct 2018 19:23:49 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ce3jWZjeYA_6; Wed, 10 Oct 2018 19:23:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 61392BCFC6;
        Wed, 10 Oct 2018 19:23:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eUHwegwDNKu0; Wed, 10 Oct 2018 19:23:12 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3C161BCFC2;
        Wed, 10 Oct 2018 19:23:08 +0200 (CEST)
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
Subject: [PATCH 11/15] x86, olpc: Use a correct version when making up a battery node
Date:   Wed, 10 Oct 2018 19:22:56 +0200
Message-Id: <20181010172300.317643-12-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature. Add a different compatible string to the 1.5
battery.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/x86/platform/olpc/olpc_dt.c | 59 +++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
index d6ee92986920..6e54e116b0c5 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -218,10 +218,28 @@ static u32 __init olpc_dt_get_board_revision(void)
 	return be32_to_cpu(rev);
 }
=20
-void __init olpc_dt_fixup(void)
+int olpc_dt_compatible_match(phandle node, const char *compat)
 {
-	int r;
 	char buf[64];
+	int plen;
+	char *p;
+	int len;
+
+	plen =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
+	if (plen <=3D 0)
+		return 0;
+
+	len =3D strlen(compat);
+	for (p =3D buf; p < buf + plen; p +=3D strlen(p) + 1) {
+		if (strcmp(p, compat) =3D=3D 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+void __init olpc_dt_fixup(void)
+{
 	phandle node;
 	u32 board_rev;
=20
@@ -229,32 +247,33 @@ void __init olpc_dt_fixup(void)
 	if (!node)
 		return;
=20
-	/*
-	 * If the battery node has a compatible property, we are running a new
-	 * enough firmware and don't have fixups to make.
-	 */
-	r =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
-	if (r > 0)
-		return;
-
-	pr_info("PROM DT: Old firmware detected, applying fixes\n");
-
-	/* Add olpc,xo1-battery compatible marker to battery node */
-	olpc_dt_interpret("\" /battery@0\" find-device"
-		" \" olpc,xo1-battery\" +compatible"
-		" device-end");
-
 	board_rev =3D olpc_dt_get_board_revision();
 	if (!board_rev)
 		return;
=20
 	if (board_rev >=3D olpc_board_pre(0xd0)) {
+		if (olpc_dt_compatible_match(node, "olpc,xo1.5-battery"))
+			return;
+
+		/* Add olpc,xo1.5-battery compatible marker to battery node */
+		olpc_dt_interpret("\" /battery@0\" find-device"
+			" \" olpc,xo1.5-battery\" +compatible"
+			" device-end");
+
+		/* We're running a very old firmware if this is missing. */
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
+			return;
+
 		/* XO-1.5: add dcon device */
 		olpc_dt_interpret("\" /pci/display@1\" find-device"
 			" new-device"
 			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
 			" finish-device device-end");
 	} else {
+		/* We're running a very old firmware if this is missing. */
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
+			return;
+
 		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
 		olpc_dt_interpret("\" /pci/display@1,1\" find-device"
 			" new-device"
@@ -264,6 +283,11 @@ void __init olpc_dt_fixup(void)
 			" \" olpc,xo1-rtc\" +compatible"
 			" device-end");
 	}
+
+	/* Add olpc,xo1-battery compatible marker to battery node */
+	olpc_dt_interpret("\" /battery@0\" find-device"
+		" \" olpc,xo1-battery\" +compatible"
+		" device-end");
 }
=20
 void __init olpc_dt_build_devicetree(void)
@@ -289,6 +313,7 @@ void __init olpc_dt_build_devicetree(void)
 /* A list of DT node/bus matches that we want to expose as platform devi=
ces */
 static struct of_device_id __initdata of_ids[] =3D {
 	{ .compatible =3D "olpc,xo1-battery" },
+	{ .compatible =3D "olpc,xo1.5-battery" },
 	{ .compatible =3D "olpc,xo1-dcon" },
 	{ .compatible =3D "olpc,xo1-rtc" },
 	{},
--=20
2.19.0

