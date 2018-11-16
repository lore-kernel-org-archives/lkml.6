Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D0B2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="m0YufQhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D0B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbeKPXjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:39:07 -0500
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:6072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727727AbeKPXjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fShsFY7wVDyB98GBsKrX3bygQxh28a5BfpHxOBa/zZ0=;
 b=m0YufQhLaOkMS3VArsmh6JIPGaj25Qxc9U2/9hw+vEFVSmAi4S/clDp5SMMou915YB1/vA2HF9+iuKaP+fEqD9O8VW/bvdSPXm6Ghn/Bn91/NGnBm5tDyNdjg/BM5r2DUU0sTa+sC36WrGRbeDAgCq0h51zTwduTjAZ35uZMbR0=
Received: from DB6PR07MB3398.eurprd07.prod.outlook.com (10.175.233.26) by
 DB6PR07MB4150.eurprd07.prod.outlook.com (10.168.20.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.13; Fri, 16 Nov 2018 13:24:42 +0000
Received: from DB6PR07MB3398.eurprd07.prod.outlook.com
 ([fe80::5581:3615:c627:920f]) by DB6PR07MB3398.eurprd07.prod.outlook.com
 ([fe80::5581:3615:c627:920f%3]) with mapi id 15.20.1339.023; Fri, 16 Nov 2018
 13:24:41 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wolfram Sang <wsa@the-dreams.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>,
        Anders Berg <anders.berg@intel.com>
Subject: [PATCH] i2c-axxia: properly handle master timeout
Thread-Topic: [PATCH] i2c-axxia: properly handle master timeout
Thread-Index: AQHUfa+7o5LJTw4VckaRIER/LmY1zA==
Date:   Fri, 16 Nov 2018 13:24:41 +0000
Message-ID: <20181116132334.GA3951@localhost.localdomain>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0055.eurprd09.prod.outlook.com
 (2603:10a6:7:15::44) To DB6PR07MB3398.eurprd07.prod.outlook.com
 (2603:10a6:6:21::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.191]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR07MB4150;6:5lEHfE7b0oG3wEBg6WBoku35xm/hn+7MrKfrMpuGGz7K6ALTPq6WLYDVSmQNDbZM5He+8ekVP4isvA65g88Do0RPVfwyrBPkehcaFMDJbvpsmV9RM09OCgvcejdlujg6mpDepvOkGyjw3up7QX2XcerUpaak/KcIOnEMRVU4yR96b7C4MJmOVUhnBRUdyxUDlUrXmimYbXP7eBEe/MZy1vTh9LedpbLVvFWxlTcHhka8ujsQ2gnNbnCVtplMHpqS3uwH/16WAJnPWmg3yYqa3MayId6z4zvmxNx/o2yZJ8lhvIY71N2ITLWKf+Hy6gh4XqgbawEbur8epllRE43MDlPnFDpmNvKqmYjn1HpGP5Vz/EYs/We/vqeRLtrY5kMNFSAmgcNQBkFsVlXFLqeM4GhSV/6tiALPEVdY4g9dZ9lT4bvz33FuhPrWVk/pRkZaMIvfeCtgK6LUppXo1OdL8Q==;5:OuzBthfS4r/jLof/gO5wOKFuWivKvrhpiZIl/nwWcbhCZit5WDvUcmnONB8eCzciUZXWzGo/ks+C8XUyJKYtlan6KAzx0rLyrFak5NYZdx03jom4TYPanOkJFnTGuw1Q2AbFlPGiG6Pjnu7KSfVWN1fOb4KqSjqn6urNr0IdNIQ=;7:XBGtBPBNOFpZRrwo0SxFyP1yIOSItHAYcGWgyMQUoL/uz/U2mBxFrmHhYFtmU0504MfNnHK2lWz4v8IL3ZVgHeiGGqZ70Gq71s0hcTiRdyAdxNEWJdr1VBC5LvXB80SfHREX9khENjkCnowqCFJoZw==
x-ms-office365-filtering-correlation-id: 13a4f12f-b400-44ca-c1dc-08d64bc6dca7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB6PR07MB4150;
x-ms-traffictypediagnostic: DB6PR07MB4150:
x-microsoft-antispam-prvs: <DB6PR07MB415042216ECEEFFEA891C749EFDD0@DB6PR07MB4150.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(11241501184)(806099)(944501410)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB6PR07MB4150;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB4150;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(6486002)(52116002)(575784001)(105586002)(86362001)(486006)(25786009)(4326008)(476003)(6116002)(3846002)(1076002)(97736004)(9686003)(2900100001)(6346003)(71200400001)(256004)(26005)(33656002)(71190400001)(6512007)(53936002)(5660300001)(99286004)(186003)(305945005)(1857600001)(54906003)(66066001)(478600001)(551934003)(8936002)(7736002)(14454004)(106356001)(102836004)(81166006)(2906002)(316002)(6436002)(81156014)(110136005)(33896004)(61506002)(386003)(14444005)(2501003)(68736007)(8676002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB4150;H:DB6PR07MB3398.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-microsoft-antispam-message-info: GC30k3c1ef1Voqsxf4ua/WxTnTnMie9ZuyE7eib+RudYzvZ4q8k2poB/T8eBpM5oIkmRCuwXaUbCQz7pRQcBItvuwg0c8kOirDpLxSRpKmW9Kp1+oLRAOIxXZWxddRXhs9BYPwktPOwFHXBy3jj0DPZTodvHiUua40wli5WXHav3TaWMPUThQiZQRgBuviSCZOS8UY0xjbHQ4++PyCtc56Nex8svCe6pecFzK6PqotAVxrneXqcGmHgwrn9r4n9ImEYft3nOPOqOy7CGxbhOeXZpZDPcDgOZH9hz9vqz/IFwo99/4o5FWRfGgjfPSAZ51Qga96f/UDsYACzkPr8CkH+RtrayRo+3wODCxyyAuNs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0534958739C2E047B36637E20B8B91AC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a4f12f-b400-44ca-c1dc-08d64bc6dca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 13:24:41.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Intel (R) Axxia TM Lionfish Communication Processor
Peripheral Subsystem Hardware Reference Manual, the AXXIA I2C module
have a programmable Master Wait Timer, which among others, checks the
time between commands send in manual mode. When a timeout (25ms) passes,
TSS bit is set in Master Interrupt Status register and a Stop command is
issued by the hardware.

The axxia_i2c_xfer(), does not properly handle this situation, however.
For each message a separate axxia_i2c_xfer_msg() is called and this
function incorrectly assumes that any interrupt might happen only when
waiting for completion. This is mostly correct but there is one
exception - a master timeout can trigger if enough time has passed
between individual transfers. It will, by definition, happen between
transfers when the interrupts are disabled by the code. If that happens,
the hardware issues Stop command.

The interrupt indicating timeout will not be triggered as soon as we
enable them since the Master Interrupt Status is cleared when master
mode is entered again (which happens before enabling irqs) meaning this
error is lost and the transfer is continued even though the Stop was
issued on the bus. The subsequent operations completes without error but
a bogus value (0xFF in case of read) is read as the client device is
confused because aborted transfer. No error is returned from
master_xfer() making caller believe that a valid value was read.

To fix the problem, the TSS bit (indicating timeout) in Master Interrupt
Status register is checked before each transfer. If it is set, there was
a timeout before this transfer and (as described above) the hardware
already issued Stop command so the transaction should be aborted thus
-ETIMEOUT is returned from the master_xfer() callback. In order to be
sure no timeout was issued we can't just read the status just before
starting new transaction as there will always be a small window of time
(few CPU cycles at best) where this might still happen. For this reason
we have to temporally disable the timer before checking for TSS bit.
Disabling it will, however, clear the TSS bit so in order to preserve
that information, we have to read it in ISR so we have to ensure that
the TSS interrupt is not masked between transfers of one transaction.
There is no need to call bus recovery or controller reinitialization if
that happens so it's skipped.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index 8e60048a33f8..51d34959709b 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -74,8 +74,7 @@
 				 MST_STATUS_ND)
 #define   MST_STATUS_ERR	(MST_STATUS_NAK | \
 				 MST_STATUS_AL  | \
-				 MST_STATUS_IP  | \
-				 MST_STATUS_TSS)
+				 MST_STATUS_IP)
 #define MST_TX_BYTES_XFRD	0x50
 #define MST_RX_BYTES_XFRD	0x54
 #define SCL_HIGH_PERIOD		0x80
