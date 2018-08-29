Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D046C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A206A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TmIPBc2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A206A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeH2QwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:52:16 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:31904
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728483AbeH2QwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw9+YfSA6MDu1qVOhtAIGv4iDtfo3XsUT5Y+EGVeicw=;
 b=TmIPBc2bPoHKbcoy6sJmZHOQDu84A3VaetRQbAlH0JrnXHrBsyv6F+ryfW9HinupzgnG9W7H/cPPdnDdi8frCkEL+UtbeaYsr4pWqnt+1F9pHnNIpXKeLBs172zJplXFk1TtWP/YHce6SCHIlSkzr7nfVaic3Rza6mTkVInLPHM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 12:55:18 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH V4 2/4] clk: add new APIs to operate on all available clocks
Date:   Wed, 29 Aug 2018 20:51:38 +0800
Message-Id: <1535547100-25634-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535547100-25634-1-git-send-email-aisheng.dong@nxp.com>
References: <1535547100-25634-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:36::15) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab10b721-72c6-4342-a1e8-08d60daeaed1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;3:2LgdQXUXe5shLAuLu7mbjH5IZGkvNAjG7ZWHsxfsY3twE9mb9Q4hlcY9fbqLJ+UY9uMZZgFADgAFQccnbImpA2YAF9eOyvmml2OQL75yANZA6OnI6DtXqeyJQfCPxXqLdBHSTfPFz6iCt6xy6H1HuJLoOgIulMPKhu+IyR7WPhdlAxO2U+7/rQWNSugzF1rnoZ1nzD9iEru0QOKkDKgRpfM4ejxXMT8vG9Up/U2UxRnM3lalYWal+ThgUIAHRdfw;25:r9+SWCQccEPH9S9akoIh4meunP2p4pHJTOGyllvqY92GlsBC1YEaCb/E5eJ/Bs5vWr7Pe2ezkwENQEXDFSFz6NcqnsTYgdpFgt2L5WRTCAsv4rS/pRGBI8RaxVb7UskG/ZAuUyrZ//AE0m/9NSR5EWtI2Jx8rdDdnNMWD9q862nMAEM8b6RpVTp9TRyCJwQcrKN5+zm30ck7scdn+gHjD1j6T47ZeB7KxvFZYemvqxyHhx3lAZ0KJRryKQrBtQY9QSTKwMTIaOKA+nqf+zwMyQ4kPErDBXr8Njc8r6P7d6KfzFTYf3lGbvlZkH0JzkKq8uLlZtjLBxBl2Xmo7UXgqQ==;31:Xy2UsvEgiXXGDnLpe7/N3RsTew3NyHd6/ThMyHS+TTY2DbrnK7x344l4mtWLi19XBYyNMypnsN4YYnoIC0q/W7XoVcVmUAc1EHCEblBi13TbTWpGGDYzESwumE8957SNJwiFYTLunlEiBMaMyEDW2TXtCR6Jo4hY2mv+QlmL92mvjmo0yQ2O72mKelhm1NaM15gmBFPbyBpNL1CjTq/jPK2ff1xCddqkcVqABqUzHH8=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;20:jCb/4hI+V44j0iPd3q4HMKHOu6zb0Ymk7Abi6nv8be/PL7ellkHY33+yI2HSGxImN9FLKS9N6YIBBXzCz4Vhe7uli4DlnwQISDz9eWcTuX2+bcTiJxZWZPs7vuqQV0aptezN3l2r+hf4YfLwbvFR6BrYcLs8KlU1mhsYLgM7WGl9AQm7ddyNtMYgyhKQ60MuWChQo1AOrZXar2u01HSUUo33TLoqWC7tCIaKq9QI0bFGX87MGTFdO8n7DHwIyM3nZLOPkQBiLjamqIBM3T4Yrt0V16wG85Fz5cBmMboE4SKEe7k+7cqUhZx5Gv5dTSBzx1S5yvDdDZxJ9N2JAc+AckRv+wN+jbsvXKoEonosFs/RB5QG1MN4zIr76/iojeD9w8/rEMHgn0bZvkNd7gjBpMBPgA0dDq/zx8iy3hHzXprrbbU4z3mvRvxgc/GngWwulchLIqvP+pdOFqVu5gAOtP2sp7Rs06q5Ke/F5Fjlc6ao5CwM7+STwlzEj+PV654T;4:9FrIO+s26S/nCvJ/BCEPLxUn4CAoHVkOw5YzYipEN8q/9X9Dx5rx/bE+BrKllkge0wokJibKvI83URGQcFAHBCrazusQQbtBTWl2RuuIG80evPKxu/zItzJax2WrGO8Q6F9FLKdf9QP+1zZeRYgw28KjqBsPCsl3FTC7sLlSnuvMhV0noPp6dDNJDFRDkNI/RzfFoMUq0p3TtvJ51ObKAZ/IXkNhgosozdtGsgMKmXPuSNFi2kE3cQ4ii/QaALdOyvmjI+Jh1RUi0bpTlNsc9gldeD0YR8gZjUZdWlX8NzhYjDvVPoP32y3jrj9Rz8somZKJKmGQs/kOvgZb118/x3oFvFd298KbCTCT04UB4i8=
X-Microsoft-Antispam-PRVS: <AM0PR04MB42115BDA5E3F6F7D030FA76980090@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(51416003)(50226002)(3846002)(6116002)(68736007)(2361001)(8676002)(50466002)(48376002)(2351001)(2906002)(97736004)(106356001)(105586002)(36756003)(8936002)(7736002)(305945005)(53936002)(6512007)(386003)(47776003)(81166006)(6506007)(14444005)(6916009)(2616005)(4326008)(26005)(446003)(16526019)(66066001)(25786009)(956004)(81156014)(476003)(86362001)(186003)(76176011)(486006)(5660300001)(16586007)(316002)(478600001)(52116002)(54906003)(6486002)(11346002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4211;23:WwbTkwrYDXLBOknbnhwprHj3BC/I1YOisZ5g1YFLM?=
 =?us-ascii?Q?XO3wE0TTZJDUCzOSjMAI2tPmyLAdTW5igzInK9i0CrzOVfIyuftIdcKEjwiX?=
 =?us-ascii?Q?fwhzyIMsypXc+pnEb0cSBoQdDrDks6NFAUWACqQIvSHMe1tsPcSkHwm83ohu?=
 =?us-ascii?Q?+a4efG9q0SrfsXnlXyNyH05pHsd+JLJW57xSNFIjAycNjSVklHZRRvvgWXPc?=
 =?us-ascii?Q?KLsS8JACd4MjmYBQ08Dq3elRtkC7Geoh/iE18JDu/Y5EfaULuJekzvoGu5eu?=
 =?us-ascii?Q?kpCfhZM7QUnwOISYw68Wbol+YRvGB8QIrAzE400TKQLsEiS6ClVC32+ssCGc?=
 =?us-ascii?Q?RW8V0RlvsNZOQK3zZlMb/4O+pofA0PGMKAX4cdIL4HLFtiTU5ZldyxBB3XLj?=
 =?us-ascii?Q?pqwV3NJ3bRplRnmXmrDEJocVKoHPR5ysyfJccE/e9dsiXC18tgTWflJ2cjBs?=
 =?us-ascii?Q?Hk73QaXGU9iq1eaDqjRX5OrKVfaqoW2tdiQkvZtlO1AzGCu5caMX1K5nh4/E?=
 =?us-ascii?Q?hTAXmUR1vc/Zct9C9KgN4tPtBC8IyDVRm2dgi60NJT9yCQmHYUfWJDX/AnVL?=
 =?us-ascii?Q?5olSPD4dL72xg8EOEvqukXqMah3qFpNXk5P4kkjCauqYzP+mB4k/fQPY0h4I?=
 =?us-ascii?Q?80AZbGMqfKVM1V+OiKYQPmkP67wfZ+V6JcnGxKiEIXDJD4/ErWF5RF44gNkr?=
 =?us-ascii?Q?RPWfmGMvlk2kvBB9HF8+S1WUosdmTPDJK/vcI3TV/lQCIw0td4jf+AaRv2nX?=
 =?us-ascii?Q?ARljZumUkoKiiywz2tgZh1GLtF80CT9V/mwXSLR1yLYaEg9/rX6h9SbUVe0j?=
 =?us-ascii?Q?cwSzYpZlOG/rsJvD5VQY2ZKACdRkEWTKWZmcslf/E8WhrWs7tpEZohNIzB88?=
 =?us-ascii?Q?qg688GVH0C+aX3I2fdpqEI1yCxsaudOlL/imXvb3LKwKjN5J7PfHdBF+eved?=
 =?us-ascii?Q?s3izm4X7klrP4BmNOYIKPmqE4hPeGwme7lw8Vg68sRRKg9JnFNWtZ6wG65jC?=
 =?us-ascii?Q?8yBKEjq79q9l+u27ivxxkMucvSUeBRe4odZpEDCMgnF5genuWSTameTeiyPM?=
 =?us-ascii?Q?XzjY7InTV3T4lhza4dIc5BBKS3vZ78Uy6IZuAq1SDo7pGs15+gfH+IhxHQbx?=
 =?us-ascii?Q?9ko1UwU6rMEsRU7m+X9DCOrqzR0gXNQBKqh3YDS6ipPQNM/FRq+SaIdn8o/A?=
 =?us-ascii?Q?OvqYV/scMggVYUlE73p1TyMzIy2e7q9c0RqJD1TFy4V8QyTI19aCuPQTm9W7?=
 =?us-ascii?Q?EL9K2AtrbQgQm70ewk=3D?=
X-Microsoft-Antispam-Message-Info: 4mtvH4tqyC2TJpuZ80kaE4lIwRLf3eGO2mhnaLxwBh4X6Mzf4mM2wZNGNjshHBbX76EQXOHQ6F6reI3cvJCBOvp9XD8M5L1IlYZyMWoK5nyNanwdr7500E0IYgPqahW0qUZQjZak9XVD45NScmRhNNkdTR44y2aZUfB4mTdDOT8bs7ohwPhZjMPBDkL40rm6uecc7+bRHULVXp24F6ESmuSuSiILJ88LhT3h9OzeG0iHyzXGNbnG4AS0RCmjVZVlEh/uNxevZARKKWeBeL+JW/LFiBw1v3qoJNSzLPg5VC6WZf4zSimuhiJJmEV5ea9zjLfnsCf1g5x0M9t4AhDxIPb/ynComm5WJPC3Oijq6MU=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;6:KJpoUyHouGDwF6SB3gtO6r3KWHDTWbOVPAf/uSaOnDAljOEv0gJR1TFjaP64wNKuBRtRx4mxRRvKvP9hBxdy5oH53tWKoxDGRs4sLIFpnW/dgKsdvP82IRP7F5+g96guF9p+taO2mdhIjuXDAXrSbrEGiBEGD6X5XMitBo410CMnVKTQfPWyPWHtvWYQyDs+g0yc4x0SukEZkXmOYNbpfdxZnS6we3taDlL6TOCzq9SP1wEqHX4eD/Vn0QmpXlYj4mrjK9XRAVD1GrYM/ErcFjW2doP8B67eTOt4D+uZrkwS+I9js7wcGVQK8TgM0cJAGsuJfXCVjmbeGgFwtnFrPfzKhrqCBxyzXovM/xgRwIXQhscvaXtpoI6iS3XhWH4ZHKyiWcaBEo0C26r3q8zK5MMya1cmQYMvwJBxnZaJInJ3wvlnlGjraKo5jJTFyN7X/+mHnX6jZEkDs40Ix8Zs1A==;5:InLI5jmBk4zZxNka/YZHDwirGDmadlYEYiB5NPbfBjxtxMHRrOWeJObQsitth/8ryyuGvs6MJP8RRKzfPai2wZbhCUGWiqkAXw++FeF5AEWnkgA934ouKNGiticAewdShoNcOablMpvCJFvZVR1psjBz1PHgHnY4cWTOFwojIAA=;7:W9OdBRuFvUSWCwX5dSL3UIrmCk1lheFlAzgqR5a0AUD77jEL+ayH2uLotQooXT0X06fjefCj/xN67RqCvuqPhTdNUXZCjMpF3T1IzOQxctgQXwvxylui32Dee9ZPeZXn7PnmA7l6GVMtI/oAX/QzET7YQJD9nqX9U3WeTvRz4z98AgGMeJk01bFtlCWZrlFZTQ/+8YE2+vuePq9kArJo/MUmdZmbQxS3fLi2OdVi9dbR4B1j7Na7XZ2rZhuCR5CC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 12:55:18.9198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab10b721-72c6-4342-a1e8-08d60daeaed1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces of_clk_bulk_get_all and clk_bulk_x_all APIs
to users who just want to handle all available clocks from device tree
without need to know the detailed clock information likes clock numbers
and names. This is useful in writing some generic drivers to handle clock
part.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v3->v4:
 * no changes
v2->v3:
 * remove #if define condition
 * use kmalloc_array
v1->v2:
 * make of_clk_bulk_get_all private
 * add clk_bulk_get/put_all
---
 drivers/clk/clk-bulk.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h    | 42 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4460ac5..6a7118d 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -17,9 +17,11 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 					struct clk_bulk_data *clks)
