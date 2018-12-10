Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D11C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5E120672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="qwObSNhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5E120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeLJPF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:05:29 -0500
Received: from mail-eopbgr140105.outbound.protection.outlook.com ([40.107.14.105]:45634
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726978AbeLJPF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edIp+aqyaMQywj8lZl4k2cLT186xBR7S/o6IMS7TmDk=;
 b=qwObSNhKu+7Z71QHJYt0q8mkjrmRObCeqzt1a7i/8APDD3ftINXX4UEzNgrEzbj0ULOg7a6VYVqQ4gEVXepq218hebY40Qw7r77DrWd1S3+/IixT9UJqwjeP+lJHze1qgb+sxtVAsnSJpaU4STbZlfPdkaC0LWkyvOkf7570Y60=
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com (10.170.247.141) by
 HE1PR07MB3338.eurprd07.prod.outlook.com (10.170.247.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.9; Mon, 10 Dec 2018 15:05:23 +0000
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb]) by HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb%2]) with mapi id 15.20.1425.016; Mon, 10 Dec 2018
 15:05:23 +0000
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
Subject: [PATCH 3/3] i2c-axxia: support sequence command mode
Thread-Topic: [PATCH 3/3] i2c-axxia: support sequence command mode
Thread-Index: AQHUkJnGbS63ysGb7E6mOzAbaTpNEg==
Date:   Mon, 10 Dec 2018 15:05:23 +0000
Message-ID: <8515ba7093f5be3ad7bd31d68efedcbe17958282.1544453688.git.krzysztof.adamski@nokia.com>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
In-Reply-To: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0113.eurprd02.prod.outlook.com
 (2603:10a6:7:29::42) To HE1PR07MB3434.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB3338;6:uzIzGJsh1JaYNf0Nq6ewmTL6cWDa/sGCp6lhqeAh+8iqblFiWJ8ZsmLf58rQr1xx4dFmlMf+BZBVGbcaWY7VpE4Bf1oW9BpMU0n8tp0yzOfr59WmQge5YJjhirRRBmV4mJoPg8iyYS6nNbKOAqNLNoi4fc1IBDNwPisf9u94HtdOfhfJCfgibHspeu0C6/P2A5zNMWc5EzwF4guNU+GYZEjlNSfEUyf6NLOLK3edDtyrTRiug6g5ctMG34Y/+YzbtbiPS7dV44r6WM/RMaptfNSmz1UcUWH3HFLj5Bo+K85XamIlrgrjwbwCkYskvktljzigbqhJCP36PFdEV/k0U6lFv8KM9VsM0s+oTfcS2F1tyUMWjHtopOkj1dddiGKL++lnxxhowCeARtP8WLDj4gJfoeTcs8G8MdNdWI2kOThG3CpMB9qLXM14sr2amc+4XuAVbDayKw+izpDOkjCRTA==;5:jLLvfa6195wc/udQqPPL3ejT5Z5w9G55UA2TqRQTgHMTV29AktBERToIlvSQZmFjlerxJD0rnP7YkFyL6iyiXFhWM/xmG9fP7AOZMw7SHkEPCJLJ6cM+GVa1J97YLgBbLqdP3fPahhi5n5laPj8f2ZRsID7xvA0/KGFhHLJjQ3k=;7:qSpJ1KHYR7HtvRayD5DIjrcyO0gOYJ6q7umsskXU0JohRTtvnbp3j5tOn+GhT7aCkOkLyqKeEc/CWP1oGV9N4qOvjnHtt3eyDaoO6EqmcGEWantlVEScfAgyrqF6R4OcSQTYM49d3SYYOAkfa87yYQ==
