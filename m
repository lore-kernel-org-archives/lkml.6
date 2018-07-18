Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87893ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BF020854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lyoXCkxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BF020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeGROSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:04 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:39184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731087AbeGROSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDRVYHkmllP7aLiPwO7IPZGNKqGVdoUaa3eyeJPTo9M=;
 b=lyoXCkxHolNzeBkKXt9d45+EBEgpLFrIn+AB1p1Mw9itpEg03c7fDMuZR9YnBmmjgxJHUTp7iSVm3a00IMr0S2tECED8TbV/59guARyZaClQLpx2E7bCBBv6RvTp443Ui3TGNLKBzz/F4iOsnwB+xyqJMdX/TCMXyrzPHUmoMl0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:39:56 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 2/9] clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
Date:   Wed, 18 Jul 2018 21:36:56 +0800
Message-Id: <1531921023-18497-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB7PR04MB4219.eurprd04.prod.outlook.com
 (2603:10a6:5:27::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b341ebdf-35cc-48e4-e4da-08d5ecb3f5c0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:XUV3h0j+P7nFNRyyFVW9ve8WrfLxhEjgus56eD5DTnhGgZxkh3iYoQXHenfJg29pNV5QdLw1jzJBIXJVg+LWe8lXXDYUg1+DmVR6ieyzYPTfoRLj8wOsP2r55yst/F0sVakLWUChWmTw3823SuVGQ8qlVSvf4uw7TPsIqxCSjSaoDnZqcHZ9vGc80hKgu8e4vJXDY1Je9DB4kzDDaL+EydDqZGerbPqXQ7YBvcit6X2Vx81HULE2kOoQzdFbJHaJ;25:f1t6sNmBiad+Yoy+PNmcHZDSgcEWEGylJK/Npm6/y7gpIbkonwjcqAULu5NRpa/a/y74KFr+JnhiCh8DInu9al1alzy6A9YO/MRoojgtdEgLiNFNM8C9S35ZQsfpI3VPEc2tEWunl3URz1DsZqdWV8JL3HvQT20DyS4K7mNjTMPAa6j/vae0vk1Rj3Ogkz5enMzXZLrIEFEobz8BDdzuqcGZncXd3MgP4/jUGyTsq2s0teL0j3j9p3Dzww8vp6Zl7f58+N0dHlw/An9YgNyoGChbIlSVo04PCIJ7Oqv5GDRmTf59KjVvBoFGtAvKeYUr8gXrhrw6UHZUHSK214nM5g==;31:4KtRAGpv05w68gtsRqI6fQsrztHuB+cPmW+0USrxwbntDncCUnpGT3YofVpcTDgEpr1nUMr0NiSm9lWovNwTfrFCW5Nx5sjavAy2JYD7W23E1kpw7DMFySscQ/Iz4DhV6FlQXRCw3LS3F26gQgiVfperuSVLnxhmN7WsnNL4S+AesaX2lIk6pf65rshVqIF6zHXB9hWfn1PWT8M6KQ3FbUJOpnvT+/jVUvEuQCNsbic=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:mmuLhWvriOPV66N3q+xzz2nBs6JBAwY2LxgaPYhhdnybFcqJGsiAGeXbcVoUDERz7u2ARIqa31qwUiXOZTEbw98+sMZkwvHyUtwiVbh+CYkg76gvTvvV7Y4c/zKYjXnCqKow40MQNdwxS47q+3iXx1AbRO+Z/aMUaqlDcRzy/08vGDeD5ZnJkaHeThxqe0G6LUrX5fbHedG/B6aydC9oNzxrtEk0glj5G3XLDkTRf8lvBIiIKNiZTmgP48muiJaTKQB6P0VJ7xdRI8Dul84WvBXE4Y2k/L6IybeZE3nhUQdjxNmrmhW6z9kYv+8VLoMDRZOPRKufE8XCAAIRILubYfZx11O6TVUuI4ot0gW28cxC4vOubxoxM3QuxRmwmlLXzmMN2UAcM1Xd8uvb7gLkN9wiQR71/zNtOOiyfzLgh1DNBabL0jRB1WXa+9s4/2OLWZ572FiuF6biQ1tbTU/f44XACg4/Z22E+HfwHrlOrTnqgv86JB8NtxrHNh1N+x0T;4:dRcS6rtHVSIbPVpt4/mJOXdhVH2Uwe5M9+4ZlDHX/7Q+ZE89ovv9bVG+rn376zYRxWWYulURNrcqqgbO2d551M/xG3aX349tFAZws4u4glnEc3H4Uxp2YFIvTDT5PmX9NnNfEwWJeBbFdaLZhONvcYZ0fhlb+Tz0IcoYgizIEqu1/DO9gJ1I8+ocsBuLS02yD0Yk5R23k0OMFtVMDFMclp4ODbDsVqcgT2JoG57QfqTlSVp+0CRTyl0Rx715cebLEpZFyNMY7W8e5umnCdyt26zDS4Vs2KXl4xh3qLC4IWtvmznV1b1OlHjB9L8c19TA
X-Microsoft-Antispam-PRVS: <DB7PR04MB42193FD56A232EA37B75FEC580530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(14444005)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(86362001)(446003)(36756003)(16586007)(25786009)(81166006)(6916009)(54906003)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:f4TEQoDRBolvEPgTvwV3T8lhK+wNU1JIUpYieqY7N?=
 =?us-ascii?Q?CjTnHuQk2x9Kv4MAh1QfHhYOkEFy+xNLm3dHQvtIgL1m3S1Se2OhUxqRE3aZ?=
 =?us-ascii?Q?VehQw+QqjTNacrZIZ+RlPmGZt53Qyd2KRA7w6S7PqutE//De+YqVEd7zV/Kb?=
 =?us-ascii?Q?/O3vSGIW2HAkSNtgy9VsIfdLLztwK6MwqrWSi7rGWo0oms6/bGqtRLhoLdS9?=
 =?us-ascii?Q?Mmajaguo6EkQKrrHiZb3YkXp0BML9VasIppysTm1NFNx2IBdR5VE2G0h4ljZ?=
 =?us-ascii?Q?JsrTrTgUwSFU3rMOChHfX1sSn1x+hWw0YW+1WavKn6C1mvgx22MuinGkPtKL?=
 =?us-ascii?Q?AVFOPsZgXXDoRdJCWVUWCiNNXzenVsoGNYeMNUWmSCRXMcoGVQEZQQlJDS/l?=
 =?us-ascii?Q?OMS8Siq2ERDHntNC8iOU5C5bBzsJym4ZBi92BqYTEFtsuluLxUVoX/rt1Lzf?=
 =?us-ascii?Q?QlD9B/PQ1n/88pFrIOqqppZ4Eb9mlDXGvl5O7nUpNwj43nefxKineNyWYR1B?=
 =?us-ascii?Q?KfyP9mA9JjD5TTq8m52G4e6nwwbCRfoZmyWn6C/giOR4IreTVewdEpy+MSli?=
 =?us-ascii?Q?+pMhHCfhgsp759qk0DTtB36J9rvO7sLagTN1IjSiWqicSXS7d97Ql+OkoAyw?=
 =?us-ascii?Q?YxwKSpqhIqkUflm9efGDPiBlMHfsSK20OfryA+0iZmRoeXu7eRCYkHzlPEn/?=
 =?us-ascii?Q?mpg5vaCWAe8H+oNkiiU+sNcmKAMMY2TL/+ddtlKzpkELSZ0CmbVkz9l/B8Ts?=
 =?us-ascii?Q?ywAXrJO6OVSN5SceEqFQcMtX9aibv7B+4T+2Zs2COlQ13RJeISg3F4j4R8Jj?=
 =?us-ascii?Q?3qGWTTLXUxbpHTBT9cqzTPTtm+Z+I/e+9l3pgWnUMfqykSk/fzH2ddkBUPWs?=
 =?us-ascii?Q?LgoiK2ybK46X31B/fCyD8gsFzVhOaX/SJFQUcG18pmiiluWXC3WtEY/ChU5i?=
 =?us-ascii?Q?0SyS0FBvjEL1LAXeOuqVNW26MtjOoQB7ZZAJSZOItcRWo3PueLT9gJ/447U6?=
 =?us-ascii?Q?3bL4isy8aBTKTOnQ7TcejaPCYbkhmRuugRV9b1kKDFI3dehS6gv3Xbh0MvYJ?=
 =?us-ascii?Q?FAJxIMEUWJS66gGgrKTRJgdUDmLmHMsVM5w3W5zCNLhB1w0Y30tNrDoPByc3?=
 =?us-ascii?Q?4Shr9KPuLl9P5XwQ/7bd0CfaFIrfkSCm+X/GoXhMUaf8NfTDVWYmuFJFONmn?=
 =?us-ascii?Q?ZkTh0VIuzVot4RQ8O4qNWdOAmmcq4d5q6aDxIwb4BOQ1KJ3xt1B8qY6XTTmt?=
 =?us-ascii?Q?RgjcOGUpuSLkaqisK8=3D?=
X-Microsoft-Antispam-Message-Info: rdxgGlpIeNhXCKj3l9RxXGlkIGKOdZmSORyTectFStm0LdWSVpuIjX636zEHO52HZFj+3Ku/usKLN32WAmrV4MGZG5Kehwu7w+TBvK0s8p6xa08TCfUXtCcJlSkwKHX5JsPDWHRVfZiuhttgQbvqZKynv9JIePO7b8Q5TGALyD9shDRaHZT0vjiEYW8HVqj3DMj/ad6qKM+CBz2+in5akEB2eepMIIwSI8Th0ZZ+HSYlMGoNR9rHMPC8v5zoqQYjwZd7dGCeAnIScRtVGWzZs1CGzsdHbcxWGtHdMuntThA+8jBRTRal7M+vD58x5l9DOi7we2invNdG05WujU9635YGvCwPp9CiOxldIlHiX94=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:8bgbPo2cmZSLTg/49dFMKFuL3JnTb1UB4kmMUgRtRSs1hL8MamDzMAVPOdzbCw+p5IM5K8JGkuDvOQ0piM212IcZE05PrRKpiAum91LkGYx9tjxvV92/WVBn1Y7ejNyhXwFtXGFdl5S2pL8EAEfpBNPNUlYoNt2qk/gryv3LGOGUc6XvZaZkRX6RFWNjccCMo46iUrSa6GmaBZGt4581XPxivaaENKhParv6gJxRhQ5p/rkywRnUn5LI4RnzwmwsSIiHQgv6ZELEDy/6PmndLQPkiRwwJR7EC7RMNOW12Qy6oOC9JW172Ktu5AkmNd1+ChRhBNY7g+sF01f6A+SgEAOWQq4EPSF3VE0/kKyRYp9gzp8C7KmjWWeKn7h/XGwX0C85kMmeCmHwjlfRDBmsIh1k4eMU6z+BAfJx9PcLXO8d7wXxONiiFXSxEt/I4+JHT55LtVDeEfVlm76fCgRTWA==;5:AgbXUSeNuePOEkIwF6NHPf2EuXjlq6kbRqAmPbL0rKuHtUjWkjXRCRlV3bFvfTbeiOgqcgk7jY5u9Tsl9UxqKaeHhCm9B/caVyluFG4B+N6DvAXhIqqG3Kr2VrylVCvPlHIHWJNGOMx+A5q0OWsZsM424dd2Hpm9Hzpirxc2bWw=;24:CDMWyoXbrm6cwQ9ipqcT1IYjid6OiyBgcHbkfyvww8hdqITBjM8wDau4HW6P9IuhEnyD3UGrmGC/gxG2X16M8uIv/DmQFdGidQH8Zu4R44k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:N4Gd1AXcYadwFU6YVFN/S2EzZvWwXE7qwtvCglYlQLF+xhvsbnU6htufRksEWbbyrzGNTA7B6i7Z3GBCC40F0q0SSi+40w128vs0tdeOVGbrU8CI8FpCEP+znWtDyMmWlTiJdlVO+4WmtwMeK/DDeSVKedHcRVTlel/1QgaGwwcozu1h5nDCSAvvkAJA6bB6BdLZBYXLqdrp4CxP8RwPDkkal67TcDoA7mcqFfP0Z8qUwykmD13o/4O+RM/EMyIu
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:39:56.7589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b341ebdf-35cc-48e4-e4da-08d5ecb3f5c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CLK_FRAC_DIVIDER_ZERO_BASED flag to indicate the numerator and
denominator value in register are start from 0.

This can be used to support frac dividers like below:
Divider output clock = Divider input clock x [(frac +1) / (div +1)]
where frac/div in register is:
000b - Divide by 1.
001b - Divide by 2.
010b - Divide by 3.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * no changes
v1->v2:
 * improve comments suggested by Stephen
---
 drivers/clk/clk-fractional-divider.c | 10 ++++++++++
 include/linux/clk-provider.h         |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index fdf625f..7ccde6b 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -40,6 +40,11 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 	m = (val & fd->mmask) >> fd->mshift;
 	n = (val & fd->nmask) >> fd->nshift;
 
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m++;
+		n++;
+	}
+
 	if (!n || !m)
 		return parent_rate;
 
@@ -103,6 +108,11 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
 			&m, &n);
 
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m--;
+		n--;
+	}
+
 	if (fd->lock)
 		spin_lock_irqsave(fd->lock, flags);
 	else
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08f135a..90d7c26 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -603,6 +603,12 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
  * @lock:	register lock
  *
  * Clock with adjustable fractional divider affecting its output frequency.
+ *
+ * Flags:
+ * CLK_FRAC_DIVIDER_ZERO_BASED - by default the numerator and denominator
+ *	is the value read from the register. If CLK_FRAC_DIVIDER_ZERO_BASED
+ *	is set then the numerator and denominator are both the value read
+ *	plus one.
  */
 struct clk_fractional_divider {
 	struct clk_hw	hw;
@@ -622,6 +628,8 @@ struct clk_fractional_divider {
 
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw)
 
+#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
+
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
-- 
2.7.4

