Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeCHT7F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:59:05 -0500
Received: from mail-eopbgr10115.outbound.protection.outlook.com ([40.107.1.115]:45083
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752377AbeCHT66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:58:58 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: potentiometer: mcp4018: driver for Microchip digital potentiometers
Date: Thu,  8 Mar 2018 20:58:30 +0100
Message-Id: <20180308195830.16348-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180308195830.16348-1-peda@axentia.se>
References: <20180308195830.16348-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0006.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::16) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0af67a2e-0715-4a1d-268b-08d5852f05f8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:JCau5Fx1Zae1RyCXB8bf8eLNg6+oEaW3yTQdiy1gU2FW+yn19Y4RB40K26Kp9UFUt4dbahuJrDoMWCqOvSZ2dZ+jM7cL8i9LADrmb4yF2p817ul2lDWn9Q+NgJe5kNxxdnHUaqnxQKbuYV6hGEbIG02rf2UyIBJn4KnGnzsvvDCbcOwbYbg333mQpI/3ut9gtIGSi6r9M/g+stslzBTKzzbJ27lhYchCNSKVtl2b8kWcgbCKYszjbebwQ1G9p+Si;25:P1aC5Bggsa9+phOMUCl6c0UlPrSmmwp0deps+3fMAzB0hn8iZ9E9blssFeWUp2Hao2e2nNKIl6mhSlGDmMhi51t/0dyb4G5TGt2GHOGV8dVBLn0HAqhhht82DFrfNOTMG/QD5TU04WIF58TVgztKZNxbnCyeyPkGhwpyqVRlLfF1pJD/tKII/r5UBarioAyzwb1XC5XGrsuGuEFkmyA32X5ov4aghMPHxx5cb85cmzjLEvuGogT7wmxI8N/cfNS/6zQRG4IvzVIecdH1mzq0IrXwe/pnqDiwcx7SkzZy7I0OHPrhp46KkpTOqLb4bMhvki8sqqUoLzJ0xqsBxBVLuA==;31:CgRfGIKBaLUVxiXw09f1Mhyg3vWwMOfa2CbXOFq4zCvTAW5sj//N0keWaZcLsN53jjhJKimGBDhbd3gu1jlPY11ogj8FlhBC0d1nVV49eT/wSGjDeYsEFeqLDDptQ2mO5TInzLOzD5UOLIV7WQM36hnws8s7EnnRZVjUNge7wlDygeyI2oCKAvrkjQWqS7xC+LPh8eH/W7EwzkCL22Jik/wjhCzqlNf1LE6qnqZg90k=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277228BEC64F68CB92B19550BCDF0@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(152791735303576);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(2016111802025)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:KwxCk4Eyq0mzdnhkeMUJ5wva/5Y9OyNBx3B90vqbOt3tdRfRw0Gg4jwjTOPGaQLCJDWXIJKuPeD8JB7VZlwj4iGM/cEEC69/RPO3FS4GwUgxKMmGDNa6LoxZINjlLw8iRBqV9MPCqgbGnmpsfE+ClWIP2rqFkD0i0vlkv7wSbP4ZYJpc6UPEq2QB6ofG4bBAtrnrhHvXbMfXUjcQ8ZLUZYAlg1ewND7v6rP8jh43dDjKfLH+FfZwvhQdXR8PqUXfP+iB9h8e/bec5GquBbwEBtVWhvjPYWT4nMwu6R9ARRTNkIEh3I1V47WKVaet0CbwQzGNimIk5knvLxbsckc4n720WuMEatf5EcfG1VJseK8=
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39830400003)(376002)(39380400002)(199004)(189003)(66066001)(26005)(47776003)(81166006)(2361001)(81156014)(59450400001)(305945005)(2950100002)(6486002)(7736002)(6666003)(8676002)(186003)(6916009)(16526019)(316002)(106356001)(8936002)(50226002)(74482002)(68736007)(36756003)(2351001)(6506007)(97736004)(386003)(5660300001)(51416003)(52116002)(105586002)(4326008)(3846002)(76176011)(2906002)(54906003)(6512007)(966005)(86362001)(478600001)(6306002)(48376002)(8666007)(50466002)(25786009)(53936002)(1076002)(16586007)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:IVwJ6Kn/Uyt2R2ojOwGJQBL0OYtYcQR+RmcK82c?=
 =?us-ascii?Q?8uJ/Xo/MgQTxVBmphWweHteEsiDDviIWjjFWyBbzc/HKHJyXlJgpwXawRpA3?=
 =?us-ascii?Q?SiipYnvEgjNqRATJhGD+BVkjM6tjB5W61vFM8W+Z0S42pQaEWpgFa3DM+fET?=
 =?us-ascii?Q?DjN4QTN/xkCfnpJqu1wkjxqHZ62O7ErW/uIuJkG1JYOjE0IAC0JsND4S+rsC?=
 =?us-ascii?Q?NCxXVrq/OTb9nfH01MKuj4eRmCj2RgDaQafccpdx+3ep7oS6Uqs5ahi34ozR?=
 =?us-ascii?Q?jxvEXICmz2pDPkdGFbXjenLDWh9p51UCfC3u4PBajmlUzaiJDPhucMv4q0un?=
 =?us-ascii?Q?MpodWrIhlH0SYaeFSA4mqwGhtUrX8HkLKnscFOqiuyCSjUX2axu/Hhlikmt/?=
 =?us-ascii?Q?kEeNs6MQWjSJS5GDVSZy8PcfXxy6huZdQg8ABY6WMTScnKHc54140MqTRZPE?=
 =?us-ascii?Q?OPI4iYjSb4CNFwkj3ssJOemKN3dK/IDVn58K5I7i+Jd6C39iaqOlsO0iRLMT?=
 =?us-ascii?Q?wVJILBTHmI8bt2tY+ec3pBK1sCDbVxif9It/oyvV8h122O5vTu0ymAyL1zAK?=
 =?us-ascii?Q?5zRvsHivKm0tM5AFLlHLBUUcHIF3BdYPmeg8QNDcrLGoquIAQnAAsVqQUKY+?=
 =?us-ascii?Q?8m7hjXLw9NM0xGGtbHTEdzkGHJWS5WJpMXXdVVTT73RnXlKhL/4O08DHsO8x?=
 =?us-ascii?Q?SypLh8cQxMztMqcFX4ZMpYstT/oNYJiHoPkxBfGbY7M3dQH+EC5z3G425/Vi?=
 =?us-ascii?Q?psnvzhkYhIeB4aBILGA++2eJAZBSPSAqgVHNbTyZYMWqtafVp8/41RKSCIk4?=
 =?us-ascii?Q?STlQWwIHIGtknq7K9EFBEpZ/UfAB/y4DpOrmZ2SugnO6sBnzK7bshiTHr+EB?=
 =?us-ascii?Q?3eyTMtlRSjBXos47AWFJ5TJ8S8C9urhr4ckZXiQH8lFiWdzXCgu+8vlv4fBZ?=
 =?us-ascii?Q?sIOhBkZpZwdc/XHc1f9Zfm9TNpbSIDZ5J3kKNZa+icjf3tSQWw9719Mg8P1P?=
 =?us-ascii?Q?ONBbhKMKYRxljujYcMKxTvoHPZzrizBD8CZklTTVLhzNJ66feQUKQKz1F2ew?=
 =?us-ascii?Q?KNfxmRZJjmynLybMiKajiNqJtnAkN+qLTdiju4uP8YrlPQoEcD1dxBXXs406?=
 =?us-ascii?Q?HJUlldP8hEINCUXfEB6Z8rmkRoiaa0Ii9bQ6FZehA9WfhHGaB+6hvTRXS4fW?=
 =?us-ascii?Q?nZWfU967lCTGFfPlphykZjIEebKWkLpI0PWjl+GqVYuVYJZx4UzjAmnT3Bsk?=
 =?us-ascii?Q?pyQYIeR/69m7Fn4+40PjnWg8xk/oe8EOcDeCiAwSUM06xf218Tir31wyBOa6?=
 =?us-ascii?Q?/Gg=3D=3D?=