@@ -241,7 +240,7 @@ static int axxia_i2c_empty_rx_fifo(struct axxia_i2c_dev=
 *idev)
 			 */
 			if (c <=3D 0 || c > I2C_SMBUS_BLOCK_MAX) {
 				idev->msg_err =3D -EPROTO;
-				i2c_int_disable(idev, ~0);
+				i2c_int_disable(idev, ~MST_STATUS_TSS);
 				complete(&idev->msg_complete);
 				break;
 			}
@@ -299,14 +298,19 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
=20
 	if (status & MST_STATUS_SCC) {
 		/* Stop completed */
-		i2c_int_disable(idev, ~0);
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
 		complete(&idev->msg_complete);
 	} else if (status & MST_STATUS_SNS) {
 		/* Transfer done */
-		i2c_int_disable(idev, ~0);
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
 		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
 			axxia_i2c_empty_rx_fifo(idev);
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_TSS) {
+		/* Transfer timeout */
+		idev->msg_err =3D -ETIMEDOUT;
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
 	} else if (unlikely(status & MST_STATUS_ERR)) {
 		/* Transfer error */
 		i2c_int_disable(idev, ~0);
@@ -339,10 +343,10 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *i=
dev, struct i2c_msg *msg)
 	u32 rx_xfer, tx_xfer;
 	u32 addr_1, addr_2;
 	unsigned long time_left;
