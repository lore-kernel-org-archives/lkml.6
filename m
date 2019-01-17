Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA0620855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ggdzGy0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfAQHC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:02:57 -0500
Received: from mail-eopbgr700084.outbound.protection.outlook.com ([40.107.70.84]:23296
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729608AbfAQHCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aev3OpyfSUsm7cLtAhvtGwjx5J8yuQwizR0wmLKwRVo=;
 b=ggdzGy0MWkXOjEWcJnGdevLMxWaUlW9mQyD0GQp2wKHJCr3s7TquLII69+BLEo03SZrtS7Otfp7x/f8b4FFQNIBaNksCdglRwFdO4sB/wX6JkCA5hWOu3xZpLLBlH96xbVYePJ00ELY1jWP6EZC5E/L8f6LGU8U0aKvFKwUhpzI=
Received: from SN6PR02CA0032.namprd02.prod.outlook.com (2603:10b6:805:a2::45)
 by SN6PR02MB4336.namprd02.prod.outlook.com (2603:10b6:805:a4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.18; Thu, 17 Jan
 2019 07:02:43 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by SN6PR02CA0032.outlook.office365.com
 (2603:10b6:805:a2::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.26 via Frontend
 Transport; Thu, 17 Jan 2019 07:02:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 17 Jan 2019 07:02:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hI-0005kB-KL; Wed, 16 Jan 2019 23:02:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hD-0007Rm-Fd; Wed, 16 Jan 2019 23:02:35 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0H72PFc022382;
        Wed, 16 Jan 2019 23:02:25 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1gk1h3-0007MP-6J; Wed, 16 Jan 2019 23:02:25 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 67E74800ED; Thu, 17 Jan 2019 12:32:24 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 4/5] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Date:   Thu, 17 Jan 2019 12:32:20 +0530
Message-ID: <1547708541-23730-5-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(2906002)(16586007)(356004)(6666004)(4326008)(44832011)(186003)(110136005)(54906003)(26005)(36386004)(106002)(426003)(63266004)(316002)(42186006)(305945005)(106466001)(478600001)(336012)(90966002)(14444005)(81166006)(81156014)(486006)(51416003)(8936002)(8676002)(107886003)(5660300001)(47776003)(50226002)(6266002)(76176011)(217873002)(11346002)(2201001)(48376002)(50466002)(36756003)(446003)(103686004)(52956003)(126002)(2616005)(476003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4336;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT007;1:IJbnXJO0OPqV8U1Xo6dlBW7bJrPiGUb42NFbWcywt1aTCx0vSQB4Fsx5xliSYIxxhBEJQ2NRCfWmFyB0/nCd08xV79vWb3etyYZ38n13WxygibwcCtRuK+NYV9Et/Pw9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f1e570f-fa92-4daa-4d16-08d67c49c5ec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;3:K14C/5P94gP5rtvPWPQCoADF0TusqizjhccdlVg1/7f1Ux5gvvL1OzUFwVdBJ7Anw0MbGFgx54vH3q77v+epFZHjkA0xuHDpPqmSh1cipWDh+EHHPPB3f71B1jZPZG1Y1k/U8aHo+82tnH3Vzg370Nvnx19i2J/r06UXh5YzX8fDGl3lCLSEjFU8pyLebpdNlBcutKMUAnQyX0//psqNMJWwjolatKyEtfVDDa0XwEITfR+Z2mu00hiUcYfKLfaChLVsBFpbFiR8Ob8swrmUxyT6YAqMcDX8OHPMIUPMWCDSYlsU/tVsII0Hl15z87PLogQmpYF17Zid3Cbc8rKeZSVYsBoiQy7nFIJHyqlQ8J2taazP7lIfeK6QNO8L4Zf4;25:LX9xoneArQ0FTEdiwDD0eOeNGYfAN5Ytv+9OqQtBNiUCjUE6Ynqa/rEvfceHZGMNaoin9Br/r7jjc5km0Qt2tC8F37Q2fJJY4PFcu+ii5n8eT+NQfJSe9Tfl/0SZNCeuKwWfuoNeqkGMDUEcTZhliFdcE1hNWZU8+Nw0JSNOJ2tetjePCGvEg+FklvJ0u15B21ptRaaWzXgvdJzm3p5s2tCGMY+Ic/aCqzWcg84oyvvWpnyTQOYP022gOQKWhy1TloItj0nyYFsJXA3pHMOHjylAJ9v3g49/oB4e80k5aH0MUI8ALq4s9MyXYLTHRZ2NTdCWltaOqI8Ng5JhGeWHtg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4336:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;31:b1gPx4SB4yVfTrmo5r+4Q1GjYzqDlBqSgrGd+R0c3Kp8TaIHlx2lSfuSlu0PGtGtwmjkAKKPuDUjNDiupPfW4ezx47rXj4rMLjyIeGb7RSYM2g3G8HSb8xEliZWO7/1tjPsAB3zUh3wL690JzukaVPJDEEUY/XotTxGTKmZCRqRovY+GGJjGY7DYoQQpDWnLa7wAEqwPh4eM+axojLFIJa7sw54kpvaT8aFsgkVnMT8=;20:48VPZdIM5opmBqWaoRct0MTwHDtuhzrrI2Iaz7XGryLvEtizgf9SLcTGnfthzzmiDRQUzc6Wq5OJmiVkeDZbKI4cdXS5HcnySAdY3NVORbo8RqyHl4W4EQgS2XHsEHLvViSYiT5n3B63fsTgCTmEqoOoaOPqDkrBmL29PQlDvPJoncYQov9Vsi93GJqHcPnnf0HGiXvbltMQT/dYBSNvRdTWdy9bgfpu5fG5pT5/vAl+Qi0t7XSwJ5iXgM8AVlcwV1hqT3YWvzrpY7vNu1i/Dy9RSc5wlm9i+IwV/sgM1400+qAPTdBbKfWvd644tJX7QbAIpcoj8iqGEzg/UtpyaCJId/4ewEGYNfYhK7XRBy/EVQw/SYvkWlQBlg6hT3v3gIAD7zrXXr1mpvvWKP+BzhDB6PGjjKjpZMfdfeFrVY5o6l4xwhTklJGFuDdN7zN9UxPoYY3qVtMPrvwO/P3MY/WnT09h/0lawaedPovBurQ1/ZDZdiNuzTuQ/VJwcMzJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4336C3E4833D1856E92B0094AF830@SN6PR02MB4336.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;4:jT+L+V5LAeJzfJBUoVO9KNRUmBHlPu9usgpK/AZjEcEffImaIQ+xfZVSpyaTPGpddPcKcYNsSN58goRyKl65NICVsosuzTYAA6+EmEiDwbbh1DwUqhr5yLLtNfeqtld6CyiXtsF0yaJ5tnklEXJLegLja6LPG/hnPWWCMK8ueahsOFh2tk3nAFrPCS/iKBaN2hwaaHrb2hlCX0q6nJo2bS0lzkVQdOmZ0gvok+Ek3rmi+8UMbi/RQuWAmDCvod8iie/fGv4pY5uUqhKkx0ayXrY8h2Ay9LTMExen7dblOHUVWdiUEny/bQyr54NjzLdd
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4336;23:IKBW54pdRttpU6dEzMVl/IEI1nijhyuDwr+d8j/ke?=
 =?us-ascii?Q?UFfJmEdIcsH48m41sBQPu8xZfnYvvVLpn75CIWTBPWqI1dEhHsYHbISfHX1G?=
 =?us-ascii?Q?g0z5foEKtEXcizGu9jqs70X1u4u6ZId7kg/I3tvgQfYB/dQNXJuIw109NXGq?=
 =?us-ascii?Q?3jb/MoxzS4qIrqj2cH0CO2HxH2Nzd/ugOBRiOdRv57EwHpLObnIrkkoQpvRM?=
 =?us-ascii?Q?A/DeDmF2qt7drxfLyKBGtw3OcKrC38cHPQjs8+058qrkHcovPwObzu4xo+4i?=
 =?us-ascii?Q?p02RvqA3ehUaQI95JUD1gBMdZWfQVZ4+1ED03Xz+ybFL43FJ8U7gkCX/IYcQ?=
 =?us-ascii?Q?vL1hVnQNQtwdZy6mdhd1+051LWra1gKA7/GHGNZw+JxiovssDKSAIWNzD1MG?=
 =?us-ascii?Q?SUnEc5E0aojrGW/oHgndX9sO0CrFZ2Vlw68tprlPRzsAwqoDaaB+S4eIOxnB?=
 =?us-ascii?Q?mO5vAl601P/09AskQK7Y3eTUU59JgWXg4VICZ4z+soQF1QTxBWXVABpo7zdN?=
 =?us-ascii?Q?DIgfM+PPm48i8zzIlLGwjrNJpSxFT14nFbO2IDGallhc8quhyDcqx1HoslkS?=
 =?us-ascii?Q?nauFbDCHuVQQwxevYW3APw/vrsZfT3matulJvz4ZYNqjarTprJiK74RCxH7F?=
 =?us-ascii?Q?IW8WdWHnyWIwMXoAEaVnrj6fcPUSpkxktlTb2tGkKHu3NXkLFkAurObk6RRR?=
 =?us-ascii?Q?vb3HNNLgBi1YEprZH5P3RGp+ApzlxENlRXfB1kSskF1rkABC7mxBT5ha4sHO?=
 =?us-ascii?Q?veB2KGjdssZQKszQrHAxKZmM8dKUbs2GM1TIxOFaBZrn5m6LFwA9trgcEWwG?=
 =?us-ascii?Q?LV6F66xpmxJaPpjEZV+e9rbMJ4uTskEhx0lBAcoPd1L+YoyfpZQPGJev9yVh?=
 =?us-ascii?Q?NqQ16d/0ncm3dzUqPtI5Yqu3Z2miSVLw04NgsmnVNxyO8bS6mywZSbVVPiM1?=
 =?us-ascii?Q?3JDHI3i11i0klMhVt/9gfFO84kMu4+f33Rq/g7Xf9INBbn/jFaeZa59O634k?=
 =?us-ascii?Q?oipcw/XNrwrqQKQxCDLkd/fdfisBjeF53g0POHAtOF7QA8wa2DpIKMsjdr6d?=
 =?us-ascii?Q?TdkOK7pvjZNGlzXnExAsxKtHNgvH2af6XX2urCDxUd908zrj4sFinRenXINs?=
 =?us-ascii?Q?WDsbZ22Nuj81cM+baZ/kfADYQwxnqHU29/ILCpXpHmD1qLcx7PyZezvKhp9J?=
 =?us-ascii?Q?POYManjwTxNtLoqez9lzLrCNMuas5VQb0wO?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RXeewfogAnlm/3Vj2pn/xWbFd0FFTd5HvPqGhVBA/LUymmnMFJS9h0+eN4rw5oAPmkHjE0+7d5zig2MdmmEz96fa8+zHSEjhJJp4l7nDxbfvTYIMY5HD/3HOFQO0c7RcMJZpaGesximAj4OAwIp3YENVG8aPnUFfUvSbOJqz5xk4d9bRqycH6e6319YaGiCwIhjQWEwRpWF/7ZOMWoW+9yLtyyQgwOZwialOUlXsrVX+xRjMCIsNGLZkcqP0xsqRJ/UC+hqiFV/x/l/2dJ/ce4QckElAGXthjCUUleCN1AWzDipaUvrBfb03UgPOYx6c3IkpBPRuHAxxL1NJ9inORoOswMqBimmJySUYHVMyOt/G8eqd/5dexS9cDkRU0YsMufYV16u6y5hjHVLf5COHxoKRz57AfVj4TaAptpmh3yw=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;6:/spLuqRiDbxqRkb0PiywxLidk7+ceh2Q+LGEln1bzALkFQIQIxKgFqkjuJSpTVgbU4lxuEh/zUxDMm+Th4KKtCywVoF4HLARsFTWwH3yaInBgoBugHq7Q6HbXqzskc3a+F12VF4x+2EZBhWjvuyvU97n9jaoxlO9GuqsrW6HBQqvEXcCGQni/7iY9q80A5sdcpVDRWwvNHDlhnDLbjq3uOVVTSdXOd37sFc3sd5ppS1oMmEerPgN7eedMcnMS3OgqdkMRGbX9oBLuSApaeJRBSSq7RFgPR8AaJEf1DX8fASQ8nFt+yMR1wVoYatpDfMgVN6IiriQ35yk2YdlksqYEQHLzeXn9irImBQEpXLmY9lL3+aDxxuIWULfMZyRmG1iHUCbiF2T3PslMNP1eOmk2HmdkW53eXevTBbawhl/+mlPecDTld9h5Qq16W4dBuB1pXxYh68H7a6zMN4dKg34Ag==;5:SM6GuE1ZIjQKRBc9jsRfnWdiQrGJxX+Ub5WWbU6hkRP7vRMv8KWN5tw954h3AXuLrIJdyWdVwikM+d1HBZZ7eWCb1Ve9Z6ZPPzWI+CpsfMVFNPYj2ESrAGCZxUkP0XLge2S1XxITp07IfpxUUABBalSi1Tv5i/s9smaA5Gl1Tiy1S/xpKVXq0msGujwE3bH8Mi1zNyzwcz4c5wa2GSQKgw==;7:NQ2V43fj8Nc6o/1ov78c5Kio7gkySJRwAt1syBZPnFgZooixHEV1A3vdFaVvstqEjMkAMieMQhbteY+Di7hTDzqLuQZlanr0ScI1jPfk1iItWY28af1jkaSSJW4y5Hxg0/7ZvgBPtc5NNvSzgdHeCw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2019 07:02:41.0495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1e570f-fa92-4daa-4d16-08d67c49c5ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALG_SET_KEY_TYPE requires caller to pass the key_type to be used
for AES encryption/decryption.

Sometimes the cipher key will be stored in the
device's hardware. So, there is a need to specify
the information about the key to use for AES operations.

In Xilinx ZynqMP SoC, below key types are available

1. Device key, which is flashed in the HW.

2. PUF KEK, which can be regenerated using the
   helper data programmed in the HW.

3. User supplied key.

So to choose the AES key to be used, this patch adds key-type attribute.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 crypto/af_alg.c             |  7 +++++++
 crypto/algif_skcipher.c     |  7 +++++++
 crypto/blkcipher.c          |  9 +++++++++
 crypto/skcipher.c           | 18 ++++++++++++++++++
 include/crypto/if_alg.h     |  2 ++
 include/crypto/skcipher.h   | 10 ++++++++++
 include/linux/crypto.h      | 12 ++++++++++++
 include/uapi/linux/if_alg.h |  1 +
 8 files changed, 66 insertions(+)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 17eb09d..c3c0660 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -261,6 +261,13 @@ static int alg_setsockopt(struct socket *sock, int level, int optname,
 		if (!type->setauthsize)
 			goto unlock;
 		err = type->setauthsize(ask->private, optlen);
+		break;
+	case ALG_SET_KEY_TYPE:
+		if (sock->state == SS_CONNECTED)
+			goto unlock;
+		if (!type->setkeytype)
+			goto unlock;
+		err = type->setkeytype(ask->private, optval, optlen);
 	}
 
 unlock:
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index cfdaab2..9911a56 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -320,6 +320,12 @@ static int skcipher_setkey(void *private, const u8 *key, unsigned int keylen)
 	return crypto_skcipher_setkey(private, key, keylen);
 }
 
+static int skcipher_setkeytype(void *private, const u8 *key,
+			       unsigned int keylen)
+{
+	return crypto_skcipher_setkeytype(private, key, keylen);
+}
+
 static void skcipher_sock_destruct(struct sock *sk)
 {
 	struct alg_sock *ask = alg_sk(sk);
@@ -384,6 +390,7 @@ static int skcipher_accept_parent(void *private, struct sock *sk)
 	.bind		=	skcipher_bind,
 	.release	=	skcipher_release,
 	.setkey		=	skcipher_setkey,
+	.setkeytype	=	skcipher_setkeytype,
 	.accept		=	skcipher_accept_parent,
 	.accept_nokey	=	skcipher_accept_parent_nokey,
 	.ops		=	&algif_skcipher_ops,
diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
index c5398bd..8922f58 100644
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -408,6 +408,14 @@ static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
 	return cipher->setkey(tfm, key, keylen);
 }
 
+static int setkeytype(struct crypto_tfm *tfm, const u8 *key,
+		      unsigned int keylen)
+{
+	struct blkcipher_alg *cipher = &tfm->__crt_alg->cra_blkcipher;
+
+	return cipher->setkeytype(tfm, key, keylen);
+}
+
 static int async_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 			unsigned int keylen)
 {
@@ -478,6 +486,7 @@ static int crypto_init_blkcipher_ops_sync(struct crypto_tfm *tfm)
 	unsigned long addr;
 
 	crt->setkey = setkey;
+	crt->setkeytype = setkeytype;
 	crt->encrypt = alg->encrypt;
 	crt->decrypt = alg->decrypt;
 
diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 2a96929..6a2a0dd 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -605,6 +605,23 @@ static int skcipher_setkey_blkcipher(struct crypto_skcipher *tfm,
 	return 0;
 }
 
+static int skcipher_setkeytype_blkcipher(struct crypto_skcipher *tfm,
+					 const u8 *key, unsigned int keylen)
+{
+	struct crypto_blkcipher **ctx = crypto_skcipher_ctx(tfm);
+	struct crypto_blkcipher *blkcipher = *ctx;
+	int err;
+
+	crypto_blkcipher_clear_flags(blkcipher, ~0);
+	crypto_blkcipher_set_flags(blkcipher, crypto_skcipher_get_flags(tfm) &
+			CRYPTO_TFM_REQ_MASK);
+	err = crypto_blkcipher_setkeytype(blkcipher, key, keylen);
+	crypto_skcipher_set_flags(tfm, crypto_blkcipher_get_flags(blkcipher) &
+			CRYPTO_TFM_RES_MASK);
+
+	return err;
+}
+
 static int skcipher_crypt_blkcipher(struct skcipher_request *req,
 				    int (*crypt)(struct blkcipher_desc *,
 						 struct scatterlist *,
@@ -671,6 +688,7 @@ static int crypto_init_skcipher_ops_blkcipher(struct crypto_tfm *tfm)
 	tfm->exit = crypto_exit_skcipher_ops_blkcipher;
 
 	skcipher->setkey = skcipher_setkey_blkcipher;
+	skcipher->setkeytype = skcipher_setkeytype_blkcipher;
 	skcipher->encrypt = skcipher_encrypt_blkcipher;
 	skcipher->decrypt = skcipher_decrypt_blkcipher;
 
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 482461d..202298e 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -51,6 +51,8 @@ struct af_alg_type {
 	void *(*bind)(const char *name, u32 type, u32 mask);
 	void (*release)(void *private);
 	int (*setkey)(void *private, const u8 *key, unsigned int keylen);
+	int (*setkeytype)(void *private, const u8 *keytype,
+			  unsigned int keylen);
 	int (*accept)(void *private, struct sock *sk);
 	int (*accept_nokey)(void *private, struct sock *sk);
 	int (*setauthsize)(void *private, unsigned int authsize);
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index e555294..a6e1eda 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -42,6 +42,8 @@ struct skcipher_request {
 struct crypto_skcipher {
 	int (*setkey)(struct crypto_skcipher *tfm, const u8 *key,
 	              unsigned int keylen);
+	int (*setkeytype)(struct crypto_skcipher *tfm, const u8 *key,
+			  unsigned int keylen);
 	int (*encrypt)(struct skcipher_request *req);
 	int (*decrypt)(struct skcipher_request *req);
 
@@ -116,6 +118,8 @@ struct crypto_sync_skcipher {
 struct skcipher_alg {
 	int (*setkey)(struct crypto_skcipher *tfm, const u8 *key,
 	              unsigned int keylen);
+	int (*setkeytype)(struct crypto_skcipher *tfm, const u8 *key,
+			  unsigned int keylen);
 	int (*encrypt)(struct skcipher_request *req);
 	int (*decrypt)(struct skcipher_request *req);
 	int (*init)(struct crypto_skcipher *tfm);
@@ -444,6 +448,12 @@ static inline int crypto_sync_skcipher_setkey(struct crypto_sync_skcipher *tfm,
 	return crypto_skcipher_setkey(&tfm->base, key, keylen);
 }
 
+static inline int crypto_skcipher_setkeytype(struct crypto_skcipher *tfm,
+					     const u8 *key, unsigned int keylen)
+{
+	return tfm->setkeytype(tfm, key, keylen);
+}
+
 static inline unsigned int crypto_skcipher_default_keysize(
 	struct crypto_skcipher *tfm)
 {
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 902ec17..a47c9a8 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -268,6 +268,8 @@ struct ablkcipher_alg {
 struct blkcipher_alg {
 	int (*setkey)(struct crypto_tfm *tfm, const u8 *key,
 	              unsigned int keylen);
+	int (*setkeytype)(struct crypto_tfm *tfm, const u8 *keytype,
+			  unsigned int keylen);
 	int (*encrypt)(struct blkcipher_desc *desc,
 		       struct scatterlist *dst, struct scatterlist *src,
 		       unsigned int nbytes);
@@ -734,6 +736,8 @@ struct blkcipher_tfm {
 	void *iv;
 	int (*setkey)(struct crypto_tfm *tfm, const u8 *key,
 		      unsigned int keylen);
+	int (*setkeytype)(struct crypto_tfm *tfm, const u8 *key,
+			  unsigned int keylen);
 	int (*encrypt)(struct blkcipher_desc *desc, struct scatterlist *dst,
 		       struct scatterlist *src, unsigned int nbytes);
 	int (*decrypt)(struct blkcipher_desc *desc, struct scatterlist *dst,
@@ -1466,6 +1470,14 @@ static inline int crypto_blkcipher_setkey(struct crypto_blkcipher *tfm,
 						 key, keylen);
 }
 
+static inline int crypto_blkcipher_setkeytype(struct crypto_blkcipher *tfm,
+					      const u8 *key,
+					      unsigned int keylen)
+{
+	return crypto_blkcipher_crt(tfm)->setkeytype(crypto_blkcipher_tfm(tfm),
+						     key, keylen);
+}
+
 /**
  * crypto_blkcipher_encrypt() - encrypt plaintext
  * @desc: reference to the block cipher handle with meta data
diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
index bc2bcde..aa31b18 100644
--- a/include/uapi/linux/if_alg.h
+++ b/include/uapi/linux/if_alg.h
@@ -35,6 +35,7 @@ struct af_alg_iv {
 #define ALG_SET_OP			3
 #define ALG_SET_AEAD_ASSOCLEN		4
 #define ALG_SET_AEAD_AUTHSIZE		5
+#define ALG_SET_KEY_TYPE		6
 
 /* Operations */
 #define ALG_OP_DECRYPT			0
-- 
1.9.5