X-Microsoft-Antispam-Message-Info: Fv3hAt+bOYpn3NLOhatDq9FGpRmhP0uuMHRApPf7JmPfkgD2QQbvpmGJHzghh1qFCwUGz61hN3DdQ8VLmlK/q8cb3Q3jQ7Lguf2iwG2cu5BubHlxxzveVGxLN1beC3PVfAr0VcE32OCZ0jyDEuUVAJ/9locUKFKgSiLSubprVNybaRHTn0LZ15pVWl4oFJLz
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:u8ZSNmgEupN8LnpzduLRxKXQPvQQh5pA38de15h/QsRJarriAEN0NE2lJsydqmRv1tq7eGhKi37+qbqROdlSUrDKTxCgK7gxQdG0nScWEUy2tK9JKaIMWJcNSbcSjAKGSCxqee1l9wjoBb1D76qWaQH1YniH93k5x8EqE1AyrYsYNBKeCKP8TRA+4zmo0yde/6DL1d7IsZjLrOHGuVR3BSzn8Xq0zvYraSL29M6L+ecnFry7iM5SopYH8949LKNNu1UVbTuIX8YCTNpDTzZI0NN1z+wf7j8IRdRhXE8Pt75/xRSjdBTTkefFIgWt2+aqngl6IbvH54CFhTN2WKRoGGlVBaxFh3dD1HGU8BZmABw=;5:MBhhp8bp/a7US4ApVgb6iHNpYITdZa7JiuRp7+PTDhio/s8lwixUz4FQY1SNH3HtyqX3I2ErsUvIWYbhIEHBujZiycOqyl9cYUua8mWzWYGIiQxl+vRHU8sE/PV5By8QSLU5bWoy05+wQ3xJH6V1DhTmOHuPNe8PLFhIOHcuBU8=;24:cnoUYeZ3TfikjY/Bin4/gTPsM17gT1BRZ3eZBow3/N/xAuT03v7DdrLHnp3DoaRnVdc3Xo1uCnijaKnhBOaqLGsrD/hMrSSNaPBQ9FXyqek=;7:Pu7PTF+BvQVwNcUuVmApoKFJvZdKTwoPVpCG2tfjIFOfxPOjHKVuk4VNaqYb6VPqmaBUaDipl2s8x9edU7kSHBS9I6XDBz4Lf/tVc/WRBX365S1YMYFKUfFx1Ug0edwG7F0HYWzUmL9ww438mzrjUdn86a8bPUJ1Qi5amnVmKSt3twry7H/382E0RAMFgvADA2RZmHHIt4WMuWMeGPqqzzBJE+v2/YaXVSEKgvzhMkL8hMsloB99XAQ8vQBfdn+d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 19:58:54.6649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af67a2e-0715-4a1d-268b-08d5852f05f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Microchip digital potentiometers and rheostats
	MCP4017, MCP4018, MCP4019

