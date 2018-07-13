Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3727AECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF56C20842
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="mMwHj1jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF56C20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbeGMKDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:03:34 -0400
Received: from mail-eopbgr710067.outbound.protection.outlook.com ([40.107.71.67]:31573
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726817AbeGMKDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBIMsbacmlMuwctb3XiiQNpqyFCS5ZgUbHLqQihnk2w=;
 b=mMwHj1jFcMjEa0/TXebK07FyMBpZ2kWb1F63hiSvsTMSyk+lOSIIuMgXleRORShVHe3fIywfj4SMypWPLmvOAg3NFPAa6mmQf8MGp3eBcdUP7iSrqCmibR+4vO5uhqpIhTu1wYHfXV6kNbBmRP+QAJNJOVUmrzW9JFNj6178q+U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Fri, 13 Jul 2018 09:49:30 +0000
Date:   Fri, 13 Jul 2018 17:47:26 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 2/2] pinctrl: berlin: add the as370 SoC pinctrl driver
Message-ID: <20180713174726.44d1f7cc@xhacker.debian>
In-Reply-To: <20180713174436.4842419e@xhacker.debian>
References: <20180713174436.4842419e@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MR2P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::32) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d79824a-6d06-4fbe-13cc-08d5e8a5f02f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:84ZA/KnD8oiM45y8cGLJSoh3XelZYhVqGhU9mdhRYOVNZ/RH03HYqGqL1WEa4g1FqAfmteLtIdmr79K7XfnOff7aSUX/RwWNaEcmIYEmdXpXyCfjfdzxyXMfr0ydaSNnLu7T60lnMyyoyvRTsNd7fyH5L3RVK5tD40IMGLi3cPnGTdS3xbkwG09mHPYYSMC/rI7HnQIORUTua6V+ZZ95vNeWi5FN5OhYV2S/+hLFCVN3SoXcuPchcYwDXV8pxr19;25:usScRa43PALhU9ZhNUK4eraPMI6nICdWYyhyqQ8iWb55+A4pYP/JdPAnfNRQabA/m0k7WY8uje/w+jGE6hlU4CDj9vv28kYBFksh7BoLrSmUkvO4NjuQ0CcYG0zGN1zG1mTD1qlCUxn+tZ/IFpXpOlR0QnrHvmI//A0qOMdaL7yrbEEWQSj4QwoyyoaG9iWUTqe3yHemCJimDaafVu5xZSzilJvg2ChOGsVPtVwA8KYu7yUBi/D9usxjClGh7kZT+lbOigvY0RDzDGhRDnTwl6Ce8VdZ6xD2X9mt1QnJ4GUzyeEkTSySygFeV2tfGEkhj1NraQoov5TRJ5IydCGnJg==;31:L9qPEttrtlWg0AW3iiPWx6FUCISUUzDfVvCxuNOCy5o0m0eMlAqfUtEbKi6isQ9z3oC5YNBQH9ml+dyXIlyVLNzGA10m11wD5T5e/Aw+OZtZhWOW3rmHDh67K5Zg6d7PrT+FzhbXyos56LGGz9J6l/3AnDpAxae7qTM5wUs7afwFUg1G5V4PpbcqppK5l3IA90/7WO9JVK1gOqqUs9SNkMlfpq5cKfIzkrFQ6xGCm3M=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:iYotvKwU1qIy2XU8SY68D+nJaPE2e/l1PBP9vYRVZrTm+IKUP31l4ncMQJggibbynOh6MmEJR6KgmwF4JIstaMXggdnDzz0DUTnbWyGC6yFgXDz6xQEgz9C+TRiky6ZmTPpLypPsmuY85cNQAhBaYuu0z3oFMChFXQN1FE6TcJvintrFuBqyibthFEAdcow+0xVlrkm0v2dTFbULG6rerOlIhLiHa7scw/T9PRQXAeb5jyYeDMDk4A+uuNKY5OhSM1tgEkexYze2vhQ2J/fw4CZvbbRPV7chmMtCRjPxRX8eP3/bU4lGOpVQWNER19M9bLZ4iGnecR9cMrdhT7m4RPrFjiJERDIOQvPbENaGzZRTtFUKM7TW9VBbzfb7e4neY79KOz2i8tnc+7OZ0pK1P0FiAlrdi500AGDmvZeZbsFrY1QiMFaZPhWRk6fu6T6ikpJrvAjvyaeAp0G0wxsfkAqNpX0GDuvF4mytZHSzT/UOc6JUp9haQNA9jzsycf74;4:B2wu4GOnsgixwKTrKK22h2LsmqePD2OHpd0s/e4jThqVhjY5gwnww8cYkp56w/hy7P7p6HK1DRyzDqvqOgMoxeeH7VPrr1niIdU+ybPKTDf6LMe2Nul2lqf+6NYrpnFYhW3prl1raHlhYgIlhhPqlsjHB6VkWpPOUMCnYXFugiKbZgpNFeG1BDSBMAxJoFmKcVslrMXEtCj8lzx8Gkg3JLas9HF9QJmhqxeRkaUHZotPqlr0zv3fJMzWgI1G1W1QCacT3Au5OtFbaGz7SlulsQ==
X-Microsoft-Antispam-PRVS: <DM5PR03MB263670780CAD59D0A8CD4EEEED580@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(105586002)(106356001)(66066001)(47776003)(5660300001)(6666003)(33896004)(76176011)(52116002)(7696005)(53936002)(9686003)(55016002)(25786009)(305945005)(7736002)(26005)(8936002)(16526019)(186003)(446003)(386003)(6506007)(39060400002)(11346002)(956004)(476003)(8676002)(81156014)(81166006)(4326008)(486006)(50226002)(316002)(110136005)(72206003)(97736004)(478600001)(68736007)(1076002)(23726003)(2906002)(3846002)(6116002)(230700001)(50466002)(575784001)(86362001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:RDg8m50JH2qeamtAvkop7tlo8ullNVwc5YyXIR4y/?=
 =?us-ascii?Q?R2t4rnAzLYS2wnSUzwAYBwV/WYSr0R1vPS+Dee9+k1orwtnu5TvM3Aesj7+g?=
 =?us-ascii?Q?bkFnAvRpyyYN1nbj7suLIX2cZBI/HJrUIqbYbj+rcye+gT78eS+7avS2iKz/?=
 =?us-ascii?Q?WDalsATHuY6xG8ur+SfZfuTouhZcswV/9nGduGnM1Z8zyyoMy5WecYnXpDHC?=
 =?us-ascii?Q?bUpduobHRfRZdlYsHT7b1H1aOVgnrwIHJXvgduhhet1B96Efd6+XMXd9PrjK?=
 =?us-ascii?Q?l+bKZgHVXbcOtAcrW0ZSRvfPgW99VsA5dcuI8VrBlUbytw7PdBdeu75qBV72?=
 =?us-ascii?Q?agTXHXqGTLSUwffLsgC1O0AMKWSpBUhAYGD7jM/V6t+mHOUnlgVAcnfkmdJq?=
 =?us-ascii?Q?FKC9ChDN1ozLXD2Qg/aDoSOcxK7H91UkMkiOwOGmZRRuQSSIE+A1ct8oSVDv?=
 =?us-ascii?Q?GjXtQu48h47FxdKDlrhDEHRvpEOEykjxUSn3uDjxC8etEG76QMrv/zfFA5XX?=
 =?us-ascii?Q?bvPw5iM6QQe0YEj1MbGiMuVnAiqEmT23l9xUF75d3g5OdWWvKRm4skoXYANF?=
 =?us-ascii?Q?Aqxwee+2GFXSkgNb2+aEryVTKUA7qgTpSHMd5V0N4nNNPlJjcqXIeiNI4a9Y?=
 =?us-ascii?Q?ESrzliZJ1EyZIJEdEl6Csj2HE/S3gberYiTuIT6IbwfVo88U9nRQ+K5NcOAK?=
 =?us-ascii?Q?Oyb6XHC+E7JEDRF5CTytxlIZdCPZr986veB2lbcJZGLXjw07ps6jKM3+ZZML?=
 =?us-ascii?Q?7E44DpGQhN1HRyxQDfyppgBxKQpWnq19wqCLrqwLcwA/oUHgUIxeYcWj7vEB?=
 =?us-ascii?Q?+va9YsNPjpLoOvQDMF1WNtzss+cPHEy+IglcHoiBbcLEZVJUWIsPvoeLig0m?=
 =?us-ascii?Q?78Fg9awq14weMCmldqiWddtocwvkRB11sPMVQ2GhyQX6WADfKQUq43oIZfOw?=
 =?us-ascii?Q?wR0Kw+6HsUNJ7zS/JrbxH8rWoeSwhD3rsxJhOxcRH4yCiV+FLuVYisEgakJb?=
 =?us-ascii?Q?XqPbmSTXRJohfccV6hmYB7I7XK93iXKoCxsLf0A3bqIgrcxWFm1w+RaQY3ln?=
 =?us-ascii?Q?TM8zuh7kYVwpGXEIBgPvmAs473Uw8/92LyZVArcIyAnPlfF82/FN3fQ/YTFu?=
 =?us-ascii?Q?Xmgz6WjBefp8Ha3FARcsothfaY5Tuz46eGa11FAb0Dg0G65tcVoMHGa35xTd?=
 =?us-ascii?Q?gpkD+VLR43GaiQRiQsRha4X+gzEdJwK39t8CiPGfGcE7Jmhxp7ZyEsPne2QM?=
 =?us-ascii?Q?IbTYTx4n1rnIylh8S8KieuzJlz8dvCzIoRHsTx1?=
X-Microsoft-Antispam-Message-Info: KBcgyqJz77TG/Av7mwstvNClRCQwHJ/9b8F0NSl3ZjMvaLjz4ICOE/c/yrVnY8+UkxAt/otbuwH0ulW2uSi4Lj0pkF15YyLNoIljLaF3a4zEeDCq6hkZdBObLbF5sbTXFKN88G1t6KLyiimAu4/pt3WcB//wiQZOlShjZYcpkKMdXNqLS3MkJ7V0mY1lshQVElrr53IUcapHlcNJNXW792oNtRlt8v8Gfu+4VcPHYtePA4hr0dVAGqklflJk+CL2LaPGR1iYz+jGdcnyCUllXaRiIP9ty1oclFuwnK8EE/wWyo1E1EcSRlPDLQ7Nb0w7+4+70ldJnhxzCnlEb2Sr/PI5kCLHfZ9y/5JWjTBWFwk=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:b9KHSYtCAtu6d4mpg783u6/Z5clLdTl/o1ECQoVnL2FGqhz7LKqvw7lFhwPu5BM2vsBYsAxr7+5W0yNGJ97d7jMvu1DATTA4dhDSot3vuzPAiR5B70OeokmxssXOnPthym4lbdp9gNu2Tsh/K5yVU3+29FyA6hwxD+PeE1kp6DLZQ099LZy+rC2odrXPpY1fPNT+cfJDY+786bk8Ca5FcqXpvyVAt3uMMpt9KMUJa4Z6Aq/DenLp29F37mMiTUyu69uXj40VOBCQekSFFWww+1tn/nUJEdQO4kfjAGfaS+kC3PmxisYeuHXo6+5zhR6/6ocK9sLYVmU4yAIEC2Pm+AVTonit4PtWwc61g89BnSTm28J0jfUqtzIZER9nnV3d1lXDr/q/DbiRECvMxqAe1D5iKgD4l0r2tSuj6mJGuqxeHICMxye4+0EoGQvbAvYzMC+hcOsgsU1jc+zYbxNTrw==;5:7MxVZzi+OjrFoYmutkWXUlMH8dDy8jqzBDvANJqAhftn5nKxXKy0HWpnh4QDKGDYylkP6vbRm1/kMB7+V7GYouzGCZxkbAIE87UA2lsMe8RHIuApcZeajiWE5rjJXnKryj2qqgMYtAJaSXAKbO46wDi2DhRLqAu4/MC6nghZATI=;24:imA+omyGbqAwun7fsnOhcozeUGPyafyVUzdPdqS6w7DDhSla0GDil2qbI516+c85lYofBuaoZMKoDkgbXy4s4U96/sBzz/yXLBCvyDBSXH8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:Y5r6TzZXAFU4GdqnGQZzIB7vidHv9CMcRd92/6jJocHuDiOoT+Xjg8E7DEZnu62yy3xWhPEVoydg+zc3kTYbYVQhX5+aE/23NyywRAHOzltRWId3uU3UcRWWmuekcd7R+deNZSFyAVhRkLwCNgtOa5zYy+beHOFKWg2mAnrPeqz+5i7TWTYadIKZ1fdSnPRJ6AZ4ZMIe1Z8MqlRUPYJlj/+4t59yPGNCj88xYyx/JL2AcY9q+if9/1Dm+kdJYPq3
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 09:49:30.7922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d79824a-6d06-4fbe-13cc-08d5e8a5f02f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
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
 drivers/pinctrl/berlin/pinctrl-as370.c | 369 +++++++++++++++++++++++++
 3 files changed, 375 insertions(+)
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
index 000000000000..5d8352d801dd
--- /dev/null
+++ b/drivers/pinctrl/berlin/pinctrl-as370.c
@@ -0,0 +1,369 @@
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
+MODULE_DEVICE_TABLE(of, as370_pinctrl_match);
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

