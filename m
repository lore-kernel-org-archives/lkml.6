Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9880DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8BF26D5A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="Feh3k8Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8BF26D5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeFZPrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:47:17 -0400
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:46464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752155AbeFZPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N15rv9A3ZAoJHimEOfEY+R2V/2NbuRDdKW6zaQaVJks=;
 b=Feh3k8Q7QS4RI6oLbx19+KV6RtUz1Ttql+u6Vqig5/CaYbGotlGElF0SZwBrscwx7ZO3ajUBMXi/gIR0x6uPWS5janRKdJiywPd/+oU0H5k+K3LxKuZGBdXmqaxri58xeprNsyijg/yTgRQBV9B8Edih90VZTq9DoDerz3hmPtc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
Received: from localhost.localdomain (59.174.248.170) by
 BYAPR04MB4357.namprd04.prod.outlook.com (2603:10b6:a02:ff::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Tue, 26 Jun 2018 15:47:07 +0000
From:   "ernest.zhang" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com,
        mike.li@bayhubtech.com, chevron.li@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        bobby.wu@bayhubtech.com
Subject: [PATCH V6 2/3] mmc: sdhci: Add support for O2 hardware tuning
Date:   Tue, 26 Jun 2018 23:46:46 +0800
Message-Id: <20180626154647.11623-2-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
References: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.174.248.170]
X-ClientProxiedBy: HK0P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::15) To BYAPR04MB4357.namprd04.prod.outlook.com
 (2603:10b6:a02:ff::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf854b1-d8b6-47eb-017a-08d5db7c1416
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4357;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;3:HKI+mVdgSh0sUttsc1hnqy5GUhEwn9lCT23LGi3O6YGe0Sd0mpxLqmot2MOPZX6RuOpHraKLlSHvyUt+HE924GYvUegybKjbM9doUI5z9ViBlZYZtQ7reUJmHHNRTVkvGK/PRYDZMXiRc2fvq25A3+4hgcIIPpBpWaMtCsRyW3Xtqqd1w1W5ZBRIrB231dOqYkGMtWqi7gP3+NOt8W1nKkUxnR4ItcG4L0OMr+AkaY+pswcYoz/4XI9HRULS2LXD;25:MaEO6weXukM4DF5dtYWRL55X0xsXXYZMy/LuLO6BjzoBWbN9rigs5eFkp3iTu9q9NYxCKjEhQBT+soyMyhdco55cgBdyDlp/w3iBLY7mw/lCSnam0npeGIbLGg06sztuuwdHi5eeq7qElS2lgs1I01UzlMHnWxwXNyZLYHSbTXdjUTAkFOMDMdGPG5pO/Td4x1EVzglMySdj+Wqqtl6Btp6S9Fr9mio+khnTtTpavY9GYWMIRDYC0t4DdejbIMlZq3YlY1NJiZwtklfDPnPJR2LqWKnyrgNeeKp91ip6lrtmhrNarDYENPQmq8Sh4IssS+mLrK0fB5lnzaxdq0OC/w==;31:/ucf/B1N7BDMgspZW8GnkS+8D+HAWcFq4vT1GjwB7WufkmxWXZqn2nntMFj3HoNtWSy1aYJZoa6L7MdxYAf6ubFCF0T6tMu/ZEzRNqIz3K+0Yr0AEvmtaa0SyDQ5t00Kzc23g9BCi0yVfRwD+7CJP4vJrIAe4/zxJS9yF6Yrd2YX0ycUwd9Ci1gNOrBwZgDHS/XN/6C6k8MPnSYBahs6OjZtHQ8NbUgepWqtJrHOON8=
X-MS-TrafficTypeDiagnostic: BYAPR04MB4357:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;20:sSKy9IwJwMcUN0Z1dGrhRoIQ6TssO5zTCML5Nqd5Gk5Nwh9Rq22f4FLaqF6P0z3ucvh2pvg4Z0pW903awoQFqvLmohhGdz9zz34Jw8ygfikWaRK4nZ0AYMmvN/CYYhJ7ShWXGiH2cCjm+H0oJlfRGiOl0j1CjKasWqz7LZ+u20ztFXKFoPpTLWqj1+afhkrSRzzS32dXs6VyJxMtxpbEpND4M0/JGEvpounjTdFY7qRP/IHjtE3Glk7wAgVu4TYZkOho2tAJhIQahffvkqyPSiI8VigxJGJgMSZ5DkWHmoZ9P9Pnz2LbmeoZfXZaOZsfHUABipImLY5Pjuj9ifZrB/lJbYQb4Q1S97yLaCyPyC4p0gl6jQol3Lweyljfqlnc84ngT2/XsiyCxmsLbDr7/Dr+wmiLyQWdnGBPmrFKd70=;4:mdc0yMjjEnGsXSYPYCV11p1Ptk1tjuou2HH1oifQrwq3gHQ8MJecHmjSIETuF/Eo5+iaReHpQVL8zKq/1Ppd02RuTDTOQ+pJ41i5SZN/jWr9mg+fmdXZg28X4kMjBy62BawxIknQ319iwGl4e1LnSpH9+apDg7M7IgO28rYThRWuC3QVi6KJOFtgiKprHRUt/3SUD2iDrzPcNs33TrDGggNV1ixokCDFloszxcPaLDobb8PH8p/+E6W38x4NuNA5H7aLcCW/irC3JtJDWB1WiA==
X-Microsoft-Antispam-PRVS: <BYAPR04MB43577E05BED04B411181BDA7E5490@BYAPR04MB4357.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR04MB4357;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4357;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39840400004)(396003)(136003)(376002)(346002)(54534003)(199004)(189003)(2906002)(86362001)(1076002)(6512007)(575784001)(4326008)(53936002)(25786009)(6666003)(186003)(107886003)(81166006)(68736007)(8936002)(76176011)(51416003)(6486002)(110136005)(52116002)(316002)(50226002)(7736002)(81156014)(305945005)(16586007)(8676002)(3846002)(48376002)(5660300001)(478600001)(106356001)(105586002)(26005)(50466002)(476003)(386003)(446003)(16526019)(956004)(2616005)(97736004)(36756003)(486006)(6116002)(11346002)(66066001)(47776003)(6506007)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4357;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR04MB4357;23:jpW7fkNZ6nnGyqjL+RZcpvWuC1jWF6F7JH/Pikckl?=
 =?us-ascii?Q?tIYYG3QKYNvWiWdJ3gcqTtVywyN4Ok9mnZ5s+AaNz3mmNimbkZqt9qw+Mp8G?=
 =?us-ascii?Q?rOY05PhxLCHKzvuPWJRjXu6pvPBPd2D//vZuNWdPw7M2gf08nXDtxaxODKUr?=
 =?us-ascii?Q?DESvPxjFcM6qPivCLtsd1/wlVRb8FOBjpntdGRttozFGxYGvmSneyj2zDwmr?=
 =?us-ascii?Q?qtTtTzR3ZR+36gu8YNZanH1H4ERAl5rD2oxLsId0AE47dMxNQLcLZh2/Pu0X?=
 =?us-ascii?Q?9LLIZ/kUvCudt5psKAg+8ixDHNu7z9ul03UWVTPr1L5PaIeAdNTDQ6oaaVpq?=
 =?us-ascii?Q?cd7KGqAQmyu6IqGhcR3ehWmmt0Zqf4ONMk7kIhyGDJpIIQo4cg9eFoapLYO5?=
 =?us-ascii?Q?LjfYS5yTXLRFlaG6uoVHTkcRJvtqnGWnUwQgJ5yWrTyeSYE68DS8MtXHGJRn?=
 =?us-ascii?Q?MhTI2DkOcpR97PKwJIABQcS0+tPVrhvMX9tgQIqQibpkyRqXgRmpySPUSngW?=
 =?us-ascii?Q?AcXgN7eXKICiIiwXaPkWivexswZB3g/+MggBCsAHr+WVOUuOO5yGHRMbAgZe?=
 =?us-ascii?Q?O5X/9X0WM8JZvkSSmZ8PNYrbLBVMTQCRjMVdk3z27Rv3Nk9Pen/u0PpJzNYW?=
 =?us-ascii?Q?SFKqTVMqwCOn22DmpCKsraSJfByXM2ZB7KobVfLE7o0e7uZcWgip8uegGOss?=
 =?us-ascii?Q?He9PWw1y0PBps56fsmoB1cKUXSrp83G2ABHehTfRc1XJ4eFcZk1WcH0bzWyf?=
 =?us-ascii?Q?0JP23cDk1Kc6v0+fJIeSVHjFEAxLvFvSevQ37Ut8t2DVsCK12sVnbtRI/doE?=
 =?us-ascii?Q?QjYplODWtLjQDuJMnBNreQhDxiw5CJnfhPlE7V4SOHlWnH5i5/EqCKz03h26?=
 =?us-ascii?Q?9HYT87SZEKvbZjVHdbIze1Y9hW7CRUi6e29o59FuXVnsQ8G6Kissm7S69DS1?=
 =?us-ascii?Q?XrAeatmecWsDSYuHoaU7ewy+1UFUftbdnXNYGYI0FitaMo1V1XlEuqdnn+mt?=
 =?us-ascii?Q?KGq9CKCzc5E4IeJmYF7im6GZAMOxj4cleTNkjY3QsZt+eb9c6XZ81mn82G5O?=
 =?us-ascii?Q?FKI/7dzLi/aja9pE1Yvj0Q5pjm3k+Hrkz1Z0RHDjxXdNNtyuydnRVN0mXMiw?=
 =?us-ascii?Q?KVYopoKBpERzf5oTRGb61E1G6wSx91earLvbaohM5NWRDoPzOBYL9a2CIlB6?=
 =?us-ascii?Q?elaER4bOfWVVEMgbWd/gk1AcmJpuUM8yBJFWfcPS5Y3plpozHU3fyhtwQAxX?=
 =?us-ascii?Q?u7E86s7FSgEy57QSrf7SSpGvE100sBj5nwxb8hGPq8Zt4rHvf8ycU76A8165?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: XJYwV21VijuVWZpS7rcHH6/9hZXc+XWr/HtlOA6CK+w/oy3B5wSGe9ooTcBJAUviHdxcFm3LaXXVpqEPNp1648p1F7qTb6YcX0XYlSaS/IfyPOHnlW/SQlDN041L+mHRf587AZAEALJTsrWJBgVMlvGV5qbmtpX6S8UXgmKk5++W+jlhlXmsHTkVfEeV7DsjCVzRBdZokTDkhKUOZ2YZE5oBpueh8uenoARwZ270k+H26BRFomG+rMz4crv/TtOVoP7+bRLLRHiQFdTQqomGEVODSzCXQMqhZVsoO3etkUqTur/goxpNrDt8pVqOXZI3NSb8Wg3l5Vg0xFzi4k0Z5ZMNgWUp+pj9hR5n8oYKi8o=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;6:pMx5jBN9Q5PExjjafJ+7s51s0jMHkv5QnYbn4wLED4SYoebr4wJt41DrlHhVNQjaP8WUPdVCPUmN+FfFhQZuiCTsPG0X4Ps0BNOxh1VCnXPTUbY4u5Qa8YiSCi3053/FFx7QSLA8NrzhAjanxPLcSt3+vNoZQhU6l+KyeqMcpLoTao/ucTcS3OoFvWA6nh8BZ11g+Q9oMpe0JtwWCJYWxnwltJXrNxoK7K7xvdbojPVNMugkKqOmV96igpzXNme03MQoh3G7S01IR2U/BjFYPmUjinkNWmh4WERts8p/yyTZmZA6vriDt5RXbHG33iVm36j2jWjlUN4lWNAzXzDhX78Vy2CH/Doh6vAYM0T5fur/fX+hdgkNcm99/3YUzf90z5vgmzfyqAeXqIgCw2q9n8JRezv0tUJm0kaMABFG8hky+zSH91V3Oa6gDssTe0gAb85TbObawW+2+F5vWvy9Cw==;5:zEWOCURCg8IiYjoQZ5qM58mKBEry4Kxwb62etJtYPn3uk+AwgEDZy4gcQlO6dEiTI2bfW3+tRUFR8wgD8bCEoqvuHBRR9qgcGl+9WQ2GidArB0MsRa4tCEcRHNjZXJgN993o2MBQXWCsAHIMSTP1Vq+HZqOnBGYUYORZqzmc6SU=;24:YHPnfeSBxnA3nVnBAGuQFIMQKH12MYWw+sdLfpJyj9fzYwKNDijcQfqoRVyDZec5pk4pj+83c9fz7WtSP6se0neUrteLcArFYRbMApOML8g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;7:Wmzuvx7GYMkhDsQcJINvI601FZZuhWJ6vynNNphjQdOH+9dEyAl/aA1O+Sgy1RYz3huF7I4wYX/YZfP26CNAj4s8OMQvR1VmDfu7S/RqLkIc4FrpCNH8qqxwdNiokvc4eOa6m5l7hz51fiTHxNI7SyC22oSvfAePTswFrYz89m7UNpfNqS4BKTjLxpChsv6VOxNrt/0zZVsRRisse0nLtTlAmZHmE97AYTTeDSJxkWQwPZficpAE4ntz1SFx9cqs
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 15:47:07.3287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf854b1-d8b6-47eb-017a-08d5db7c1416
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware tuning function instead of software tuning because O2/Bayhub
SD host controller support hardware tuning.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V6:
	1. From module 'sdhci' export the symbols 'sdhci_start_tuning',
	'sdhci_end_tuning','sdhci_send_tuning' and 'sdhci_reset_tuning'.
	2. Remove local tuning related functions in sdhci-pci-o2-micro.c
	instead of above function exported in sdhci module.
	3. Remove unneeded braces in function sdhci_set_transfer_mode.
	4. Move change log to correct place.

