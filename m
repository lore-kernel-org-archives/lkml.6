Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+qKXps4bxBRUgnfmZTSbIaKvmqiI859Gr4luSgJqqFixKsKQWtoMH0J/swB7SF5DCU24Ml
ARC-Seal: i=1; a=rsa-sha256; t=1523399679; cv=none;
        d=google.com; s=arc-20160816;
        b=AcLvah+nX0lw1/Zu3+7psSXimmfUV5AszUeqX4UoZKkdhn9h/udhSZeI0st8ozFO0Q
         9q1+ecM/1hbr6UOVCJuhkyUwzcwo7SFKuXWqjZPk1Hjl57OStsT2RfhV/4OsNCpBAxHZ
         0lGbghlxKXm+rOfqZmRaB4DGnwSzXQmJGxoCZMkGEqGEaHca/JAvSgOoBlbiAUozFNzU
         Ka3O7AhNSTUiGKTCUyUoDtHlCtGx7UmhSlIbaY6ZffstAB4ZygdJEsE75hDKcUn9iV7l
         Ct5ccCZrf9SGElTZwZmfHwFf8lTV1ALHiF5OWua8BGIe+4nKqLLxkpVM+71jsToyF6nf
         5Vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YDjNQL3C0Lc2tI8TKlINa19SHtsTSnwJKVkyD/zoT4k=;
        b=bglTP4R/zMHZNsa+wWRQnmO2o907yENBXCwEuyIA1+k6RVOOoXC77HyWWa9dlJOHAh
         Y40FN/iHqPf/KWTf0xVvzHPnMzYNfs4ZgOiVBCucPaxfE1sQuf0tFDxh0/nYxLC+v9gE
         lkNqDGxjsZpvgNKm8bM/fxKMr58R5wc5GCK82RxHqaxL1Jnce2VmsnrArh1Z8GZcBsNc
         RvgNgucVWf/rG8zbpYhjHmCXk7v/jNSItYmSZF5u3b87oWFeS/4XbUxrgDzJI5wLmZLw
         3+C7YzwIbxX2vyGCxjig89RzA1IGSHkFCYcmHejQaSVPLKAWi3A4mN2KKV4m1tLzNqTm
         N65Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maciej Purski <m.purski@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 024/138] hwmon: (ina2xx) Make calibration register value fixed
Date: Wed, 11 Apr 2018 00:23:34 +0200
Message-Id: <20180410212904.942111524@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399952621184160?=
X-GMAIL-MSGID: =?utf-8?q?1597400341935730779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Purski <m.purski@samsung.com>


[ Upstream commit 5d389b125186cf254ad5b8015763ac07c151aea4 ]

Calibration register is used for calculating current register in
hardware according to datasheet:
current = shunt_volt * calib_register / 2048 (ina 226)
current = shunt_volt * calib_register / 4096 (ina 219)

Fix calib_register value to 2048 for ina226 and 4096 for ina 219 in
order to avoid truncation error and provide best precision allowed
by shunt_voltage measurement. Make current scale value follow changes
of shunt_resistor from sysfs as calib_register value is now fixed.

Power_lsb value should also follow shunt_resistor changes as stated in
datasheet:
power_lsb = 25 * current_lsb (ina 226)
power_lsb = 20 * current_lsb (ina 219)

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/ina2xx.c |   87 ++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 37 deletions(-)

--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -95,18 +95,20 @@ enum ina2xx_ids { ina219, ina226 };
 
 struct ina2xx_config {
 	u16 config_default;
-	int calibration_factor;
+	int calibration_value;
 	int registers;
 	int shunt_div;
 	int bus_voltage_shift;
 	int bus_voltage_lsb;	/* uV */
-	int power_lsb;		/* uW */
+	int power_lsb_factor;
 };
 
 struct ina2xx_data {
 	const struct ina2xx_config *config;
 
 	long rshunt;
+	long current_lsb_uA;
+	long power_lsb_uW;
 	struct mutex config_lock;
 	struct regmap *regmap;
 
@@ -116,21 +118,21 @@ struct ina2xx_data {
 static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
 		.config_default = INA219_CONFIG_DEFAULT,
-		.calibration_factor = 40960000,
+		.calibration_value = 4096,
 		.registers = INA219_REGISTERS,
 		.shunt_div = 100,
 		.bus_voltage_shift = 3,
 		.bus_voltage_lsb = 4000,
-		.power_lsb = 20000,
+		.power_lsb_factor = 20,
 	},
 	[ina226] = {
 		.config_default = INA226_CONFIG_DEFAULT,
-		.calibration_factor = 5120000,
+		.calibration_value = 2048,
 		.registers = INA226_REGISTERS,
 		.shunt_div = 400,
 		.bus_voltage_shift = 0,
 		.bus_voltage_lsb = 1250,
-		.power_lsb = 25000,
+		.power_lsb_factor = 25,
 	},
 };
 