@@ -49,6 +51,32 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 
+static int __must_check of_clk_bulk_get_all(struct device_node *np,
+					    struct clk_bulk_data **clks)
+{
+	struct clk_bulk_data *clk_bulk;
+	int num_clks;
+	int ret;
+
+	num_clks = of_clk_get_parent_count(np);
+	if (!num_clks)
+		return 0;
+
+	clk_bulk = kmalloc_array(num_clks, sizeof(*clk_bulk), GFP_KERNEL);
+	if (!clk_bulk)
+		return -ENOMEM;
+
+	ret = of_clk_bulk_get(np, num_clks, clk_bulk);
+	if (ret) {
+		kfree(clk_bulk);
+		return ret;
+	}
+
+	*clks = clk_bulk;
+
+	return num_clks;
+}
+
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
 	while (--num_clks >= 0) {
@@ -88,6 +116,29 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 }
 EXPORT_SYMBOL(clk_bulk_get);
 
+void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks)
+{
+	if (IS_ERR_OR_NULL(clks))
+		return;
+
+	clk_bulk_put(num_clks, clks);
+
+	kfree(clks);
+}
+EXPORT_SYMBOL(clk_bulk_put_all);
+
+int __must_check clk_bulk_get_all(struct device *dev,
+				  struct clk_bulk_data **clks)
+{
+	struct device_node *np = dev_of_node(dev);
+
+	if (!np)
+		return 0;
+
+	return of_clk_bulk_get_all(np, clks);
+}
+EXPORT_SYMBOL(clk_bulk_get_all);
+
 #ifdef CONFIG_HAVE_CLK_PREPARE
 
 /**
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4f750c4..e9433c7 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -312,7 +312,26 @@ struct clk *clk_get(struct device *dev, const char *id);
  */
 int __must_check clk_bulk_get(struct device *dev, int num_clks,
 			      struct clk_bulk_data *clks);
