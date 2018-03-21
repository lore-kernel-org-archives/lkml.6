Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCUDVA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:21:00 -0400
Received: from mail-db5eur01on0082.outbound.protection.outlook.com ([104.47.2.82]:13505
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752015AbeCUDUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:20:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        sboyd@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V2 4/4] video: simplefb: switch to use clk_bulk API to simplify clock operations
Date: Wed, 21 Mar 2018 11:19:51 +0800
Message-Id: <1521602391-30356-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KL1PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:802::12) To DBXPR04MB320.eurprd04.prod.outlook.com
 (2a01:111:e400:9425::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d6062fe-b9a9-4d12-dc73-08d58edabc6c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DBXPR04MB320;
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;3:XZE2qEFCQFPuLZKjRWSeRZRM+qFQFHwj+8KRYr11z+83m2fSun6pVLmmcKW31bbOxt6nyOU9cdwHZiWqYyDs8WsvTygcVgl5X1sbX0b5Wg0IQBURwr6P0ivAHv5A1RSER3lhFyQkvvwFQiclRmM0l/ET6vk9zD6Sez6edXizBX2pI2hMfdnuvYOzQQUjWM1u7IPdmEDB2tW//d8M3Ql4GPETcGgn1+PrHJ3SxslUjWJCrNiL96YK8jMrWkbQPVtD;25:4mRZP7BPjfy4X87hxhRYuURoQjt6gtKpjpupU7iiaj4Z8DjKZ0wn6CNcGvQACcnR12+fD2II8rSeTFTq1LCXPw+mPjXeww6QJLDDYRty8RxW+fgSFvL5wZJDH9S3n3UXViv2k5B3+5kHPhE7UE3G2S9oXiHOfsJuZd64xkFHd+rW6hNmS9q1bk/f1HkHDJvbHa4z6NsbLerILNTmqxpQBKwoqkW3BB9R4oJp4D+sc7dQQOmxn5j7T5SfIhQnzy007rtKurFfe44T8uxJDSV3UXXMj0s6w+qsGe0pLEqanH1V+v2Wzzw8Nt4OvAYSut8N5hmhLsW0R26NaUpZD4eYjw==;31:v/5efrhrvSsIHck9+gBIUPWShu21cb3hag6CbWSYVzR9jpTzTBaRoVhhA1duk5H3AC1YVltvombjF3ASLJkhHhjIzxpsQo8f4APaKsjRF/JrL67dDsTwl58xxEvWFypAF5Kr+PTDHxBxexrHPGXODPYM3cUlpQN/6LjJMXzf8JbhIx4ZBEAcCfzcmV1pBEHlR+WzxKH4AgO571Y4J5/23vQYPMNnFnkd0nLfHhHWZcA=
X-MS-TrafficTypeDiagnostic: DBXPR04MB320:
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;20:f6DhjFP1938Gs1mYb/ePZ3r/H0Vmdu4i77eEEVFLb6r7DZgTxNLi8e27uAAYxnwgKKYJ59QJEsMNfnm/7YlCYbKt5d43gQGlVzZqTSZcZq0zsEAzXA3QPSpDe6638a0v37ZgLQgg5Z2mVbN2TR31Npty7tQDQ2ohn5MwXXgRPsxETvFfMbBNPaX+ITpfyBCxISx9GsuYNnrkSdQK0fXgpY9fthCHClojjZX2QtmBddyWdZEHbmcfZrALMoo+R3dYBHMYmXKxBm/vbm4sxCSOBufWNEeq7WUwDNkKZmquoTFWWxgeZi4s+NBCgu7j2RrTkel5Ez2Z+gu5UueLh/ROzUadSts+Kd+SgHhYlHQZ8OMW7o5WOBTPyYMNtWSORc7PgOK9j2saBq3PYYZxJIxI2NFc6vo6Lsuf+pionvo9MnE5fL8wqjn3KQvdHMD4aNA0s8k3ez4h4RdWIBqe4kciXu3Rdq1LZmkIRQY7YCpwiGzweps/rAybrsbdQ2naeOml;4:vvU12EwbOsmmtmCgTtwkbHT73Ags7b7u3j8REukJeHX/2toRgQdlZDY/TjGi7EehbGIqK8XTMqIon9nmaWE6v4/NZcqvKdYY6UFMfMV7CuPQ+Y8Qx0KeJ4M1pj2v98D9tt5kfeXdocha4ng22oB+wQuN52jpIhkt4qU4qSUrvl7/GxQHCKtAITObV5eiH69zcuIuuQLpUcmLnRRH2aDV0fLsVFhkjDpdGVTMlxZjbXyQfvgxkR1uvU6i3fYyAau3EFUPYexsErscDj70HHw4DQyrUXqftkVpnyPIsgLDkB3qoLGNIpFghWzQrH9XfN28o6WfrcpvpBVg4/ekDA61k5J9s/OTcrIspQu1qk6RziyomhVYgO3Sm/U1egrkK3bi
X-Microsoft-Antispam-PRVS: <DBXPR04MB32055A6DE28E4DE5D22E61480AA0@DBXPR04MB320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(7411616537696);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501318)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DBXPR04MB320;BCL:0;PCL:0;RULEID:;SRVR:DBXPR04MB320;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(346002)(376002)(39860400002)(199004)(189003)(6512007)(47776003)(53936002)(186003)(66066001)(50226002)(54906003)(105586002)(16526019)(478600001)(68736007)(25786009)(106356001)(4326008)(6666003)(2361001)(6916009)(16586007)(2906002)(97736004)(2351001)(316002)(6486002)(36756003)(8676002)(305945005)(2950100002)(386003)(6506007)(3846002)(7736002)(6116002)(5660300001)(7416002)(81156014)(50466002)(48376002)(81166006)(26005)(8936002)(51416003)(52116002)(76176011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR04MB320;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DBXPR04MB320;23:XPIRyyvmUmK1thtjts2UqXGI1E6XIGR4sfsZ8mMjQV?=
 =?us-ascii?Q?gtLNwDImo+BQ9yykEe5jZtieZN9ccAMHqzyjE83v0gNJ6PMRu7FnewJjI0Tq?=
 =?us-ascii?Q?VLxK57gjbv1fTvrFvAphWKVFbVUFfEkfTf4ipQhxd918qy29DYpunkR7INjJ?=
 =?us-ascii?Q?OHLoDgoyg4Bm8AJS1gt8fE/sc7EEqyEcY/8uDx8Z541qAYc46iUlYt86S6wP?=
 =?us-ascii?Q?5ffvva5q5mfFkUD0mhAhjNcp0PejTUop00EwWiOq8XbRyKm841LKo1IIcsT0?=
 =?us-ascii?Q?Ug4u0cCeZ9EVtRKb5VR46FRY5dcPU0o5HTGbgiwEv5hmkUpanQr36c0dfDW5?=
 =?us-ascii?Q?eDc3OZiTMKRfWVDykUDD+DZknX3GxIjZWn17lE13SHdgmclKfN3mZ/6Jmds5?=
 =?us-ascii?Q?IPh8J+BuIoc9hlwuSY4XcEuociWOSueJRNsM7JS8/eL4/ABcvghdo/APRd2X?=
 =?us-ascii?Q?gKN+nFfNGSnFJMgBzAVJQBNb57RHCouPBtX/890fjJX7Sqb4znOFw3VlnhGG?=
 =?us-ascii?Q?7xeY7tYJ2GPunGS9qfIHYoa4NwcbVxTiKVz0LLXcnvT/s31LdELm7mgLX9jw?=
 =?us-ascii?Q?Lao9FAQnZs+jWzIWUymyptltlHx7UnoFTutNBAv5k1lMuaHuIkIPLZMYl8Mc?=
 =?us-ascii?Q?2Ok/k8i92bkNM5HC8rwRBurhzCysv4CJz0VuDxkLUdgVHeYj2yw1IerRJGVN?=
 =?us-ascii?Q?+2usO83QsziQ7rSBYhJaOZbCAkX7vTvpOQPFZ8SPldYtuLAbqTMcDusrUT1C?=
 =?us-ascii?Q?bHdSCZ2MqLPMnp1FDHZhhQvZcstvj9ejTw2lo0hPak5DrIy+la7m5YbC8HWL?=
 =?us-ascii?Q?EKtZG5DjOEOyVddXH+3KI1KHeaJ3B07HerlzQCe0yoez5+iJOGayKPCM+9IW?=
 =?us-ascii?Q?J5PppODpuy6sEP0UdJzKNV692sRlLizNIfIw4RbZMzR3zAIBMWwdyzIpscNa?=
 =?us-ascii?Q?4Oz/3aEm2xsZbjBZIypodaM5CNvjp+Zx0mdmE9yGllyYT2HOV5JBNFHLwpUx?=
 =?us-ascii?Q?BTV9h1QC8/ozaRtxj0Wbq1acESHt7GGbVNm1tujaqPtfQ6WItnXVICHC2MHP?=
 =?us-ascii?Q?Nx4R4UdS64B3h1oOUeehXLP4GR1y/1C+DyMnlKVG7u90F06axvCEfuIe2GrV?=
 =?us-ascii?Q?M6rneuXPXZBMuQM+fw4kSpaDMSQp6piQcudgtgRi/xqYdoFDhWV1VH+2J7Hc?=
 =?us-ascii?Q?GFKXuZADBDBS4=3D?=
X-Microsoft-Antispam-Message-Info: Myh3WQ4B9I1UqrFCPPCkt+6AUNn/TEAc7MiODBoQFbv9Eu+GYrubg8c89mexwU/UK+hRWM8lkY3YTwkEOuimQWlIT3aOR5S58YKqCIefrX0L4xDvdzEgi7tvePVqRKgFQwN3ByoPNnD+NoDZElh2XaXSnvBMeUIBMCVIpmeAv+yjAxFz8DvIlAVZ5rZExlh6
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;6:VCxQF5GTy9+aCr+o6cfMuceSmIkRrgJMBwhvnCQZjbvC+hanLOY2wToaCUl7mB2ldsN2Sp77aewACYu3GB/WqNiImjEd4o2yuZqB9GMVmI3aD82DERLccR+Gx+YDlA5UH2YfV9yUdvhwVQAeCA/Lz6WLzkLqJtOicYIsGa6WaB9Fo0nOsTK//+pEoC74Wo1eDhkT5Q15mYXXs5rtT2Rz1rXsAdFd7LHfqToy9NBqTWOICqCGHvtC3rDtR+xr5wO13TIM2VRKeSDbslXGfA+ivQMJUt63rtSA5EgcjRcdgTNgXcsade9b6tB21h4GLAc0d9ZSckvSoX/HltZzOtdvKgRXPpQYcjzwNUSWzx78MdI=;5:2rIoS5wJFXxBVpBmUZ69x6ToGjD0m8OXQPCYvkwHdRbWSH+KJbfnqu+RbZZ/vv40JW0EjPpjwam4I280frxL5b8HTJIwNPg6SQcjHcYgwZ2+/LwmALWyTAM/I03mINfFasutlzF21pUDzBd6FAJG4aqtW3H9l/IMk5IfDEIH/78=;24:5kWkHrFrVvCA401JgH+oeyo8aQbuKI3uw2q+i/0Fq5u9rWemGK0CWQdzrqMsH47Glh8wIEQAv6PZMgObL03MjrtQjjUIPADHL7Jth68Fe0s=;7:BT4OxcyyeA9Es1XhnmlVuw9gqSrb1rndRIABgMazX04T1Kzz6Tgiu9/PvqUIBHvVv3lb400Eh0LoLjQRr3Iw3OgK/2yJLXjNUh8N5s3u4BapG1GGuVtmpJ8ptrC0sTfFEmT8p/MXo4Ibg7s+CFB5JBajGObltymqwK5ZwDmh7Y3HXFAbnxlKPEPoLbfYLR1nCHIKgQVj2EkMzXPZ4bqDPCB2qYXf/GpYtqHrAqYk89ANIF1ALeuVyVMONykP0B52
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 03:20:41.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6062fe-b9a9-4d12-dc73-08d58edabc6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR04MB320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to use clk_bulk API to simplify clock operations.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * switch to clk_bulk_get_all from of_clk_bulk_get_all
---
 drivers/video/fbdev/simplefb.c | 69 ++++++++----------------------------------
 1 file changed, 13 insertions(+), 56 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ec..3c8124e 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -182,7 +182,7 @@ struct simplefb_par {
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
 	bool clks_enabled;
 	unsigned int clk_count;
-	struct clk **clks;
+	struct clk_bulk_data *clks;
 #endif
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
 	bool regulators_enabled;
@@ -214,37 +214,13 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 			       struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct clk *clock;
-	int i;
 
 	if (dev_get_platdata(&pdev->dev) || !np)
 		return 0;
 
-	par->clk_count = of_clk_get_parent_count(np);
-	if (!par->clk_count)
-		return 0;
-
-	par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
-	if (!par->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < par->clk_count; i++) {
-		clock = of_clk_get(np, i);
-		if (IS_ERR(clock)) {
-			if (PTR_ERR(clock) == -EPROBE_DEFER) {
-				while (--i >= 0) {
-					if (par->clks[i])
-						clk_put(par->clks[i]);
-				}
-				kfree(par->clks);
-				return -EPROBE_DEFER;
-			}
-			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
-				__func__, i, PTR_ERR(clock));
-			continue;
-		}
-		par->clks[i] = clock;
-	}
+	par->clk_count = clk_bulk_get_all(&pdev->dev, &par->clks);
+	if ((par->clk_count < 0) && (par->clk_count == -EPROBE_DEFER))
+		return -EPROBE_DEFER;
 
 	return 0;
 }
