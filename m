Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A72FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D4220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="u0tT856J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D4220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbeHAKWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:22:52 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com ([40.107.6.98]:55744
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387708AbeHAKWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqRUF1hCoOAEOgTWqkU6npE3mhbjqVoZWmCu903CCXQ=;
 b=u0tT856Jjt7FBuUQ1ZZAGRIycpjsgv5miaZqwmnxr+5VwjO58Ev+822heGmyAXTb/JsigMpgPBQMtqe0w36xhFL6SBc2HjTJ6rWXqdi0UluzKY+kJTbBoGmzeFYNZq79wKxBxFNW9eah1PKUBoDxBSnYqLimP3S8H6uezinqcto=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Wed, 1 Aug
 2018 08:38:10 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] mux: adgs1408: new driver for Analog Devices ADGS1408/1409 mux
Date:   Wed,  1 Aug 2018 10:37:40 +0200
Message-Id: <20180801083740.29859-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801083740.29859-1-peda@axentia.se>
References: <20180801083740.29859-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:203:69::28) To VI1PR0201MB2461.eurprd02.prod.outlook.com
 (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59d06d31-dca0-434f-1eb6-08d5f78a1cee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:AGZbB8flCShp7+ADu26l5LJCGkdN33HNdjimZwiu4hYEySf+EKQIUjfj8Yl9hMyibQB7UDfNLzRU7H8ATSyZhIJhbNccMq4rw7WFwIWUY1FLR1DO+GewkFHdJuE3QJT86I1X94+MJnDfuPBmyE+/rzenhwdkVYbJSCG/j0a39yWPA1ZH1CRViu1brcQEYwkAA9Rb4l0dIkkfq5DRjLSHfI/ZiBEg969TpfLlXsZu8HZY6BKTZi5Cr3Bgzq+4BDQB;25:aZQtzpa8NJ+ODKP1yiSr8B8i/B+7KqIkPqVUGafe1/0a1kzv/TrZtdmDXSndaebps/DvKxp8pl/DCa6Z5h8FoAxqhjlLNG54BdrpccwwBJWDvMWSPLKQCCEGtQYrjnIanta2jub7goarWLhRJFla8sR9ZpGCwRex6PAcP3z5VV3lPNq3Ng/WxAwqOdTXzG6OjwXWJhTmUogB59rdOSUAt/QyAlsoP17+pQRqiq2hY1h7yzfEV2srenVsrNr2wuGb4ED1J0ZOCR5r7nWDH2Qj0sLcKqTklvsLf8P+gQpDjzAaQZkHmIHmKTf77/AsA3xUgFOqjQeHYi4jEu6DISnX/A==;31:qWvkLUWphHpHnXPgS+IPiAHyIlbWgjQ3kJ4qj8ouIeeFUQGcEenylQj2m4BwdWDT8LdB9BvzkpBe42DvHdbsAfQ6kBoGLzsiLTdQhKZFebgQWsopmW8lJzsPFK+OygOSVjHTHm/7ek7Wjo/lJTRZWaxvQTwLIbmTAsyY00uKwCGL8wdrj2NRZ1n4fgZ4rmM6UmrRKS3pq2deGdb9RdyovdkNCTihEebiOmnzkRs+R3U=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2461F61E8171578C2B42FE78BC2D0@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:T+3DEhoFd0WhDV0R6BmhzJ39ggv1lg55hRcmGXCqcranNG6aflOiNazZ5Oy7dBNqrLQSY+9GG+aHdMD6eXnRQ7uUf5adHCP1Jo19Fx6ErNmpeyFKP+CbvUTTzgdXUveNJjfnK8diwAoEZaaudiapHYocBp1qUXOKvdsXlGKsdDzpWBuwAkHGKlfbY7f/Kxl9Cs3+Ko0YwysYIg2N0XFkDqv6cK379cZa/yDC2u0+UnRYbO4SCruINeYqQtsLA0roU7mw0IIre9FnmXKM/d6uIcU9bNuSp4MRcx0xRxwHrx3l7X/RKrz/olrN/WyIZzsa
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(1076002)(51416003)(7736002)(81166006)(53936002)(97736004)(36756003)(66066001)(106356001)(105586002)(6512007)(81156014)(47776003)(2906002)(26005)(305945005)(25786009)(4326008)(74482002)(52116002)(76176011)(8676002)(11346002)(3846002)(446003)(956004)(54906003)(6116002)(476003)(486006)(48376002)(2616005)(16586007)(50466002)(6666003)(6916009)(68736007)(86362001)(6486002)(186003)(16526019)(5660300001)(6506007)(8936002)(386003)(478600001)(50226002)(316002)(14444005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2461;23:Og8fhz0jhgcfth8g9pi2jnqljiZy/SNbT1IJxcq?=
 =?us-ascii?Q?8WkcYqgFlTnjH4wD5KJO559OwGtVBHkcNDqHB8sVZNFct0kP5+UrK+dSobH5?=
 =?us-ascii?Q?oyaJDenI/5+x0TJBE2QpJU3VQofImdP7Brm4q6X1uKczFd/eIJZx8pey918L?=
 =?us-ascii?Q?+3k4jKRqg/hgLcDpeopYnGA7/FB5CRyZOrlR5ICkhyVPwNbdWDv3M89sw83M?=
 =?us-ascii?Q?yLv4BkYisq1iP7/ZNrCNPRTjwzRHRKaCQTjuGZIzyPuc0L40AoN4HxBIrtQw?=
 =?us-ascii?Q?gwOkwVm+HGN910sSfSW4iul4W852BvY6dp56lL0tln7rBMfhz+2yhx8gxpRz?=
 =?us-ascii?Q?rPzENlMNG5/D2WnMN+JD3gI40/zf7g2q23RG92socDgYzAZLXsOmHrotE7DJ?=
 =?us-ascii?Q?dOeHkI1DyjI3c2Ax7lSDjUGa540WHIvRVVDNSooI8ZlrygB5kQTk+NDbN1M6?=
 =?us-ascii?Q?KiG6wyd1rA5goAEPJgNyMYg2H2wwdrdcLcELUJFtMGsxqgKvUrpW7vuHJr8K?=
 =?us-ascii?Q?2DnvkLWs77kDs2eNYs0nwrk7Say3xJVjCgPOb9I3nCxPJ3TIKNIu1WpL4bbH?=
 =?us-ascii?Q?vDri6bkeYgd1ykmDFYZyMWK/2QXQUGdl9Bj+OV3BtbKmvgVQLrM/Yq3f8HWy?=
 =?us-ascii?Q?Dy6Zo45P98D+X53QuJwrm1AleQbfVcmlWJ1vSOC0pC84EXmVbpHW0rPUBtew?=
 =?us-ascii?Q?MxdLbyyWZvH0glvNcHRqrseHHCSQ2Z3CL3OmxC7SmFelLuWa+3rxCOuqfMQ7?=
 =?us-ascii?Q?kItoL2s66WVuo+t/4BRD1j+Ph4PBS1w95d2moIwX6XoE4P8j6A8wl7WHNeks?=
 =?us-ascii?Q?cuhp14a0vM4/iKOMfaln8KD6I+mXTMyENvNPbuk3iDyGKcWIU/VuIF4EaA5z?=
 =?us-ascii?Q?SogPutgMxXEeYRDxPWNVmu1mn5kqaGcKz6F4zRzBZ/NcoZRi0PKEAt3a0hze?=
 =?us-ascii?Q?BifMAye+RUsCiwKufjIgLYOlqeNW+RQ8EctZ1fd3WeR8tjljV8vq2XFN0VVc?=
 =?us-ascii?Q?y4xRr543Tw9rwEoVN7m5CX/jl2ZaZlqBKs9SnwFHFXBzHCPWth9wtUlsuvXL?=
 =?us-ascii?Q?5NrfrA+sO615PLoIfAdWqpPIUhrHuPdmZgVcT6iLXtzbTI02A9ciYtyuTXB3?=
 =?us-ascii?Q?kx1TY2MzlHG79inAZbDYEbS9P/B33T/rpdymjU9YOL0EOpmel84uV1JTl6mr?=
 =?us-ascii?Q?ypkEJ+NjQYuu2R2vQkRzDOmydy4be8im84cFNtAE1D7PnxdR1z4SEvuXbilt?=
 =?us-ascii?Q?ZG9opN7kykp0uj3C9EQDdL4j7JovP1oQ2U4PirjVu?=
X-Microsoft-Antispam-Message-Info: BlcgxFezzCDiOalDG6i5eeftEcL0hgmcw7wsD7as3sF5SjtRGMefa5biEMquFkIQUZ5wyV8L7L6cu5vqcevUuP4dr5EHUGmoaRVEn63UcjjDABWCGlkgvmWryq79SCXJNp3plnAUsEG41fWnnN0KiT6+WlXraNPyGkXemLZZKhh3ui+vQvuBhrqqIFrqRP56i+EB3eNc6r/KedWYCoBdpDLLhytlu3KM9+MKsbfjt6x2HgRG+7wkHBNOUyvupAnPs4qltNK97itAJk9zCHqDKbOoFgRhGQ6/yxFoiOu1jAG4DUgvpvzvjZBEOzGoBV1H4KclvEBbnNZnZcijWbTUDY7gk3eXiXs2ljmZQ09EMWs=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:kk8ZnUbBoHEOeZ+KhhVwi/s/FHVt+8S4ZhtVK9ihG/xfhymTmJA16fJkWQUbIwZlXsz4rZAo4+1CYhzADxqiDwAC+/DKmWqNtPeU+oE33A4JB4SsP29weh/+MdSsWTB0pPTY+yW3b6KkOFTk9Owe+i+ko+AhDEAATNJfLPEj5lYGbzNFF4CTtnkzW6+z2Bga8CNziwt53GVjbIYOO+M1fpLpdIFCiGBl5IAft03NotisTYV25ZnVAB7CYOQafQInJVUpwXMlPL7MjEWMc+iI/JxfO7TnxQpM1ChIlXId2uk1TqKCknKOEy4rj0CHQRYVW0VTR0u43rx5QsZn6BY5M8GPFQwTs1+Db52vxU1bx4PkgVbXtz0VKAVL//ZgGjVb2b/7ayF9AOV1gQADDu36pgQN+FcTFGYSZOMFrmiGSMzCPYV9E5HnwS3K4K7sHyuRAgIXRjIFqtdQtfznViDxUA==;5:FBbV35Y3fq0Dv19Qb1uiUTWM845kHWc6bWGFJyHgBKv2TiYsvdW1rEf7bllPOgr7tWV5VWEvLnN5HRlkx6/3TAfjNUvBTYrZSPGC1/qbbvBqfGo4STRMax2oAy17v2W402LBde9YJdEgXrG8260I1vtS5jyLTsJfj5b9ENAhsOY=;7:m9XhtOSFt2LwGB6o8kHPsep/9D9FkrgIEH1bTUJEEwh8YVeVBxyxD8TvZXaqA2MnX0VX841Iide1jswxWUt5pm1MDpP8q1VoErMQnw8Mv+hX9xK/c3KaTTDrRO0Ten45wCK3JMNBtdMp3S0X0NZmBiJPJpxvCnj6lp1yAqYA0tgE8qtF2Z+ScmWPYXro9g688jLkRm/cl409UwhxjWHt30H6FQ3WEtBg2JZ75CHvfJB5OhcpqEPddcEEsUs8L7dj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 08:38:10.2583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d06d31-dca0-434f-1eb6-08d5f78a1cee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mircea Caprioru <mircea.caprioru@analog.com>

This patch adds basic support for Analog Device ADGS1408/09 SPI mux
controller.

The device is probed and set to a disabled state. It uses the new mux
controller framework.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/Kconfig    |  10 ++++
 drivers/mux/Makefile   |   2 +
 drivers/mux/adgs1408.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/mux/adgs1408.c

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 6241678e99af..7659d6c5f718 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -21,6 +21,16 @@ config MUX_ADG792A
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-adg792a.
 
+config MUX_ADGS1408
+	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
+	depends on SPI
+	help
+	  ADGS1408 8:1 multiplexer and ADGS1409 double 4:1 multiplexer
+	  switches.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called mux-adgs1408.
+
 config MUX_GPIO
 	tristate "GPIO-controlled Multiplexer"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index c3d883955fd5..6e9fa47daf56 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -5,10 +5,12 @@
 
 mux-core-objs			:= core.o
 mux-adg792a-objs		:= adg792a.o
+mux-adgs1408-objs		:= adgs1408.o
 mux-gpio-objs			:= gpio.o
 mux-mmio-objs			:= mmio.o
 
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
 obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
+obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
 obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
new file mode 100644
index 000000000000..0f7cf54e3234
--- /dev/null
+++ b/drivers/mux/adgs1408.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADGS1408/ADGS1409 SPI MUX driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/of_platform.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#define ADGS1408_SW_DATA       (0x01)
+#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
+#define ADGS1408_DISABLE       (0x00)
+#define ADGS1408_MUX(state)    (((state) << 1) | 1)
+
+enum adgs1408_chip_id {
+	ADGS1408 = 1,
+	ADGS1409,
+};
+
+static int adgs1408_spi_reg_write(struct spi_device *spi,
+				  u8 reg_addr, u8 reg_data)
+{
+	u8 tx_buf[2];
+
+	tx_buf[0] = reg_addr;
+	tx_buf[1] = reg_data;
+
+	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
+}
+
+static int adgs1408_set(struct mux_control *mux, int state)
+{
+	struct spi_device *spi = to_spi_device(mux->chip->dev.parent);
+	u8 reg;
+
+	if (state == MUX_IDLE_DISCONNECT)
+		reg = ADGS1408_DISABLE;
+	else
+		reg = ADGS1408_MUX(state);
+
+	return adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, reg);
+}
+
+static const struct mux_control_ops adgs1408_ops = {
+	.set = adgs1408_set,
+};
+
+static int adgs1408_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	enum adgs1408_chip_id chip_id;
+	struct mux_chip *mux_chip;
+	struct mux_control *mux;
+	s32 idle_state;
+	int ret;
+
+	chip_id = (enum adgs1408_chip_id)of_device_get_match_data(dev);
+	if (!chip_id)
+		chip_id = spi_get_device_id(spi)->driver_data;
+
+	mux_chip = devm_mux_chip_alloc(dev, 1, 0);
+	if (IS_ERR(mux_chip))
+		return PTR_ERR(mux_chip);
+
+	mux_chip->ops = &adgs1408_ops;
+
+	ret = adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
+	if (ret < 0)
+		return ret;
+
+	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
+	if (ret < 0)
+		idle_state = MUX_IDLE_AS_IS;
+
+	mux = mux_chip->mux;
+
+	if (chip_id == ADGS1408)
+		mux->states = 8;
+	else
+		mux->states = 4;
+
+	switch (idle_state) {
+	case MUX_IDLE_DISCONNECT:
+	case MUX_IDLE_AS_IS:
+	case 0 ... 7:
+		/* adgs1409 supports only 4 states */
+		if (idle_state < mux->states) {
+			mux->idle_state = idle_state;
+			break;
+		}
+		/* fall through */
+	default:
+		dev_err(dev, "invalid idle-state %d\n", idle_state);
+		return -EINVAL;
+	}
+
+	return devm_mux_chip_register(dev, mux_chip);
+}
+
+static const struct spi_device_id adgs1408_spi_id[] = {
+	{ "adgs1408", ADGS1408 },
+	{ "adgs1409", ADGS1409 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adgs1408_spi_id);
+
+static const struct of_device_id adgs1408_of_match[] = {
+	{ .compatible = "adi,adgs1408", .data = (void *)ADGS1408, },
+	{ .compatible = "adi,adgs1409", .data = (void *)ADGS1409, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adgs1408_of_match);
+
+static struct spi_driver adgs1408_driver = {
+	.driver = {
+		.name = "adgs1408",
+		.of_match_table = of_match_ptr(adgs1408_of_match),
+	},
+	.probe = adgs1408_probe,
+	.id_table = adgs1408_spi_id,
+};
+module_spi_driver(adgs1408_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

