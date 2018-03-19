Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELuKCofwG+hqVJVq7gPL6OQfZkiImeE/1KPfQ0xWy2WdjyKQiNfyjnbn5U2vxXP7A7qyggnC
ARC-Seal: i=1; a=rsa-sha256; t=1521478994; cv=none;
        d=google.com; s=arc-20160816;
        b=YOlCEe2xGCn0CQxzFkjMJjI3jE9IAV/+yVBnS/5LqNORL1+N5zezC6Bpv1SPvGJ2Zu
         WH+4uUV2BDBXNaFO5HtR2QxFv9vWELvVylA0gP0UsaeDVH8P/GpQ0FvgpRaCkKEg6KtQ
         ahUl0wZEp44+TglOOHu2yCXkCSuGJQWV5UcpCmwH7LXLTVVR4zpBbdPh3EZRK/09sfbY
         W4/MUxc0EEeXVKbiwY8QViDu0KZg2wbYzljUicA1rxKUUewD9Bq/szpWzXLlRCGetebf
         iTrCbrYPP0rJm1uJJA9FT4m3733d761A/e25HG+hUJpM04tJEsiJO6Ws14ylXr6N9wVk
         J9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mkVsZJ50gqnNr1/Ylv9aQva6QzAumixwu73Le0vM3wo=;
        b=KJmgYxkxUOI5E0Y2UfKQH4awbtmg/nLqTpnf40el+EGDbs1lxJq3OrXERv/XsRUz4p
         pmSFAdf23LGxObL3X8kfb2CUaZfnV/3nRib8PiP6eAHMloTC4q0tiI9Yz5Rjq01k6KNe
         57PQ3eHBa1ZecDktzgxm7W2wEfbkvGisVpmO9/h8glRGSLEO2iWFwLeJKDCK/1+wMB6g
         PaSmL4dPhC7fqSgNKH6Rt7xLBlX3T1i4BPFgoOohh9MJLNpoo1dNYSeg1h+ctV/seuoi
         kkRzkSeup0wlIzNmYQdYAWw7LJpsBSbQa/J71V+HmTXipKLZlRR7dOphXt3cErDM4/NE
         s5UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=rVPPKb0A;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.120 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=rVPPKb0A;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.120 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] iio: wrapper: unit-converter: new driver
