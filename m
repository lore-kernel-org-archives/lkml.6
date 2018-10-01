Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F98EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4506208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="FXCd5Bct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4506208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbeJAU6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:58:11 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:42264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729272AbeJAU6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCe8FG4/Mz4NvX5trCge4u7yH0hCkDIqhLumUMeuZYs=;
 b=FXCd5Bct/5D51uivs8LossmEx6W9l1mA9Scc6Ovqc6BVBsPIzEbMhGNIKa2pXalmLyROQ/Ed2UAxoQAULzy5p+S/jnImjfYRnoMb+3315wchYEemUuYeqDMNVUKAzatcHal+7Iujh6DJZ2C7kyzytsTNeAXNHmr08f+wIVzrRXA=
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4659.eurprd04.prod.outlook.com (2603:10a6:208:75::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 14:20:00 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/3] pwm: imx: Use bitops and bitfield macros to define register values
Date:   Mon,  1 Oct 2018 16:19:47 +0200
Message-Id: <1538403588-68850-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:803:50::19) To AM0PR04MB4659.eurprd04.prod.outlook.com
 (2603:10a6:208:75::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87be7f75-4dde-40df-79b4-08d627a8f8e4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4659;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;3:SdhUADnb51ebN5HKfszolJcqSaRsDJK8irdr+uJUsr1Xp/Acx5hpvWKSn84kuMXO3SfR9Ut0AhwTZpFT0FliGZmzNLKbfxRlhmZ8m/Ci/FKj9nKhh7+kE/IaPiA1EY8DJ7M6UFIwB/Y33Jx3taVXoYOPMTxpu+GM+nVJhbf7kfFHvjGblqQTP5YPrr/3VBm1TacoL8NeKB9T6JOVR75VMl7JxGnzxgN193jZ4LcTg9XZnoCUymRUpCNDome+/MNO;25:CkL2/SeUwSn6ESox4NiXwN0Ab0hOVH/4QfX276WzxrZyUV6oxfQyjKRvgEGSuW8HWbIDOgXBwcZvrBUja65Q+6pwsjpxdrlcKFlCqiZ5gB28NiYExVPtCI7CYCPPeHu2L8T1APpllvJsYLZ7uwDjxQuvR6+B8rGszhwQY4bVW1dCBOhDMe9boLiGGWYN8SKrRt6krkGw/SJhVMqv+kLs22hBBfPysWYXZf5hf9qlrl9YUu/8K1a5473hosvVT5wEMyJ4HowhFwozz4BbyFt/HfAMSkw3oDzH6kRfEYe9Do5wx9kohNa/+kwF4E/U4MUUpMyWOxpBew/19AygFbreAg==;31:ecKo36ZwBXqgBycuMZ9XONYAVuIAxrXQ6ao73BHFASuYAEUueBp37aFLGs1Nx+dd2KpJi4oELzBDfnvYSOSNwp32n5GMfZhD4DI3uAaHTIJ37Dflp2dh4TJxh2A4kiDQp06CufH8SaxdXj+udJvgeLJ42BddCHjJSl/laBx6Vb5T6cxpSwJxCEtiRdTT7iGIHQw5VZ0/9iZoYx3n4S3bFwS7jqS5l7UU1bE61rgIFDc=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4659:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;20:LoAXQWvdkxmjvKgRjq7O5QZZgarFOkvEbXNXyISeS4ENiuHsU164w1elm+gJX7h0yz0x/bK5DmR16sKMgZ4CQCP4BrXCZJuS2emfx9i2z/0fu+DbWYVYLtgv4E48awkcKw7PHTu2samNri1fSUuRbQ3qY2IoGUtz3dm1jfEDF+s2VYKP8puAFDCUxLDD/5LJEC+3kShdjeqxNVGq+fk16V43pNdr42CkWQpsh3o7aIHsfJApNGLiaNMFC7kpFLUa;4:nj/wr69/6fuyyqYOwNsjkVigF/+si8LxuiP1Bjq5Mln5/SISXxgULCC9KoqVz5Bc4n2Dt7e5pq83DOflU7Utv8FQxP7nhRc8Hhht+lIZi+Ma4f+tw3E6w5GP8BBRRAe/iTEEPZPL9dt2E7q8qvv39MxXeaMa/Ca6rBJ5GCy+ggWfXW8lomjeMcBgFbiAJHRbX8H+Lgy4TrxU8aCBgWu5xdw+X06xVLgjPKd2zGHGsMAoYBrCdF2ME96F2/DOqdB8RZP8vkIHY2FXXiARoxrLuA==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4659F0EF4DFA5F4E9F0A0C499EEF0@AM0PR04MB4659.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4659;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4659;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(376002)(346002)(199004)(189003)(6506007)(386003)(6512007)(316002)(36756003)(3846002)(6116002)(53936002)(34290500001)(23676004)(575784001)(86362001)(52116002)(6486002)(76176011)(11346002)(6916009)(476003)(2616005)(956004)(6666003)(50226002)(68736007)(2906002)(8936002)(5660300001)(446003)(81166006)(8676002)(81156014)(486006)(97736004)(105586002)(106356001)(478600001)(72206003)(25786009)(4326008)(39060400002)(186003)(16526019)(6346003)(26005)(7736002)(305945005)(2870700001)(107886003)(50466002)(47776003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4659;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU5OzIzOmZZV0RFOTRoVWRNdmRTcXlRZ2FKM1JvUUh2?=
 =?utf-8?B?bDcreVAzN3FsZ1FkWlJOR055K2dvaktEeEJyYWVycFRCV0xXNmFjM2xrMHBF?=
 =?utf-8?B?VnRoNmRGcW1yODlTLzRlUkRXWmIxOHpJWjFaQTZWa2ZNRGIwbHhONWdXcHRt?=
 =?utf-8?B?K21RMDZ6T2JmY1BZSnhYd0FyUE8zN2hoaXJ6UXIwSEFtTStpdEJhSUt5Q0d1?=
 =?utf-8?B?NW5SSnZ6Q2tjSGhwcm80R3hIb2x4QVMzNzB3cEZ6UFlKNVo4UkJYeENUV1hP?=
 =?utf-8?B?YmtVOFlzbUYweDZlY1hTVlFaT2g2Q2hQWHlRcFAzaVowRkNRa3NmcEZ1Z2ty?=
 =?utf-8?B?U2VuQzhLY01wcmxvZWE5eWVKZkZ4NVlQYjVweExybHVaci8yZ3ZuSCsxejlU?=
 =?utf-8?B?RGNFWnBGdU5ZVms5K0hnM3YzRW41bXorYlhuaVZTbFdkSmJpYzZSZFBjNmUz?=
 =?utf-8?B?UjlBZWxVT05tTWtob1psdHhOSmlxckh5elBacmRodVZ0UVlGanlEd3dWTW1t?=
 =?utf-8?B?WmpSSHB4Rk1zSnpWc1psT1F2WUlUSkN3ditjUlFoU1RiazZNQlljQVhKTW1W?=
 =?utf-8?B?eEVJTTFRYi9qdE5SdkhwVlh2OHBtdk4yWlczdjF2YkNiTWhQelljZ3YxRzd1?=
 =?utf-8?B?TmNSeXFjdytYL1ZyZXBqcEFIZGh4c05QbWVvYmlDaHVybXpQaG5lc2t1aGtk?=
 =?utf-8?B?SU1zQ0ZiY3F4UEgyK0tKZzBsaWdkUVpqQmE0K1pRc0F0alVSRzlsdW9QTWhy?=
 =?utf-8?B?Rkd4VFR4akxLQ3grb2Z0eTFJSmdwMGN2MHExY3BuZTRvZnlxaEtmV1UrOTg2?=
 =?utf-8?B?blFJcTFYWGNjc2RUTTZQQXBZMy92YzBpWktyL3M0bWZQRmRSSXB3Y2c1UTRU?=
 =?utf-8?B?b1g3aEZBaDlrMkpRSUhEcU5VanpwWDl5cmloQldobVB4MDBSc2YyMnJ4WEth?=
 =?utf-8?B?VVVsSzMzRWh5MnNvUTVjVkpSdmZTd1cxZEFYV2FQUDVGMWN2aHdnV3BSZEg2?=
 =?utf-8?B?akNDMTVlVzVzR3V0dloxbUlGUEV5ak9UQmp1NFE5UzNQZlRiTW9JcTNDWnpS?=
 =?utf-8?B?Q2JMSE5QT0s0L0NYeDA4cllzUmVaS0dtdmpvb3FncHRsZHJRMzJyR3h1V3VK?=
 =?utf-8?B?N1JMajNxWGlRR3c2MG5POXFYNUFpS1V4c0Rnb0tpRklhbndiOEpQRUQwK252?=
 =?utf-8?B?N1JCZlk3TlU5NnhDREZraHdJR01RZU9ob1lpTlNFb3hMbHJxbU1FeVc3dDdK?=
 =?utf-8?B?WG93S1dzSmhoQmZ3MytCM29qTUJJd1BGQXlyZ041YWZ6a3NjVDRMK0xESHRl?=
 =?utf-8?B?REJIMHlQY1U0blhvQ0NncmFXVkNnM0xRVXpic1YrODEwZHg0UHJaMmtlbWpm?=
 =?utf-8?B?Z3VHWGQ1aFBXN3AvSGlmRTgxRE8wUDF6RWNpS2Fnb2o4TXBYMkVrYURNWGov?=
 =?utf-8?B?ZUFJalI1V2FhdllPVkM0ZHNCUDk2NTRjd3YvR2NZK0diYVdFVlBZTjNEclZL?=
 =?utf-8?B?Wm1kdUxKZlVRNmZ0L2VtYVBjbjJaU3F5N25iQ1lYMnhLcStxdmhZdS9Ob0NJ?=
 =?utf-8?B?Y3dsaHRVOXpHdjQ5enFodUR6WmI4Y1JQWHlwaVJ6R0xwdEhndkwyUmQvbVJZ?=
 =?utf-8?B?RG5lck1DaDBzdG9rSGJiMlR5WGcvcWU1aGdZb09NamphZkIwZFMxcHdxYzBo?=
 =?utf-8?B?TFdrdjdCa2hkRTNoY3NLRjVtV2YyUEloK0ovbWNmOFVWZ3NhaXdvdHA1UE5O?=
 =?utf-8?B?c3Voc2RqMHkyS0t0WDRhUT09?=
X-Microsoft-Antispam-Message-Info: +bwC/NJ/WQUEAmW6s3alT7czpeCyOP0nbFYMm5KbVx0Yptg+ZwVjRlhcnN6h6NlJE0qY/aayMHpxpX57Cdsr3ua+P5eVNMllj1WbXJs1ZGeUoq58jlK9/619nWlb88W7w4bT9W/RqLvUcpOO9hL5i7gKUgsSPA3HTcOZR9FkTXmFGllz3/MBMmyliMGDUit4W97f/zSzzxJff/oK3LFEpd6lGyr721bXw9KSg2KD65iY9fNiFkf26zNAqnt696hmMB/D2ioy0k7Sull1CYSKTzb62qWFgAVYIZkp4xxf99+5CDuDP4k/nb3NdsApAtYrv+j2xkwxKKwZkHyg3Dsep4x8/v4yXauHhWep+tvXXJg=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;6:06CjYxb8GmARXJb0Zo6VrVyCo+n+gLKskuUnK0LjXbZOl3lq1vTWuVb8Tbd2eCbDJs72N8wHBnnMBYfIztuVzU6g5KY5YuCqT/sVOTXyWbPOEfMs/b8UI8CFJ7bb+tF5Bm5NrIbw0QWRIGLbGE19JX5RYNArn432rXZpquk9ich/S2GmjSJ3AfZ4FTC1yiRypU6j01imsyHhpH4FpWw7+xnlqd9o8DNy1lXkAuMqyQLsGuTxSuPoUPG7SaRwxSj+ZWQVR4TlwBrkJOR/nckRXGnnbD9m6EfLLxMmh+QWQOXQO5Gg3TgmzHNXSbX57Q7GLZniWtRfOFv5p2H5P+OBLdr/XSZwPy/RSzN5Q23CprOXjUZ9DSjHQ/NjCfzxvcxJ9hzCJ1X/2yoKyABJFNWGG7/2Jot/ooLKYepoSHRq3lYzcfGu9IQKjf/kVmLhZD6P4LpjDMsV0KdjCHZ/HKHiFQ==;5:UpOh/QKUceqngDocpHVtrQ/hzYTzkNthTUk+3WSuHcMMbla2m9MdtWxooCNb7WLi2nO8o1wF5TQCst0o+WgF2W2q7IT/h9jdHgetAvvX0ghuUbNA2b4KUEBa2L9pN9RHYmeItR1N5V/3Y7+4BERrkKoK7wnDk8k+2d5/SsToLJc=;7:lWj40ecI3MP8D3WGdN/jEZlfkJARunigUlPODBDTpJgsJIi6sFbs9fZriNCQ6UcRmW1ZN1wW7bVn1g8+YnwaWm7U5YBxwxoE0AxDGvE5EMUyjI23j278OEm7L4bGnLYhR4Kt/jPZomxgWbPyFi5NdhspPPsj+z1CP0EbK3GcPVvlQZanFWdKBIGzlwq2guu9T4IfH1DqL26q3CYyTiNp53ysHO32a5GH/xAz9w8O8q4JYfF7VNV38XsGsoHCYB3h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 14:20:00.0715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87be7f75-4dde-40df-79b4-08d627a8f8e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use existing macros to define register fields instead of manually shifting
the bit masks. Also define some more register bits.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/pwm/pwm-imx.c | 78 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index bcbcac4..7a4907b 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -5,6 +5,8 @@
  * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -23,7 +25,7 @@
 #define MX1_PWMS			0x04   /* PWM Sample Register */
 #define MX1_PWMP			0x08   /* PWM Period Register */
 
-#define MX1_PWMC_EN			(1 << 4)
+#define MX1_PWMC_EN			BIT(4)
 
 /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
 
@@ -31,18 +33,53 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
-#define MX3_PWMCR_PRESCALER(x)		((((x) - 1) & 0xFFF) << 4)
-#define MX3_PWMCR_STOPEN		(1 << 25)
-#define MX3_PWMCR_DOZEEN		(1 << 24)
-#define MX3_PWMCR_WAITEN		(1 << 23)
-#define MX3_PWMCR_DBGEN			(1 << 22)
-#define MX3_PWMCR_POUTC			(1 << 18)
-#define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
-#define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
-#define MX3_PWMCR_SWR			(1 << 3)
-#define MX3_PWMCR_EN			(1 << 0)
-#define MX3_PWMSR_FIFOAV_4WORDS		0x4
-#define MX3_PWMSR_FIFOAV_MASK		0x7
+
+#define MX3_PWMCR_FWM			GENMASK(27, 26)
+#define MX3_PWMCR_STOPEN		BIT(25)
+#define MX3_PWMCR_DOZEN			BIT(24)
+#define MX3_PWMCR_WAITEN		BIT(23)
+#define MX3_PWMCR_DBGEN			BIT(22)
+#define MX3_PWMCR_BCTR			BIT(21)
+#define MX3_PWMCR_HCTR			BIT(20)
+
+#define MX3_PWMCR_POUTC			GENMASK(19, 18)
+#define MX3_PWMCR_POUTC_NORMAL		0
+#define MX3_PWMCR_POUTC_INVERTED	1
+#define MX3_PWMCR_POUTC_OFF		2
+
+#define MX3_PWMCR_CLKSRC		GENMASK(17, 16)
+#define MX3_PWMCR_CLKSRC_OFF		0
+#define MX3_PWMCR_CLKSRC_IPG		1
+#define MX3_PWMCR_CLKSRC_IPG_HIGH	2
+#define MX3_PWMCR_CLKSRC_IPG_32K	3
+
+#define MX3_PWMCR_PRESCALER		GENMASK(15, 4)
+
+#define MX3_PWMCR_SWR			BIT(3)
+
+#define MX3_PWMCR_REPEAT		GENMASK(2, 1)
+#define MX3_PWMCR_REPEAT_1X		0
+#define MX3_PWMCR_REPEAT_2X		1
+#define MX3_PWMCR_REPEAT_4X		2
+#define MX3_PWMCR_REPEAT_8X		3
+
+#define MX3_PWMCR_EN			BIT(0)
+
+#define MX3_PWMSR_FWE			BIT(6)
+#define MX3_PWMSR_CMP			BIT(5)
+#define MX3_PWMSR_ROV			BIT(4)
+#define MX3_PWMSR_FE			BIT(3)
+
+#define MX3_PWMSR_FIFOAV		GENMASK(2, 0)
+#define MX3_PWMSR_FIFOAV_EMPTY		0
+#define MX3_PWMSR_FIFOAV_1WORD		1
+#define MX3_PWMSR_FIFOAV_2WORDS		2
+#define MX3_PWMSR_FIFOAV_3WORDS		3
+#define MX3_PWMSR_FIFOAV_4WORDS		4
+
+#define MX3_PWMCR_PRESCALER_SET(x)	FIELD_PREP(MX3_PWMCR_PRESCALER, (x) - 1)
+#define MX3_PWMCR_PRESCALER_GET(x)	(FIELD_GET(MX3_PWMCR_PRESCALER, \
+						   (x)) + 1)
 
 #define MX3_PWM_SWR_LOOP		5
 
@@ -142,14 +179,14 @@ static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
 	u32 sr;
 
 	sr = readl(imx->mmio_base + MX3_PWMSR);
-	fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
+	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
 		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
 					 NSEC_PER_MSEC);
 		msleep(period_ms);
 
 		sr = readl(imx->mmio_base + MX3_PWMSR);
-		if (fifoav == (sr & MX3_PWMSR_FIFOAV_MASK))
+		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr))
 			dev_warn(dev, "there is no free FIFO slot\n");
 	}
 }
@@ -207,13 +244,14 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
-		cr = MX3_PWMCR_PRESCALER(prescale) |
-		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-		     MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
-		     MX3_PWMCR_EN;
+		cr = MX3_PWMCR_PRESCALER_SET(prescale) |
+		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
+		     MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
 
 		if (state->polarity == PWM_POLARITY_INVERSED)
-			cr |= MX3_PWMCR_POUTC;
+			cr |= FIELD_PREP(MX3_PWMCR_POUTC,
+					MX3_PWMCR_POUTC_INVERTED);
 
 		writel(cr, imx->mmio_base + MX3_PWMCR);
 	} else if (cstate.enabled) {
-- 
2.1.4