x-ms-office365-filtering-correlation-id: 26909b10-30fd-4256-f5aa-08d65eb0e8e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB3338;
x-ms-traffictypediagnostic: HE1PR07MB3338:
x-microsoft-antispam-prvs: <HE1PR07MB3338E15880557698957AA825EFA50@HE1PR07MB3338.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(11241501185)(806100)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR07MB3338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB3338;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(68736007)(81166006)(8676002)(8936002)(256004)(81156014)(11346002)(4326008)(5660300001)(6486002)(486006)(476003)(446003)(2616005)(305945005)(25786009)(6436002)(76176011)(575784001)(99286004)(86362001)(2906002)(52116002)(6636002)(316002)(71190400001)(6116002)(3846002)(110136005)(54906003)(71200400001)(14454004)(551934003)(66066001)(106356001)(97736004)(118296001)(105586002)(6512007)(7736002)(186003)(53936002)(478600001)(14444005)(6506007)(102836004)(36756003)(26005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB3338;H:HE1PR07MB3434.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cW+KK6wrrM+ssAI6JfDJkMVmnOCWnC5XuD3aCeIhSP14Ub/mjE3urDrfgvnrBhgUHAFNnmDy+VwfFsxVeGJmbFqYVliVyCDhL+c8+ySlubMQ45Bt1GZhqmq9ldL3pxbiFjm8ot0CrLBVP5ZJPMS59QKc0YqYvHxO/SdbSxaZSWp8BVTMPndWLGJZCr/HvPknPTQ/IhXQjaP/JJywvdVpS0V8uX+DTjBKaMlV/gFSQ3kxf3q+wZx4PTbSxiUs+Zu+6WRLbeLqtCjo/V69f+ZAqDqATT0U8BTwRlB17CPYKUFGcVFbcKs0MCw5Zc1aQEjS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5BA719FC6E688A4F92C22D826E1A4A0F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26909b10-30fd-4256-f5aa-08d65eb0e8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 15:05:23.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to comply with SMBus specification, the Axxia I=B2C module will
abort the multi message transfer if the delay between finishing sending
one message and starting another is longer than 25ms. Unfortunately it
isn't that hard to trigger this situation on a busy system. In order to
fix this problem, we should make sure hardware does whole transaction
without waiting for software to fill some data.

Fortunately, in addition to Manual mode that is currently used by the
driver to perform I=B2C transfers, the module supports also so called
Sequence mode. In this mode, the module automatically performs
predefined sequence of operations - it sends a slave address, transmits
specified number of bytes from the FIFO, changes transfer direction,
resends the slave address and then reads specified number of bytes to
FIFO. While very inflexible, this does fit a most common case of multi
message transfer - the one where you first write a register number you
want to read and then read it.

To use this mode effectively, a number of conditions must be met to
ensure the transaction does fit the predefined sequence. In case this is
not the case, a fallback to manual mode is used.

The initialization of this mode is very similar to Manual mode. The most
notable difference is different bit in the Master Interrupt Status
designating finishing of transaction. Also some of the errors, like TSS,
cannot happen in this mode.

While it is possible to support transactions requesting a read of any
size (RFL interrupt will be generated when FIFO size is not enough) the
TFL interrupt is not available in this mode, thus the write part of the
transaction cannot exceed FIFO_SIZE (8).

Note that in case of a NAK during transaction, the NA/ND status bits
will be set before STOP command is generated, triggering an interrupt
while the controller is still busy. Current solution for this problem is
to actively wait for this command to stop before leaving xfer callback.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 100 ++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index 35258321e81b..64779819a948 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -12,6 +12,7 @@
  */
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -25,6 +26,7 @@
 #define I2C_XFER_TIMEOUT    (msecs_to_jiffies(250))
 #define I2C_STOP_TIMEOUT    (msecs_to_jiffies(100))
 #define FIFO_SIZE           8
+#define SEQ_LEN             2
=20
 #define GLOBAL_CONTROL		0x00
 #define   GLOBAL_MST_EN         BIT(0)
@@ -51,6 +53,7 @@
 #define   CMD_BUSY		(1<<3)
 #define   CMD_MANUAL		(0x00 | CMD_BUSY)
 #define   CMD_AUTO		(0x01 | CMD_BUSY)
+#define   CMD_SEQUENCE		(0x02 | CMD_BUSY)
 #define MST_RX_XFER		0x2c
 #define MST_TX_XFER		0x30
 #define MST_ADDR_1		0x34
@@ -87,7 +90,9 @@
  * axxia_i2c_dev - I2C device context
  * @base: pointer to register struct
  * @msg: pointer to current message
- * @msg_xfrd: number of bytes transferred in msg
+ * @msg_r: pointer to current read message (sequence transfer)
+ * @msg_xfrd: number of bytes transferred in tx_fifo
+ * @msg_xfrd_r: number of bytes transferred in rx_fifo
  * @msg_err: error code for completed message
  * @msg_complete: xfer completion object
  * @dev: device reference
@@ -98,7 +103,9 @@
 struct axxia_i2c_dev {
 	void __iomem *base;
 	struct i2c_msg *msg;
+	struct i2c_msg *msg_r;
 	size_t msg_xfrd;
+	size_t msg_xfrd_r;
 	int msg_err;
 	struct completion msg_complete;
 	struct device *dev;
@@ -227,14 +234,14 @@ static int i2c_m_recv_len(const struct i2c_msg *msg)
  */
 static int axxia_i2c_empty_rx_fifo(struct axxia_i2c_dev *idev)
 {
-	struct i2c_msg *msg =3D idev->msg;
+	struct i2c_msg *msg =3D idev->msg_r;
 	size_t rx_fifo_avail =3D readl(idev->base + MST_RX_FIFO);
-	int bytes_to_transfer =3D min(rx_fifo_avail, msg->len - idev->msg_xfrd);
+	int bytes_to_transfer =3D min(rx_fifo_avail, msg->len - idev->msg_xfrd_r)=
;
=20
 	while (bytes_to_transfer-- > 0) {
 		int c =3D readl(idev->base + MST_DATA);
=20
-		if (idev->msg_xfrd =3D=3D 0 && i2c_m_recv_len(msg)) {
+		if (idev->msg_xfrd_r =3D=3D 0 && i2c_m_recv_len(msg)) {
 			/*
 			 * Check length byte for SMBus block read
 			 */
@@ -247,7 +254,7 @@ static int axxia_i2c_empty_rx_fifo(struct axxia_i2c_dev=
 *idev)
 			msg->len =3D 1 + c;
 			writel(msg->len, idev->base + MST_RX_XFER);
 		}
-		msg->buf[idev->msg_xfrd++] =3D c;
+		msg->buf[idev->msg_xfrd_r++] =3D c;
 	}
=20
 	return 0;
@@ -287,7 +294,7 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 	}
=20
 	/* RX FIFO needs service? */
-	if (i2c_m_rd(idev->msg) && (status & MST_STATUS_RFL))
+	if (i2c_m_rd(idev->msg_r) && (status & MST_STATUS_RFL))
 		axxia_i2c_empty_rx_fifo(idev);
=20
 	/* TX FIFO needs service? */
@@ -320,9 +327,12 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 	} else if (status & MST_STATUS_SNS) {
 		/* Transfer done */
 		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
+		if (i2c_m_rd(idev->msg_r) && idev->msg_xfrd_r < idev->msg_r->len)
 			axxia_i2c_empty_rx_fifo(idev);
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SS) {
+		/* Auto/Sequence transfer done */
+		complete(&idev->msg_complete);
 	} else if (status & MST_STATUS_TSS) {
 		/* Transfer timeout */
 		idev->msg_err =3D -ETIMEDOUT;
@@ -363,6 +373,62 @@ static void axxia_i2c_set_addr(struct axxia_i2c_dev *i=
dev, struct i2c_msg *msg)
 	writel(addr_2, idev->base + MST_ADDR_2);
 }
=20
+/* The NAK interrupt will be sent _before_ issuing STOP command
+ * so the controller might still be busy processing it. No
+ * interrupt will be sent at the end so we have to poll for it
+ */
+static void axxia_i2c_handle_seq_nak(struct axxia_i2c_dev *idev)
+{
+	while (readl(idev->base + MST_COMMAND) & CMD_BUSY)
+		udelay(100);
+}
+
+static int axxia_i2c_xfer_seq(struct axxia_i2c_dev *idev, struct i2c_msg m=
sgs[])
+{
+	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SS | MST_STATUS_RFL;
+	u32 rlen =3D i2c_m_recv_len(&msgs[1]) ? I2C_SMBUS_BLOCK_MAX : msgs[1].len=
;
+	unsigned long time_left;
+
+	axxia_i2c_set_addr(idev, &msgs[0]);
+
+	writel(msgs[0].len, idev->base + MST_TX_XFER);
+	writel(rlen, idev->base + MST_RX_XFER);
+
+	idev->msg =3D &msgs[0];
+	idev->msg_r =3D &msgs[1];
+	idev->msg_xfrd =3D 0;
+	idev->msg_xfrd_r =3D 0;
+	axxia_i2c_fill_tx_fifo(idev);
+
+	writel(CMD_SEQUENCE, idev->base + MST_COMMAND);
+
+	reinit_completion(&idev->msg_complete);
+	i2c_int_enable(idev, int_mask);
+
+	time_left =3D wait_for_completion_timeout(&idev->msg_complete,
+						I2C_XFER_TIMEOUT);
+
+	i2c_int_disable(idev, int_mask);
+
+	axxia_i2c_empty_rx_fifo(idev);
+
+	if (idev->msg_err =3D=3D -ENXIO)
+		axxia_i2c_handle_seq_nak(idev);
+	else if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
+		dev_warn(idev->dev, "busy after xfer\n");
+
+	if (time_left =3D=3D 0) {
+		idev->msg_err =3D -ETIMEDOUT;
+		i2c_recover_bus(&idev->adapter);
+		axxia_i2c_init(idev);
+	}
+
+	if (unlikely(idev->msg_err) && idev->msg_err !=3D -ENXIO)
+		axxia_i2c_init(idev);
+
+	return idev->msg_err;
+}
+
 static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg)
 {
 	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SNS;
@@ -371,7 +437,9 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *ide=
v, struct i2c_msg *msg)
 	unsigned int wt_value;
=20
 	idev->msg =3D msg;
+	idev->msg_r =3D msg;
 	idev->msg_xfrd =3D 0;
+	idev->msg_xfrd_r =3D 0;
 	reinit_completion(&idev->msg_complete);
=20
 	axxia_i2c_set_addr(idev, msg);
@@ -452,6 +520,18 @@ static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
 	return 0;
 }