@@ -169,12 +171,16 @@ static u16 ina226_interval_to_reg(int in
 	return INA226_SHIFT_AVG(avg_bits);
 }
 
+/*
+ * Calibration register is set to the best value, which eliminates
+ * truncation errors on calculating current register in hardware.
+ * According to datasheet (eq. 3) the best values are 2048 for
+ * ina226 and 4096 for ina219. They are hardcoded as calibration_value.
+ */
 static int ina2xx_calibrate(struct ina2xx_data *data)
 {
-	u16 val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
-				    data->rshunt);
-
-	return regmap_write(data->regmap, INA2XX_CALIBRATION, val);
+	return regmap_write(data->regmap, INA2XX_CALIBRATION,
+			    data->config->calibration_value);
 }
 
 /*
@@ -187,10 +193,6 @@ static int ina2xx_init(struct ina2xx_dat
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Set current LSB to 1mA, shunt is in uOhms
-	 * (equation 13 in datasheet).
-	 */
 	return ina2xx_calibrate(data);
 }
 
@@ -268,15 +270,15 @@ static int ina2xx_get_value(struct ina2x
 		val = DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_POWER:
-		val = regval * data->config->power_lsb;
+		val = regval * data->power_lsb_uW;
 		break;
 	case INA2XX_CURRENT:
-		/* signed register, LSB=1mA (selected), in mA */
-		val = (s16)regval;
+		/* signed register, result in mA */
+		val = regval * data->current_lsb_uA;
+		val = DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_CALIBRATION:
-		val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
-					regval);
+		val = regval;
 		break;
 	default:
 		/* programmer goofed */
@@ -304,9 +306,32 @@ static ssize_t ina2xx_show_value(struct
 			ina2xx_get_value(data, attr->index, regval));
 }
 
-static ssize_t ina2xx_set_shunt(struct device *dev,
-				struct device_attribute *da,
-				const char *buf, size_t count)
+/*
+ * In order to keep calibration register value fixed, the product
+ * of current_lsb and shunt_resistor should also be fixed and equal
+ * to shunt_voltage_lsb = 1 / shunt_div multiplied by 10^9 in order
+ * to keep the scale.
+ */
+static int ina2xx_set_shunt(struct ina2xx_data *data, long val)
+{
+	unsigned int dividend = DIV_ROUND_CLOSEST(1000000000,
+						  data->config->shunt_div);
+	if (val <= 0 || val > dividend)
+		return -EINVAL;
+
+	mutex_lock(&data->config_lock);
+	data->rshunt = val;
+	data->current_lsb_uA = DIV_ROUND_CLOSEST(dividend, val);
+	data->power_lsb_uW = data->config->power_lsb_factor *
+			     data->current_lsb_uA;
+	mutex_unlock(&data->config_lock);
+
+	return 0;
+}
+
+static ssize_t ina2xx_store_shunt(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
 {
 	unsigned long val;
 	int status;
@@ -316,18 +341,9 @@ static ssize_t ina2xx_set_shunt(struct d
 	if (status < 0)
 		return status;
 
-	if (val == 0 ||
-	    /* Values greater than the calibration factor make no sense. */
-	    val > data->config->calibration_factor)
-		return -EINVAL;
-
-	mutex_lock(&data->config_lock);
-	data->rshunt = val;
-	status = ina2xx_calibrate(data);
-	mutex_unlock(&data->config_lock);
+	status = ina2xx_set_shunt(data, val);
 	if (status < 0)
 		return status;
-
 	return count;
 }
 
@@ -387,7 +403,7 @@ static SENSOR_DEVICE_ATTR(power1_input,
 
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_value, ina2xx_set_shunt,
+			  ina2xx_show_value, ina2xx_store_shunt,
 			  INA2XX_CALIBRATION);
 
 /* update interval (ina226 only) */
@@ -448,10 +464,7 @@ static int ina2xx_probe(struct i2c_clien
 			val = INA2XX_RSHUNT_DEFAULT;
 	}
 
-	if (val <= 0 || val > data->config->calibration_factor)
-		return -ENODEV;
-
-	data->rshunt = val;
+	ina2xx_set_shunt(data, val);
 
 	ina2xx_regmap_config.max_register = data->config->registers;
 
