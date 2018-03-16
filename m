Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuG74OfUHXQThcoSysgXMsO1r7C/BcQvbqUrcNc7Fk7ZF+zyhNxCuco99C1M7SJrNErYFd0
ARC-Seal: i=1; a=rsa-sha256; t=1521214594; cv=none;
        d=google.com; s=arc-20160816;
        b=TvNFqLk38XVwVGZln5OmQk0WoKXlVx1Ye7vrg1tFxW8222Bc58SWzGH5Um/6rAafdM
         Gt5Fb31GzVJXCJLFyp4EYHAVllGxfGJlDG/OohVD6FX31Z3dU+nI0hX/UliddHYjuo/a
         le8OMZxsiIMtgUvmtF4pUAU7m/EndvijjLQzCZ6itZVbSVKYXjWUkpOk1R7zcOIRxuQO
         K4ai+giCpI3f7nfGOPafquTchDhzOwcMPx7eNRg3xUVYAdUVHlbt/no4qjscdCLv58TE
         so6+rza/zFvdME5VSfRCEUelHPTW1ZAYS3RPdG3elXTTpCWNBeFk7gd2qtVC1ZUSkZft
         4pfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pS+yi0I6xqQnb2+vRHt7YRRkL7XLZCqrg2XUC/oVirY=;
        b=f71BvBAP5aCIWoYqi4vROzaarzaIJX5WYk96gRivR+va6WihR73uLWhYFx904dwMHd
         HJovFKeX6hBkc9+ICJVMY9jf1tDvA+mMHBTxCu8E5bZjAafYTVW9Z8Q0zN6OtwVuga6D
         d46a/nfn5MZ4i0UVcYz8TcPbFkQfLFkkGnkByJBMO5ckmelbWf6nfOwcyTiDAmPaRPbi
         gwESGll/WQdfPZcXVCQGJwKrkYBm0iVMUwen+EBw0tuEfMQGr7e2KQ9UKaE7EpGPInJz
         Dp3bBDxQGS1CDkUuXAfLBEyi/zpbTI3lPa3egkGjM5ZwwYfMAyRH6H7JHCJSu/+6q7P0
         MMPQ==
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
Subject: [PATCH 4.14 060/109] iio: adc: ina2xx: Shift bus voltage register to mask flag bits
Date: Fri, 16 Mar 2018 16:23:29 +0100
Message-Id: <20180316152333.191948541@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109114716361527?=
X-GMAIL-MSGID: =?utf-8?q?1595109114716361527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