Date: Mon, 19 Mar 2018 18:02:46 +0100
Message-Id: <20180319170246.26830-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180319170246.26830-1-peda@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0048.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::37)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4140a4d2-5167-40cb-6f16-08d58dbb4c06
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:8S/cJBkgExvS6YCBz0FfsKjcV2vTio1sLTPOECsZTQ1aIpnW5fB5Xq3XRyawmgF//tfnakSP3E2uvFYyr3RJNNeDNiu2tn4uk+XTcj+NGS6n2u9dND6hsAOferpfB18qJFMr4pMNNJ6dMii+kMrmX2UdKEoNCmIKOKKTJcCl+sjnqNDoQzYrot9PyBvJTWCT1l1t3IahW3YsWeSwPYiCN89GHY485wiSxx2acNgrOaEaRDfBkIkh4ftqWhYEBarj;25:8ANHY6ypgF69ZNKNTw0iJjJZGtts7NInaHRiU5ikQZoc6NEUbo6BQ20yBPYEHGnYwqXYJxIiBXebkVHWAJH/NTvIMPt71CC9G+hhIv8jEws2ZUIKtEcx05drg16FgBF3XWqHD23pD9DL0LS4RLh+FraRLiHKvBUHPnv0FzU+NLcxF5Vvrjx6FnQIfxK1zVOdhwhhI+mIZgsP9qwoCmjMXfP0e1q+VGax5ps0hawZMRI5Iz4RtP92n1oWL3aDwsE0iEfQMXmk35gRzYlge1Q92IsScdAQSpNDIW6bMXuPdy5pQc3vbxtB2Gggq8BhwPa32KKyoYtVzeAlTEuTscG1ig==;31:VrOVvJ1r/YMzve6vHICJUn4EhEM64Ain6ClrDIcbBMOCLFDAl6tBPOt2r258hBpBMwXqNZ0ZvPc/9NUzASEulr+auwip30QufSKllpFzoLMQvBK70klGYnEIirRBI+Gx6O6uIe+aAPIAntsfM4dmPbNW2fa/w8/jo4V6AEbHyLqhuRLNDAawdlpVa14jKrNyKyJC3+MbUjcN0oixl/wtanVdEDjMRzr6gae4pdVUjkk=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769D4C5BD4DD60C48E7BD09BCD40@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:/PtAI8oAWs6Q7af6TNjgUhxuDMof/qQP2WVcXUio67iMl1qty2zbdXqBfr2+RKoB5tH5/3c6RqiLhdB5HqtYZq3Z45iXkbak8VtATdU3p9EPv5p3TtnFhZYVGPX61nyYwmKFBroJFUutTU3MHOgk5nATiogMfQ++/UrvPZcmuNn1wHEatbeLgmYL6q3Aq3Ht9NuP9Ue0RHs1eAEByH27z61eJPsM3/afRVWg1GoTxurM3XR+g5IlkoEAGRGcNfAcqQUHqw0O8sCs6pSRyqLXBs9iMKlnyNQEqbKvxL0iwcLGJQuclx6OLmMGBTv3aEXxMVxEJZo2N4ekhvE/6tU4Bw==
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39840400004)(396003)(39380400002)(346002)(199004)(189003)(76176011)(36756003)(48376002)(68736007)(50466002)(50226002)(66066001)(8936002)(6486002)(53936002)(51416003)(8666007)(52116002)(6512007)(7736002)(305945005)(105586002)(478600001)(3846002)(6116002)(2351001)(1076002)(2361001)(97736004)(6666003)(6916009)(54906003)(2950100002)(16586007)(74482002)(26005)(2906002)(4326008)(7416002)(386003)(6506007)(86362001)(81166006)(59450400001)(81156014)(8676002)(47776003)(16526019)(25786009)(186003)(316002)(5660300001)(106356001)(42262002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:NxJDY39PAR74/Zrm1ss5ArEbEx7Qz4//Yrwxpvu?=
 =?us-ascii?Q?mPps0F1gyR573Ga2WmGFm39B1AhVTzr1oNuMDaDyWoQwNhvHgrO+VIajO1Sz?=
 =?us-ascii?Q?NQdzBMwh8+0QlhfCCTpkqsbcG9vTS7UZgXGBsQdZRyhg7FjefH3VcdaXAKct?=
 =?us-ascii?Q?UNvRIqne8XnZFvFucRk3kyhctJIh1EFo+Y26SSDSQYk+YBgXnSbEESdDq2Zn?=
 =?us-ascii?Q?HvVsl+uhC4BrJfUdnUzYIhAcYfFuW4+B4a19DSszDR6SzngW1rWLbUUC8icH?=
 =?us-ascii?Q?INO8qFqRyucNChCUSL1fT/kY3kNFXlociuom/vB6SKg5QPUYGB6x4TNfnzCK?=
 =?us-ascii?Q?ZEyT+fBFCzEh+5qYdVtdmXVjiDjYZ99LsB6aLawLvSf7em53xgHmKxv35U2s?=
 =?us-ascii?Q?sgSxOPduP+yFFGC145l0GOzf9tubjsoq/LyyXFUBuIpNOUwlaviJ3qo6n+G3?=
 =?us-ascii?Q?SqP+B5QFqRCPdds8ddcFB8hMsgw6Bl+BA6lkPQy/wbS+HFc9gIn92TtCfO1V?=
 =?us-ascii?Q?XegnxJdlglcrmwFc8Km7Jrk6clWverhrRRdgnIOo/XYFNf/j5cfh4oc4rAII?=
 =?us-ascii?Q?1bblRHf/YzSmsHRe7tcHmaFQ5aGvHtyzso6PwLrvGXJtpTigKGhOHj+5x7Ce?=
 =?us-ascii?Q?/P3OcNFkqEoc6DZ04RtaW2Bxa/5XX2jw3m+Uguhtnpl3ST6iDIW5DRsCVGuE?=
 =?us-ascii?Q?SzIAxKSjb4Jcz85p6egXY9OyFk47CieifvmN+WLyeSqvMAe3j37RvPFQVO86?=
 =?us-ascii?Q?RgHe4W+dyCfkM4KsALb3AmCyGraioiIkXSEEpQICIRKAdhpio7Af/hYbzBHu?=
 =?us-ascii?Q?VcMLqAbIoE0yz0+/9497XnxcEH121Py6FZs92Xdz9VyqKFGge0LTLHTyYPDo?=
 =?us-ascii?Q?GxFTvV3iOo0QdANrpG6M+rcFKR3amJYAmUSbCoVjvhsJMrDqirHex95loOqj?=
 =?us-ascii?Q?yTpjobcxyfeYqaaBQB+rvAKT/HR1ou0UxCk8f7IPQ10QR2G1Gw78Z7G6TzkC?=
 =?us-ascii?Q?Q48MJCDxAVBJhmmkYiV1DXXJDBJhw7U75ogfaS/EUG9Atx+Whk0ViZq+L2fh?=
 =?us-ascii?Q?OFDJmb58QEtI2oZiVLT3MeIuCaXqzsUmvmUGGqjphJCC42yhUfDhOcSZ7OcI?=
 =?us-ascii?Q?Qgx51ffQuPvhLJGoOCaPaJTE2wR5kpWnGi8ahnNLn4AA2ZKVzQ7UnL5jCpKo?=
 =?us-ascii?Q?ItW9nww7DTkI7EK8zTJBPfyB+r4hGIdjlrSFlqrhmwkRY2kGUyWXCjlelUb4?=
 =?us-ascii?Q?KfBBfSMt/EIIUZaV8Jy4fruI0GtysQoN7jqeCuuxFnUh082cgg/+37JIvwDU?=
 =?us-ascii?Q?A/WrJ+Gpd3OFWOII52ZC23/U=3D?=
X-Microsoft-Antispam-Message-Info: Xikb/7pXC482c8ReNwVKsYdW8mGo/NwRcQsb88axeiaZNUXQBCBLQxijHvzJtq3irxPCH6jZyEhWyFNT7wQZl61SSD9MT60dK+QFDXswt5v+SjsbmNwZdLxXLF8e8nN14QGK4LbfGWVi08jws0Ys4eGIlnuoh7LL7+UFfPF7noF6/zKDb+/9iCuVhhZHWyWJ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:BxiPjbcRxNeI341v2yO5diXCBgZwvpH0QDjHF1KdGRVulSbXTChH3XCXGBqvXA9UqYi6CMUnJckdwsD2VxMCF6ibynVDp8ZyAPQoqmr8zEsCVkUhcZ37KdKBsvdWbEqZ5GPYfEPuF0z7kzxEXvH27OcoLweF62RTzwJAB6UfN8HrCUTFj9z7iH2YoAmstyAWdPJr56LVuPJVwR3wrWzqBihhUIM53Xhijv4021LBO5h6JKKh4D3Sfl9+ky2bOyePEEL91mIP226eTpZvr86TMOZJG4o9rBTw12SxbqiVPdHCvVVFLfzBAQT1TPY3YRWGW5lla+YSexAWz9cTZZd5yHKX87kN2flG7uwMHodKRVk=;5:iJMWYKHI65mJbu9WTsiEfp5EiEA6WZMbM3jepir/RogFMpSonzAJQw/quaG1wjwEBy2uvRlF2XlW1rtkB6B11hbWlvXG9Ubke/fhesNeP4PvJS2SOLpzls+wAhw4CoEVLB8jAilGl8gBnJ7YBkuuQVtd3jkG/ZTQ8oSI/qVZNRU=;24:XF7Dypun2FEtOSRJMA7aoGy0qWz1bNVaYBPmTgCs8JBUB0RQSJyiIcWJpeg4AMZuQRCOk13lmAxF43d2Vup0Jx6snJ0oR70OxELsOe5HSKk=;7:GcodvVpurlisGtK0h7ngoQUj2DmCS+qw6mqQpZMQ/7Ndy2hnSysd5UQRJmJ+vksLRoBpHaPdADzvFcmg8VQkx5Sk78S/duq+iLsdalboC3HdZHd/dI1THhlXKanjbt3qyPgIzbfZ+Y2oPoXLZ9M9XDwbryZ2EqU+l/xi74VaYB9vCwDI7ohV3lpI1j2HDrc5DGFNBmBuuxctWp+ziMGrswL+9d0RFYVAsZ34T+dECxnwI/mv/GGMuuEx3GpeiyCR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 17:03:10.7586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4140a4d2-5167-40cb-6f16-08d58dbb4c06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386357743794195?=
X-GMAIL-MSGID: =?utf-8?q?1595386357743794195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If an ADC channel measures the midpoint of a voltage divider, the
interesting voltage is often the voltage over the full resistance.
E.g. if the full voltage it too big for the ADC to handle.
Likewise, if an ADC channel measures the voltage across a resistor,
the interesting value is often the current through the resistor.

This driver solves both problems by allowing to linearly scale a channel
and by allowing changes to the type of the channel. Or both.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS                              |   1 +
 drivers/iio/wrapper/Kconfig              |   9 ++
 drivers/iio/wrapper/Makefile             |   1 +
 drivers/iio/wrapper/iio-unit-converter.c | 268 +++++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/iio/wrapper/iio-unit-converter.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dd555c7b1b0..b879289f1318 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6889,6 +6889,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
+F:	drivers/iio/wrapper/iio-unit-converter.c
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
diff --git a/drivers/iio/wrapper/Kconfig b/drivers/iio/wrapper/Kconfig
index f27de347c9b3..16554479264a 100644
--- a/drivers/iio/wrapper/Kconfig
+++ b/drivers/iio/wrapper/Kconfig
@@ -15,4 +15,13 @@ config IIO_MUX
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-mux.
 
+config IIO_UNIT_CONVERTER
+	tristate "IIO unit converter"
+	depends on OF || COMPILE_TEST
+	help
+	  Say yes here to build support for the IIO unit converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-unit-converter.
+
 endmenu
diff --git a/drivers/iio/wrapper/Makefile b/drivers/iio/wrapper/Makefile
index 53a7b78734e3..1b9db53bd420 100644
--- a/drivers/iio/wrapper/Makefile
+++ b/drivers/iio/wrapper/Makefile
@@ -4,3 +4,4 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_IIO_MUX) += iio-mux.o
+obj-$(CONFIG_IIO_UNIT_CONVERTER) += iio-unit-converter.o
diff --git a/drivers/iio/wrapper/iio-unit-converter.c b/drivers/iio/wrapper/iio-unit-converter.c
new file mode 100644
index 000000000000..53c126f39e4e
--- /dev/null
+++ b/drivers/iio/wrapper/iio-unit-converter.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO unit converter
+ *
+ * Copyright (C) 2018 Axentia Technologies AB
+ *
+ * Author: Peter Rosin <peda@axentia.se>
+ */
+
+#include <linux/err.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct unit_converter {
+	struct iio_channel *parent;
+	struct iio_dev *indio_dev;
+	struct iio_chan_spec chan;
+	struct iio_chan_spec_ext_info *ext_info;
+	s32 numerator;
+	s32 denominator;
+};
+
+static int unit_converter_read_raw(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   int *val, int *val2, long mask)
+{
+	struct unit_converter *uc = iio_priv(indio_dev);
+	unsigned long long tmp;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return iio_read_channel_raw(uc->parent, val);
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = iio_read_channel_scale(uc->parent, val, val2);
+		switch (ret) {
+		case IIO_VAL_FRACTIONAL:
+			*val *= uc->numerator;
+			*val2 *= uc->denominator;
+			return ret;
+		case IIO_VAL_INT:
+			*val *= uc->numerator;
+			if (uc->denominator == 1)
+				return ret;
+			*val2 = uc->denominator;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			tmp = *val * 1000000000LL;
+			do_div(tmp, uc->denominator);
+			tmp *= uc->numerator;
+			do_div(tmp, 1000000000LL);
+			*val = tmp;
+			return ret;
+		}
+		return -EOPNOTSUPP;
+	}
+
+	return -EINVAL;
+}
+
+static int unit_converter_read_avail(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     const int **vals, int *type, int *length,
+				     long mask)
+{
+	struct unit_converter *uc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*type = IIO_VAL_INT;
+		return iio_read_avail_channel_raw(uc->parent, vals, length);
+	}
+
+	return -EINVAL;
+}
+
+static int unit_converter_write_raw(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int val, int val2, long mask)
+{
+	struct unit_converter *uc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return iio_write_channel_raw(uc->parent, val);
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info unit_converter_info = {
+	.read_raw = unit_converter_read_raw,
+	.read_avail = unit_converter_read_avail,
+	.write_raw = unit_converter_write_raw,
+};
+
+static ssize_t unit_converter_read_ext_info(struct iio_dev *indio_dev,
+					    uintptr_t private,
+					    struct iio_chan_spec const *chan,
+					    char *buf)
+{
+	struct unit_converter *uc = iio_priv(indio_dev);
+
+	return iio_read_channel_ext_info(uc->parent,
+					 uc->ext_info[private].name,
+					 buf);
+}
+
+static ssize_t unit_converter_write_ext_info(struct iio_dev *indio_dev,
+					     uintptr_t private,
+					     struct iio_chan_spec const *chan,
+					     const char *buf, size_t len)
+{
+	struct unit_converter *uc = iio_priv(indio_dev);
+
+	return iio_write_channel_ext_info(uc->parent,
+					  uc->ext_info[private].name,
+					  buf, len);
+}
+
+static int unit_converter_configure_channel(struct device *dev,
+					    struct unit_converter *uc,
+					    enum iio_chan_type type)
+{
+	struct iio_chan_spec *chan = &uc->chan;
+	struct iio_chan_spec const *pchan = uc->parent->channel;
+	int ret;
+
+	chan->indexed = 1;
+	chan->output = pchan->output;
+	chan->ext_info = uc->ext_info;
+
+	if (type == -1) {
+		ret = iio_get_channel_type(uc->parent, &type);
+		if (ret < 0) {
+			dev_err(dev, "failed to get parent channel type\n");
+			return ret;
+		}
+	}
+	chan->type = type;
+
+	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
+	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
+
+	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
+		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
+
+	chan->channel = 0;
+
+	return 0;
+}
+
+static int unit_converter_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct iio_channel *parent;
+	struct unit_converter *uc;
+	const char *type_name;
+	enum iio_chan_type type = -1; /* default to same as parent */
+	int sizeof_ext_info;
+	int sizeof_priv;
+	int i;
+	int ret;
+
+	if (!device_property_read_string(dev, "type", &type_name)) {
+		if (!strcmp(type_name, "voltage"))
+			type = IIO_VOLTAGE;
+		else if (!strcmp(type_name, "current"))
+			type = IIO_CURRENT;
+		else
+			return -EINVAL;
+	}
+
+	parent = devm_iio_channel_get(dev, "parent");
+	if (IS_ERR(parent)) {
+		if (PTR_ERR(parent) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get parent channel\n");
+		return PTR_ERR(parent);
+	}
+
+	sizeof_ext_info = iio_get_channel_ext_info_count(parent);
+	if (sizeof_ext_info) {
+		sizeof_ext_info += 1; /* one extra entry for the sentinel */
+		sizeof_ext_info *= sizeof(*uc->ext_info);
+	}
+
+	sizeof_priv = sizeof(*uc) + sizeof_ext_info;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof_priv);
+	if (!indio_dev)
+		return -ENOMEM;
+
+	uc = iio_priv(indio_dev);
+
+	uc->numerator = 1;
+	uc->denominator = 1;
+	device_property_read_u32(dev, "numerator", &uc->numerator);
+	device_property_read_u32(dev, "denominator", &uc->denominator);
+	if (!uc->numerator || !uc->denominator) {
+		dev_err(dev, "invalid scaling factor.\n");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	uc->parent = parent;
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &unit_converter_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &uc->chan;
+	indio_dev->num_channels = 1;
+	if (sizeof_ext_info) {
+		uc->ext_info = devm_kmemdup(dev,
+					    parent->channel->ext_info,
+					    sizeof_ext_info, GFP_KERNEL);
+		if (!uc->ext_info)
+			return -ENOMEM;
+
+		for (i = 0; uc->ext_info[i].name; ++i) {
+			if (parent->channel->ext_info[i].read)
+				uc->ext_info[i].read = unit_converter_read_ext_info;
+			if (parent->channel->ext_info[i].write)
+				uc->ext_info[i].write = unit_converter_write_ext_info;
+			uc->ext_info[i].private = i;
+		}
+	}
+
+	ret = unit_converter_configure_channel(dev, uc, type);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "failed to register iio device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id unit_converter_match[] = {
+	{ .compatible = "io-channel-unit-converter" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, unit_converter_match);
+
+static struct platform_driver unit_converter_driver = {
+	.probe = unit_converter_probe,
+	.driver = {
+		.name = "iio-unit-converter",
+		.of_match_table = unit_converter_match,
+	},
+};
+module_platform_driver(unit_converter_driver);
+
+MODULE_DESCRIPTION("IIO unit converter driver");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
