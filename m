Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx48g7LoeVGPcLFtxB8utZfjD/kOA5F36Trgu9xo0yPcm9HYaEZxps35GiXq+OVt6xOmLIspd
ARC-Seal: i=1; a=rsa-sha256; t=1523374114; cv=none;
        d=google.com; s=arc-20160816;
        b=Oh60ail8MC613cAzLNfJdChZC7f2/PqYY5qS+bST0fUG5oQn6hd2uiZnVJA052bV8E
         6MZx1PtDdvi+N0Q15wYrQqTKM2hQAqmy1YACvPODx9cgBK3PPv1xlMp+3tf5S6/a20kh
         dl0vioBaXvBRkrdhxBMP3fZWukRqVvIeUp4rqdj2yRpfJc4dV/t0p76V4lVvPOArfvZe
         8G2vv8U0WIf3pOVtvBo0Io9HVQ7u8JaywgzqwwgA39QsdOlF+Oion4afhLlWperSkGmu
         DwncHMii1FrSFxt7MbibP9/92Xf5StNff2D1dO+JFiY7HbUyLZqCXcHGulsnuH7kZeFg
         +b9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Ht6KhicgEUSG1Yfk3LPOB9bmWQcAJryyDxaCN1du0Lk=;
        b=o/1/bRmjNc2O16o+qfJRQMLBMmzkeRFJ1q8uT54xb1xtyite+tax+Qq1ZcaKCcDSfy
         BZ8X5FSA0d87yFDMnijqD+xwbxYhmdMFFnCxnla1K3dlthFoJyLOzcL8UiyI578VcUlL
         arH/KLdZeBh7/CF3zfL+Pjln8elaZXhUN8wI+5qE6s2eytWKZ26OWpn805cItOT38i4S
         7ccLEK5pgBbFwa/rOtbCnpSaKtvdf576cPQPxGC2H3aIkID6D2+sJxEHOdj2kP5AsNCc
         hoGjW8t2W+hSRm/hrNXSXNmJ/R2TAFWCWUrvVBtzdCsPSq8ANYkUUtObSbidykGLXHCa
         FtmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=Z7uwLvTk;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.5.110 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=Z7uwLvTk;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.5.110 as permitted sender) smtp.mailfrom=peda@axentia.se
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
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] iio: afe: unit-converter: new driver
Date: Tue, 10 Apr 2018 17:28:02 +0200
Message-Id: <20180410152802.30958-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180410152802.30958-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 272ce6e1-7fe6-4bd1-70ef-08d59ef7b6d4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:BivxeB0ggfccLMLR+FNEa+KpnG97Av4qSN00NnUwoaeVbENl7z/ZxXlsIGqzvvY/HcURgb5pOu8zhjDw7R/5yEmZCL+jEdXUrqbNMDlvc67uWrXN3TWgoa1ZO2kdbDvMm2RrIYgFvqd+RcPXXYCJ/kffgHqU8tFi3WpJyA3Gnu/Ms0a3Nc5uRlVQDt8drztPFZeeYiRhklurOF1Vd63FttCb31gjV6BtzjXOrCZANVEcFG26PnLdAtf0E5ATIzPw;25:XID5Ge4tWbD/YuVNQCZ2muaEveVdDBe1IN3q/iYIbLCBIgJMBhgDYJPumukz6kFGyyOckKVQkOSurS5vYTR60cG4oFDQcYfZ3OB0uwunCr/aEFHJ+njW7BP0Dtq21/Ml3hJItuicxFRb1Rk+kelhHcoZpiyZbVtaPVmeWRZo8U3PYtDAPayKWraNss+/xgNWyXs3IbiVLEJe05hmv3nXxjT5c37R2z0oY/XHsBGzuKqFbRiXL4llJ8rZ4Qf6f7JqmO1y/3XuysO4AjXmLTT4vTnNgfy107fwmtiDq9g0RzUgBNCMcUoDvVSGb92ZdQLihBiNjY9aGN7sI6jnWQdP/w==;31:UcZvGiJMCZTY3DzOi6ng0YUc8F4PoEiXITdwqFKNdhPG8Dy1vaS3538AefRcFLfhgxA0z2WK5bdt5Vig1OGwiHiRfCqPsx1bxCqk6r0NLATQiv3vtxuVGfocCIiPXGHq2N/21snyaeJ8CaNyNcJm+0za3VJ0zAOutYgvHQ9PFA+CSp9NvUN1up7js1rz7v8rTK99USpTigUWRiN8XVXtOzlRKKeH/1sRZQGBce3r6qM=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278460AC98C22619A87E68D3BCBE0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:OqVaV9Glxy9/IpNhxA+DRj2lLmASQGoASzgF3D46nQiaxUUR30ZSAedezgU7TiyELh7xfBQ7PpXwRB5a8PykiqO99uiBTUuauxkLvBF7gcpxTajXjNrcbvUnSbRND92EsIdCQXfMnXHsUO42LxaoqCGQm0HjV5BzWQs/6pbHNBzvoJ0amcNgh4XtcxKqHikw3dfYkZ8m1wJuAxx4dLIzEAZNzw68B63RPD6oJHbn/p3akv5WzD2t51ov0W72hd/lHlkJ1CMdm3kZGedEVwa0JcfKb+1S9omh4HZkXqpGXPjYey+o2NEQHsxx8i7hSUiuF4hWaPs+lyyG0DWdTba6Hg==
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(346002)(39830400003)(189003)(199004)(50466002)(8676002)(81156014)(2351001)(16526019)(186003)(81166006)(6116002)(575784001)(446003)(3846002)(1076002)(16586007)(76176011)(47776003)(51416003)(52116002)(6506007)(386003)(25786009)(2361001)(48376002)(486006)(956004)(11346002)(97736004)(2616005)(74482002)(26005)(86362001)(476003)(6666003)(2906002)(6916009)(8936002)(106356001)(105586002)(50226002)(6486002)(7736002)(6512007)(305945005)(8666007)(54906003)(36756003)(59450400001)(53936002)(478600001)(68736007)(39060400002)(316002)(66066001)(7416002)(4326008)(5660300001)(15866825006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:sAXozKHSapJAJJDkosqhAGWNt8UCPvGxttrZ17n?=
 =?us-ascii?Q?jMlewi3gODVVJVWJ7sODeBwttf3JI2pPFkFoNLmcOuCmqNAII4Ec4bJGWk1X?=
 =?us-ascii?Q?UC2ZNuDzf4Dmg/5h6QWhQ1QCzziFuzXr+uRoMGExFRUqlavzTQ11sKtwk9l0?=
 =?us-ascii?Q?Kqr2s5Vj07HC1E0nxuwcswEk40fb9hdbAWuIOa2W7pDkC84kS0RwfpPcFrcd?=
 =?us-ascii?Q?CJu2XDs4mizZsuW6U/Hb18IOncs+iKKdORM/mFv/vq5SZjq6gM6I/IIdEjWX?=
 =?us-ascii?Q?1erBiS+CPHKgBf/ao4bo2gp4qlbmt99T6T8TN6fU+v1HugyG8htX52zSdKSp?=
 =?us-ascii?Q?6rcX+vSKf4UXt6d0TBnVNIABiC8YFvEyWmzQdzzW5R6jjhjdXlPrXPnmyyuY?=
 =?us-ascii?Q?japVc0b1xD4qZl89DodUR4mUvmAygKJjvhAKeGd9iVk3dg/j+YDUhd1pgxU4?=
 =?us-ascii?Q?CVMO3dAMeSirNAlMQk3YWalFo6Sg2giq3d+cGVACRA2ywU/AB3YVCZLuvXHf?=
 =?us-ascii?Q?K5ZCbbnxaMMx3Q1j29thfDOOtYgIV56AGRavKR2TTD8GKk+CNBsCHXJdBdtq?=
 =?us-ascii?Q?P3VkpBexWruWVcgMb27Qv8U5MtmaMKVBVbfQsorhNvSHf2LN0Rv1TrxmEipJ?=
 =?us-ascii?Q?gfoHZskQ3j9ETwJtOlNlKgQ88PfVrjLNUpp0uu2quragkSNo9thunSaeLNxr?=
 =?us-ascii?Q?J4eF9m31UBJgHf1khETb14/5bFU0Bxm4qhqaSQIqNnpBLkZnUBYPKRE38crM?=
 =?us-ascii?Q?eTxycpYZOOHuv15x3RNLYCpZutyepEfXUYQBV/kV1a8irJrbtG4oynWvrDAS?=
 =?us-ascii?Q?NbwWTKkq/Pqpxx//Dn57kmdBWSxgrrcwkgEo6zVawcwj76cwN59v19rHjYkx?=
 =?us-ascii?Q?skIY8s2GAHqttKeglCiYB6DtaAn17lNK+y5677PluHC+A5Sizei8H8vL1iJ1?=
 =?us-ascii?Q?MMFPPsTZvcEedi2yUvc6AeAxgDQVXeo+a7jdzOhvowAnilxbR4N1w0c2Da6t?=
 =?us-ascii?Q?oXvqUH6Wm5iuTgDTbYmc/JF2IaLQjJ3Tw/bXlGElzCCYLo5GvWN3wIW3cQwX?=
 =?us-ascii?Q?Z4Ikj8dgYJE8iDlwfSILD0hsvohn/JOcnPEO0yoplChxLTkdunQSfSDZ4U1a?=
 =?us-ascii?Q?dKOHpRkmznpw2Io86emVLCQWrj13uqM4hm/YXhDcrxN1FyKc7Vgck+2/Pg+f?=
 =?us-ascii?Q?gMfxaYAAIrQqIhv+bwhYWgMLyci+gmtj82lbUmSgZkGtvKJMOaT/kttXOsDn?=
 =?us-ascii?Q?iAic9v4cRg4LK663bz3wXkVRLfQlGdBYsOODQYx1fLA8Hpw/j/yNkJRttj5L?=
 =?us-ascii?Q?kjf0ba40iXfqryGu+ZbfXyKa9v+i1P+SHYEs+vzmBfX/SNso6qxHjHZmnpsN?=
 =?us-ascii?Q?Ep+TGCuuIJmeWzfLFAaVmyAEZeUnnDGyNVZUQ9xoLAVAWJnANagFFx4lndYb?=
 =?us-ascii?Q?xtawEIXIWnxF3Hakntl70rTS45X5cWI8=3D?=
X-Microsoft-Antispam-Message-Info: FvdkjNwnvlg+1A5xxTZglIL2rJWUGMltGezUwe7qWcxaEuxntMCuHcYpDp2ZxtEe4pvAaN8Gpvr22S7Wy4KeATj+0qRRMVp4EwwBJ3jRO1v10MJppvcN/Zict2w+Wum8KYmvYwF2f6XgHO4HHsNsQffT9IP98n4yXFbzB4EonTX9go0y2SA7MnzZ+IrZ3IyZ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:DXgfjaQ9aWMnqfJj2fr+1YJayZZsHBL9MWtAUPvy/JaxKKmM+WpvDABz4TiW57jub41sn+jmvbMnaP8vP+ncdGzGbqk3uWjr1ccBswSc92jJQ1D6AXh49pYuUvBsO/nlutMxzFN7XobJrMi2KfMVqqbx8Nxypc4sY/i1Y/7IDdlL86nN/fFprcY0H7rT64lzUrTwCos+40OgZcYUF2Qao2P3CyiH8pjFOtGeCY9VZ3IqjCsVUWuwPCNIsT2Bgced47BNw1/6256f8nJxjP4P75q7QXgFpitUJjsBTg18z/lqp8acXVcvWXpTMNwL77PCdBoFg5EoaX9YF8NNt9kk3iFm9v41k1DdqMYJAFCxGubv3QGwEWbcnLkxce7urfmFwRG6cZTHsEPVAQUliqgQY/4/A5SyEj3CBjSimQnZqDryVM2brWExO5AVDCOfNjMjmXyWYTbIX37pScZmlr+c0Q==;5:btskkhJLgVNaGCWa1661nZiPtyJH+wbEdqqV/BNDQw6vo4L5VWIHTwJc8YZH621zJ1wCRGsGeyw0FU1XaQihV7iZ1PPe9J98VRCjZMTf7FXGROnDsEcE7F/hsgxT/tZlOEJxJl50RacBsCYhYzqlxyin07ry/b01QT77JgcGoAo=;24:Z1xqwTSh7DQlDGEFCSjRuYJKA5pEu5yb6wrfAhAwlSh/ocCEFCw1H0dr4MI8tglXU5E99LstIgaz7Gan9WQTBUpKfXhs6l1/aA8NDDRUUX0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:TGHx7tCggDxISrzFBA1dReOyFA8IDO0A5H91A4Eu0RRzq2ZQdTU+HKPNCbRYhNE21QpoX4TNryhGl1BjslwOckvB0bsegsIiC87JhWjLGOD0/KVQhtkuM+X8/3PqV1fOT5ENkKfVTxr/52Ypx4iSGLzKCNyfBzwDtB9zjXgoJJUmF5cqgyP80bzksVWpCf1jnNQSFd4VG8i9Eu/PKIEOPDkwXW48wSh6sCMXvpZPXqp7WyH2grMARfkRRsHqI+Na
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:28:29.1936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272ce6e1-7fe6-4bd1-70ef-08d59ef7b6d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373534966690766?=
X-GMAIL-MSGID: =?utf-8?q?1597373534966690766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If an ADC channel measures the midpoint of a voltage divider, the
interesting voltage is often the voltage over the full resistance.
E.g. if the full voltage is too big for the ADC to handle.
Likewise, if an ADC channel measures the voltage across a shunt
resistor, the interesting value is often the current through the
resistor.

This driver solves both problems by allowing to linearly scale a channel
and by allowing changes to the type of the channel. Or both.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS                          |   1 +
 drivers/iio/Kconfig                  |   1 +
 drivers/iio/Makefile                 |   1 +
 drivers/iio/afe/Kconfig              |  18 +++
 drivers/iio/afe/Makefile             |   6 +
 drivers/iio/afe/iio-unit-converter.c | 291 +++++++++++++++++++++++++++++++++++
 6 files changed, 318 insertions(+)
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-unit-converter.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 237fcdfdddc6..d2a28b915fca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6893,6 +6893,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+F:	drivers/iio/afe/iio-unit-converter.c
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b3c8c6ef0dff..d69e85a8bdc3 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -70,6 +70,7 @@ config IIO_TRIGGERED_EVENT
 
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
+source "drivers/iio/afe/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/chemical/Kconfig"
 source "drivers/iio/common/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index b16b2e9ddc40..d8cba9c229c0 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
 
 obj-y += accel/
 obj-y += adc/
+obj-y += afe/
 obj-y += amplifiers/
 obj-y += buffer/
 obj-y += chemical/
diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
new file mode 100644
index 000000000000..642ce4eb12a6
--- /dev/null
+++ b/drivers/iio/afe/Kconfig
@@ -0,0 +1,18 @@
+#
+# Analog Front End drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Analog Front Ends"
+
+config IIO_UNIT_CONVERTER
+	tristate "IIO unit converter"
+	depends on OF || COMPILE_TEST
+	help
+	  Say yes here to build support for the IIO unit converter
+	  that handles voltage dividers and current sense shunts.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-unit-converter.
+
+endmenu
diff --git a/drivers/iio/afe/Makefile b/drivers/iio/afe/Makefile
new file mode 100644
index 000000000000..7691cc5b809a
--- /dev/null
+++ b/drivers/iio/afe/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for industrial I/O Analog Front Ends (AFE)
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_IIO_UNIT_CONVERTER) += iio-unit-converter.o
diff --git a/drivers/iio/afe/iio-unit-converter.c b/drivers/iio/afe/iio-unit-converter.c
new file mode 100644
index 000000000000..fc50290d7e5e
--- /dev/null
+++ b/drivers/iio/afe/iio-unit-converter.c
@@ -0,0 +1,291 @@
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
+#include <linux/gcd.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct unit_converter;
+
+struct unit_converter_cfg {
+	enum iio_chan_type type;
+	int (*props)(struct device *dev, struct unit_converter *uc);
+};
+
+struct unit_converter {
+	const struct unit_converter_cfg *cfg;
+	struct iio_channel *source;
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
+		return iio_read_channel_raw(uc->source, val);
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = iio_read_channel_scale(uc->source, val, val2);
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
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EINVAL;
+	}
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
+		return iio_read_avail_channel_raw(uc->source, vals, length);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info unit_converter_info = {
+	.read_raw = unit_converter_read_raw,
+	.read_avail = unit_converter_read_avail,
+};
+
+static ssize_t unit_converter_read_ext_info(struct iio_dev *indio_dev,
+					    uintptr_t private,
+					    struct iio_chan_spec const *chan,
+					    char *buf)
+{
+	struct unit_converter *uc = iio_priv(indio_dev);
+
+	return iio_read_channel_ext_info(uc->source,
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
+	return iio_write_channel_ext_info(uc->source,
+					  uc->ext_info[private].name,
+					  buf, len);
+}
+
+static int unit_converter_configure_channel(struct device *dev,
+					    struct unit_converter *uc)
+{
+	struct iio_chan_spec *chan = &uc->chan;
+	struct iio_chan_spec const *schan = uc->source->channel;
+
+	chan->indexed = 1;
+	chan->output = schan->output;
+	chan->ext_info = uc->ext_info;
+	chan->type = uc->cfg->type;
+
+	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
+	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
+		dev_err(dev, "source channel does not support raw/scale\n");
+		return -EINVAL;
+	}
+
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE);
+
+	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
+		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
+
+	return 0;
+}
+
+static int unit_converter_current_sense_shunt_props(struct device *dev,
+						    struct unit_converter *uc)
+{
+	u32 shunt;
+	u32 factor;
+	int ret;
+
+	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				       &shunt);
+	if (ret) {
+		dev_err(dev, "failed to read the shunt resistance: %d\n", ret);
+		return ret;
+	}
+
+	factor = gcd(shunt, 1000000);
+	uc->numerator = 1000000 / factor;
+	uc->denominator = shunt / factor;
+
+	return 0;
+}
+
+static int unit_converter_voltage_divider_props(struct device *dev,
+						struct unit_converter *uc)
+{
+	device_property_read_u32(dev, "numerator", &uc->numerator);
+	device_property_read_u32(dev, "denominator", &uc->denominator);
+
+	return 0;
+}
+
+enum unit_converter_variant {
+	CURRENT_SENSE_SHUNT,
+	VOLTAGE_DIVIDER,
+};
+
+static const struct unit_converter_cfg unit_converter_cfg[] = {
+	[CURRENT_SENSE_SHUNT] = {
+		.type = IIO_CURRENT,
+		.props = unit_converter_current_sense_shunt_props,
+	},
+	[VOLTAGE_DIVIDER] = {
+		.type = IIO_VOLTAGE,
+		.props = unit_converter_voltage_divider_props,
+	},
+};
+
+static const struct of_device_id unit_converter_match[] = {
+	{ .compatible = "current-sense-shunt",
+	  .data = &unit_converter_cfg[CURRENT_SENSE_SHUNT], },
+	{ .compatible = "voltage-divider",
+	  .data = &unit_converter_cfg[VOLTAGE_DIVIDER], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, unit_converter_match);
+
+static int unit_converter_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct iio_channel *source;
+	struct unit_converter *uc;
+	int sizeof_ext_info;
+	int sizeof_priv;
+	int i;
+	int ret;
+
+	source = devm_iio_channel_get(dev, NULL);
+	if (IS_ERR(source)) {
+		if (PTR_ERR(source) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get source channel\n");
+		return PTR_ERR(source);
+	}
+
+	sizeof_ext_info = iio_get_channel_ext_info_count(source);
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
+	uc->cfg = of_device_get_match_data(dev);
+	uc->numerator = 1;
+	uc->denominator = 1;
+
+	ret = uc->cfg->props(dev, uc);
+	if (ret)
+		return ret;
+
+	if (!uc->numerator || !uc->denominator) {
+		dev_err(dev, "invalid scaling factor.\n");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	uc->source = source;
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &unit_converter_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &uc->chan;
+	indio_dev->num_channels = 1;
+	if (sizeof_ext_info) {
+		uc->ext_info = devm_kmemdup(dev,
+					    source->channel->ext_info,
+					    sizeof_ext_info, GFP_KERNEL);
+		if (!uc->ext_info)
+			return -ENOMEM;
+
+		for (i = 0; uc->ext_info[i].name; ++i) {
+			if (source->channel->ext_info[i].read)
+				uc->ext_info[i].read = unit_converter_read_ext_info;
+			if (source->channel->ext_info[i].write)
+				uc->ext_info[i].write = unit_converter_write_ext_info;
+			uc->ext_info[i].private = i;
+		}
+	}
+
+	ret = unit_converter_configure_channel(dev, uc);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
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
