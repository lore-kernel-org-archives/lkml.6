Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4/+OSFyQJS5HWKciCiRuTDdbqJtEb1BA/f0PJ8qKEOpABo+6++2xlQIWKY4/hAz/PrqW79G
ARC-Seal: i=1; a=rsa-sha256; t=1522769820; cv=none;
        d=google.com; s=arc-20160816;
        b=MUnuL18aqKmKTF97KIzkrkSozV7Au9DNK7E1Uf9smevU4uQpg9zL4qkqmo1veUBZqJ
         qTY38+PcPC1zOQUUNUJtgZCA/xkKi8qVWYjqlltDEpkhbOzX7THmtPBC8//IjHpd3he7
         jk5bLeT7aCCqQ/YMVsn6Z7D96nW+tXVlVBwx7q/3kY2jIAD80XNPnpeqjq0xdk+RfaHF
         x3f653bwq57t8eVGpLvlM8Msuh7rsPHSrQWnuOn3fTiaj1adFrxNvm9ES3VDEkyO9BLf
         3nk0Pqj+31LnJPaHkTtPUQCFgdqm2tjo6p2bi1h/i1IUAxKavfiBj/gj55cQUFJKmODx
         YkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=2yEtz3XWkVD0DtR7SSF+wD7UwPLTLuoILXp/ulYrK3E=;
        b=wmSwx9ztwHHXOPWxwpbwAaaizN2386m1iJibXO3Yj1TszzzLv8CF5B4GvFuMKnnrzB
         p9GtzRMO9CIKzx7QK+xAjpNhWr/audRyNkYrxBAo9bi3z9DEBB61WYs1Ie5ZTXOGVjip
         xkdRmojRuEHl8Gl0y0y0zR4P+tLwXom3lfwLtOgHmuphTgkwOw7RLMEi9zEmsWwNkT0p
         gBdUhZCW9Lq8hhRtMkYr8SPlzJn8vbvhSxtUerDg/Fn5Pn4Mcd4Ph/k5JiN1+ZzmzVSc
         p0QjIhyqVA/GHJA0fKpT2rhIvD/GaLamJD7KrIQtcQf0g6JQSf4j78/1JXqVa6uTXCGp
         l9HA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=U1qoq6n3;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.131 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=U1qoq6n3;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.131 as permitted sender) smtp.mailfrom=peda@axentia.se
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
	Michael Hennerich <michael.hennerich@analog.com>,
	Phil Reid <preid@electromag.com.au>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] iio: afe: unit-converter: new driver
