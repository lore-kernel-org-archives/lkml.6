Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6185ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8832075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="w3HOViFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8832075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeGRGyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:54:14 -0400
Received: from mail-eopbgr720069.outbound.protection.outlook.com ([40.107.72.69]:60768
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbeGRGyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvvjk8ACSTC2GKGRu4ko2jiUysAyrhY3Kgb5XxY/iww=;
 b=w3HOViFB+anfx1IoAy9xH0kOiluKBc54MrNV9Dcspt5o8SVnWrRufYtWQrvWbqAAcdFRIupsxi39rQUPNiV2w/NriE4Z6zcmUkV88cxPE74teaSo6WBqJU9pTPbEKeugQzoUnoS19iWyD7CcZEZ7vOpmo7FjYhk0GADQzCyRzjc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 18 Jul 2018 06:02:36 +0000
Date:   Wed, 18 Jul 2018 14:00:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2 2/2] pinctrl: berlin: add the as370 SoC pinctrl driver
Message-ID: <20180718140030.73eb45ca@xhacker.debian>
In-Reply-To: <20180718135613.1c559b9c@xhacker.debian>
References: <20180718135613.1c559b9c@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0026.apcprd06.prod.outlook.com
 (2603:1096:404:2e::14) To CY4PR03MB2632.namprd03.prod.outlook.com
 (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aec6b667-8946-46c4-e9a9-08d5ec74109e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:POg+P7B6EUuQGmX0aFKC30PbaA6X1UgKiDTv0aA6xKJJZI33ovJhFrMkk9zNtEWId3dsG99v2h5HLPoy8LCpH7cwNDfRPdBMf9mtAZd2uXgCjlGgFz5Y/rrMGXsJMhK69V6rNu515dAECrTMhA1/chM9sM45VB8yetfwshp16Gz7BwB66fYI7o7dhyDuuWXfCay7QK5o7Grs1ef6gnX3Sw040LCGfu77YbyBziQCRTdYzhScJQaOAo3IZeF349Ko;25:CScJbmWARfAGAiEjczvJrn0u/k4z7LTYayO0OFNnfRyB3UW8AmHli/6UHbhvJlLioDLtioyhXvSpWZzvVcElpnatlh+lwiPPPaIc2YEQ/FXaHFsRgkLdwkKq32jz2U1i9FcqX/3BcjESrjePV0Tdi+HnfmEGUDBR0xyw0Lt6nUENbb2Ar/gV00n5FFUBN+9n1SziGZQurxEMyu4+2Iq3hA2BrGIc6rYOV9zvmne8DmWCks0W1LiOGMmPPaXfsfTIPg7Q4ROAqusITvLDdaUWVrlCQjMgrs/6+EYHYzmFH2zpACYNx/pFW6X/Lqg0qwgUG76M0/Q2cArfxv/kSkaXCA==;31:QXUCNxMoRLqWpYOFPtnxgqu6BMZmUpbTcNFdaJb1HuyB8zExjhoshs86Dddx3x0ds/UuvZOLORLL+AVJJ3ylqFm2aOk/X2I2P4fpZB8LyRr+TlF8scKj92pMOe3mQA+RkxZmATCPiSCgk5dG67DI41voZQ9i1hMOMabCq0U3i5o0zIul1TJauWFcTPTxTGm9giEDToFtyf/xN1MxX60hff96rshnL8yezvS/HKZIXh0=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:Gse9ca3L3aBslxUCAbo2YcZhCPZUw1MoXgSTUFgHiKgSp+Bb48U0wOGDztl548v3TDlER/O1oijtm4dfNKn2YlXWugS3NBb9XJ60t247EX9NseXdr1Jl3gY1vJ6l9rNoVzjQjo1OyZFXu2sRp9qiZsVpp0YEBT7Go7I5pivD9aJhVlV8yqPuC0Wqj7E57htABkw3kqdRxNt2jqWCsHxM2wXjK25atGfFToC59DTY+hbZCCX9zVXiJvHjTgFR7VFzsmS+/xGF9y6HGpRAcQdfNhrEB3onus1UQNP4QkIEf8sslNFMApBjdaMv0I1XDYbkYf0Jj4MHsbNWRnPsNwGmOsSxJ57/D3oQvw/f2yn9y6eH0YLsFmP7icVcsowQ2ESLDXJYyEeDE0Fpowe+JaK5L62OiZaGVjQ9N1DjLaL63I6DnlLvIGK89ZLf8afygzvDfUZU4/01DGnEKYDFCly6mhQk8YNM9dEYPPVHhMCci8r9Fdwak/78yUxznUamcso0;4:zHEmMYMOdP3//+H3GwXqGb8VV8moM6dL3wVdM6llTJSv+adCJ9GkNlkHMqLesEqFNf/zSiQVXKUUHLWxh65IRHgp48HEvRp3rnakzUn5mQr+8CDajQPSv2+tkWbTAcAZW2fWxIxKb2o7mS8ao6aQgdS0hJhhmmEZsW5nsmvaaIY9Ww8R4XlC+AtrEZviG3Opq893KtUasYXYwrPgOh0W7jzITaZtSD/BZzGZMqSKM1OLvZxKNqnU9xfyvkTB8LFRjEuut1E5ijipnR+x/s4e1g==
X-Microsoft-Antispam-PRVS: <CY4PR03MB26323EFD953D1FFF54681FD8ED530@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(50466002)(8936002)(81156014)(68736007)(9686003)(25786009)(476003)(956004)(106356001)(81166006)(486006)(11346002)(39060400002)(105586002)(446003)(305945005)(50226002)(8676002)(97736004)(16526019)(4326008)(5660300001)(66066001)(55016002)(7736002)(186003)(47776003)(72206003)(2906002)(52116002)(6666003)(478600001)(386003)(76176011)(6506007)(110136005)(7696005)(33896004)(316002)(230700001)(26005)(6116002)(575784001)(53936002)(86362001)(3846002)(1076002)(23726003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:4cBVzgt+z1ixH8eFJmLucGUuJeZ5Ul3skYZ2WI5L6?=
 =?us-ascii?Q?DRX1EBmqZdmVW2C1zR4SPXK8LpXW8piyA96rD6IF6uQoDJufJVxA0WHwdJ0m?=
 =?us-ascii?Q?fGApX3NoFcwtq3HSAmDb098tUw2wvawxxeCkBEbOAKBHSgwHHnyT5gDI8pUG?=
 =?us-ascii?Q?IGHnJx4ObsKTqMqDfyDit+3jOfWgQw2Du2ikJB7Eokmx9oDiYsDM5DyrIsvx?=
 =?us-ascii?Q?vtvi8xDahwj7ayv3qjpsZJAkPaDsp0rherJbd/lvaxHuGOvH3ZftGih2f/5+?=
 =?us-ascii?Q?xoH+6LN2Tpnmx62nbvEzhFoJ8X0n32gaFXRCsJ10JBtJ+UAGyvz8Tl3FP8un?=
 =?us-ascii?Q?rxxbVeMz7cQ35SxW2DVxrzW2TsldHCft/l/McW6Pgem5m5U1VTN9fyBShbeM?=
 =?us-ascii?Q?j1EMT2lt7dPaWfHm426h1/a5Q+6dDqR6PG70zYHntt24WslNThuo4cKgRNTo?=
 =?us-ascii?Q?DDV4F385abGcM6TQsjGQ+LABKDEnwj01TkvngGJ/edT+WpdMFFnrAaYYbH+a?=
 =?us-ascii?Q?O+RkHjj6zyyZixs3ziBC8vlSpzATb2sF+IIqYnHDN4nJVmZYo/4t4OUETW9s?=
 =?us-ascii?Q?6nKtZ+vsmJf/DnPS1wqnBoUvnEfqJjOwf4rDlVKWOJ9b9r0Hrz/GSQX7mkoc?=
 =?us-ascii?Q?kQlfrPIRogGRVZ0E4o4qKDGIIVBM9hOy07H+UQpSQXFMF9pXEkQvyJvBks9U?=
 =?us-ascii?Q?cNVvnKLNV5qFzGO45MdD0w/0LQh+gmMZOIIACV7pf+c6hnC5weFEdRINV1pO?=
 =?us-ascii?Q?mwq0LwXtK/sw3vk66RjlsZBC2/CZ77+ZDSJJu6QrqAQjxlURqjr7TjcvuPhx?=
 =?us-ascii?Q?g/6bQ/f+G3rgngsnxUjw4bR/RssfGcgRw5F8V62gunYX3ORaA9PbpwYN5Lse?=
 =?us-ascii?Q?D3f0I7Vbul3SK1OO1yWIscQYY4s5g5xIAFAEOdrOFZGcqO6aPryuGUt7swgx?=
 =?us-ascii?Q?CuE38LbrsXxRE7EDKOALLGUx/Sni7bscPPwxGZ7P6eI5l2nv0+EyHcnG1Hwa?=
 =?us-ascii?Q?KZZqQDOMbED3xBXp1GhB6bESmhSgx1Gb5GwP0W6u9Eu1b8WRONJ0HT/F3P9s?=
 =?us-ascii?Q?YlcO5pGvp2QLEKm+LOGhuZmCKxCFaNVNC06hht1J3zz7SiPBQg4pHvqJs92D?=
 =?us-ascii?Q?fdRO2MwL8CUq6a9wf5lMlSw1YZJ5QGRz9wG1FoNJnmzduQyByfaWlEuUZmkG?=
 =?us-ascii?Q?/yOfUI5blhjGSMlmMKQDz8ckNr0EyTva8X2vFyQ0KhkDWrSm19uDbovXbAHH?=
 =?us-ascii?Q?VnuXwgb+m/L0QHf456DLE4cRCsdGmB+uSpsZHFV?=
X-Microsoft-Antispam-Message-Info: ctdEZl/Sb/m1/oq+L/p5Zgv9sKvnwrJyDcOehUv6da7PBFbfcJTptClG1XUMQXYX9J8nyTf3pavUkMZR61TvSeCcanCYuEdgpbJhO2H52Z1zYZxtXFKDeFlZKYeQ/lZmzMlmkLC7e581p2NOkBKR6B1Yig0547WHPoPdCW8DfCnGYlo5m5j2DQa8ak7npMMJK0nEW5a+rUppMtH2jp7hMdFBSTIC/SkY6SL0uT8mV7NNs9/oHeEoeHBRIk0DnQHsSx/Hla0dv3R4NG4H2CgGYT+d6QdNOjGRW5HxLlvhae9RsRrB0HWxehTIvalv8C3wcI61s0TFirBRCwlCpK15bjTA+vba41ejVGyXkSyXu80=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:/yqV8HPYTQYV9XHMaXbxib5EY3iWL4xmhEYFAHdtGZDgX5q0HY2xmoa+prJjnL6Mns6iM6fm6hY39Fu807ViH1nj4M8KpphlzuxmVXDUJIFeaIszrm8K2HhymQhaNXZYh8clI/5lbt+IUrl7GkLx2BPHqDOaUsnJMq3EGVPvR7GA3/w+UbOAempLN53mGEMmoWSvbh4dY3p9vf3I3ff3wj6w+qQnVBb5anIAQvZJ+DYJSi+MpCUZg1PoM3m4Pp3TWAB8kyHm5FxUl6yn3bvbIS31e+bwVQ6H5wK2LSB1yQb6BB6q0/wNNBLLlWkghpF1JFpTxU0PVG/zVyNy04kJfvkmkIYnVSjmFIlKCgKvx4K42mNdTCm2XSnDZqfMgFOqExM9hZ6eyomQpZn8x0fpkIdjJAH4jD2GTzkXREIo1zKT+zj3T90EmTbv3hipesGpXXq735Krt/w6ZpNwB+BXPw==;5:+iWsB6nSTSsx9sQQQoCnzXgYxt21F/kR5sTZXlYRIw5krdbXvVZ6gY/27FfgrdS1EVtjMUY0eSplbUzwXlbBU4WROdOoaKttybzgj+xf/GKuEhwqkXfhNlHObT5BKT2Gr1vostH2QNyKTGW4qxiCKi6g9Qff2JFkZyaajGyVfLY=;24:6Yx9NZnzs8woDQe5IPHA8kZvDKMKsil1knybIq4crP5gLUTunWdhfvGArkB2C0Aa1bHtsZEcuijd+KZmqzS3utBvcj62HJLyPkpHoTvnYes=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;7:jHL4S1+YgZsD1Kr0nfcpF5Fc2F/gqXeyVMEXkvR3oEBXBVD3zTkzn2HGuVxTbd32PIZsCOFCsPIL3GIHPoaviuAYgO/DFDyZ/Mzl/pORKqMUUZNQX/3CQqVpAeyy/QOynEPAY2REN4nToi9C4cTsnGNQ4du/1EXvFOoNO5bVUSqGlMTsLc4Ndv4xxE5YOMsNRI/VBPWS3G/66J4hoGv1cipWbmrbuLYSNAHX5siaQSBNRA5AddNIbIdhcmfpqClN
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 06:02:36.3228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec6b667-8946-46c4-e9a9-08d5ec74109e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pin-controller driver for Synaptics AS370 SoC, with definition
of its groups and functions. This uses the core Berlin pinctrl driver.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pinctrl/berlin/Kconfig         |   5 +
 drivers/pinctrl/berlin/Makefile        |   1 +
 drivers/pinctrl/berlin/pinctrl-as370.c | 368 +++++++++++++++++++++++++
 3 files changed, 374 insertions(+)
 create mode 100644 drivers/pinctrl/berlin/pinctrl-as370.c

diff --git a/drivers/pinctrl/berlin/Kconfig b/drivers/pinctrl/berlin/Kconfig
index 8fe6ad7795dc..0dd60278e973 100644
--- a/drivers/pinctrl/berlin/Kconfig
+++ b/drivers/pinctrl/berlin/Kconfig
@@ -5,6 +5,11 @@ config PINCTRL_BERLIN
 	select PINMUX
 	select REGMAP_MMIO
 
+config PINCTRL_AS370
+	bool "Synaptics as370 pin controller driver"
+	depends on OF
+	select PINCTRL_BERLIN
+
 config PINCTRL_BERLIN_BG2
 	def_bool MACH_BERLIN_BG2
 	depends on OF
diff --git a/drivers/pinctrl/berlin/Makefile b/drivers/pinctrl/berlin/Makefile
index 6f641ce2c830..00c53ca3676d 100644
--- a/drivers/pinctrl/berlin/Makefile
+++ b/drivers/pinctrl/berlin/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_PINCTRL_BERLIN_BG2)	+= berlin-bg2.o
 obj-$(CONFIG_PINCTRL_BERLIN_BG2CD)	+= berlin-bg2cd.o
 obj-$(CONFIG_PINCTRL_BERLIN_BG2Q)	+= berlin-bg2q.o
 obj-$(CONFIG_PINCTRL_BERLIN_BG4CT)	+= berlin-bg4ct.o
+obj-$(CONFIG_PINCTRL_AS370)		+= pinctrl-as370.o
diff --git a/drivers/pinctrl/berlin/pinctrl-as370.c b/drivers/pinctrl/berlin/pinctrl-as370.c
new file mode 100644
index 000000000000..d2bb811fc5fa
--- /dev/null
+++ b/drivers/pinctrl/berlin/pinctrl-as370.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synaptics AS370 pinctrl driver
+ *
+ * Copyright (C) 2018 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "berlin.h"
+
+static const struct berlin_desc_group as370_soc_pinctrl_groups[] = {
+	BERLIN_PINCTRL_GROUP("I2S1_BCLKIO", 0x0, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO0 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* BCLKIO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG0 */
+	BERLIN_PINCTRL_GROUP("I2S1_LRCKIO", 0x0, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO1 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* LRCKIO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG1 */
+	BERLIN_PINCTRL_GROUP("I2S1_DO0", 0x0, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "por"), /* 1P8V RSTB*/
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* DO0 */
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio"), /* GPIO2 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG2 */
+	BERLIN_PINCTRL_GROUP("I2S1_DO1", 0x0, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "por"), /* 3P3V RSTB */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* DO1 */
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio"), /* GPIO3 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG3 */
+	BERLIN_PINCTRL_GROUP("I2S1_DO2", 0x0, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "por"), /* CORE RSTB */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* DO2 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm4"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio"), /* GPIO4 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG4 */
+	BERLIN_PINCTRL_GROUP("I2S1_DO3", 0x0, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO5 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* DO3 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm5"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "spififib"), /* SPDIFIB */
+			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG5 */
+	BERLIN_PINCTRL_GROUP("I2S1_MCLK", 0x0, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO6 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* MCLK */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG6 */
+	BERLIN_PINCTRL_GROUP("I2S2_BCLKIO", 0x0, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO7 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* BCLKIO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG7 */
+	BERLIN_PINCTRL_GROUP("I2S2_LRCKIO", 0x0, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO8 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* LRCKIO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG8 */
+	BERLIN_PINCTRL_GROUP("I2S2_DI0", 0x0, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO9 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* DI0 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm2"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG9 */
+	BERLIN_PINCTRL_GROUP("I2S2_DI1", 0x4, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO10 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* DI1 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm3"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG10 */
+	BERLIN_PINCTRL_GROUP("I2S2_DI2", 0x4, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO11 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* DI2 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm6"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "spdific"), /* SPDIFIC */
+			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG11 */
+	BERLIN_PINCTRL_GROUP("I2S2_DI3", 0x4, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO12 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* DI3 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm7"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "spdifia"), /* SPDIFIA */
+			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG12 */
+	BERLIN_PINCTRL_GROUP("PDM_CLKO", 0x4, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO13 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pdm"), /* CLKO */
+			BERLIN_PINCTRL_FUNCTION(0x2, "i2s2"), /* MCLK */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG13 */
+	BERLIN_PINCTRL_GROUP("PDM_DI0", 0x4, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO14 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pdm"), /* DI0 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG14 */
+	BERLIN_PINCTRL_GROUP("PDM_DI1", 0x4, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO15 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pdm"), /* DI1 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG15 */
+	BERLIN_PINCTRL_GROUP("PDM_DI2", 0x4, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO16 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pdm"), /* DI2 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm4"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "spdifid"), /* SPDIFID */
+			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG16 */
+	BERLIN_PINCTRL_GROUP("PDM_DI3", 0x4, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO17 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pdm"), /* DI3 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm5"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "spdifi"), /* SPDIFI */
+			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG17 */
+	BERLIN_PINCTRL_GROUP("NAND_IO0", 0x4, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* IO0 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc"), /* DATA0 */
+			BERLIN_PINCTRL_FUNCTION(0x4, "pcie0")), /* MDIO */
+	BERLIN_PINCTRL_GROUP("NAND_IO1", 0x4, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* IO1 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc"), /* DATA1 */
+			BERLIN_PINCTRL_FUNCTION(0x4, "pcie0")), /* MDC */
+	BERLIN_PINCTRL_GROUP("NAND_IO2", 0x8, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* IO2 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc"), /* DATA2 */
+			BERLIN_PINCTRL_FUNCTION(0x4, "pcie1")), /* MDIO */
+	BERLIN_PINCTRL_GROUP("NAND_IO3", 0x8, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* IO3 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc"), /* DATA3 */
+			BERLIN_PINCTRL_FUNCTION(0x4, "pcie1")), /* MDC */
+	BERLIN_PINCTRL_GROUP("NAND_IO4", 0x8, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* IO4 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc")), /* DATA4 */
+	BERLIN_PINCTRL_GROUP("NAND_IO5", 0x8, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* IO5 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc")), /* DATA5 */
+	BERLIN_PINCTRL_GROUP("NAND_IO6", 0x8, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* IO6 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc")), /* DATA6 */
+	BERLIN_PINCTRL_GROUP("NAND_IO7", 0x8, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* IO7 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc")), /* DATA7 */
+	BERLIN_PINCTRL_GROUP("NAND_ALE", 0x8, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* ALE */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm6"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO18 */
+	BERLIN_PINCTRL_GROUP("NAND_CLE", 0x8, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* CLE */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm7"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO19 */
+	BERLIN_PINCTRL_GROUP("NAND_WEn", 0x8, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* WEn */
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO20 */
+	BERLIN_PINCTRL_GROUP("NAND_REn", 0x8, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* REn */
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO21 */
+	BERLIN_PINCTRL_GROUP("NAND_WPn", 0xc, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* WPn */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc"), /* CLK */
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO22 */
+	BERLIN_PINCTRL_GROUP("NAND_CEn", 0xc, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* CEn */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc"), /* RSTn */
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO23 */
+	BERLIN_PINCTRL_GROUP("NAND_RDY", 0xc, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* RDY */
+			BERLIN_PINCTRL_FUNCTION(0x1, "emmc"), /* CMD */
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO24 */
+	BERLIN_PINCTRL_GROUP("SPI1_SS0n", 0xc, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS0n */
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio")), /* GPIO25 */
+	BERLIN_PINCTRL_GROUP("SPI1_SS1n", 0xc, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS1n */
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio"), /* GPIO26 */
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm2")),
+	BERLIN_PINCTRL_GROUP("SPI1_SS2n", 0xc, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "uart0"), /* RXD */
+			BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS2n */
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio"), /* GPIO27 */
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm3")),
+	BERLIN_PINCTRL_GROUP("SPI1_SS3n", 0xc, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "uart0"), /* TXD */
+			BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS3n */
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio")), /* GPIO28 */
+	BERLIN_PINCTRL_GROUP("SPI1_SCLK", 0xc, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SCLK */
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO29 */
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm4")),
+	BERLIN_PINCTRL_GROUP("SPI1_SDO", 0xc, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SDO */
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO30 */
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm5")),
+	BERLIN_PINCTRL_GROUP("SPI1_SDI", 0xc, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SDI */
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio")), /* GPIO31 */
+	BERLIN_PINCTRL_GROUP("USB0_DRV_VBUS", 0x10, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "usb0"), /* VBUS */
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO32 */
+			BERLIN_PINCTRL_FUNCTION(0x3, "refclko")), /* 25M */
+	BERLIN_PINCTRL_GROUP("TW1_SCL", 0x10, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO33 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "tw1")), /* SCL */
+	BERLIN_PINCTRL_GROUP("TW1_SDA", 0x10, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO34 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "tw1")), /* SDA */
+	BERLIN_PINCTRL_GROUP("TW0_SCL", 0x10, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO35 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "tw0")), /* SCL */
+	BERLIN_PINCTRL_GROUP("TW0_SDA", 0x10, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO36 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "tw0")), /* SDA */
+	BERLIN_PINCTRL_GROUP("TMS", 0x10, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "jtag"), /* TMS */
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO37 */
+			BERLIN_PINCTRL_FUNCTION(0x4, "pwm0")),
+	BERLIN_PINCTRL_GROUP("TDI", 0x10, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "jtag"), /* TDI */
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO38 */
+			BERLIN_PINCTRL_FUNCTION(0x4, "pwm1")),
+	BERLIN_PINCTRL_GROUP("TDO", 0x10, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "jtag"), /* TDO */
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO39 */
+			BERLIN_PINCTRL_FUNCTION(0x4, "pwm0")),
+	BERLIN_PINCTRL_GROUP("PWM6", 0x10, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO40 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm6")),
+	BERLIN_PINCTRL_GROUP("PWM7", 0x10, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO41 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm7")),
+	BERLIN_PINCTRL_GROUP("PWM0", 0x14, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "por"), /* VDDCPUSOC RSTB */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm0"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio")), /* GPIO42 */
+	BERLIN_PINCTRL_GROUP("PWM1", 0x14, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO43 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm1")),
+	BERLIN_PINCTRL_GROUP("PWM2", 0x14, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO44 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm2")),
+	BERLIN_PINCTRL_GROUP("PWM3", 0x14, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO45 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm3")),
+	BERLIN_PINCTRL_GROUP("PWM4", 0x14, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO46 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm4")),
+	BERLIN_PINCTRL_GROUP("PWM5", 0x14, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO47 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm5")),
+	BERLIN_PINCTRL_GROUP("URT1_RTSn", 0x14, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO48 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "uart1"), /* RTSn */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm6"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "tw1a"), /* SCL */
+			BERLIN_PINCTRL_FUNCTION(0x4, "aio"), /* DBG0 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG18 */
+	BERLIN_PINCTRL_GROUP("URT1_CTSn", 0x14, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO49 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "uart1"), /* CTSn */
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm7"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "tw1a"), /* SDA */
+			BERLIN_PINCTRL_FUNCTION(0x4, "aio"), /* DBG1 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG19 */
+	BERLIN_PINCTRL_GROUP("URT1_RXD", 0x14, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO50 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "uart1"), /* RXD */
+			BERLIN_PINCTRL_FUNCTION(0x4, "aio"), /* DBG2 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG20 */
+	BERLIN_PINCTRL_GROUP("URT1_TXD", 0x14, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO51 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "uart1"), /* TXD */
+			BERLIN_PINCTRL_FUNCTION(0x4, "aio"), /* DBG3 */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG21 */
+	BERLIN_PINCTRL_GROUP("I2S3_DI", 0x18, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO52 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s3"), /* DI */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG22 */
+	BERLIN_PINCTRL_GROUP("I2S3_DO", 0x18, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO53 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s3"), /* DO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG23 */
+	BERLIN_PINCTRL_GROUP("I2S3_BCLKIO", 0x18, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO54 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s3"), /* BCLKIO */
+			BERLIN_PINCTRL_FUNCTION(0x5, "clk")), /* DBG */
+	BERLIN_PINCTRL_GROUP("I2S3_LRCKIO", 0x18, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO55 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s3")), /* LRCKIO */
+	BERLIN_PINCTRL_GROUP("SD0_DAT0", 0x18, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "cpupll"), /* OUT */
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* DAT0 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio")), /* GPIO56 */
+	BERLIN_PINCTRL_GROUP("SD0_DAT1", 0x18, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "syspll"), /* OUT */
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* DAT1 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio")), /* GPIO57 */
+	BERLIN_PINCTRL_GROUP("SD0_CLK", 0x18, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO58 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0")), /* CLK */
+	BERLIN_PINCTRL_GROUP("SD0_DAT2", 0x18, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "mempll"), /* OUT */
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* DAT2 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio")), /* GPIO59 */
+	BERLIN_PINCTRL_GROUP("SD0_DAT3", 0x18, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "apll0"), /* OUT */
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* DAT3 */
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio")), /* GPIO60 */
+	BERLIN_PINCTRL_GROUP("SD0_CMD", 0x18, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "apll1"), /* OUT */
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* CMD */
+			BERLIN_PINCTRL_FUNCTION(0x2, "gpio")), /* GPIO61 */
+	BERLIN_PINCTRL_GROUP("SD0_CDn", 0x1c, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO62 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* CDn */
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm2")),
+	BERLIN_PINCTRL_GROUP("SD0_WP", 0x1c, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO63 */
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* WP */
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm3")),
+};
+
+static const struct berlin_pinctrl_desc as370_soc_pinctrl_data = {
+	.groups = as370_soc_pinctrl_groups,
+	.ngroups = ARRAY_SIZE(as370_soc_pinctrl_groups),
+};
+
+static const struct of_device_id as370_pinctrl_match[] = {
+	{
+		.compatible = "syna,as370-soc-pinctrl",
+		.data = &as370_soc_pinctrl_data,
+	},
+	{}
+};
+
+static int as370_pinctrl_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match =
+		of_match_device(as370_pinctrl_match, &pdev->dev);
+	struct regmap_config *rmconfig;
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *base;
+
+	rmconfig = devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERNEL);
+	if (!rmconfig)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rmconfig->reg_bits = 32,
+	rmconfig->val_bits = 32,
+	rmconfig->reg_stride = 4,
+	rmconfig->max_register = resource_size(res);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, rmconfig);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return berlin_pinctrl_probe_regmap(pdev, match->data, regmap);
+}
+
+static struct platform_driver as370_pinctrl_driver = {
+	.probe	= as370_pinctrl_probe,
+	.driver	= {
+		.name = "as370-pinctrl",
+		.of_match_table = as370_pinctrl_match,
+	},
+};
+builtin_platform_driver(as370_pinctrl_driver);
-- 
2.18.0

