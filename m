Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrUBRxMqpO6fZoabhBAMaMqMEnNRsHafsraX/TmatTYVDxor9rfwf2YH85ZBlT3Tx1fEi+W
ARC-Seal: i=1; a=rsa-sha256; t=1526281239; cv=none;
        d=google.com; s=arc-20160816;
        b=f5lBlsTHjq04OOoQh1X2YDejoD7DoxnHvcs+15iE5/Z1qjRrCrjrplfq2F3x6wEe7q
         r07X8wxuLIerpLuJvvwSLyPjg5lOQFIlgmmZjPDptASA0JuSt1lWLgJ7WkxS9rB0e4xl
         b08iE0mGUf2v4Da46/35EiE+xLTr//eEYkNtMIAb1/S9+HRUqe+nJhGCJSuR1OtUwg7i
         +uoXuXKw2DE312JZJBo1XeQ7LAjF90ufhn/QvgFiCp9qN7qF4OEQaF4esz2EnqPGh3BW
         7qr5sIe9FLcwCqD6sViSSbk4bmohOr5TCVbpJhtTYWxo7XXoOK7gd0xyN+lz68+pwypF
         SsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7x+QR77bHw7i909aeA7KpZOg2geGzr4oN8GiBqb+K+Y=;
        b=V3aLFjsa42f2Bc98JZ1lMDQQwk2qmAn4mRQSfJgyKFePQtHm074T2crAmn/MMmIAEv
         6S8ytMjupd4VSTIvwZHWmpm2DcKzE8rFvfzbwperAPk2oAvGZ0GsceX1gdIKvoyyXQrS
         iGsuGJij23khPAdZ6wceEe3UTGvmRGMe/IyivCVYUHbxSpxqN13bCUhSN6E1lNEwnClE
         cW4dscHuZwJmzB5ltoe8Wh/ZFV0i85Dp+6EYpuLbrhIiC4v2fMkdfrvK/cSQWDWKZXGj
         c6u9EOCMCIorRPdhOtuDtHrlxMv+JAfSz0QHdsg2xippYkTD/0PJ5p3yzakjBo+ij5S/
         QLGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZDmh4/2S;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZDmh4/2S;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Gavin Schenk <g.schenk@eckelmann.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.16 35/72] can: flexcan: fix endianess detection
Date: Mon, 14 May 2018 08:48:52 +0200
Message-Id: <20180514064824.644059395@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421877101965100?=
X-GMAIL-MSGID: =?utf-8?q?1600421877101965100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 0e030a373df3b8792b8991740fc31fe0629c6e58 upstream.

In commit 88462d2a7830 ("can: flexcan: Remodel FlexCAN register r/w APIs
for big endian FlexCAN controllers.") the following logic was
implemented:

	if the dt property "big-endian" is given or
	   the device is compatible to "fsl,p1010-flexcan":
		use big-endian mode;
	else
		use little-endian mode;

This relies on commit d50f4630c2e1 ("arm: dts: Remove p1010-flexcan
compatible from imx series dts") which was applied a few commits later.
Without this commit (or an old device tree used for booting a new
kernel) the flexcan devices on i.MX25, i.MX28, i.MX35 and i.MX53 match
the 'the device is compatible to "fsl,p1010-flexcan"' test and so are
switched erroneously to big endian mode.

Instead of the check above put a quirk in devtype data and rely on
of_match_device yielding the most compatible match

Fixes: 88462d2a7830 ("can: flexcan: Remodel FlexCAN register r/w APIs for big endian FlexCAN controllers.")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Gavin Schenk <g.schenk@eckelmann.de>
Cc: linux-stable <stable@vger.kernel.org> # >= v4.16
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/flexcan.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -200,6 +200,7 @@
 #define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error detection */
 #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offloading */
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error passive */
+#define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register access */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -288,6 +289,12 @@ struct flexcan_priv {
 
 static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN,
+};
+
+static const struct flexcan_devtype_data fsl_imx25_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE,
 };
 
@@ -1251,9 +1258,9 @@ static void unregister_flexcandev(struct
 static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
-	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_p1010_devtype_data, },
-	{ .compatible = "fsl,imx35-flexcan", .data = &fsl_p1010_devtype_data, },
-	{ .compatible = "fsl,imx25-flexcan", .data = &fsl_p1010_devtype_data, },
+	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, },
+	{ .compatible = "fsl,imx35-flexcan", .data = &fsl_imx25_devtype_data, },
+	{ .compatible = "fsl,imx25-flexcan", .data = &fsl_imx25_devtype_data, },
 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
@@ -1337,18 +1344,13 @@ static int flexcan_probe(struct platform
 
 	priv = netdev_priv(dev);
 
-	if (of_property_read_bool(pdev->dev.of_node, "big-endian")) {
+	if (of_property_read_bool(pdev->dev.of_node, "big-endian") ||
+	    devtype_data->quirks & FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN) {
 		priv->read = flexcan_read_be;
 		priv->write = flexcan_write_be;
 	} else {
-		if (of_device_is_compatible(pdev->dev.of_node,
-					    "fsl,p1010-flexcan")) {
-			priv->read = flexcan_read_be;
-			priv->write = flexcan_write_be;
-		} else {
-			priv->read = flexcan_read_le;
-			priv->write = flexcan_write_le;
-		}
+		priv->read = flexcan_read_le;
+		priv->write = flexcan_write_le;
 	}
 
 	priv->can.clock.freq = clock_freq;
