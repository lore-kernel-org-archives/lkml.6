Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D770C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29A921848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="CBTsoBxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBTXGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:06:44 -0500
Received: from 7of9.schinagl.nl ([62.251.20.244]:40958 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBTXGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:06:43 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 18:06:43 EST
Received: from [10.193.209.67] (unknown [89.200.5.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id B72DBB3AA09;
        Wed, 20 Feb 2019 23:57:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1550703452; bh=Pzj2MRTHFh7GY6rYGrmiRrvAq3D3Q0PndMXvQvAnzn0=;
        h=Date:In-Reply-To:References:Subject:To:CC:From;
        b=CBTsoBxmeaJWW+i7999pAcWpMA+EpocPi86UDpGoMMwu/iIElWi2Rjle/wzcaUeA8
         B6M2c3ykHi8liBg2710f7cDl3CGkfq73aegkyewCW3kCOhdA3yxL3KZye1P0DI3cHb
         OqxmQI+u3yr3WJW4yvrVx4E6KYnntFJcbzgjB0BM=
Date:   Wed, 20 Feb 2019 22:38:23 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190220165013.12774-1-axel.lin@ingics.com>
References: <20190220165013.12774-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS defines
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Chen-Yu Tsai <wens@csie.org>, Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Olliver Schinagl <oliver@schinagl.nl>
Message-ID: <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Axel,

On February 20, 2019 5:50:13 PM GMT+01:00, Axel Lin <axel=2Elin@ingics=2Ec=
om> wrote:
>The AXP20X_xxx_START/END/STEPS defines make the code hard to read and
>very hard to check the linear range settings because it needs to check
>the defines one-by-one=2E
>The original code without the defines is very good in readability
>as the meaning of each field of REGULATOR_LINEAR_RANGE is clear=2E
>So I suggest to get rid of AXP20X_xxx_START/END/STEPS defines=2E
Are you suggesting that magic values and hex numbers are more readable?

Maybe you can explain what your problem is, as it appears you are trying t=
o debug something?

>
>Signed-off-by: Axel Lin <axel=2Elin@ingics=2Ecom>
>---
> drivers/regulator/axp20x-regulator=2Ec | 176 +++------------------------
> 1 file changed, 19 insertions(+), 157 deletions(-)
>
>diff --git a/drivers/regulator/axp20x-regulator=2Ec
>b/drivers/regulator/axp20x-regulator=2Ec
>index fba8f58ab769=2E=2E46b5de53d1a3 100644
>--- a/drivers/regulator/axp20x-regulator=2Ec
>+++ b/drivers/regulator/axp20x-regulator=2Ec
>@@ -64,26 +64,6 @@
> #define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK		BIT_MASK(3)
> #define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN		BIT(3)
>=20
>-#define AXP20X_LDO4_V_OUT_1250mV_START	0x0
>-#define AXP20X_LDO4_V_OUT_1250mV_STEPS	0
>-#define AXP20X_LDO4_V_OUT_1250mV_END	\
>-	(AXP20X_LDO4_V_OUT_1250mV_START + AXP20X_LDO4_V_OUT_1250mV_STEPS)
>-#define AXP20X_LDO4_V_OUT_1300mV_START	0x1
>-#define AXP20X_LDO4_V_OUT_1300mV_STEPS	7
>-#define AXP20X_LDO4_V_OUT_1300mV_END	\
>-	(AXP20X_LDO4_V_OUT_1300mV_START + AXP20X_LDO4_V_OUT_1300mV_STEPS)
>-#define AXP20X_LDO4_V_OUT_2500mV_START	0x9
>-#define AXP20X_LDO4_V_OUT_2500mV_STEPS	0
>-#define AXP20X_LDO4_V_OUT_2500mV_END	\
>-	(AXP20X_LDO4_V_OUT_2500mV_START + AXP20X_LDO4_V_OUT_2500mV_STEPS)
>-#define AXP20X_LDO4_V_OUT_2700mV_START	0xa
>-#define AXP20X_LDO4_V_OUT_2700mV_STEPS	1
>-#define AXP20X_LDO4_V_OUT_2700mV_END	\
>-	(AXP20X_LDO4_V_OUT_2700mV_START + AXP20X_LDO4_V_OUT_2700mV_STEPS)
>-#define AXP20X_LDO4_V_OUT_3000mV_START	0xc
>-#define AXP20X_LDO4_V_OUT_3000mV_STEPS	3
>-#define AXP20X_LDO4_V_OUT_3000mV_END	\
>-	(AXP20X_LDO4_V_OUT_3000mV_START + AXP20X_LDO4_V_OUT_3000mV_STEPS)
> #define AXP20X_LDO4_V_OUT_NUM_VOLTAGES	16
>=20
> #define AXP22X_IO_ENABLED		0x03
>@@ -156,44 +136,9 @@
> #define AXP803_DCDC23_POLYPHASE_DUAL	BIT(6)
> #define AXP803_DCDC56_POLYPHASE_DUAL	BIT(5)
>=20
>-#define AXP803_DCDC234_500mV_START	0x00
>-#define AXP803_DCDC234_500mV_STEPS	70
>-#define AXP803_DCDC234_500mV_END	\
>-	(AXP803_DCDC234_500mV_START + AXP803_DCDC234_500mV_STEPS)
>-#define AXP803_DCDC234_1220mV_START	0x47
>-#define AXP803_DCDC234_1220mV_STEPS	4
>-#define AXP803_DCDC234_1220mV_END	\
>-	(AXP803_DCDC234_1220mV_START + AXP803_DCDC234_1220mV_STEPS)
> #define AXP803_DCDC234_NUM_VOLTAGES	76
>-
>-#define AXP803_DCDC5_800mV_START	0x00
>-#define AXP803_DCDC5_800mV_STEPS	32
>-#define AXP803_DCDC5_800mV_END		\
>-	(AXP803_DCDC5_800mV_START + AXP803_DCDC5_800mV_STEPS)
>-#define AXP803_DCDC5_1140mV_START	0x21
>-#define AXP803_DCDC5_1140mV_STEPS	35
>-#define AXP803_DCDC5_1140mV_END		\
>-	(AXP803_DCDC5_1140mV_START + AXP803_DCDC5_1140mV_STEPS)
> #define AXP803_DCDC5_NUM_VOLTAGES	68
>-
>-#define AXP803_DCDC6_600mV_START	0x00
>-#define AXP803_DCDC6_600mV_STEPS	50
>-#define AXP803_DCDC6_600mV_END		\
>-	(AXP803_DCDC6_600mV_START + AXP803_DCDC6_600mV_STEPS)
>-#define AXP803_DCDC6_1120mV_START	0x33
>-#define AXP803_DCDC6_1120mV_STEPS	14
>-#define AXP803_DCDC6_1120mV_END		\
>-	(AXP803_DCDC6_1120mV_START + AXP803_DCDC6_1120mV_STEPS)
> #define AXP803_DCDC6_NUM_VOLTAGES	72
>-
>-#define AXP803_DLDO2_700mV_START	0x00
>-#define AXP803_DLDO2_700mV_STEPS	26
>-#define AXP803_DLDO2_700mV_END		\
>-	(AXP803_DLDO2_700mV_START + AXP803_DLDO2_700mV_STEPS)
>-#define AXP803_DLDO2_3400mV_START	0x1b
>-#define AXP803_DLDO2_3400mV_STEPS	4
>-#define AXP803_DLDO2_3400mV_END		\
>-	(AXP803_DLDO2_3400mV_START + AXP803_DLDO2_3400mV_STEPS)
> #define AXP803_DLDO2_NUM_VOLTAGES	32
>=20
> #define AXP806_DCDCA_V_CTRL_MASK	GENMASK(6, 0)
>@@ -235,34 +180,8 @@
>=20
> #define AXP806_DCDCDE_POLYPHASE_DUAL	BIT(5)
>=20
>-#define AXP806_DCDCA_600mV_START	0x00
>-#define AXP806_DCDCA_600mV_STEPS	50
>-#define AXP806_DCDCA_600mV_END		\
>-	(AXP806_DCDCA_600mV_START + AXP806_DCDCA_600mV_STEPS)
>-#define AXP806_DCDCA_1120mV_START	0x33
>-#define AXP806_DCDCA_1120mV_STEPS	14
>-#define AXP806_DCDCA_1120mV_END		\
>-	(AXP806_DCDCA_1120mV_START + AXP806_DCDCA_1120mV_STEPS)
> #define AXP806_DCDCA_NUM_VOLTAGES	72
>-
>-#define AXP806_DCDCD_600mV_START	0x00
>-#define AXP806_DCDCD_600mV_STEPS	45
>-#define AXP806_DCDCD_600mV_END		\
>-	(AXP806_DCDCD_600mV_START + AXP806_DCDCD_600mV_STEPS)
>-#define AXP806_DCDCD_1600mV_START	0x2e
>-#define AXP806_DCDCD_1600mV_STEPS	17
>-#define AXP806_DCDCD_1600mV_END		\
>-	(AXP806_DCDCD_1600mV_START + AXP806_DCDCD_1600mV_STEPS)
> #define AXP806_DCDCD_NUM_VOLTAGES	64
>-
>-#define AXP809_DCDC4_600mV_START	0x00
>-#define AXP809_DCDC4_600mV_STEPS	47
>-#define AXP809_DCDC4_600mV_END		\
>-	(AXP809_DCDC4_600mV_START + AXP809_DCDC4_600mV_STEPS)
>-#define AXP809_DCDC4_1800mV_START	0x30
>-#define AXP809_DCDC4_1800mV_STEPS	8
>-#define AXP809_DCDC4_1800mV_END		\
>-	(AXP809_DCDC4_1800mV_START + AXP809_DCDC4_1800mV_STEPS)
> #define AXP809_DCDC4_NUM_VOLTAGES	57
>=20
> #define AXP813_DCDC7_V_OUT_MASK		GENMASK(6, 0)
>@@ -517,26 +436,11 @@ static const struct regulator_ops axp20x_ops_sw =3D
>{
> };
>=20
> static const struct regulator_linear_range axp20x_ldo4_ranges[] =3D {
>-	REGULATOR_LINEAR_RANGE(1250000,
>-			       AXP20X_LDO4_V_OUT_1250mV_START,
>-			       AXP20X_LDO4_V_OUT_1250mV_END,
>-			       0),
>-	REGULATOR_LINEAR_RANGE(1300000,
>-			       AXP20X_LDO4_V_OUT_1300mV_START,
>-			       AXP20X_LDO4_V_OUT_1300mV_END,
>-			       100000),
>-	REGULATOR_LINEAR_RANGE(2500000,
>-			       AXP20X_LDO4_V_OUT_2500mV_START,
>-			       AXP20X_LDO4_V_OUT_2500mV_END,
>-			       0),
>-	REGULATOR_LINEAR_RANGE(2700000,
>-			       AXP20X_LDO4_V_OUT_2700mV_START,
>-			       AXP20X_LDO4_V_OUT_2700mV_END,
>-			       100000),
>-	REGULATOR_LINEAR_RANGE(3000000,
>-			       AXP20X_LDO4_V_OUT_3000mV_START,
>-			       AXP20X_LDO4_V_OUT_3000mV_END,
>-			       100000),
>+	REGULATOR_LINEAR_RANGE(1250000, 0x0, 0x0, 0),
>+	REGULATOR_LINEAR_RANGE(1300000, 0x1, 0x8, 100000),
>+	REGULATOR_LINEAR_RANGE(2500000, 0x9, 0x9, 0),
>+	REGULATOR_LINEAR_RANGE(2700000, 0xa, 0xb, 100000),
>+	REGULATOR_LINEAR_RANGE(3000000, 0xc, 0xf, 100000),
> };
>=20
> static const struct regulator_desc axp20x_regulators[] =3D {
>@@ -645,48 +549,24 @@ static const struct regulator_desc
>axp22x_drivevbus_regulator =3D {
>=20
> /* DCDC ranges shared with AXP813 */
> static const struct regulator_linear_range axp803_dcdc234_ranges[] =3D {
>-	REGULATOR_LINEAR_RANGE(500000,
>-			       AXP803_DCDC234_500mV_START,
>-			       AXP803_DCDC234_500mV_END,
>-			       10000),
>-	REGULATOR_LINEAR_RANGE(1220000,
>-			       AXP803_DCDC234_1220mV_START,
>-			       AXP803_DCDC234_1220mV_END,
>-			       20000),
>+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
>+	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x4b, 20000),
> };
>=20
> static const struct regulator_linear_range axp803_dcdc5_ranges[] =3D {
>-	REGULATOR_LINEAR_RANGE(800000,
>-			       AXP803_DCDC5_800mV_START,
>-			       AXP803_DCDC5_800mV_END,
>-			       10000),
>-	REGULATOR_LINEAR_RANGE(1140000,
>-			       AXP803_DCDC5_1140mV_START,
>-			       AXP803_DCDC5_1140mV_END,
>-			       20000),
>+	REGULATOR_LINEAR_RANGE(800000, 0x0, 0x20, 10000),
>+	REGULATOR_LINEAR_RANGE(1140000, 0x21, 0x44, 20000),
> };
>=20
> static const struct regulator_linear_range axp803_dcdc6_ranges[] =3D {
>-	REGULATOR_LINEAR_RANGE(600000,
>-			       AXP803_DCDC6_600mV_START,
>-			       AXP803_DCDC6_600mV_END,
>-			       10000),
>-	REGULATOR_LINEAR_RANGE(1120000,
>-			       AXP803_DCDC6_1120mV_START,
>-			       AXP803_DCDC6_1120mV_END,
>-			       20000),
>+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x32, 10000),
>+	REGULATOR_LINEAR_RANGE(1120000, 0x33, 0x47, 20000),
> };
>=20
> /* AXP806's CLDO2 and AXP809's DLDO1 share the same range */
> static const struct regulator_linear_range axp803_dldo2_ranges[] =3D {
>-	REGULATOR_LINEAR_RANGE(700000,
>-			       AXP803_DLDO2_700mV_START,
>-			       AXP803_DLDO2_700mV_END,
>-			       100000),
>-	REGULATOR_LINEAR_RANGE(3400000,
>-			       AXP803_DLDO2_3400mV_START,
>-			       AXP803_DLDO2_3400mV_END,
>-			       200000),
>+	REGULATOR_LINEAR_RANGE(700000, 0x0, 0x1a, 100000),
>+	REGULATOR_LINEAR_RANGE(3400000, 0x1b, 0x1f, 200000),
> };
>=20
> static const struct regulator_desc axp803_regulators[] =3D {
>@@ -765,25 +645,13 @@ static const struct regulator_desc
>axp803_regulators[] =3D {
> };
>=20
> static const struct regulator_linear_range axp806_dcdca_ranges[] =3D {
>-	REGULATOR_LINEAR_RANGE(600000,
>-			       AXP806_DCDCA_600mV_START,
>-			       AXP806_DCDCA_600mV_END,
>-			       10000),
>-	REGULATOR_LINEAR_RANGE(1120000,
>-			       AXP806_DCDCA_1120mV_START,
>-			       AXP806_DCDCA_1120mV_END,
>-			       20000),
>+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x32, 10000),
>+	REGULATOR_LINEAR_RANGE(1120000, 0x33, 0x47, 20000),
> };
>=20
> static const struct regulator_linear_range axp806_dcdcd_ranges[] =3D {
>-	REGULATOR_LINEAR_RANGE(600000,
>-			       AXP806_DCDCD_600mV_START,
>-			       AXP806_DCDCD_600mV_END,
>-			       20000),
>-	REGULATOR_LINEAR_RANGE(1600000,
>-			       AXP806_DCDCD_600mV_START,
>-			       AXP806_DCDCD_600mV_END,
>-			       100000),
>+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2d, 20000),
>+	REGULATOR_LINEAR_RANGE(1600000, 0x2e, 0x3f, 100000),
> };
>=20
> static const struct regulator_desc axp806_regulators[] =3D {
>@@ -841,14 +709,8 @@ static const struct regulator_desc
>axp806_regulators[] =3D {
> };
>=20
> static const struct regulator_linear_range axp809_dcdc4_ranges[] =3D {
>-	REGULATOR_LINEAR_RANGE(600000,
>-			       AXP809_DCDC4_600mV_START,
>-			       AXP809_DCDC4_600mV_END,
>-			       20000),
>-	REGULATOR_LINEAR_RANGE(1800000,
>-			       AXP809_DCDC4_1800mV_START,
>-			       AXP809_DCDC4_1800mV_END,
>-			       100000),
>+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2f, 20000),
>+	REGULATOR_LINEAR_RANGE(1800000, 0x30, 0x38, 100000),
> };
>=20
> static const struct regulator_desc axp809_regulators[] =3D {

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