Changes in V5:
	In function sdhci_o2_send_tuning, mrq.data should set to NULL for
	cmd.data has been set to NULL.

Changes in V4:
	Patch V3 delete register SDHCI_TRANSFER_MODE write operation before
	send hardware tuning command in function sdhci_o2_send_tuning. This
	is a mistake. The write operation is essential for tuning command.
	Add it back.

Changes in V3:
	Rebase the patch on the mmc tree 'next' branch.

Changes in V2:
	Modify code format, and delete unused code path.

Changes in V1:
	Add many functions to execute hardware tuning for eMMC 1.8V HS200
	mode, the hardware tuning procedure is based on O2/Bayhub hardware
	tuning spec.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 81 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c             | 16 ++++---
 drivers/mmc/host/sdhci.h             |  5 +++
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 94cf3cd..7747e8b 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -17,6 +17,9 @@
  */
 
 #include <linux/pci.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/delay.h>
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -55,6 +58,82 @@
 
 #define O2_SD_VENDOR_SETTING	0x110
 #define O2_SD_VENDOR_SETTING2	0x1C8
+#define O2_SD_HW_TUNING_DISABLE	BIT(4)
+
+static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
+{
+	u16 reg;
+
+	/* enable hardware tuning */
+	reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
+	reg &= ~O2_SD_HW_TUNING_DISABLE;
+	sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
+}
+
+static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int i;
+
+	sdhci_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
+
+	for (i = 0; i < 150; i++) {
+		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				host->tuning_done = true;
+				return;
+			}
+			pr_warn("%s: HW tuning failed !\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+
+		mdelay(1);
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_reset_tuning(host);
+}
+
+static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int current_bus_width = 0;
+
+	/*
+	 * This handler only implements the eMMC tuning that is specific to
+	 * this controller.  Fall back to the standard method for other TIMING.
+	 */
+	if (host->timing != MMC_TIMING_MMC_HS200)
+		return sdhci_execute_tuning(mmc, opcode);
+
+	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
+		return -EINVAL;
+
+	/*
+	 * o2 sdhci host didn't support 8bit emmc tuning
+	 */
+	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+		current_bus_width = mmc->ios.bus_width;
+		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
+	}
+
+	sdhci_o2_set_tuning_mode(host);
+
+	sdhci_start_tuning(host);
+
+	__sdhci_o2_execute_tuning(host, opcode);
+
+	sdhci_end_tuning(host);
+
+	if (current_bus_width == MMC_BUS_WIDTH_8)
+		sdhci_set_bus_width(host, current_bus_width);
+
+	host->flags &= ~SDHCI_HS400_TUNING;
+	return 0;
+}
 
 static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
 {
@@ -215,6 +294,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 			}
 		}
 