=20
+/* This function checks if the msgs[] array contains messages compatible w=
ith
+ * Sequence mode of operation. This mode assumes there will be exactly one
+ * write of non-zero length followed by exactly one read of non-zero lengt=
h,
+ * both targeted at the same client device.
+ */
+static bool axxia_i2c_sequence_ok(struct i2c_msg msgs[], int num)
+{
+	return num =3D=3D SEQ_LEN && !i2c_m_rd(&msgs[0]) && i2c_m_rd(&msgs[1]) &&
+	       msgs[0].len > 0 && msgs[0].len <=3D FIFO_SIZE &&
+	       msgs[1].len > 0 && msgs[0].addr =3D=3D msgs[1].addr;
+}
+
 static int
 axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
@@ -460,6 +540,12 @@ axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_ms=
g msgs[], int num)
 	int ret =3D 0;
=20
 	idev->msg_err =3D 0;
+
+	if (axxia_i2c_sequence_ok(msgs, num)) {
+		ret =3D axxia_i2c_xfer_seq(idev, msgs);
+		return ret ? : SEQ_LEN;
+	}
+
 	i2c_int_enable(idev, MST_STATUS_TSS);
=20
 	for (i =3D 0; ret =3D=3D 0 && i < num; ++i)
--=20
2.17.2

