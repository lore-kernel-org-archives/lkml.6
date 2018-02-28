Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935400AbeB1W2H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:28:07 -0500
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:31699
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935301AbeB1W2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:28:01 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jolly Shah <jolly.shah@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/3] drivers: clk: Add clk_get_children support
Date: Wed, 28 Feb 2018 14:27:39 -0800
Message-ID: <1519856861-31384-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(39860400002)(376002)(2980300002)(438002)(189003)(199004)(36386004)(16586007)(186003)(9786002)(47776003)(5660300001)(81156014)(81166006)(106466001)(4326008)(8676002)(7696005)(106002)(36756003)(110136005)(54906003)(26005)(50226002)(77096007)(76176011)(107886003)(336011)(8936002)(316002)(63266004)(50466002)(48376002)(2201001)(2950100002)(478600001)(6666003)(72206003)(356003)(2906002)(305945005)(51416003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3821;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT059;1:wZ7CnQbukd2aGhrgRJLCn7WY1al9IBtpgNPf8Lr3r8YkWGFOnjThulbj2GW/ZxbGouZ9DN1ZHPBk3XYHg+G11oFgP+usZnBCtBOQ62MEROneMG06S1PDr85v0PbG/cXx
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c5c0da-854d-4143-0280-08d57efa850d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:SN1PR02MB3821;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3821;3:QJwWvlI50c8A9DtdS4vTOyXSU5Exm+XL9lePpMJTqI/pl5L6VQ+B6wP3/MjxAd1Z8bHYwuQjgXRM3cu8tr15oLGSxwyVhFBilGhpbllDdtNK/WTMPfT6532mOx9r5ufvc+NjCMdYTRUVJfRVnfkB6zRykMAxVS/VsTo2nrXyHAIaOh5hMXZSVEVKYAIZDaqNuGNWJRGKCgjDmzQK6onWymGIapJMO00rE1bAymJegLBPpf77jwtmJ1AhprWrHY6cZ6P2658LNdIAmtS/bgQv7c6aAiBdInhhvMpU52nkiEzjLtEh50viFyXIkYgmehzga2nkGYOg560IWRPiG4TgcqrMObq6ddJvRQ3H0bqtasQ=;25:41GK3q3W47pbOVEn/Gylh09KG+8opN7BJclr+2QDtohRkCepRgpknFJagXp3pu+WXXTXIjVJTlnPU3Dns1retew2Qah7Hkb7orIL727VpRKPiJEUQQAlqxNG0y9HpNA0fsCmewRPC5cLwmcdZbYFemqq7b07itEWgQUg7Po1efN87fcrg5mJGjJmgbCA9mN2PLyiNg5irMWtB2P41VGRT+CgsP63NUn2jmRTeT+iGeXVmKOvGy0cyklXAb68rKNqzU2TuG+h7UcHC2LvbU4lI4et1NwroKSeAf2x05bAo4DLMHw7p/HsJ82GkS0Qs7UwAjhxl3qXuJwFyGvF3SqMVA==
X-MS-TrafficTypeDiagnostic: SN1PR02MB3821:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3821;31:3/+hCnr0cG8G6u/ALOF0fazpxNY4Pca3nZUYdXWM9njnpS+0jVd9c7BzFMK5rTeCj75/olvr0C9wZpgf3//ql5FUb/4bsh1fp5Cq9WRWvacIErC5MfGC7LktRp6SJJsqFFgC0Himj3090nFnHCu8T+fgabwBEL2RHXjLQycW6BpTkuKwAM+DZzb3XPX7C9dlyYh9nBSoSBMfE56GBRoPAHzjgUh7JMKBjbOxQOamTMk=;20:1oou2G20lxX7rl/U17qqCoX6Ut8TKoXPRkMoAi/K1OPPXTdPUMZEqFZytcjaJssq7Ul9zdqAecgy7Cm5+wiQQnvCvrV53eY12Z/ArYdAkM3zPaxW/YwUuQe4FEs+de0APGCqkRHDLIxg/KAqcWM5IaT6nsQl93cCiFDbcIqcbH+I96ET84Pv6zhpQ3HwLS8bXCZMzkUZWjJBY2TNM/rE02YfroxMcBw5hJZHH7jKh/4CA4CyLSKBi0MldwQU8e+ATXYvNaDbVC42rKOnq+mtQAL4PU4qDPZRQZcXkhQbFDNC+VMOJDNKdtGcwEKvOVX61iUOU0cnG2yfXLGU+yp6H1eU8u4bJXICp14KRZYHvt+6L1YF3D6PYoVIFVDigjwgJ3gqEAvva85uav8j8xInHH583CKWCktPmF1lAvNnyLdcosR6RQtkDFeGRECzSob633sfqY08LhtiQv0sz2TWRfFqnGfd40Z1S3eMLXdjoYCXpGyfrZDcvQPtmRi/Cc4w
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB3821DCB08D52B076F098D0D7B8C70@SN1PR02MB3821.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(10201501046)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR02MB3821;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3821;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3821;4:foPf1fXPyS4XIWVUb+tP2ZFfkdUzY/L0yizq3swfofqKrWbKfDrqGFcKp4RwGt/zlkZ7BMEutYbCYRNbXjNWZgF0xS8DC1FBzTLg7KdTUCOJoivz6pp5U+T1F4cuXHMTHS83kJ5PVliFK4g45JEViop7Q6qCPe62nXOKkLGq1WDFOgARXpX+HhemOPXoi69I30+KD0RfnDSyIYvwpEcVQ4JnnOVcHYmOMGioR2CWaKylL5AeVEOSVll+nSq6JpXCjDsWZcaETlywTdd8HOvmocQPYR+VH6UI16LyB7GkgjIwBzIimMLNQLtrUzHsepSI
X-Forefront-PRVS: 0597911EE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB3821;23:8Ov2J5GTdOReXhwNiOGyad4MJhSGP1ctTd/YyeFoE?=
 =?us-ascii?Q?VcCenKsyBfn3tMiTDY1j19CGKhvjLzpFhnqBMoNK4xq7OW8wRcX09lqozuLc?=
 =?us-ascii?Q?OXpQTwOrkwfbrFfkInZjOQO5/sf2pvZ4fYtVktm2dJqK9IrCFYy9ZmXrCD+a?=
 =?us-ascii?Q?Ram2mpBS6mEq/yp+hx7v7rbLN2Y1mjvhbVIa9nzSsZeY+6oYd7dyriA5UzeL?=
 =?us-ascii?Q?kDMXb6NM2+wAbEkA+WGSUexlyUOJhF1BAhuMDvy2xDwjpP/YErmMqCxNgWJi?=
 =?us-ascii?Q?Jk8W28TKH7Z8K/lR8N8OjSyqid6gFaI366T6B8k054MA3XL3LXZvHQeFLMrf?=
 =?us-ascii?Q?1jvu9gJFGMjTMNiXEZIKVpvv6OTzPWuV1grF1dkUbRivXB5WSSS2uNJ8MQIf?=
 =?us-ascii?Q?BBTY3x+t3T9aowOcZJhk2iXNFn4gW2yCtsjvH9rh3o2xDo2hu9rWgcur3974?=
 =?us-ascii?Q?LJ8io14ZSnMVKjVWh4xnbovYZm6yprNohTg/yq3+3ea9xQj7f41Ez3EvG62w?=
 =?us-ascii?Q?EezqkzEQm/S1h11fMxTY0I9IEUy5tPmwZa58dqAQ6jr9+4gpk+YFV4cJvRMs?=
 =?us-ascii?Q?z8PK35QFMMXiOSEX6PDMECOyGRoPHSL8291AlIZHefhKksAEqlFKaRU+9JeG?=
 =?us-ascii?Q?Zz2qW55wLpUrM63fcl4Ma/90iAoN1/1OO5RN2wf3As62jdzvFX69MPeCgpFt?=
 =?us-ascii?Q?k0grpf1FJlyVlQCv3toySB9EmSrHt1PBYk6+qXfJv//3ry2nMUWez9WD9kRA?=
 =?us-ascii?Q?j1mtXtzRZJJpE6FEDBlVHRPyeYeCU3/XIBEAlEK5RhqQp4lO7zhxQnNOddwc?=
 =?us-ascii?Q?fNDcJmEu2XT2LDh3r0XcPpb78nBA2qoBdVx10u0j9BBv3T2uBy25rLWr1Qq6?=
 =?us-ascii?Q?R8ngbfc/beirGFufDUQFb+bcYL2hFla0fuVZGH3cVMOb8JlclJbjDBGOwPou?=
 =?us-ascii?Q?AhzERRV8mlP+cWDTlSt5akBZOZxp4SRlPqeAckJffC6fUHnWEYZkTBOP7JiN?=
 =?us-ascii?Q?OTGzXAzk1TTIS7raTDnwtP8sYFLYL3XXDO53xyvmOAxtSMYIwfdAcg9pLkgq?=
 =?us-ascii?Q?RcYWmk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3821;6:71KY9pkxqaybgRqjTvPdn8cFc4zkNy2XQXBoH+GY4ndiqqxc4Ym3eckmQnxIPcV3+oFcCUmy967x8IThhKATCrUsK5xq/13GS7h5P4vlBuHMXfuMV/C7i0ag6kGcVHdsOIaoudx28kNGQrmISo/O0aW0MGUxybPm0MMjmm5bkZNopnvPQMkQgKi7ro3xs8vNVNXraj4TyF3oewjyUedDfFdmyKuOayLe4rA5iN+Gmh1buVwFynEbSTiPvEWvVF3afl0MUpRgRgJYpCfqH8R6MbEWVkGVLOqIo3G1aYtCjvvJt4rNXFcupv+R0ee1e089GCOhOPkbbZSrdEbMMaHKspm0jywHlIPYdaID3PnQdyY=;5:yP4xpGPXyYxtDMJN7m4JqxWMK3RxD5/0OzIts7S2SHWoSiUXT4cYQVccecnqunqml1YewIXpiDLp6MsKeWyprcgL4P2+4Se4/Yp0gVTBgqkVjsTw0qPyE40CIF3vd4j9UXWUq1W4dfptrX8E1/CTiyzX42nw42H1N2bfxCq0vgc=;24:a2aDVy80dFShulQj5HKNjADiZ75g9tEvMatSuwZyGxrMAADOwC40goWa2t5bFbCRnIwU/dNngn0w5MjijPk5ls4QcqK1sB/Y9CLW2dhuSYY=;7:MahD7AMil4J2HpIU8L5wvcpd0aGdfp0z98m2m/PEQp1k47kN6/x6MRXSFbQlmzFlLQAasyvGnONtzmWRErkjaBfGuPanVZNzrYvA5HVMlKrHpQuOVzfmTIEFWMQvR5jOuOfe1ApNFKk6P/f0TFYQu48pkPa2D/FwHkI92FxrmheSh+xZM9b6cZEnyJ1ZPB3Es5gR0rnKdJM8p2wabib5PVEN4b1R/Y5PCfrrVNxLegXQP//MTe26++XH49RPWswy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 22:27:58.0220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c5c0da-854d-4143-0280-08d57efa850d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3821
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jolly Shah <jolly.shah@xilinx.com>

This API helps to determine the users for any clock.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Tejas Patel <tejasp@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk.c            | 28 ++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0f686a9..947a18b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -274,6 +274,34 @@ struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_parent);
 
+static unsigned int sibling;
+
+static void clk_show_subtree(struct clk_core *c,
+			     int level)
+{
+	struct clk_core *child;
+
+	if (!c)
+		return;
+
+	if (level == 1)
+		sibling++;
+
+	hlist_for_each_entry(child, &c->children, child_node)
+		clk_show_subtree(child, level + 1);
+}
+
+unsigned int clk_get_children(char *name)
+{
+	struct clk_core *core;
+	struct clk *pclk = __clk_lookup(name);
+
+	sibling = 0;
+	core = pclk->core;
+	clk_show_subtree(core, 0);
+	return sibling;
+}
+
 static struct clk_core *__clk_lookup_subtree(const char *name,
 					     struct clk_core *core)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f711be6..e94dfb2 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -745,6 +745,7 @@ unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
 unsigned long clk_hw_get_flags(const struct clk_hw *hw);
+unsigned int clk_get_children(char *name);
 bool clk_hw_is_prepared(const struct clk_hw *hw);
 bool clk_hw_rate_is_protected(const struct clk_hw *hw);
 bool clk_hw_is_enabled(const struct clk_hw *hw);
-- 
2.7.4
