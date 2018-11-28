Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0CBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CD72086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CD72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeK2E43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:56:29 -0500
Received: from shell.v3.sk ([90.176.6.54]:39378 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbeK2E42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:56:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B291599A51;
        Wed, 28 Nov 2018 18:53:58 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Rjb3amOlC977; Wed, 28 Nov 2018 18:53:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CDCBD999EF;
        Wed, 28 Nov 2018 18:53:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6MFQQnOlA8bM; Wed, 28 Nov 2018 18:53:31 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2C952998D3;
        Wed, 28 Nov 2018 18:53:30 +0100 (CET)
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
Subject: [PATCH v4 07/20] DT: marvell,mmp2: add more TWSI controllers
Date:   Wed, 28 Nov 2018 18:53:11 +0100
Message-Id: <20181128175324.163202-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've gotten the base addresses, clocks and interrupts from an rusty and o=
ld
out-of-tree driver. I haven't actually checked against the datasheet, sin=
ce
that one is reserved for the Marvell inner circle.

Tested with an accelerometer on TWSI6 on an OLPC XO 1.75 machine.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/dts/mmp2.dtsi | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index c5787eea57c7..c48d17a38d6b 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -269,6 +269,55 @@
 				status =3D "disabled";
 			};
=20
+			twsi3: i2c@d4032000 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4032000 0x1000>;
+				interrupt-parent =3D <&intcmux17>;
+				interrupts =3D <1>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI2>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI2>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			twsi4: i2c@d4033000 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4033000 0x1000>;
+				interrupt-parent =3D <&intcmux17>;
+				interrupts =3D <2>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI3>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI3>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+
+			twsi5: i2c@d4033800 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4033800 0x1000>;
+				interrupt-parent =3D <&intcmux17>;
+				interrupts =3D <3>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI4>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI4>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			twsi6: i2c@d4034000 {
+				compatible =3D "mrvl,mmp-twsi";
+				reg =3D <0xd4034000 0x1000>;
+				interrupt-parent =3D <&intcmux17>;
+				interrupts =3D <4>;
+				clocks =3D <&soc_clocks MMP2_CLK_TWSI5>;
+				resets =3D <&soc_clocks MMP2_CLK_TWSI5>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
 			rtc: rtc@d4010000 {
 				compatible =3D "mrvl,mmp-rtc";
 				reg =3D <0xd4010000 0x1000>;
--=20
2.19.1