Date: Tue,  3 Apr 2018 17:36:35 +0200
Message-Id: <20180403153635.8228-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180403153635.8228-1-peda@axentia.se>
References: <20180403153635.8228-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0101CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::14) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e5da91-1a2f-4d57-8643-08d59978bc58
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:getS7qEh8W4bGoVrgj+M87EFkW6FSn5ryPG+VQJ+bMQH5MpEEcUArdlm/U7uZgYP70Ar6IvZfU3jfM2gjmjQC5ZDNTf3j59dOIf/CVGrkj5+Chsv7+VzAbUoaK1gQ/JRr2lqUtOjna0Js6X77XCpSpCTDmbo0BFs+JUB2yr+p2qW9FzZBAeRGQXB2gCdej3yY40Ox2KEHjgwlTOxFOxpHikQQsQTDw2RgWkwwTOLtUi5nTUd79QxT+e2rMRRnfKl;25:jZRt+nGKbsMTx3yPYCTmhM6Sw6/fksN9STxaEMe51+Fd5Rw5O23/F9o+JDKFMaBGyEkpoL9uy4y5ouL64zbyhaKn+J1NkHilo0X3qqLAXPuXNwt4HDBSoIRbC7g/0+WbJNR20JJjKekuPz4+JV/ZPanFXDJinkZFkzsrAWHWxkiplyBImSDc19FyVzXvVuVSm8jAOzd9liQuufCBCoVhlR3Rhr5earRbI7ReWTiRAqQDV7JD154smr0Het61MXlK7Oy2LMSEgqq1GK6T3e+XPtB8Uxb3zwIb4ZldlX76F1163rwlhtQlcdErJYyaO+7qWmfN7lYxq7GtvWoLyIiF6w==;31:0E86DCbh2kFMZ9Qts+T1xjhtqOHkCs1fXC2EOQaW5uLSQ1mPzky/GWjZ8hUjN0/8UdceC9c1hGWJo8Lr3mCnxMe05y5rBBYeP0p4k65UxsbxDxMudLdOgpnmschL3XfvN3Hg8yn1JfXNcSCaFKSJDr0dfIWnT2sd42CRxZ5/opqRovvayDGp2VEHZVo1XRv+lps6VAp52qikCyfRMvQN8meHvPimv3TRhL3xIzK7hO8=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27723329E58D98460C3F472DBCA50@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:mGS0t67XGNzZk3aV/S+LguEyLIZ4xdb5LxWsF5n48tckSHAthHGGwrB51wTC5FRFrsuf7gS0BNv8YPMCWQqHtilb4IffivKocbd3eO3ym0wlDwy3NCh8GVJnb7mpjy/q6MA7bRxRaAiMwFAT52KXFiXMoIrS4zOwaDcud6ooW4QE9FZp/6apF07hcmaa4Bgpf2e5EH3N50C6h6BKfwAZyza0M/vbNLnjxCArzVphBZjijciprqd3CvaHtk/u269namwzTV0q06/Hrl+8IHF5AvCDd8vkyggAMl4QyYbELsPS2D08DUKX4PcXZv2kbdRWdhrADlYgyNKH+bqRyHAUWQ==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(366004)(396003)(376002)(39380400002)(189003)(199004)(47776003)(6512007)(476003)(105586002)(53936002)(76176011)(16526019)(186003)(66066001)(97736004)(52116002)(4326008)(106356001)(51416003)(6486002)(8666007)(36756003)(59450400001)(6916009)(25786009)(6506007)(11346002)(486005)(54906003)(386003)(26005)(446003)(956004)(486005)(2616005)(81166006)(81156014)(6116002)(50466002)(575784001)(2351001)(316002)(74482002)(2361001)(1076002)(16586007)(8936002)(5660300001)(50226002)(68736007)(48376002)(3846002)(2906002)(7736002)(305945005)(6666003)(7416002)(478600001)(8676002)(86362001)(42262002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:hs7Fh7g03WH9tWMol+GzfV4tPjfyimN5RRIwNrA?=
 =?us-ascii?Q?iJWR/Nsy7/0s2Z4i8W5FegzoLcB0E0w1FR1SR5r3en9h0ch8m+qVRvyfmmvD?=
 =?us-ascii?Q?AMevSLx5YPWJAc8/+vnwYHKEYPpzLak0bwaSJ9qKX7ti+h5j12KRy47K2Aty?=
 =?us-ascii?Q?sWTfYA11wbNzUyh9hmNlAaoQ3GGc21Ed2I01E+F/DIgoWnkwFjpYFgUr7led?=
 =?us-ascii?Q?Pzy0I/sbORmytBp0FyXgnKBYuVwK2JfOAwpM9L2Huue2UahG5C6VoNG0pPDT?=
 =?us-ascii?Q?10ghfs22DF+DTW1SG9YSHSDuF9cWtBlELnyI8Ysv9EJbLqD4eKZxhYDT07rc?=
 =?us-ascii?Q?vrRCCq3aohqgaJ9c/SfHDfdwfV+qf09aZ/ii+6I12KV9pVuykymvYrZduYP6?=
 =?us-ascii?Q?fcxSOl7BlChPealGYjMjKXql0h0rAZX0KjesbWun6PQcB0FX2Zyjcof8iMqT?=
 =?us-ascii?Q?UeC4J8OIpJGEpFdLDMjNAuxBWBb2KtC/pcwn7GFhOQ2INLZWfYw8AB6K0wuK?=
 =?us-ascii?Q?HReGhe6QDdXaF0R2fWqQRKiW3yb5FfonjSIPALT+hM8tXIpPlkTgBlrcOSYb?=
 =?us-ascii?Q?SFRny7jRe13jKWzI2bBtaIZdWqqHCk+2SQdE8oOdv3r2o0h4GQoL9/VRcqpR?=
 =?us-ascii?Q?cuq0g/MRq/HwpV0dyJcSOlbIAESnmvqswJaz9YoJHgsW0F8r73tXrnIN8ieQ?=
 =?us-ascii?Q?XHkqfecb6oaiaBUCLZTxqz1a3zteDO0PTf4DPo5/m89CflV/sYvPp5b7MRyn?=
 =?us-ascii?Q?vpWgAYnRQDljf8lx5rJGJOIR0Z086TpUcR23YO5EwwH4scs9rz8kCwxfrq9J?=
 =?us-ascii?Q?8oYgTvPw+8d/wOieBGqyAxAkFiv6SQCNGzO2fX/tWDi0vCnHw4Qyzy/QfHxN?=
 =?us-ascii?Q?EACmC0SKeEZ6mZrqB0L4ZlppW3kAXSnLoK38AtlWrvO+/Ff+p5fU5BrCOPGZ?=
 =?us-ascii?Q?zEpnNGk0yXHasivyqifsGg6jwQEnKbSBRi/6i6VMnxsSNNu2jx+gGlgxAXx9?=
 =?us-ascii?Q?PGDjhZWHH7J1fxoDImXivN6wrUNLJGohHxpWFkWUHZUltKr8HWFNr+k7SxBv?=
 =?us-ascii?Q?4sSjagNxvKgniXWXH9K6Z8DFkvXE2Zv3rmnnFDEpkFXvsR0BHS04nz8o1qad?=
 =?us-ascii?Q?7ojLzRHRU/Wbhqcm6J7MlsUglGsup8FK5yH97iS+MAj7xTtubQ7U3E44eWQ5?=
 =?us-ascii?Q?7Qe6p+eBhoKqnT0ntfI+5LbXykTGZCTAGx7hiq9Ov2+fz9eXCpiEx5vhIlIU?=
 =?us-ascii?Q?sTomFycJU0A92DneR9NgjNfsUSSA6G7wFGewesdk05HDd5Z7bcI4vDQBoLjQ?=
 =?us-ascii?Q?WgVSD+i9FQ98L2met6FeiQBtk6rnlqs69xminu7Kn1l1Zrde02qWwYyrXgfC?=
 =?us-ascii?Q?7HO/UkQw8JdczWh9D1V7XifQO8CQKQj5Z+yAdsTXdZkQdBHvE0fhKqMreOBg?=
 =?us-ascii?Q?X65adk3ZFhw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 64ekkyUJVZreUDq9alR4zU5g0qgQL0vZKIVRBqPF1h0/rh82z4K5VUIqIVIue5dCRGE+R09ap5OWuLqJS5KmgPCvEsFqlngGOWyRVgButpcqv0gXNYEPKKvwJ6RkVOh3p4nPWgz2ln6KmkCj8nUApb0OU7qsXxGFPfqlbQRtVxYzUtXjPYMgiynw3EviAYLu
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:50r8s1mhTZYTzrxuW0jOzh97ntl6WirddF/b0cXcAuamkL+RN8VwptqBz9XBq/oRKQb3tnEXGdqRvRN9c3OZJrE2l00UBdKJzCVqItn5RfJm7tgWVKs8u8wrVAokINU+6ojBdEIPX6e0WPXVAfY58eT1yJIn5Bb+QV6EfQHeEU3ffpGUeQHNbtbWdlNuzIRZmc8BbnODSbja6ETa7GwzYwSaNisFPnet1Kn6cEibO5BhaCErmf6JNq7zq0/ndiG1G0CiLhXt+KRnYvIsP/HKPKl5RitgHYPlk5SVQfljAC0H+NtNG6M7U037De1DOtfQ+fj9Ktq585DGLHtn2QYWhag2SPZTIonbNfelGV37BLlDgxNZ3ZFtk6NV2rnRaheDnQXeZFE3FPAOks936hrBa0gEmVhfxUR+46V1i6RvQ2zvkL2wK540WELLxOIqmq27BzY9gWCI0EjoHGd8BigFdw==;5:JXLKT1YqKp2OA2h2FQ4aglfeeyNefwX4Z33HhM1J3gH0BzJcB3699inrFWj8+v1CpafoUDxfK1hhK1XOnO7iLWFRGUIxGQ298Sehoe7WNqP1QR2nm8Uk0SuP9sZ0zdc3h9u9ooWYSGTNaiQhJzK54y3iuyeEOZGq3yaCwTCU6Cs=;24:Oh5aAY9xcvGNmzvKVR6xRkb0FewyoP8560L3VjXmnQHB//WQj7oewx9Ux4vuY9w03foQP1VmuuyD3ZBtTSC7UMQwTGeJ9PArxXyNEPZm54I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:SZSW2daXCYCSbdHRTS5T8pE9/7dcdi1BuVHMfLQQU+DXPsR0alW5Uh+cegprWZ+X77OmWlc013w1BgF4aIuaZrEyHB9cHkwL4w1pPlmtOZAF6wD5xWPIvQhuqmUmnKyrn1CrK160bo04djHB6TD3RMmfRkcKPeGZ3WJAOVRTthiXZCQByPD7VpRDU6/WGVCOAf3aq77ZiaGhGbiGiDWxlnOpaE17NRk5yNluq0QIss+nq0C1t5KVGy6EuZoDOhLd
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 15:36:56.5026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e5da91-1a2f-4d57-8643-08d59978bc58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739887853490430?=
X-GMAIL-MSGID: =?utf-8?q?1596739887853490430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If an ADC channel measures the midpoint of a voltage divider, the
interesting voltage is often the voltage over the full resistance.
E.g. if the full voltage is too big for the ADC to handle.
Likewise, if an ADC channel measures the voltage across a resistor,
the interesting value is often the current through the resistor.

This driver solves both problems by allowing to linearly scale a channel
and by allowing changes to the type of the channel. Or both.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS                          |   1 +
 drivers/iio/Kconfig                  |   1 +
 drivers/iio/Makefile                 |   1 +
 drivers/iio/afe/Kconfig              |  18 +++
 drivers/iio/afe/Makefile             |   6 +
 drivers/iio/afe/iio-unit-converter.c | 257 +++++++++++++++++++++++++++++++++++
 6 files changed, 284 insertions(+)
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-unit-converter.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dbe5019c6bd..f9835521eec6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6895,6 +6895,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
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
index 000000000000..75acbe7eed15
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
+	  that handles voltage dividers and current sense circuits.
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
index 000000000000..43429543cc29
--- /dev/null
+++ b/drivers/iio/afe/iio-unit-converter.c
@@ -0,0 +1,257 @@
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
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct unit_converter_cfg {
+	enum iio_chan_type type;
+};
+
+enum unit_converter_variant {
+	CURRENT_SENSE_CIRCUIT,
+	VOLTAGE_DIVIDER,
+};
+
+static const struct unit_converter_cfg unit_converter_cfg[] = {
+	[CURRENT_SENSE_CIRCUIT] = {
+		.type = IIO_CURRENT,
+	},
+	[VOLTAGE_DIVIDER] = {
+		.type = IIO_VOLTAGE,
+	},
+};
+
+struct unit_converter {
+	const struct unit_converter_cfg *cfg;
+	struct iio_channel *source;
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
+static const struct of_device_id unit_converter_match[] = {
+	{ .compatible = "current-sense-circuit",
+	  .data = &unit_converter_cfg[CURRENT_SENSE_CIRCUIT], },
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
+	device_property_read_u32(dev, "numerator", &uc->numerator);
+	device_property_read_u32(dev, "denominator", &uc->denominator);
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
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		dev_err(dev, "failed to register iio device\n");
+
+	return ret;
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
