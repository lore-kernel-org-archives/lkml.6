Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCB7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5351820821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zUuLhs05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfAIJ04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:26:56 -0500
Received: from mail-eopbgr750071.outbound.protection.outlook.com ([40.107.75.71]:34304
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728138AbfAIJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGRSmbpqn2qXUwZsO5NDYwjJXEl9up7pXrJ1pOCMA9M=;
 b=zUuLhs05+R4qKruqK7/cJf+c8H5qycalQwQslNR9nmmUzXia1qkci1djRKI14NXUyokS15fxcVsG9jFW/IwU/fCiqQuM1yGZAkyG/GhwfUYbWYCnWc33rw93a0RCMkAB+Bs0iWoJDvfoxhjCoUfuRZUg0lvlEx+k4DowrT6/DCM=
Received: from MWHPR02CA0035.namprd02.prod.outlook.com (2603:10b6:301:60::24)
 by DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Wed, 9 Jan
 2019 09:26:36 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR02CA0035.outlook.office365.com
 (2603:10b6:301:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Wed, 9 Jan 2019 09:26:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Wed, 9 Jan 2019 09:26:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51884 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA8B-0000WX-0W; Wed, 09 Jan 2019 01:26:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA85-0000jl-RA; Wed, 09 Jan 2019 01:26:29 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x099QSGj019294;
        Wed, 9 Jan 2019 01:26:29 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ghA84-0000iw-8g; Wed, 09 Jan 2019 01:26:28 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 639A8800EC; Wed,  9 Jan 2019 14:56:27 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH V2 3/4] crypto: Add Xilinx SHA3 driver
Date:   Wed, 9 Jan 2019 14:56:24 +0530
Message-ID: <1547025985-7228-4-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(199004)(189003)(2201001)(90966002)(54906003)(316002)(110136005)(42186006)(16586007)(81166006)(52956003)(106002)(81156014)(478600001)(336012)(106466001)(6666004)(103686004)(2616005)(305945005)(356004)(126002)(107886003)(426003)(8676002)(6266002)(476003)(8936002)(4326008)(50226002)(63266004)(446003)(11346002)(186003)(36386004)(26005)(14444005)(217873002)(36756003)(51416003)(76176011)(5660300001)(47776003)(48376002)(50466002)(486006)(44832011)(2906002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4330;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT014;1:gFzo1ogfTKYSSG0wyUUjAy0Vm84lqzPobgYiEfApVDhnyJDEHRrpMW9RHWk/IS+RTM+6oHHoJ5hxe/WExylJRCm6+MQ14SbYiph5NIx7moDif+EiX05FKga/ldIWBlp1
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33c4032c-1afe-4dec-05e6-08d676148d13
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;3:YusPrhim77WP3iUYXerRZFeS5uGY0JepXWsxBC6xwha6/LNRpOcz++RCLV+ua0q9F90RUivN/0ohwgngrj94pUMKqLPWHGXgfI6JW6S3NUAZfihcxBptc1A6Y+DZ47E2taoAwzWdKz36986mKbfhN06FjX9x/rGpFo91iPO4vOX+aWPnyNZqxS09AMbEjsj5AspnYLj0Ibc+PKWq9oqmI5hF9oe4ZF6m8EXliuTyxRaegTWlJtJ3UzIVxFx2FjQLH+rQ/u3KtNVCEih5NFLWJG/o7M5l0ldVm8uX5+OOcVxknaq1qO7l958eng4HgyNp1Lcxqs0nD438497cmyRwZDIwDNqO/f9gQKG1T54Zn9J65fFuorR1rlnHh4gmlcm/;25:4xg5bsX9SCnkpwOBHXMroLwLHlK7lqLZg3oCEnH3xyq8wgPRISfBzhrM1AVLm5f84o+mt2M+/M9CVTgVku9IrOdA5ovqwFwrPQR5hl0RKbuiwlljUpVN36T0c0jct0i9RgItA+Oiokq5aJyf38bivA7E7/qtnAZVksoqSklJQ32ZIj8nUD4xuaLBqpeuUCtpogImPFZZcqhW7fzKdmAnoSRpvZsoW7Gbf0FHw+19fsT98FnCwCBW0oqvrgH9L4J68HyNZxkF0vPvyP5QUmW5Avvg16UhtpWc2jzlhAmJCPedwILgARU8pZqwp4Ow8OUm94Ld9VzoCjyRU3ZQMwZyYA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;31:6KYA17SFchDXBS5pU/LxqILGHusEUnuOtFYE0D7V8supSgq7QIQfw0B+NrSDA5U+nOaolQgnzx/qMKE6gsZap+3dYSjXc9qQr+kGApCEQ7WztKRhyPwwMe3ros9OiF21Qj677s0JXTcy+eg2QybgB+riGfqFSUrf+2SumcgIWRUOhtdI7e2F9w7VjpZSHf8zDJDNClm3W2GPpyxqhC6/PFtB6qlKlDJktOMVtqkVIrM=;20:0cDtDiWtJoEEVhwIdsE11nRrKnpdNAIwva/e/4rD9NAhJUVM2dDVEdIrfkj1hiGILJ1/XNlARn/48gPxg06YZ+DLIMBf4WGyAo9VTgt6SsMMeYGzyreyhfGoePfjx/cYeIjUhLfa+Uh3Yb1tVgenQxdbhwu/a933Hsng+y7mE6hFhk6i5Wyog7Pc2P1MDCsRVyAfevQiS3fN51OBq0P3mn0dgQwsrSmGPOL28qwALP1R1xBL5MYRbcliZq0Xwp7zGN5gj+vzqfksJvK0afQM74l8t1/Iewoq9w8+XZrRUUSkJ4E7fsAYfgA0o9ptVSD0jQl16FC+9WXU5Lp0OPYmHCs+pd98DDLRyq0iNFeQiE+cMHB8lSELQFaMUPzJkl3wKyguMoP5bdYH+phjBPQMfe5coM7Y7+XFJnUur+MroRFqDLDmD456Fs57JOvlJ7BytRmPK0i05iyjFa9cW3LuC3286zjVScrz+lJSZCTmR8nSMyHqmBTDaAL+8b/2bqDU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4330A73366FEBEB32EB371CDAF8B0@DM6PR02MB4330.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;4:pi0JyQMHyjsuWH+ClJH27exV2/WbA6dkqqSFxmqAxJ8symydUsYm1KLC/QL0WikMOQ3BF6dWpCmVjDZSAsYFwVc/oVtrehcqPB/GkCTda+6ElmCWriivPx48IpeDlP3pTN4pockiw/BWSM+cJSYoAy+T/5xowoaPQTuMbfA9y6bapjcwcnvVN4ezdyc09+WEkUmaUaszxVQ1dKVaNNXHk/bwZfvKNC4dCdCo0hAEBCPBu9FVpnPvYK7hSbg+Aj8s5D0CTJfMGJGQYkFot8mZ5c6348pgwNkQxGzUOAC/q5NXzb8mbbKnmLniW2EBYUPr
X-Forefront-PRVS: 0912297777
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4330;23:IzSqj8DRqIiFmogC9V9W0QyrwaWVCVrFhvf+V7Poz?=
 =?us-ascii?Q?qrMRVKIoXsI48YKu8qpZsoZcq4965qkKJg20bKRuS0M41hLt5k31JKYpF8F9?=
 =?us-ascii?Q?1NNOGA8atyHAheBJgE4DERFUIIRGv7e7fBdTXn9N3QsyoxSp7wVLjKcEzejQ?=
 =?us-ascii?Q?DzBrM9l5dUj+TXr99dMwvzLDErwfBDnkGYjmtFvaCFnG1Gux7E/kI4fG4bkp?=
 =?us-ascii?Q?cKIn8nJ0u3NRH62E7IvnEMobnw7sqfyq1hnX+zuVDAZBKVGwVrvmrhn7TkrL?=
 =?us-ascii?Q?YaHMeFwI5t2jbmW6DzUoQmxauGmcXVjyh5+jqmXkp78PRbci8lcIv8g032O1?=
 =?us-ascii?Q?3D9A8nWxfGS3vs3MoQVbV0mxe3oNJBcVw288Fqng2LWmqnx0IKYM29nq5Hj6?=
 =?us-ascii?Q?RaKIy+Xkx/qxXCjmhC6ekA9ypHgqJNM1rkzYKrldeSDUnof+d8pz5awgPYqq?=
 =?us-ascii?Q?3eGDGq+gijMfCHZHD8kbe9NNIgY8nDGxtpPHnAYPJDmHrajZ9KST9mT7YkTs?=
 =?us-ascii?Q?KsQBF0VwLFTUaRWnHX6bk3Ssg0igVb8jEbHzUnwCEJBICgZG5xt3jGJVDCXU?=
 =?us-ascii?Q?pDvgOeLL/OfjFPTJ6VABIN1h6Q91N7OlACGZ9He1MLgNR8LM8TvxOFCYMJ0P?=
 =?us-ascii?Q?ta5bnBdeeOyDjJ9XiURysrtB3LIvHDjfwxMWKdI86TGR7AmCfSmGsVezvfZ+?=
 =?us-ascii?Q?XoWt0QJZHosoWC5fCaLNbcjt2bPQB8VCXOYs3wwAifYudYLEqGomZRWDEkYs?=
 =?us-ascii?Q?ajBEIxAYg66lssjUspdfLcUmLzZ5oG8Bhuo1wL6IgrvYhBoYsUu8Rku7s33o?=
 =?us-ascii?Q?XKr6SGU7dkLDD30JnWqc2KAXhCY9VTJ4+/wLYpjhi8DMP4RYShH+D8Qpnq+l?=
 =?us-ascii?Q?gkHJI4eRS7IKD+7t5rtq3/pB2hlNxtXRI3sS0hfKTvfLA9ec2TjmCXKtdXJZ?=
 =?us-ascii?Q?V/BmDM3smKBesunQj88UCSYF5ksIrZYxFiZfMo/f2x7HHil2GZLUiVdIELWc?=
 =?us-ascii?Q?lK7OXFBf7MfDzdtn1+QDWimCd8+/FK3BX6i1Qq0cgLw83JSIyHkqJ67GwsJm?=
 =?us-ascii?Q?E8aOFeyM9nkWy4Mw6KLdV5oK7Ed0Z8QczFiTUnYKXVNpXdmIvTnzq3owyTmw?=
 =?us-ascii?Q?F8xXkyRjSXH+6dqoO+8iDq1V9w98eTNugjWNw4A3jNYnegss5o2iQSv7TQxJ?=
 =?us-ascii?Q?KyYNX0ZRLBHzeeP6/dBpgRtYsbJp0sxnXp43hnfRTiXEU/5BImWuueP8SYeI?=
 =?us-ascii?Q?mmRZL6tAopExT+12dE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7ciSAkXcZnijImgHLFAx+DZYIlcIvZH1STdfa5pD6F/hVv3m76kqtDumbs/bXKEIUWafrxZAOAHuDDrGCOtGOngpurXKXPKhxu1rc2d0kEaKiYtgiO/ekVxIiSANdGWQqU7an47ZviMs91OFuguUVoPmJYM/2jOIuHl/sprMtaN4tJ4HN7D7yi48LSWL2Y3jLL1GTirGi6PiWJX8l6JTlJCubdOH1Rd+jZE0c3YdV4TznRiZCOM0bxIUzVcQgMrCq2UjSkdGF+3RLpltaR739FFWeydwgTEojOk/E2XbA7rJglELIIQyRGPCt9SQ7iFe
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;6:MK/t5TfA3jkWeEpRHcZuzbNwgxpELxcYQp9zPiuMrSGcLCXfISyG86o+7qkbZJtbkkELg5akAXI34Uw2MPfkjk3n7MNvg+9cAILAJ+LkPiYa8LpK+kEml/EJWM3atjyawb9X+/Il6t36E7L8FBsPaP/vWtXYputKyO/HW/9wJhFFfxWIcnyFLsYMRq6DkZr+WrKsEnmL3PDV5iqIFHPmvUZaz+msdKoiE8QrQSV3k12joO9tmi+enAgD+Br6qEX9WF0qKMt6MA6Xu2WWfglWH8vWaATB5UueNAWk/L/MHFUfi/ByioZFm6lLRtcphE+C8qUrJehPs0DqiDnTgXEqiXOYdRXANmnObIAw14QNWNYhVJfexvP4fQJMhoKSnGIyBdIAVPbJ4jWhlnONs/QPDoSLaWLi0VY6gRADPn98HGHSLpkkel1qnXN0Ob4+9y+P+n7loehRteb5cM/u4YOY7Q==;5:/Dr4g/nkQvfuK/Ga8Bau6exoiEMGFVu+EJvJ5waTZaHRo+7syD3P+rSbieqPklAI4SOKW325rhr7efzUO6Eh10w3Mds1+eIFpZUMmirVdzNfusH7O0XlXq9wJa7UJy/JQt806Wbc0CIF4K+e0J8NtYAVNarBVZ8MZooHhnO46nOQrZMK9lZH+GY5ZbKbTt/oQbkSGoaEomlScNy5wMr9kg==;7:JQUsPQrzBCkISAZ+teuRmNbgfFKLnVJw81twtRZvMcq5erh3MXEi+4TUQLkZ1+pq0qRW5W0Iso3cffrNCIKaYdnfZyzLOv5sgJ43lU9bmGC2pwXFVwVdnX9fPfjEyCzRt5Ag4o1MF8X5+9xmpAh2LQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2019 09:26:35.4948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c4032c-1afe-4dec-05e6-08d676148d13
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SHA3 driver support for the Xilinx
ZynqMP SoC.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 drivers/crypto/Kconfig      |   10 ++
 drivers/crypto/Makefile     |    1 +
 drivers/crypto/zynqmp-sha.c |  305 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 316 insertions(+), 0 deletions(-)
 create mode 100644 drivers/crypto/zynqmp-sha.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 5a90075..b723e23 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -667,6 +667,16 @@ config CRYPTO_DEV_ROCKCHIP
 	  This driver interfaces with the hardware crypto accelerator.
 	  Supporting cbc/ecb chainmode, and aes/des/des3_ede cipher mode.
 
+config CRYPTO_DEV_ZYNQMP_SHA3
+	tristate "Support for Xilinx ZynqMP SHA3 hw accelerator"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	select CRYPTO_HASH
+	help
+	  Xilinx ZynqMP has SHA3 engine used for secure hash calculation.
+	  This driver interfaces with SHA3 hw engine.
+	  Select this if you want to use the ZynqMP module
+	  for SHA3 hash computation.
+
 config CRYPTO_DEV_MEDIATEK
 	tristate "MediaTek's EIP97 Cryptographic Engine driver"
 	depends on (ARM && ARCH_MEDIATEK) || COMPILE_TEST
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 8e7e225..64c29fe 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-$(CONFIG_CRYPTO_DEV_SAFEXCEL) += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += hisilicon/
+obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_SHA3) += zynqmp-sha.o
diff --git a/drivers/crypto/zynqmp-sha.c b/drivers/crypto/zynqmp-sha.c
new file mode 100644
index 0000000..56e83cf
--- /dev/null
+++ b/drivers/crypto/zynqmp-sha.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cryptographic API.
+ *
+ * Support for Xilinx ZynqMP SHA3 HW Acceleration.
+ *
+ * Copyright (c) 2018 Xilinx Inc.
+ *
+ */
+#include <asm/cacheflush.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/scatterlist.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_device.h>
+#include <linux/crypto.h>
+#include <linux/cryptohash.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/algapi.h>
+#include <crypto/sha.h>
+#include <crypto/hash.h>
+#include <crypto/internal/hash.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define ZYNQMP_SHA3_INIT	1
+#define ZYNQMP_SHA3_UPDATE	2
+#define ZYNQMP_SHA3_FINAL	4
+
+#define ZYNQMP_SHA_QUEUE_LENGTH	1
+
+struct zynqmp_sha_dev;
+
+/*
+ * .statesize = sizeof(struct zynqmp_sha_reqctx) must be <= PAGE_SIZE / 8 as
+ *  tested by the ahash_prepare_alg() function.
+ */
+struct zynqmp_sha_reqctx {
+	struct zynqmp_sha_dev	*dd;
+	unsigned long		flags;
+};
+
+struct zynqmp_sha_ctx {
+	struct zynqmp_sha_dev	*dd;
+	unsigned long		flags;
+};
+
+struct zynqmp_sha_dev {
+	struct list_head	list;
+	struct device		*dev;
+	/* the lock protects queue and dev list*/
+	spinlock_t		lock;
+	int			err;
+
+	unsigned long		flags;
+	struct crypto_queue	queue;
+	struct ahash_request	*req;
+};
+
+struct zynqmp_sha_drv {
+	struct list_head	dev_list;
+	/* the lock protects dev list*/
+	spinlock_t		lock;
+};
+
+static struct zynqmp_sha_drv zynqmp_sha = {
+	.dev_list = LIST_HEAD_INIT(zynqmp_sha.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(zynqmp_sha.lock),
+};
+
+static int zynqmp_sha_init(struct ahash_request *req)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	struct zynqmp_sha_reqctx *ctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct zynqmp_sha_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct zynqmp_sha_dev *dd = NULL;
+	struct zynqmp_sha_dev *tmp;
+	int ret;
+
+	if (!eemi_ops || !eemi_ops->sha_hash)
+		return -ENOTSUPP;
+
+	spin_lock_bh(&zynqmp_sha.lock);
+	if (!tctx->dd) {
+		list_for_each_entry(tmp, &zynqmp_sha.dev_list, list) {
+			dd = tmp;
+			break;
+		}
+		tctx->dd = dd;
+	} else {
+		dd = tctx->dd;
+	}
+	spin_unlock_bh(&zynqmp_sha.lock);
+
+	ctx->dd = dd;
+	dev_dbg(dd->dev, "init: digest size: %d\n",
+		crypto_ahash_digestsize(tfm));
+
+	ret = eemi_ops->sha_hash(0, 0, ZYNQMP_SHA3_INIT);
+
+	return ret;
+}
+
+static int zynqmp_sha_update(struct ahash_request *req)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	struct zynqmp_sha_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
+	struct zynqmp_sha_dev *dd = tctx->dd;
+	size_t dma_size = req->nbytes;
+	dma_addr_t dma_addr;
+	char *kbuf;
+	int ret;
+
+	if (!req->nbytes)
+		return 0;
+
+	if (!eemi_ops || !eemi_ops->sha_hash)
+		return -ENOTSUPP;
+
+	kbuf = dma_alloc_coherent(dd->dev, dma_size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	scatterwalk_map_and_copy(kbuf, req->src, 0, req->nbytes, 0);
+	 __flush_cache_user_range((unsigned long)kbuf,
+				  (unsigned long)kbuf + dma_size);
+	ret = eemi_ops->sha_hash(dma_addr, req->nbytes, ZYNQMP_SHA3_UPDATE);
+	dma_free_coherent(dd->dev, dma_size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_sha_final(struct ahash_request *req)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	struct zynqmp_sha_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
+	struct zynqmp_sha_dev *dd = tctx->dd;
+	size_t dma_size = SHA384_DIGEST_SIZE;
+	dma_addr_t dma_addr;
+	char *kbuf;
+	int ret;
+
+	if (!eemi_ops || !eemi_ops->sha_hash)
+		return -ENOTSUPP;
+
+	kbuf = dma_alloc_coherent(dd->dev, dma_size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	ret = eemi_ops->sha_hash(dma_addr, dma_size, ZYNQMP_SHA3_FINAL);
+	memcpy(req->result, kbuf, SHA384_DIGEST_SIZE);
+	dma_free_coherent(dd->dev, dma_size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_sha_finup(struct ahash_request *req)
+{
+	zynqmp_sha_update(req);
+	zynqmp_sha_final(req);
+
+	return 0;
+}
+
+static int zynqmp_sha_digest(struct ahash_request *req)
+{
+	zynqmp_sha_init(req);
+	zynqmp_sha_update(req);
+	zynqmp_sha_final(req);
+
+	return 0;
+}
+
+static int zynqmp_sha_export(struct ahash_request *req, void *out)
+{
+	const struct zynqmp_sha_reqctx *ctx = ahash_request_ctx(req);
+
+	memcpy(out, ctx, sizeof(*ctx));
+	return 0;
+}
+
+static int zynqmp_sha_import(struct ahash_request *req, const void *in)
+{
+	struct zynqmp_sha_reqctx *ctx = ahash_request_ctx(req);
+
+	memcpy(ctx, in, sizeof(*ctx));
+	return 0;
+}
+
+static int zynqmp_sha_cra_init(struct crypto_tfm *tfm)
+{
+	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+				 sizeof(struct zynqmp_sha_reqctx));
+
+	return 0;
+}
+
+static struct ahash_alg sha3_alg = {
+	.init		= zynqmp_sha_init,
+	.update		= zynqmp_sha_update,
+	.final		= zynqmp_sha_final,
+	.finup		= zynqmp_sha_finup,
+	.digest		= zynqmp_sha_digest,
+	.export		= zynqmp_sha_export,
+	.import		= zynqmp_sha_import,
+	.halg = {
+		.digestsize	= SHA384_DIGEST_SIZE,
+		.statesize	= sizeof(struct sha256_state),
+		.base	= {
+			.cra_name		= "xilinx-keccak-384",
+			.cra_driver_name	= "zynqmp-keccak-384",
+			.cra_priority		= 300,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct zynqmp_sha_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= zynqmp_sha_cra_init,
+		}
+	}
+};
+
+static const struct of_device_id zynqmp_sha_dt_ids[] = {
+	{ .compatible = "xlnx,zynqmp-keccak-384" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_sha_dt_ids);
+
+static int zynqmp_sha_probe(struct platform_device *pdev)
+{
+	struct zynqmp_sha_dev *sha_dd;
+	struct device *dev = &pdev->dev;
+	int err;
+
+	sha_dd = devm_kzalloc(&pdev->dev, sizeof(*sha_dd), GFP_KERNEL);
+	if (!sha_dd)
+		return -ENOMEM;
+
+	sha_dd->dev = dev;
+	platform_set_drvdata(pdev, sha_dd);
+	INIT_LIST_HEAD(&sha_dd->list);
+	spin_lock_init(&sha_dd->lock);
+	crypto_init_queue(&sha_dd->queue, ZYNQMP_SHA_QUEUE_LENGTH);
+	spin_lock(&zynqmp_sha.lock);
+	list_add_tail(&sha_dd->list, &zynqmp_sha.dev_list);
+	spin_unlock(&zynqmp_sha.lock);
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+	if (err < 0) {
+		dev_err(dev, "no usable DMA configuration");
+		goto err_algs;
+	}
+
+	err = crypto_register_ahash(&sha3_alg);
+	if (err)
+		goto err_algs;
+
+	return 0;
+
+err_algs:
+	spin_lock(&zynqmp_sha.lock);
+	list_del(&sha_dd->list);
+	spin_unlock(&zynqmp_sha.lock);
+	dev_err(dev, "initialization failed.\n");
+
+	return err;
+}
+
+static int zynqmp_sha_remove(struct platform_device *pdev)
+{
+	static struct zynqmp_sha_dev *sha_dd;
+
+	sha_dd = platform_get_drvdata(pdev);
+
+	if (!sha_dd)
+		return -ENODEV;
+
+	spin_lock(&zynqmp_sha.lock);
+	list_del(&sha_dd->list);
+	spin_unlock(&zynqmp_sha.lock);
+
+	crypto_unregister_ahash(&sha3_alg);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_sha_driver = {
+	.probe		= zynqmp_sha_probe,
+	.remove		= zynqmp_sha_remove,
+	.driver		= {
+		.name	= "zynqmp-keccak-384",
+		.of_match_table	= of_match_ptr(zynqmp_sha_dt_ids),
+	},
+};
+
+module_platform_driver(zynqmp_sha_driver);
+
+MODULE_DESCRIPTION("ZynqMP SHA3 hw acceleration support.");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
-- 
1.7.1