+	unsigned int wt_value;
=20
 	idev->msg =3D msg;
 	idev->msg_xfrd =3D 0;
-	idev->msg_err =3D 0;
 	reinit_completion(&idev->msg_complete);
=20
 	if (i2c_m_ten(msg)) {
@@ -383,9 +387,18 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *id=
ev, struct i2c_msg *msg)
 	else if (axxia_i2c_fill_tx_fifo(idev) !=3D 0)
 		int_mask |=3D MST_STATUS_TFL;
=20
+	wt_value =3D WT_VALUE(readl(idev->base + WAIT_TIMER_CONTROL));
+	/* Disable wait timer temporarly */
+	writel(wt_value, idev->base + WAIT_TIMER_CONTROL);
+	/* Check if timeout error happened */
+	if (idev->msg_err)
+		goto out;
+
 	/* Start manual mode */
 	writel(CMD_MANUAL, idev->base + MST_COMMAND);
=20
+	writel(WT_EN | wt_value, idev->base + WAIT_TIMER_CONTROL);
+
 	i2c_int_enable(idev, int_mask);
=20
 	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
@@ -396,13 +409,15 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *i=
dev, struct i2c_msg *msg)
 	if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
 		dev_warn(idev->dev, "busy after xfer\n");
=20
-	if (time_left =3D=3D 0)
+	if (time_left =3D=3D 0) {
 		idev->msg_err =3D -ETIMEDOUT;
-
-	if (idev->msg_err =3D=3D -ETIMEDOUT)
 		i2c_recover_bus(&idev->adapter);
+		axxia_i2c_init(idev);
+	}
=20
-	if (unlikely(idev->msg_err) && idev->msg_err !=3D -ENXIO)
+out:
+	if (unlikely(idev->msg_err) && idev->msg_err !=3D -ENXIO &&
+			idev->msg_err !=3D -ETIMEDOUT)
 		axxia_i2c_init(idev);
=20
 	return idev->msg_err;
@@ -410,7 +425,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *ide=
v, struct i2c_msg *msg)
=20
 static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
 {
-	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SCC;
+	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SCC | MST_STATUS_TSS;
 	unsigned long time_left;
=20
 	reinit_completion(&idev->msg_complete);
@@ -437,6 +452,9 @@ axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg=
 msgs[], int num)
 	int i;
 	int ret =3D 0;
=20
+	idev->msg_err =3D 0;
+	i2c_int_enable(idev, MST_STATUS_TSS);
+
 	for (i =3D 0; ret =3D=3D 0 && i < num; ++i)
 		ret =3D axxia_i2c_xfer_msg(idev, &msgs[i]);
=20
--=20
2.17.2

