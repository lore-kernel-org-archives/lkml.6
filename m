Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EFAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7542320851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="PVYdJyQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7542320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbeLJPBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:01:31 -0500
Received: from mail-eopbgr70114.outbound.protection.outlook.com ([40.107.7.114]:57776
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbeLJPBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXEiv2kWI2IBla9ApAa5x5G3BZGhnX3KrzBf507bpo4=;
 b=PVYdJyQpCRT8ExvgDGI0YWT/8U5T6xq2QCyePtZDnsF/H6s8jpeKoWqg6Ep8J6ut7+9EjMiRw9qVS6MhvohBNqrKbahCZPrGUabSTmyFl2u7pOFp2P7/8M/A4FCbFwsIWEL+FX0bHvc9wSOrRGbWGRlfBZv1AP8cPwHmVsMP3gs=
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com (10.170.247.141) by
 HE1PR07MB3225.eurprd07.prod.outlook.com (10.170.246.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.9; Mon, 10 Dec 2018 15:01:27 +0000
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb]) by HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb%2]) with mapi id 15.20.1425.016; Mon, 10 Dec 2018
 15:01:27 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/3] i2c-axxia: check for error conditions first
Thread-Topic: [PATCH 2/3] i2c-axxia: check for error conditions first
Thread-Index: AQHUkJk55tLaS8VlUEGNHY3SdbedeQ==
Date:   Mon, 10 Dec 2018 15:01:27 +0000
Message-ID: <d9a8070357973b5078dc897a18f319cba1df5de0.1544453688.git.krzysztof.adamski@nokia.com>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
In-Reply-To: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0022.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::32) To HE1PR07MB3434.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB3225;6:0QjNqLU9L1fo/km3cjtqGehWIluunNhBVO9qCBvCd7ImXXrEWqI7xyHUkvSO2Y8IwRpFqX0S1fDXVjMCGHxsHGYgOhE89PbdV513pdqNNFLEF207WIjqM6w85m8TbiLOuCyHUUo3oos3lr6orU+Fi1RRJUWkE15RgRHI20Qd8pwhYnJWYCCct+Ux5AAO4GpiN3YYEUtpI0vmp+PZRbko+2tIefjfMcfPqFOtYCVvPCesTdfRWBUAZlF3KKcROxhxisN46qnglNp/2o5xmOWwBI+N8o1RjlsXuPr6AC46uLs3sqmU86els9nc/6BB/ovBuRgw4sdulRLhvl1Xe6chcIPscIUk0akQgff1sFU1Qw4VrCeA96HcNW59FU3jJwf3F9lLGoKPGPF1ol5r0AkvK4zhGreu+mVbfSAAUw7QRn6jPplbCzQplrcc4owvVp8tH5SD1YnTRGn30kJUXcHyaw==;5:bbfCbBaGOnTTe6NMAja01lQjXT11a4gdIDsQlncfawLwppKpE9r1bYd2gswvnRgwpd2labOfzpmSuUI24DCbpBhRbOTicGQ4e8gzzuP2mb3biA4Lxa0R1RY2LtFF3fo184d/2ge1kBqa+wlQ+xShx6yI2vTOT5RYJSe7zgcQ3ZQ=;7:evlUrz5HxmtkAyAXXxy8VdPqvWKzVBL+dNlSZ0X6NRroS8UaqE78EEC4OcOymZdS7R38ergswy/gos1whcawFuOF3aeXu245BbNnbCHuZvc24R97umUKWFNWbneZuf2cxuGU8hCtRlvO9EGoMki/IA==
x-ms-office365-filtering-correlation-id: 083144f6-cf88-4441-f118-08d65eb05bd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB3225;
x-ms-traffictypediagnostic: HE1PR07MB3225:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-microsoft-antispam-prvs: <HE1PR07MB32253F89A7BDD63F9E0A5F27EFA50@HE1PR07MB3225.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(806100)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:HE1PR07MB3225;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB3225;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(478600001)(186003)(68736007)(2616005)(102836004)(11346002)(105586002)(6636002)(476003)(446003)(25786009)(26005)(486006)(14454004)(76176011)(54906003)(110136005)(97736004)(52116002)(256004)(14444005)(386003)(86362001)(6512007)(106356001)(6506007)(316002)(36756003)(8676002)(2906002)(7736002)(6486002)(118296001)(5660300001)(53936002)(4326008)(8936002)(305945005)(81156014)(99286004)(66066001)(71200400001)(3846002)(6436002)(6116002)(81166006)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB3225;H:HE1PR07MB3434.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7Zx1aftXvxU6fX0blE3rng0TP6g8aVSdXTrSajyzgOalSI+k2yEe00lum1yFFONTFoVzhG0foZzbpUQdPTbxgb1cp9g6Mlr4y3NbHOD9KxerSXeNwVW67L++By+DDO8hzQZiagGEW8pivGupPqW+fXSBhiItIiWjV3DjfdZ/be5GQnSFHfYXEQy4txE6skNouQIvKTpf8UMpaTO1gOTgR8ubywrodEmkiqEmNuJCS9znv1S9KHp2Lg3Ez27DP6t30mb742DXv5LQ635JSZKu6u0gQen6r3VcMt2yYmlcm5wwjY86RZfDW9vzInpXq9Rk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <483A37907C106B439A2559E2FA27B219@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083144f6-cf88-4441-f118-08d65eb05bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 15:01:27.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was observed that when using seqentional mode contrary to the
documentation, the SS bit (which is supposed to only be set if
automatic/sequence command completed normally), is sometimes set
together with NA (NAK in address phase) causing transfer to falsely be
considered successful.

My assumption is that this does not happen during manual mode since the
controller is stopping its work the moment it sets NA/ND bit in status
register. This is not the case in Automatic/Sequentional mode where it
is still working to send STOP condition and the actual status we get
depends on the time when the ISR is run.

This patch changes the order of checking status bits in ISR - error
conditions are checked first and only if none of them occurred, the
transfer may be considered successful. This is required to introduce
using of sequentional mode in next patch.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index d37caf694fbf..35258321e81b 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -296,22 +296,7 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 			i2c_int_disable(idev, MST_STATUS_TFL);
 	}
=20
-	if (status & MST_STATUS_SCC) {
-		/* Stop completed */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_SNS) {
-		/* Transfer done */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
-			axxia_i2c_empty_rx_fifo(idev);
-		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_TSS) {
-		/* Transfer timeout */
-		idev->msg_err =3D -ETIMEDOUT;
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		complete(&idev->msg_complete);
-	} else if (unlikely(status & MST_STATUS_ERR)) {
+	if (unlikely(status & MST_STATUS_ERR)) {
 		/* Transfer error */
 		i2c_int_disable(idev, ~0);
 		if (status & MST_STATUS_AL)
@@ -328,6 +313,21 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 			readl(idev->base + MST_TX_BYTES_XFRD),
 			readl(idev->base + MST_TX_XFER));
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SCC) {
+		/* Stop completed */
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SNS) {
+		/* Transfer done */
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
+			axxia_i2c_empty_rx_fifo(idev);
+		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_TSS) {
+		/* Transfer timeout */
+		idev->msg_err =3D -ETIMEDOUT;
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
 	}
=20
 out:
--=20
2.17.2

