Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4+OJuXsC0BRso5ps3Lpa/fT4O/ajJbCbf4Ec5wiOV/0TL1TJyeJCtZx5k2646o+WXnmDERv
ARC-Seal: i=1; a=rsa-sha256; t=1524517729; cv=none;
        d=google.com; s=arc-20160816;
        b=MA0w04WS/k4/zQIjOG+qP56Zngv/ILWY5G34GTnhlE5LB0AtZHvruWQFl9BA0qj1lt
         QmA4vw7xxQvMw4SuQyFRnmdZ4D83qSbdXp7QyalD+kG4dOVB1xUS4+aGvtYwj4qEryEt
         vhEea5lK7+6s5O5BdYkRUw63aSyqFUKjmeNtITAaCZhF87/do5WiAJ2U6ZjtGFWQDD2h
         0VIhGE7gvAFRnJxTDcAox1rS/Svlfh4L7WFgX32n7TXUi6DtEHZVMSxS+lbi+yHcwTHf
         rMOtetDUn7liV9n/dc0RNsv16QMgH6fuB6fO1HRTaN8yj4DhBPvqXqaIvL8SP80emIsi
         gwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=d+uu0Su0fVV9Pe0MgQ7Iz3mBlfGGTX2FDbTySVN+d2Q=;
        b=nIk0sGBN4a6ozxFxMdQuuysoRoNwXalEjNh5ChjGPcJL9tCJwT0jptu80DL7IjxrtY
         DTldMHWrdfeVtAQS2jWdQp/gHw6qmsbHYApo2bfrOsAySQOj0EqBsdHi0hwG4ND+O/wM
         NlvsXW3CMu43xUgedzsK3Hy1g8hAXU3dLVyt2uGthyoGdOQ0GmyHbkycnh4rfk8KluG5
         mPtpSLRMz15E3smMcs4PcMb/tQdxXYgdemLO/H3MvxJfq7t8VHGstqw5x59ZPC3z8u9o
         E2Wn16HTonEY5PqTLxbksAepUzLsF0iACkQGTiNMFaW9T1E3nP9j91ns1kOyIghXcBXn
         akHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=BdPS+ThZ;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.103 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=BdPS+ThZ;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.103 as permitted sender) smtp.mailfrom=peda@axentia.se
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 4/4] iio: afe: rescale: new driver
Date: Mon, 23 Apr 2018 23:08:09 +0200
Message-Id: <20180423210809.29586-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423210809.29586-1-peda@axentia.se>
References: <20180423210809.29586-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::18) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:VnrSGW+bKP2jmL7/+w51MykSYpaKap98mBgrZWIBlqdSnJaVpj745Lju+FuDckS3ASW13RtkFvTXqDkGtHJFeGYB+5oX0knFoGcL8IlWlHu0noY3uv+Z7emeL/K4lmB/YcSOQSZPjJc2zz8Zds78JtSw33t8C9u+BhtM+FqJif69SWB9vl4UcxDJ87WYdqQLkdersdQTY1kME/3BHtp52DO2V34+7CXOXbQgFKsUMmWpzYBWqOf2wcnpnLcQtGnZ;25:PaTwzti8b2J4LCDeNe5R13Tk1JwBvn59oLIy/jJwK5rjGi7sBGDD39QV4234vuKi90t322T0EHQu0Jz1nQSwo0+sTvL89OCKfmEDaehNoMU0Zuvorh2N0u2aiXz1tkkMO+XkNUb3pa/F0XEpvVKJ3Rz246IceGr4sXd6kX/TGKEwTiLeLCKhVgedH5rDjuoKjwbxAk8Cgbh8QNGF2ME4R8J19WRFDnnLpuCEOe3piqgAPrDobsGa3ds0bhBTOPVWU7W0e7ngnuIsl5WkjYUNGZy3UfotuuX7gjc2CmlHwYnpdB+BlZqzHlLZvjxrdO5PFkaKSc+b6+IPI2tGg3s3Dw==;31:0/YbgKPdIEpFWQknlAInK7rAIYk3iEp/azLvGvtwPGooWyobX9gUhHFDHiA0Lr93BDUFT1I1g4IUg19R4Om1Ft+ttlEJ5/YrE9IADQGiGkN5lnIE/6cGqOY+ujUoMUX+CMfvlNMMGKlbQNbrQKSKEB4gMdMfIgO3IItpTLAotYIrpCiBw+9KvIOV1d0A6crDlUR9S1rhmz3I7h82of0Tp+N6TRCD8Us94HHPDkl53j8=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779C009A41775063289329EBC890@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:vqTIHGh8cs/Zg4v0P4/xhLefDIM0+vxy7GMmWcZme8gnXM3n2PNGqF6gTyurOUOOE1Ei5vNuFjZJJLEEwBJxe5kHEg2m3Yx3/Oe7yAK4R83gcPzbeXWqhcqSnIO+MzPrqePGPQMIt20rDWRS8gnz82/yl1kTsgUc3M52gK+UZoxO6TY5Q7zpvPKtgfwWs1nuk2VBlaQ7LYroOrcesA9RUGucWmEmbNgkBWFvM4kPb54iOTL6KhBqpfzRLb4MRpb1pIzRiDwThDeAzjZAg5jE3gon4mVl8C2bQm4Cf+a0Y+xsz5vI822weyRO98w89e9b
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(396003)(39380400002)(346002)(7736002)(5660300001)(8676002)(81166006)(305945005)(53936002)(25786009)(4326008)(8666007)(6512007)(39060400002)(11346002)(956004)(51416003)(446003)(2616005)(386003)(52116002)(54906003)(6506007)(8936002)(50226002)(76176011)(86362001)(476003)(316002)(36756003)(575784001)(16586007)(26005)(2906002)(1076002)(59450400001)(6116002)(16526019)(3846002)(186003)(478600001)(7416002)(48376002)(6666003)(6916009)(66066001)(6486002)(47776003)(2361001)(2351001)(74482002)(50466002)(42262002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:/04Da6f6RUigNgiSt5n9j3VD/ELxlIZu3RDL0KJ?=
 =?us-ascii?Q?ZZbKMVRIBkQZTQfSknD6vRMGLrkFsJEbr4Nq0J1obOixdxEo2jqzYUPs6CZN?=
 =?us-ascii?Q?ufxunmCE/PG8+dJHlZuGsX8T+7b3F5chW35XwECfCpcG3WXFwOoaGHgoPFHD?=
 =?us-ascii?Q?cE90LWabSk54LRBH8OQI5LPAqjlms4ncHjyCuSPMOu2zqqfCqMG1sE71/uNY?=
 =?us-ascii?Q?F0j1zGpKKIV11ZYmBUSbjK6bDDRBnK+xHP23PFRfbM+mxk54M1Oozpc3hpDF?=
 =?us-ascii?Q?JL8bS6CGWekyXxO8z34UDQmq5U9fLo4In7Ih/v1BkVC0CONh3wE1vBJXUCPV?=
 =?us-ascii?Q?tzGo5N9B8VOKeptbizfEwjAQvNuvu9XXv2i7SN6SBplhlt4lM9J7fVQB4cC8?=
 =?us-ascii?Q?76Vr+em2zADTVhtpjmEVkaDfQy4n7x0LIjj4/CZ4k3aDlUE1lN9Sgml7DxJR?=
 =?us-ascii?Q?a7DhDYkK4bDIovs12+0euQ1Tp7V3dd35LPN76TqtfndMZfrnLDrlBqDsAKFJ?=
 =?us-ascii?Q?eDesClzXS3SHZxOe4Z0IRdzsZuF0thzqaO7g4aTHVz+nuRBuCotFjfAU6bYi?=
 =?us-ascii?Q?sMDTFfwyhP+iDz3m9O8MlmiIP1xrkpkVAkP01CLGk4UzpcrWjJkq/GO+qL17?=
 =?us-ascii?Q?XQi9QlqfuWUMzneNpvjqtOSpHxbJQh4hbvIHlF2mqsK+G4HhF9hyrwncIFZ6?=
 =?us-ascii?Q?yDwvDoIOUag/ouGnpfZ92ze9VmUCYVJi9XhV2ZQRXQiWE9Lo4s3PPi0mJqjD?=
 =?us-ascii?Q?m4XeTMdtRSDw45dZa4x8Yb+oBuJ6ZdmgYoGZLhcZ1sUHLUnferaYFbkEBvS9?=
 =?us-ascii?Q?nw8SDL/iT4ORYuaGdLWofOXXJVX0CZxuQ4vl/IRheXpxE4yOybTdwK6p84yc?=
 =?us-ascii?Q?3dTWswZ6dQS67g89fftAtpud3u4mLvH++DYQO7aocugaBrHUyQSk0VLxcvaS?=
 =?us-ascii?Q?CWK99jUUGLWGivAa7OcKE31KYP7e77MiabRHp25SfGpvVcZtyldlFfwqBKau?=
 =?us-ascii?Q?bc4eBMXDrHGL9dgo6Ns3cuQjsBRwOcMM+6/vvmfa0EldQwXN2WOvLLr4UUvM?=
 =?us-ascii?Q?2rASCl6Mr9oDLENM8RL7De0BAR8WIGr2eQnppBTLl0MT1DtdHsewQypFWPV9?=
 =?us-ascii?Q?TE98/0cKQhM4FRWUiNO7jWZpOk6oWgZuMslkNjrYptFbAzKbmCvpPQ4H0Pzl?=
 =?us-ascii?Q?8n4RzenX3GmlmwQiv9TijNaijU9yx2+nW/kNxw+X+yuF72DKVQAutyFIcnU7?=
 =?us-ascii?Q?SRsOsrTX5wyv2AFTYURVmGdzpqxN5efKFCkSd2ACud7syyQR/162SXfY1hOU?=
 =?us-ascii?Q?gGQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 11/BvQI5m2cZPZErMxvYqH4L0A5G0D5Y3i1Yc4Ep0MjqD6WtOIX0PSLZdSVrCc7WvXa8AkxHZiolN4FrIz554qVUJXnkfGfjvLlk0pYnkTZDPKVFOOumIDMUW4fSz3QzxmI5khNW53yapGcknKD43COw+x8POj7nIg4WABl7Y9c9d/ZpYYS2hdoJcn8C+6Lo
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:SNpnbDpvkCKkV2lCPcYYGoxrdn5mcBaLFgDUCNUNRoUgD/g4asOWsdsP9l+2x9bdN8JhNPpmF3lnbjay2wyIny4wredknM9Iv4sg4G52p9BOcSGkKM8y03EqSbK8d8OnxrjygbE+IT0TOcHGtG10oQgw1+XMB50ZlWEeEohFiKY7eVBT4zM8waWJqgaPk6buVFSDkRgjBrKNv0nU4w6pyxlUsiZyrTytIeZ4Ot3DJ8pePEXY2jH8mWbAaJoHE5cTHiD0HpL8jyZL7uC0K4UK8he3Dl6fYSNwwFX+TgelHpS8+Vw7SxJNkyQwoXsiQiXpLL49++iJBtDjzHBtsoLApr+sVSevrZh6z5aeFlDpKqMKCq3JMSJ6IYXUi2yTOZoSymtN6Cz0EZPN4HsD6Iad4xMcw40EzKdwCCmyJm5fYZtSt129WEX+4p6O3uhENYzIW3/1S4RhSgZ3d5LPoMP9dA==;5:cnOG+/fXjL/mJoetEYaeK1GCSQGm55aihQcv+cV+/WwYx/JsKYdGyvw1V0QSp5SHzydHxKZsCBEDaEQk/L9GzVnYfyrYkzo2Cgn7LDW9TxQyJcXLwyw7lXr8hSP8MLHGai6EsVzX188nT5uJA33VM+JCn5VMOzTCVMCKTqXBElE=;24:5zzNMVbigLyjwF2yilxYto3TpB2RXNZmRqNxfpi/4BPdLUN+/iBvHipApSF52kxhE0Y+o6oWxpYljFguGMCu+8GWkWqFbMKNbQc6AhOrjqc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:H73Vvyl3RsfRQ513OevKkC0j3RKoNF2TaM92mOOrTIQm501eQ5jiJLGUwK9po4c89unbykD3p49RvGCYu0NafEEXukN4Gj1ocQ6j3GCE5+peRDPO3vMarAJ89HNDYK5K/RUgKJcQB1mMxQu3ftgt/tGzPFH6NbNC/HTUfEK57CXTnoAw+Orz4OQMCDMQtyIaUu2B4Xcgeu4xrmUlAOgRs/pgbzZsQcbwxAVf5W2yM+v2oV0ydDmKQKWBJHVvupWY
X-MS-Office365-Filtering-Correlation-Id: a17610e4-955b-4c59-ff02-08d5a95e663b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 21:08:43.5489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17610e4-955b-4c59-ff02-08d5a95e663b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572702079869779?=
X-GMAIL-MSGID: =?utf-8?q?1598572702079869779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If an ADC channel measures the midpoint of a voltage divider, the
interesting voltage is often the voltage over the full resistance.
E.g. if the full voltage is too big for the ADC to handle.
Likewise, if an ADC channel measures the voltage across a shunt
resistor, with or without amplification, the interesting value is
often the current through the resistor.

This driver solves these problems by allowing to linearly scale a channel
and/or by allowing changes to the type of the channel.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS                   |   1 +
 drivers/iio/Kconfig           |   1 +
 drivers/iio/Makefile          |   1 +
 drivers/iio/afe/Kconfig       |  19 +++
 drivers/iio/afe/Makefile      |   6 +
 drivers/iio/afe/iio-rescale.c | 359 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 387 insertions(+)
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-rescale.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b23e9ebff9c..73b8fc5dd2a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6896,6 +6896,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+F:	drivers/iio/afe/iio-rescale.c
 
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
index 000000000000..c91eef04825a
--- /dev/null
+++ b/drivers/iio/afe/Kconfig
@@ -0,0 +1,19 @@
+#
+# Analog Front End drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Analog Front Ends"
+
+config IIO_RESCALE
+	tristate "IIO rescale"
+	depends on OF || COMPILE_TEST
+	help
+	  Say yes here to build support for the IIO rescaling
+	  that handles voltage dividers, current sense shunts and
+	  current sense amplifiers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-rescale.
+
+endmenu
diff --git a/drivers/iio/afe/Makefile b/drivers/iio/afe/Makefile
new file mode 100644
index 000000000000..5fabb7bcac47
--- /dev/null
+++ b/drivers/iio/afe/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for industrial I/O Analog Front Ends (AFE)
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_IIO_RESCALE) += iio-rescale.o
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
new file mode 100644
index 000000000000..e9ceee66d1e7
--- /dev/null
+++ b/drivers/iio/afe/iio-rescale.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO rescale driver
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
+struct rescale;
+
+struct rescale_cfg {
+	enum iio_chan_type type;
+	int (*props)(struct device *dev, struct rescale *rescale);
+};
+
+struct rescale {
+	const struct rescale_cfg *cfg;
+	struct iio_channel *source;
+	struct iio_chan_spec chan;
+	struct iio_chan_spec_ext_info *ext_info;
+	s32 numerator;
+	s32 denominator;
+};
+
+static int rescale_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct rescale *rescale = iio_priv(indio_dev);
+	unsigned long long tmp;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return iio_read_channel_raw(rescale->source, val);
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = iio_read_channel_scale(rescale->source, val, val2);
+		switch (ret) {
+		case IIO_VAL_FRACTIONAL:
+			*val *= rescale->numerator;
+			*val2 *= rescale->denominator;
+			return ret;
+		case IIO_VAL_INT:
+			*val *= rescale->numerator;
+			if (rescale->denominator == 1)
+				return ret;
+			*val2 = rescale->denominator;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			tmp = *val * 1000000000LL;
+			do_div(tmp, rescale->denominator);
+			tmp *= rescale->numerator;
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
+static int rescale_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct rescale *rescale = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*type = IIO_VAL_INT;
+		return iio_read_avail_channel_raw(rescale->source,
+						  vals, length);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info rescale_info = {
+	.read_raw = rescale_read_raw,
+	.read_avail = rescale_read_avail,
+};
+
+static ssize_t rescale_read_ext_info(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     struct iio_chan_spec const *chan,
+				     char *buf)
+{
+	struct rescale *rescale = iio_priv(indio_dev);
+
+	return iio_read_channel_ext_info(rescale->source,
+					 rescale->ext_info[private].name,
+					 buf);
+}
+
+static ssize_t rescale_write_ext_info(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      struct iio_chan_spec const *chan,
+				      const char *buf, size_t len)
+{
+	struct rescale *rescale = iio_priv(indio_dev);
+
+	return iio_write_channel_ext_info(rescale->source,
+					  rescale->ext_info[private].name,
+					  buf, len);
+}
+
+static int rescale_configure_channel(struct device *dev,
+				     struct rescale *rescale)
+{
+	struct iio_chan_spec *chan = &rescale->chan;
+	struct iio_chan_spec const *schan = rescale->source->channel;
+
+	chan->indexed = 1;
+	chan->output = schan->output;
+	chan->ext_info = rescale->ext_info;
+	chan->type = rescale->cfg->type;
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
+static int rescale_current_sense_amplifier_props(struct device *dev,
+						 struct rescale *rescale)
+{
+	u32 sense;
+	u32 gain_mult = 1;
+	u32 gain_div = 1;
+	u32 factor;
+	int ret;
+
+	ret = device_property_read_u32(dev, "sense-resistor-micro-ohms",
+				       &sense);
+	if (ret) {
+		dev_err(dev, "failed to read the sense resistance: %d\n", ret);
+		return ret;
+	}
+
+	device_property_read_u32(dev, "sense-gain-mult", &gain_mult);
+	device_property_read_u32(dev, "sense-gain-div", &gain_div);
+
+	/*
+	 * Calculate the scaling factor, 1 / (gain * sense), or
+	 * gain_div / (gain_mult * sense), while trying to keep the
+	 * numerator/denominator from overflowing.
+	 */
+	factor = gcd(sense, 1000000);
+	rescale->numerator = 1000000 / factor;
+	rescale->denominator = sense / factor;
+
+	factor = gcd(rescale->numerator, gain_mult);
+	rescale->numerator /= factor;
+	rescale->denominator *= gain_mult / factor;
+
+	factor = gcd(rescale->denominator, gain_div);
+	rescale->numerator *= gain_div / factor;
+	rescale->denominator /= factor;
+
+	return 0;
+}
+
+static int rescale_current_sense_shunt_props(struct device *dev,
+					     struct rescale *rescale)
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
+	rescale->numerator = 1000000 / factor;
+	rescale->denominator = shunt / factor;
+
+	return 0;
+}
+
+static int rescale_voltage_divider_props(struct device *dev,
+					 struct rescale *rescale)
+{
+	int ret;
+	u32 factor;
+
+	ret = device_property_read_u32(dev, "output-ohms",
+				       &rescale->denominator);
+	if (ret) {
+		dev_err(dev, "failed to read output-ohms: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "full-ohms",
+				       &rescale->numerator);
+	if (ret) {
+		dev_err(dev, "failed to read full-ohms: %d\n", ret);
+		return ret;
+	}
+
+	factor = gcd(rescale->numerator, rescale->denominator);
+	rescale->numerator /= factor;
+	rescale->denominator /= factor;
+
+	return 0;
+}
+
+enum rescale_variant {
+	CURRENT_SENSE_AMPLIFIER,
+	CURRENT_SENSE_SHUNT,
+	VOLTAGE_DIVIDER,
+};
+
+static const struct rescale_cfg rescale_cfg[] = {
+	[CURRENT_SENSE_AMPLIFIER] = {
+		.type = IIO_CURRENT,
+		.props = rescale_current_sense_amplifier_props,
+	},
+	[CURRENT_SENSE_SHUNT] = {
+		.type = IIO_CURRENT,
+		.props = rescale_current_sense_shunt_props,
+	},
+	[VOLTAGE_DIVIDER] = {
+		.type = IIO_VOLTAGE,
+		.props = rescale_voltage_divider_props,
+	},
+};
+
+static const struct of_device_id rescale_match[] = {
+	{ .compatible = "current-sense-amplifier",
+	  .data = &rescale_cfg[CURRENT_SENSE_AMPLIFIER], },
+	{ .compatible = "current-sense-shunt",
+	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
+	{ .compatible = "voltage-divider",
+	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rescale_match);
+
+static int rescale_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct iio_channel *source;
+	struct rescale *rescale;
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
+		sizeof_ext_info *= sizeof(*rescale->ext_info);
+	}
+
+	sizeof_priv = sizeof(*rescale) + sizeof_ext_info;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof_priv);
+	if (!indio_dev)
+		return -ENOMEM;
+
+	rescale = iio_priv(indio_dev);
+
+	rescale->cfg = of_device_get_match_data(dev);
+	rescale->numerator = 1;
+	rescale->denominator = 1;
+
+	ret = rescale->cfg->props(dev, rescale);
+	if (ret)
+		return ret;
+
+	if (!rescale->numerator || !rescale->denominator) {
+		dev_err(dev, "invalid scaling factor.\n");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	rescale->source = source;
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &rescale_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &rescale->chan;
+	indio_dev->num_channels = 1;
+	if (sizeof_ext_info) {
+		rescale->ext_info = devm_kmemdup(dev,
+						 source->channel->ext_info,
+						 sizeof_ext_info, GFP_KERNEL);
+		if (!rescale->ext_info)
+			return -ENOMEM;
+
+		for (i = 0; rescale->ext_info[i].name; ++i) {
+			struct iio_chan_spec_ext_info *ext_info =
+				&rescale->ext_info[i];
+
+			if (source->channel->ext_info[i].read)
+				ext_info->read = rescale_read_ext_info;
+			if (source->channel->ext_info[i].write)
+				ext_info->write = rescale_write_ext_info;
+			ext_info->private = i;
+		}
+	}
+
+	ret = rescale_configure_channel(dev, rescale);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct platform_driver rescale_driver = {
+	.probe = rescale_probe,
+	.driver = {
+		.name = "iio-rescale",
+		.of_match_table = rescale_match,
+	},
+};
+module_platform_driver(rescale_driver);
+
+MODULE_DESCRIPTION("IIO rescale driver");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
