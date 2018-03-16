Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsNp1shKaHcIOoHUWt9I/e4rz6VC94qthlbYKGu4S737mXYRHsFrHR4b/0bBEkvCIbttM1E
ARC-Seal: i=1; a=rsa-sha256; t=1521214948; cv=none;
        d=google.com; s=arc-20160816;
        b=muafWHogoAB8bnHW9pnjmOj8zkASRVpOnJBtbWYzwkRMuFZSQ/3UeLaGAHeMztDa93
         +TJghC62xnKMY0nXH4tBjcL6A126aF79sFkb+562f9WhDFyy70qacwYRiXyG3qBgGhwZ
         MBEO6QxzutZi/A4AUIaWgnWo83L07n/+kTEoK+4PYc2NmsxiKS9tYSM8690inwoymRLQ
         2kobF4WXrvXak90EHWvtFAlezgmWHALwEZJlAS30BCNKOejlCjdPBgjS6ixJaEHa6fnL
         NoWPPg6+SUkx/aP4OBJTAXftUmrVUvBSRQmKUeeLiFvIaZR3iZxyBQe66tJmc7N6VPsE
         zPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L9tDtC9SELTjnSk/nDypU2o7izdVbq6ECsT40tW3Vpo=;
        b=KhIHKDT48cS8m+rBxgQV9HKMI08MMUgmMyVFHKUjPgCiPxmaPsJ+bJpcG1OAaDIRVk
         tI/vSMZnTsuzMGemSPiR0dsNgy6JOrUDlCv4FtgsWYXVds2hRFAg34SIl+t5YfD7dRhO
         0XNsFqs0xkDwq9kHp7xcWdDIi2iKUH/1gA1LdnHXByrXbctObuNA8m2EfgvW7W4zzC59
         xsd13YCMWN9Y8+KnVyYjYeVSCGnxBw8QfZpcfXY9h/Mt0mEmeK6n1D1On+HhMe1trqyN
         na0vhNuvUolhFTrq3EnZv6WNeDFoU+u/nYIuLAeB612d50EirnISHw2ebGctYh7OfvWQ
         aSsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 073/128] iio: adc: ina2xx: Shift bus voltage register to mask flag bits
Date: Fri, 16 Mar 2018 16:23:34 +0100
Message-Id: <20180316152340.347633534@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109114716361527?=
X-GMAIL-MSGID: =?utf-8?q?1595109485723855894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Stefan Brüns" <stefan.bruens@rwth-aachen.de>


[ Upstream commit 2e64438487697f3f099946edc8acd4ceea6b1ab2 ]

Lower bits of the INA219/220 bus voltage register are conversion
status flags, properly shift the value.

When reading via IIO buffer, the value is passed on unaltered,
shifting is the responsibility of the user.

Signed-off-by: Stefan BrÃ¼ns <stefan.bruens@rwth-aachen.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ina2xx-adc.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -44,7 +44,6 @@
 
 #define INA226_MASK_ENABLE		0x06
 #define INA226_CVRF			BIT(3)
-#define INA219_CNVR			BIT(1)
 
 #define INA2XX_MAX_REGISTERS            8
 
@@ -79,6 +78,11 @@
 #define INA226_ITS_MASK		GENMASK(5, 3)
 #define INA226_SHIFT_ITS(val)	((val) << 3)
 
+/* INA219 Bus voltage register, low bits are flags */
+#define INA219_OVF		BIT(0)
+#define INA219_CNVR		BIT(1)
+#define INA219_BUS_VOLTAGE_SHIFT	3
+
 /* Cosmetic macro giving the sampling period for a full P=UxI cycle */
 #define SAMPLING_PERIOD(c)	((c->int_time_vbus + c->int_time_vshunt) \
 				 * c->avg)
@@ -112,7 +116,7 @@ struct ina2xx_config {
 	u16 config_default;
 	int calibration_factor;
 	int shunt_div;
-	int bus_voltage_shift;
+	int bus_voltage_shift;	/* position of lsb */
 	int bus_voltage_lsb;	/* uV */
 	int power_lsb;		/* uW */
 	enum ina2xx_ids chip_id;
@@ -135,7 +139,7 @@ static const struct ina2xx_config ina2xx
 		.config_default = INA219_CONFIG_DEFAULT,
 		.calibration_factor = 40960000,
 		.shunt_div = 100,
-		.bus_voltage_shift = 3,
+		.bus_voltage_shift = INA219_BUS_VOLTAGE_SHIFT,
 		.bus_voltage_lsb = 4000,
 		.power_lsb = 20000,
 		.chip_id = ina219,
@@ -170,6 +174,9 @@ static int ina2xx_read_raw(struct iio_de
 		else
 			*val  = regval;
 
+		if (chan->address == INA2XX_BUS_VOLTAGE)
+			*val >>= chip->config->bus_voltage_shift;
+
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -203,9 +210,9 @@ static int ina2xx_read_raw(struct iio_de
 			return IIO_VAL_FRACTIONAL;
 
 		case INA2XX_BUS_VOLTAGE:
-			/* processed (mV) = raw*lsb (uV) / (1000 << shift) */
+			/* processed (mV) = raw * lsb (uV) / 1000 */
 			*val = chip->config->bus_voltage_lsb;
-			*val2 = 1000 << chip->config->bus_voltage_shift;
+			*val2 = 1000;
 			return IIO_VAL_FRACTIONAL;
 
 		case INA2XX_POWER:
@@ -532,7 +539,7 @@ static ssize_t ina2xx_shunt_resistor_sto
  * Sampling Freq is a consequence of the integration times of
  * the Voltage channels.
  */
-#define INA219_CHAN_VOLTAGE(_index, _address) { \
+#define INA219_CHAN_VOLTAGE(_index, _address, _shift) { \
 	.type = IIO_VOLTAGE, \
 	.address = (_address), \
 	.indexed = 1, \
@@ -544,7 +551,8 @@ static ssize_t ina2xx_shunt_resistor_sto
 	.scan_index = (_index), \
 	.scan_type = { \
 		.sign = 'u', \
-		.realbits = 16, \
+		.shift = _shift, \
+		.realbits = 16 - _shift, \
 		.storagebits = 16, \
 		.endianness = IIO_LE, \
 	} \
@@ -579,8 +587,8 @@ static const struct iio_chan_spec ina226
 };
 
 static const struct iio_chan_spec ina219_channels[] = {
-	INA219_CHAN_VOLTAGE(0, INA2XX_SHUNT_VOLTAGE),
-	INA219_CHAN_VOLTAGE(1, INA2XX_BUS_VOLTAGE),
+	INA219_CHAN_VOLTAGE(0, INA2XX_SHUNT_VOLTAGE, 0),
+	INA219_CHAN_VOLTAGE(1, INA2XX_BUS_VOLTAGE, INA219_BUS_VOLTAGE_SHIFT),
 	INA219_CHAN(IIO_POWER, 2, INA2XX_POWER),
 	INA219_CHAN(IIO_CURRENT, 3, INA2XX_CURRENT),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