+		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..4f3e3c2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1029,7 +1029,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	if (data == NULL) {
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
-			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+			/* must not clear SDHCI_TRANSFER_MODE when tuning */
+			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
 			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
@@ -2103,7 +2105,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
-static void sdhci_start_tuning(struct sdhci_host *host)
+void sdhci_start_tuning(struct sdhci_host *host)
 {
 	u16 ctrl;
 
@@ -2126,14 +2128,16 @@ static void sdhci_start_tuning(struct sdhci_host *host)
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_start_tuning);
 
-static void sdhci_end_tuning(struct sdhci_host *host)
+void sdhci_end_tuning(struct sdhci_host *host)
 {
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_end_tuning);
 
-static void sdhci_reset_tuning(struct sdhci_host *host)
+void sdhci_reset_tuning(struct sdhci_host *host)
 {
 	u16 ctrl;
 
@@ -2142,6 +2146,7 @@ static void sdhci_reset_tuning(struct sdhci_host *host)
 	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 }
+EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
 
 static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 {
@@ -2162,7 +2167,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
  * interrupt setup is different to other commands and there is no timeout
  * interrupt so special handling is needed.
  */
-static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
+void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_command cmd = {};
@@ -2212,6 +2217,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 			   msecs_to_jiffies(50));
 
 }
+EXPORT_SYMBOL_GPL(sdhci_send_tuning);
 
 static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..2a09c0a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -748,4 +748,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 
 void sdhci_dumpregs(struct sdhci_host *host);
 
+void sdhci_start_tuning(struct sdhci_host *host);
+void sdhci_end_tuning(struct sdhci_host *host);
+void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_reset_tuning(struct sdhci_host *host);
+
 #endif /* __SDHCI_HW_H */
-- 
2.7.4

