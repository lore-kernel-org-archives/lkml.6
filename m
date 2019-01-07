Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB107C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9F220859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iVXeiGZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfAGJDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:03:23 -0500
Received: from mail-eopbgr790054.outbound.protection.outlook.com ([40.107.79.54]:27456
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfAGJDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXtD8+fBLtWU3ZZUxmvw2TOEeXdpdzwsiHaggx/FxbI=;
 b=iVXeiGZwmRKNox4q/pucxadsBPoEpNjHM9Q7YrCqySv24JouebaH6hECT3NZqUR5oP3gzjZeAHx8DHIZjFzJxxvQ1ogYz1nR9ZjVrkzqcFu+YJ5nC0aack/7YwDKiEUeHA2g4kFbPEdDIMi7QIAPB360XvtflNN5V86CgC7Ezso=
Received: from DM6PR02CA0030.namprd02.prod.outlook.com (2603:10b6:5:1c::43) by
 DM5PR0201MB3511.namprd02.prod.outlook.com (2603:10b6:4:77::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 09:03:12 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR02CA0030.outlook.office365.com
 (2603:10b6:5:1c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Mon, 7 Jan 2019 09:03:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 7 Jan 2019 09:03:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ggQoP-0000nH-O3; Mon, 07 Jan 2019 01:03:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ggQoK-0001lU-KH; Mon, 07 Jan 2019 01:03:04 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ggQoF-0001j1-4I; Mon, 07 Jan 2019 01:02:59 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 4C9F2800AF; Mon,  7 Jan 2019 14:32:58 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 2/3] crypto: Add Xilinx SHA3 driver
Date:   Mon, 7 Jan 2019 14:32:55 +0530
Message-ID: <1546851776-3456-3-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
References: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(189003)(199004)(44832011)(50466002)(486006)(2616005)(305945005)(336012)(48376002)(14444005)(478600001)(47776003)(54906003)(110136005)(426003)(106002)(2906002)(316002)(81166006)(42186006)(16586007)(50226002)(81156014)(8676002)(8936002)(5660300001)(356004)(36386004)(63266004)(126002)(476003)(103686004)(217873002)(36756003)(11346002)(90966002)(446003)(6666004)(6266002)(4326008)(76176011)(2201001)(186003)(51416003)(106466001)(26005)(107886003)(52956003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT007;1:EoKfLIEJcYBAQVFeeNH85zvfL+0nDGalpEAYaaefpbyfLaapFMMWXCwv5EqDTi/R0udtjMX0P82WNF+5n9CluO4rMOJ4nQvWVsyrUjiI88KAYeXBObc4wPOj7t6NMvKV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da13bfbb-c1bb-4965-ce74-08d6747ef38c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:6WCej6KgR88w7kUdq/pZELmQJy7TJqw7aRlYkdAbRDobfYP91st50Nsbd4DgJFwPM9jGPNpk2fYLcO7rNQlXQBLJjl5Y2WOZGBGioZ4d1dZXU56Yv7UDW9kP6Gjt8pGiocPgwKL02MX3a4vkXs4VlerjmrB01sMiFDJPYgWg6DgnDwYJcYL6wAap5XYBwfnFu2gp7a5MgWgltAJDuv9onXKLcJI1VtrTN/YZUTz1ZP50tytOuEW0nbNlkDYLXpdGlMGB2F+WtiNdA+mHijWmbXKhFbXm5Cf4HsX2tK8DS7Y/GXb+yopx0BYJ47HE4dMyDbmLijPBqsMCOOCeaFhEOy5H7gZRxC0NBSdHyKVQp/CJ1coWOvyMgav4swGHh5Fj;25:mdZ9CPL17rxv9nN3Q2P9QD8L5vkRDgGwrY3U8qpMBGvvw82EDMmZOYW7bA0m90AAYQMZbKqDSFAVtM8wAKB8aKCpKFKdoBb74SR3Ofc9BbO3YGaO3EtqTNLIO0xCZBhJC3VebJs1/WSu/hdUHejVzXaZVJ9+JudlQ8dBh7biDrI7r/ba+DrnQMOiUluaOYImvCkFiPJWmXMBHrimPzfq6H14D3cu8sX6BR9neueMsJFNTb/nrIZEa154ZBq8YCkKfwCz86tH1mbjvvQdGaWG87zqPA/3lUslhS+Ha917Bzr+FgMlNC0Z+oyMctqq3wgMvpxyuhSvrSfIYhy5GRE+DA==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:BAdf7w8lqpnHhnJo1scDBXmVw3uS8luo6Lbwezy1Zra8o9lrgqFuq5yb1tzVtZEdU9XpT53dSB+wvdmDM/CYJqNAYPuSgrg8Kvfz4ZLcGH+PnoOVAj17qczRZZBeQ1baw4cwezrBiMomfNqoTr2O+LRifrFoty0Q0SQAOwANuwAn5/5so5fbQ63uZXSYeAizuVwbSKK0KaTS7fe/JAN+PeEDB67ydGKkTfpZepJ+54g=;20:EqX+isjwEWWJfN4hHtO75oPptL9ox5PaKMzV/sf7VPfDVnq3n8lN/WJO7b10xAwvyGfO9McTYrXkz81CNIgBC7iBrHgCFenNv/YhTxcs2a7/fLE+JldVBMkifE4PAsMF8bxTeI2T2LTzHXvsVHyD0tSXtZo1Im97tmetHgkgcIPGn9bqzX5JfPrn84b4ynSx8QOapiUlEGlxkKEu6XkakTQ9VFJ/kYTAqipeIj4Ak/oXozhUcyiJE4q+98EtQmdyf7tpD7kKHQnk+2FNu6YzJCoGMR/4qsTEAlgYyjB/1XkuOD0CprMV9keh8uLuaUgUPb6S7H/5BoiKMCGE56XRU9SjoNCVoSiFRQnfh5dJsRaF+OZuIBaXOGBMEaI0xTrF6G1gr8cJAOe+xMc37A+/lzKBqLP5+rkpWQCx60IizlLi7658PAcNuty8eAFpBZY8yuZgqZhMqc0HVM/U+y4vDnKNDDxHmEBUrafqiL3PstBSw62K7Y++AVdW6ucda3TB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35112D712E04FBD3A26213DAAF890@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93004095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3511;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:88wggSHsC6zUJSAPnzLkobWytWqZZGoAc9AvN0TCTZWS18YnxnzLvwL+iTtNr+XB2/EpFXj43yXCQGCx+UYR/sJwBAiKRpDYg1btYaB5cS5IMVv7/1FhzEL2XtRVNvK/qoG+NqW0DEygkcYSWUqq5+STn8eDEBI8KpMhyq2aD9Ls52mvAt/tzAjqgtnUqeO9ZibJsn54wsOWkq+/6sbU/ZdA8Ex8QqfSbfZBGKWLDd4NIE88MR6Xm7SazZWdXkuouq07ST+nmlq+fjOO9IkTVCdiEmFF1VoOSTcVAgosqxihU/S/Es4WygqyYM8VPpPU
X-Forefront-PRVS: 0910AAF391
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3511;23:/P5yXHZAdT2LvVFiU+fFT0YvjeccMZIBNURSGTp?=
 =?us-ascii?Q?6zQz13yI/RGz3I1+Pshcwk+zSZ+zEAtkT+REnZHXCqLcalykMTbV3G0aVQK4?=
 =?us-ascii?Q?8VV4F4qYDzNoZSGMtYgGZT/+qMVgbKbYqZb7mxJ8JEFWLFjhDdWWgYZFjVIY?=
 =?us-ascii?Q?xk4M5oEborosWQrFYRK2XLg9/Z7aRSeP5ODU7hRBD+Lpd/yZzbHQwaWjJOsI?=
 =?us-ascii?Q?B+fZjkHXCEQ1VC9BtSpklG6WePGEWOVF6Lsh8sV37+mr23/AkKi9s7pyfgB7?=
 =?us-ascii?Q?3AjTW16LrothsPgrsCgG/wg58XY15jsN795mSnzUpH7hxI9r39JspArgRgHW?=
 =?us-ascii?Q?Shj5+acOi1BeeGSmZY5IrFnw1MorXTErMQx2Fdii3DswbcCf8JdP3kTu2BFC?=
 =?us-ascii?Q?E4ENf37M5kBLXvjzcP/7pPZkPJnGBDloclwM85yy5utr4ArXxI55ysVRtLil?=
 =?us-ascii?Q?PbtEMWyZ///0l5Sd3AMub3wpKq8MknRiwcc9v1efgLPO612L9j8qwonTruCv?=
 =?us-ascii?Q?aBkJdG+fZBo4E3xLTLbACtdPWlHfQaU2wwkZQqnx6jiPwHJ3eeilxhJEWgBp?=
 =?us-ascii?Q?qt2J8LOIQ0MkuVDqRw9bPhFcPnJGkfYtR5xlm5Tg0SEtNTvJtJsEcNYy0+l+?=
 =?us-ascii?Q?Fa9NiUrpZYKaqRaPE+cvqnXO8RfnDqmY218UgxgAXqkJvbX3RJKt0tVaqGiQ?=
 =?us-ascii?Q?eG+hgPnehh5SC2wSyu53OSfzw4piJofeaQYWORe2pLwd+RhwD2eWmZ0TtYnE?=
 =?us-ascii?Q?nTrA3qvs0mrl5RuBBHYS233Nhe1mi54u6kOjaQGqGw+2A7nVprUT5ZTIljj9?=
 =?us-ascii?Q?LpbGvvKvMiVKoPrRTHHhxT86VKFxQaIzeIelPBrwRVnZh2HQ4RjVGZ3LBRpK?=
 =?us-ascii?Q?1MJGiywAQNliQOsKGByedKS9HEMNIL5aSAedjCmHIkDVwcRmVdlsx4oXbpTz?=
 =?us-ascii?Q?/+DDysaIOmwLoN/oYxB4IUeIlsEzOgdsnMNKi4gttAzKkTEXRJQ2IjMFyLQS?=
 =?us-ascii?Q?PiCWBcWrhyAIIMhK1RYdQDbqWkDGx35ZE3lYJ2D2Ff5NwCANDgLTIZWBE4wf?=
 =?us-ascii?Q?NOLrnvUHr9Nr196Oi031sANGbUQGEnvSsgs8rTaNUwOLaPjd3gtLqi8DLTXu?=
 =?us-ascii?Q?ZUVRzDNETFBtc7jzPi05kmkGWTJwX04cdNzcNH+X+r8qclyajoaLoQ0UnymD?=
 =?us-ascii?Q?blvTxLr/zDwA+TVddrIbWyYFfWtc+ObZdpcFJ?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: blS9xTLjBlOFikwCN5tLiwBzwQA4KcXI5c3ThnS3W2I03JyLDEy9eAyDevTG/qrxCMCKt/s8x9o24EP1Ht/YHYi9es2FDG0nOqNODz48f1nVrweqmHYvca1/fijXEhm5riwVT2vLX8NRa/q8HSivKV3bnYTxKfnvk1xTyYnYHrNM8+wlsKsOhGDHBIxiI90TLbh9pqapoXuJTN6D62ncjENjUpI5czJVy8Z8vn9ItrHYkUX5YuB8DIXWtfZPolEBU9pu7UX/PlAphCTLKECjRd7SjnpYUuiwkUh3n5T2wk9HeHsafdeTlzhuDRVUB+R8
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:CUe9FRcHeMcDH2Jw657QOooIFyAIWj7Sfzg8UcvlA1AZJjGkbvV2KYUot76Mi5SwPwYvLHvLwej+demOnpGyUK1v1xYibSJKljsKWCI8Gi4hbUAScHHZaDu/rytWk5bKjm1bVOqTFFBmT4OnLkv5Q3HYvz5RI4BVStik9fEE75ydk9pP5adCQFyOb/DU/+1iLTZaaBsSN3AZjPVvUSAX1Vvx3hH4R8Z+/n2Tte2zCPNR+BrHtX25EfOYyXDC7ZZwGb2Y1l8DrNlt6F7LeKAXriheW8Un7+pw8xey5qd1BztCKt5saJZl9SMq+TjsKDvkzYeFH9IE9f5JNaZYx00rfU9kX175NXkioVjjV0pyjphNaWxp8FmcmUO130fUtydO6/LII2S2ChxMJ0rin5LuIDueM7HESezZTHAZ5CPY+l4U6l72LRm8uihVivx3hK1Yebmq5Y30fAitJUdeg/CKww==;5:aYvNe/hEriOu+f5kLlDBWdMsRY4iOTyXZ/zdX1hogCbxbuk/HkiqHgvcXzWeay3F8pCUrr9qH7k7rejeAfs2Gaf00hWXoPOx1J9cO8HI8H1mfey026RHLSaprkRqKP3L4mJOXNyBbx2s537H5Zs4qFe76ATl89CgqYRcIbb/BDrF2rHNrKxBIdjKVt0lwjwrhQmbzlBO3Mu0kQTFZC7pOg==;7:f5AqDaHGJjDiiwGphgAkKMKzoCXGFZ14FQcAW2+VwHzYVnD1v6j7FK0zFQx6DfmDnzFJgMoxbdFLRy3QMVGug8QxkrMD4CUYWZGmqOIIesb5hTjpy2L/zp5Mv6awxFXFdKopW0Uc/z32MA/3yCi5Sg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2019 09:03:10.4515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da13bfbb-c1bb-4965-ce74-08d6747ef38c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SHA3 driver suuport for the Xilinx
ZynqMP SoC.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 drivers/crypto/Kconfig      |   10 ++
 drivers/crypto/Makefile     |    1 +
 drivers/crypto/zynqmp-sha.c |  303 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+), 0 deletions(-)
 create mode 100755 drivers/crypto/zynqmp-sha.c

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
new file mode 100755
index 0000000..016f826
--- /dev/null
+++ b/drivers/crypto/zynqmp-sha.c
@@ -0,0 +1,303 @@
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
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
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
+	memcpy(req->result, kbuf, 48);
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
+	if (err < 0)
+		dev_err(dev, "no usable DMA configuration");
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