They all have one wiper with 128 steps and come in 5, 10, 50 and 100 kOhm
variations.

Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22147a.pdf

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS                         |   3 +-
 drivers/iio/potentiometer/Kconfig   |  11 ++
 drivers/iio/potentiometer/Makefile  |   1 +
 drivers/iio/potentiometer/mcp4018.c | 194 ++++++++++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/potentiometer/mcp4018.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf8d72d..81527c75adee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8589,11 +8589,12 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-maxiradio*
 
-MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVER
+MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
+F:	drivers/iio/potentiometer/mcp4018.c
 F:	drivers/iio/potentiometer/mcp4531.c
 
 MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 8bf282510be6..84bdbcd53114 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -37,6 +37,17 @@ config MAX5487
           To compile this driver as a module, choose M here: the
           module will be called max5487.
 
+config MCP4018
+	tristate "Microchip MCP4017/18/19 Digital Potentiometer driver"
+	depends on I2C
+	help
+	  Say yes here to build support for the Microchip
+	  MCP4017, MCP4018, MCP4019
+	  digital potentiometer chips.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mcp4018.
+
 config MCP4131
 	tristate "Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X Digital Potentiometer driver"
 	depends on SPI
diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
index 1afd1e70f8cc..0cff8a2916d5 100644
--- a/drivers/iio/potentiometer/Makefile
+++ b/drivers/iio/potentiometer/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_DS1803) += ds1803.o
 obj-$(CONFIG_MAX5481) += max5481.o
 obj-$(CONFIG_MAX5487) += max5487.o
+obj-$(CONFIG_MCP4018) += mcp4018.o
 obj-$(CONFIG_MCP4131) += mcp4131.o
 obj-$(CONFIG_MCP4531) += mcp4531.o
 obj-$(CONFIG_TPL0102) += tpl0102.o
diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
new file mode 100644
index 000000000000..601b25d1f387
--- /dev/null
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Industrial I/O driver for Microchip digital potentiometers
+ * Copyright (c) 2018  Axentia Technologies AB
+ * Author: Peter Rosin <peda@axentia.se>
+ *
+ * Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22147a.pdf
+ *
+ * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)
+ * mcp4017	1	128		5, 10, 50, 100
+ * mcp4018	1	128		5, 10, 50, 100
+ * mcp4019	1	128		5, 10, 50, 100
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#define MCP4018_WIPER_MAX 127
+
+struct mcp4018_cfg {
+	int kohms;
+};
+
+enum mcp4018_type {
+	MCP4018_502,
+	MCP4018_103,
+	MCP4018_503,
+	MCP4018_104,
+};
+
+static const struct mcp4018_cfg mcp4018_cfg[] = {
+	[MCP4018_502] = { .kohms =   5, },
+	[MCP4018_103] = { .kohms =  10, },
+	[MCP4018_503] = { .kohms =  50, },
+	[MCP4018_104] = { .kohms = 100, },
+};
+
+struct mcp4018_data {
+	struct i2c_client *client;
+	const struct mcp4018_cfg *cfg;
+};
+
+static const struct iio_chan_spec mcp4018_channel = {
+	.type = IIO_RESISTANCE,
+	.indexed = 1,
+	.output = 1,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+};
+
+static int mcp4018_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct mcp4018_data *data = iio_priv(indio_dev);
+	s32 ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = i2c_smbus_read_byte(data->client);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1000 * data->cfg->kohms;
+		*val2 = MCP4018_WIPER_MAX;
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	return -EINVAL;
+}
+
+static int mcp4018_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct mcp4018_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val > MCP4018_WIPER_MAX || val < 0)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return i2c_smbus_write_byte(data->client, val);
+}
+
+static const struct iio_info mcp4018_info = {
+	.read_raw = mcp4018_read_raw,
+	.write_raw = mcp4018_write_raw,
+};
+
+#ifdef CONFIG_OF
+
+#define MCP4018_COMPATIBLE(of_compatible, cfg) {	\
+	.compatible = of_compatible,			\
+	.data = &mcp4018_cfg[cfg],			\
+}
+
+static const struct of_device_id mcp4018_of_match[] = {
+	MCP4018_COMPATIBLE("microchip,mcp4017-502", MCP4018_502),
+	MCP4018_COMPATIBLE("microchip,mcp4017-103", MCP4018_103),
+	MCP4018_COMPATIBLE("microchip,mcp4017-503", MCP4018_503),
+	MCP4018_COMPATIBLE("microchip,mcp4017-104", MCP4018_104),
+	MCP4018_COMPATIBLE("microchip,mcp4018-502", MCP4018_502),
+	MCP4018_COMPATIBLE("microchip,mcp4018-103", MCP4018_103),
+	MCP4018_COMPATIBLE("microchip,mcp4018-503", MCP4018_503),
+	MCP4018_COMPATIBLE("microchip,mcp4018-104", MCP4018_104),
+	MCP4018_COMPATIBLE("microchip,mcp4019-502", MCP4018_502),
+	MCP4018_COMPATIBLE("microchip,mcp4019-103", MCP4018_103),
+	MCP4018_COMPATIBLE("microchip,mcp4019-503", MCP4018_503),
+	MCP4018_COMPATIBLE("microchip,mcp4019-104", MCP4018_104),
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mcp4018_of_match);
+
+#endif
+
+static int mcp4018_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct mcp4018_data *data;
+	struct iio_dev *indio_dev;
+	const struct of_device_id *match;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE)) {
+		dev_err(dev, "SMBUS Byte transfers not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	match = of_match_device(of_match_ptr(mcp4018_of_match), dev);
+	if (match)
+		data->cfg = of_device_get_match_data(dev);
+	else
+		data->cfg = &mcp4018_cfg[id->driver_data];
+
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &mcp4018_info;
+	indio_dev->channels = &mcp4018_channel;
+	indio_dev->num_channels = 1;
+	indio_dev->name = client->name;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id mcp4018_id[] = {
+	{ "mcp4017-502", MCP4018_502 },
+	{ "mcp4017-103", MCP4018_103 },
+	{ "mcp4017-503", MCP4018_503 },
+	{ "mcp4017-104", MCP4018_104 },
+	{ "mcp4018-502", MCP4018_502 },
+	{ "mcp4018-103", MCP4018_103 },
+	{ "mcp4018-503", MCP4018_503 },
+	{ "mcp4018-104", MCP4018_104 },
+	{ "mcp4019-502", MCP4018_502 },
+	{ "mcp4019-103", MCP4018_103 },
+	{ "mcp4019-503", MCP4018_503 },
+	{ "mcp4019-104", MCP4018_104 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mcp4018_id);
+
+static struct i2c_driver mcp4018_driver = {
+	.driver = {
+		.name	= "mcp4018",
+		.of_match_table = of_match_ptr(mcp4018_of_match),
+	},
+	.probe		= mcp4018_probe,
+	.id_table	= mcp4018_id,
+};
+
+module_i2c_driver(mcp4018_driver);
+
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
+MODULE_DESCRIPTION("MCP4018 digital potentiometer");
+MODULE_LICENSE("GPL");
-- 
2.11.0