@@ -252,45 +228,26 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 static void simplefb_clocks_enable(struct simplefb_par *par,
 				   struct platform_device *pdev)
 {
-	int i, ret;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(par->clk_count, par->clks);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to enable clocks\n");
 
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			ret = clk_prepare_enable(par->clks[i]);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"%s: failed to enable clock %d: %d\n",
-					__func__, i, ret);
-				clk_put(par->clks[i]);
-				par->clks[i] = NULL;
-			}
-		}
-	}
 	par->clks_enabled = true;
 }
 
 static void simplefb_clocks_destroy(struct simplefb_par *par)
 {
-	int i;
-
-	if (!par->clks)
-		return;
+	if (par->clks_enabled)
+		clk_bulk_disable_unprepare(par->clk_count, par->clks);
 
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			if (par->clks_enabled)
-				clk_disable_unprepare(par->clks[i]);
-			clk_put(par->clks[i]);
-		}
-	}
-
-	kfree(par->clks);
+	clk_bulk_put_all(par->clk_count, par->clks);
 }
 #else
 static int simplefb_clocks_get(struct simplefb_par *par,
 	struct platform_device *pdev) { return 0; }
-static void simplefb_clocks_enable(struct simplefb_par *par,
-	struct platform_device *pdev) { }
+static int simplefb_clocks_enable(struct simplefb_par *par) { }
 static void simplefb_clocks_destroy(struct simplefb_par *par) { }
 #endif
 
-- 
2.7.4