-
+/**
+ * clk_bulk_get_all - lookup and obtain all available references to clock
+ *		      producer.
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * This helper function allows drivers to get all clk consumers in one
+ * operation. If any of the clk cannot be acquired then any clks
+ * that were obtained will be freed before returning to the caller.
+ *
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field.
+ * Returns 0 if there're none and a negative value if something failed.
+ *
+ * Drivers must assume that the clock source is not enabled.
+ *
+ * clk_bulk_get should not be called from within interrupt context.
+ */
+int __must_check clk_bulk_get_all(struct device *dev,
+				  struct clk_bulk_data **clks);
 /**
  * devm_clk_bulk_get - managed get multiple clk consumers
  * @dev: device for clock "consumer"
@@ -488,6 +507,19 @@ void clk_put(struct clk *clk);
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks);
 
 /**
+ * clk_bulk_put_all - "free" all the clock source
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * Note: drivers must ensure that all clk_bulk_enable calls made on this
+ * clock source are balanced by clk_bulk_disable calls prior to calling
+ * this function.
+ *
+ * clk_bulk_put_all should not be called from within interrupt context.
+ */
+void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks);
+
+/**
  * devm_clk_put	- "free" a managed clock source
  * @dev: device used to acquire the clock
  * @clk: clock source acquired with devm_clk_get()
@@ -642,6 +674,12 @@ static inline int __must_check clk_bulk_get(struct device *dev, int num_clks,
 	return 0;
 }
 
+static inline int __must_check clk_bulk_get_all(struct device *dev,
+					 struct clk_bulk_data **clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 {
 	return NULL;
@@ -663,6 +701,8 @@ static inline void clk_put(struct clk *clk) {}
 
 static inline void clk_bulk_put(int num_clks, struct clk_bulk_data *clks) {}
 
+static inline void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks) {}
+
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
 
 
-- 
2.7.4

