Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E78BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E120847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gO3/yfgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412E120847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeH2QwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:52:23 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:45091
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728483AbeH2QwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iN9uc1R4Ctt5/eBOt/haNNMwfWSxMKXuI49Pwtddzo=;
 b=gO3/yfgVT5NahZaHswna6vmt94Y25pUb5WvjFkF+wfIneW80kJs+wqrH6D6BPT0nx46Zh0pmYeU5rgzSaE8c/xsljoX5SYSv1H4LpESYSuiT/gLXTGhtnZjhqRpZ1BOpoDMyDjh9rVYJTFmtBl6610uLHOMBgb2vCu0L6mfTCFg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 12:55:23 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 3/4] clk: add managed version of clk_bulk_get_all
Date:   Wed, 29 Aug 2018 20:51:39 +0800
Message-Id: <1535547100-25634-4-git-send-email-aisheng.dong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4e33c8eb-f7a6-4189-6d66-08d60daeb168
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;3:CbGCHxvxTIK9P/AhOOG6LdRA3edOD/rrNqPsK9sU4X5zOG9Eu2p3Y/uEv4HFmNNs999lkKvWdPnFmmsK8FgugIUG4pLsO54Jzv3lIZwY1wKIvFThR86Aq6MV/xtmShrJIDBiPTMW+OXjUj/2BV1eRTKivwzcygy/evgt70FDyK70CyejVK1nBRiKnmV7DsE9mSwYCShZ4B6tAdXVymdPA+Wk84ye/XIP2zw1moLT2zBBdhAkcVuYBtVhq4AjGqx1;25:aIZ20QspnsLIz3OmAigQHz6dB1Vo6Sy9gURIv4HsgeS+0e1iu551MsGZzSTg4wxaZwrtmhqx1fjEoBWlGzP7ICIXDMMrLc0p/MFNxFNUm82IJT49mttQ3Hsp1eW13sGsjcFb8Jx+a+L/sqrCrTQJw8p2h5ouCF2Ppwvoqba95Ky+DkspLkuNcwM9GFX80Yl2KUh3+7KEx9gukxcZdX/YD9E5JvyX4qrXHVRg30/piiIyfaoAXrT63Fdl3N2dqufoWcaHHrAWUbBrPMpHH0DMb3eo7mdygOwfYH+I4FVvk0DnxqMKAeS5ZYmpgrH0PMXDnxAamwLFu8CIgN3s/Q9J5A==;31:09RVK2HCbJQDnhPeKT2THtf8+WA8LxM95i3YQyG+cmIv7GbDIlIqCFNBJ6+jYRh1zvrZ+bhdC6/xlDnxjVTQ8OWQWF3v6mFOZKifqAf/fsoTwSNyZZjVtEqh7dvN7mqXCZbWQ3ybNWeboyohfGPayixYgnBE5vqmtIv1lB+8HRlaKjSzEeFFlvI++2AryvRq8p4QYQpYxLYvo86CKOPCo+NwR4TbGG2h5ROZE+Q7/ZI=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;20:dWN8EqDM8qgP0cFRX+lzYu9VqM7y1xbyXnGlyw/v0l/X+2+oZwn344i5AFdL+cDmAPNOTXhd7r/CYPfeh0rFm2ObSde+nwUenqzDFUgQXF5pswY3wUTHl2HTYU/LVkC6tK/fMzzuKcNKwtpUh7S2QH4HaieMnkNzdhGMM+UNwZ9ipC7pPvYpbdj7G0l6fRNLAObX5wWIWggVzvF8dWSiY1hLMW8m0CLeTmA7NnPs+FG6+ZqT7Q1ijLXgIW2JHM0sihbjI6PsYN1sitIKzOxjZo3C/+h/w3niZKSvxrzofi5pbjAXOVbLY0vs5tHVb2OtC6iNQxn6xucWobGPegc+IxXhoZ4oYgy7lUM9+jZnIoXztqWCwDwbZMBKdj3mr1DA9HG3BmCgHy86UlWeJmjAk6+vgb+H2ROqJ6zBYxWdIn3lyX68N2xTB80xdF3q6icOgkmLpa2cpEguhGDtEosX8v8NyJv3LRoKHflGkcBRi8DIp+B0Hh7wAUhZ4QgNd5nY;4:78pPQQig1Aj2yD7JR4w3RBISTIGhaYoWEOwKtDX9KzHI9RBGI+eQOfoAxfR6C/Twn5sIb8OsbtjPVrmWu424gkNW5/1LoAWB7Bm04ddlr+XJ96VL7zSjnfCNfcGJehHcf5/oHAUJl4PRE8/p1QO6M/XoZpXumgOerfoDoKNMvtN6KB588omogAGAG/7CDE+d4HIom783+Mjvx+iSNaFVF18Q4KbIT9z4j5sWncJjLOhjDEVJwE/q60MAF1GjyxmcKJTSYwfnDzwxYtMI8hMOBoIPbYWwm/lrKo+fvEmw2y/PFCXJv5DIFaEvyQbu1+rNcAp2xRDXbFoHkc/TTGtVk6CySWJ1OkmnUGKXdrWCais=
X-Microsoft-Antispam-PRVS: <AM0PR04MB421103C308D03B29416DC89F80090@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(51416003)(50226002)(3846002)(6116002)(68736007)(2361001)(8676002)(50466002)(48376002)(2351001)(2906002)(97736004)(106356001)(105586002)(36756003)(8936002)(7736002)(305945005)(53936002)(6512007)(386003)(47776003)(81166006)(6506007)(14444005)(6916009)(2616005)(4326008)(26005)(446003)(16526019)(66066001)(25786009)(956004)(81156014)(476003)(86362001)(186003)(76176011)(486006)(5660300001)(16586007)(316002)(478600001)(52116002)(54906003)(6486002)(11346002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4211;23:vRuq9NyfYXBmQP4p0S1sURME0/WxLIMgbbwNIfCWx?=
 =?us-ascii?Q?hlEN6iE/PO50NU+1NcOI3uK6cq3rHloBtX/OtmxsuGq84rUCNWCo8152MXSO?=
 =?us-ascii?Q?narP/9BVG8FLYe1j2cF4nh3TAY1JmUhhMgkZIDfExC+QWYKqB6O80HI5Iy9E?=
 =?us-ascii?Q?AhkmwHyP3PHD/W1iR5T35YDwIES2sHKcGS4pPRpLwYCVYrzZQPSrHZJV31ON?=
 =?us-ascii?Q?jEYSxjjVL7QB3VMuJXmFcwqRleRJwKRsVNOmgKfKogSBCadjRKGKzgLisvD0?=
 =?us-ascii?Q?p2K1CR4leIo20+ZVAS5s7Ax0rw2yxS4RPh2QDTnzzQ2u+iajAEMmddOPDbuU?=
 =?us-ascii?Q?elWa58KORGi+JebPv8ckcq++Jl/rOQ4L05+eGqS4ZyhVqCXBHqjdMwWEC7AK?=
 =?us-ascii?Q?fCzMSQmtGVMXWaRyfkOG+hqKGDmojkftRTRAbDjLhRMqMbk/cDiIS9OZagYr?=
 =?us-ascii?Q?P5GA7ktw3sZAV6+Aj78n98TI1Hf3QAfk6WzxJdU5zz8t+H8C1sNkbvD+B3bz?=
 =?us-ascii?Q?rljNHrQFHyrNvoO3d0wxOKUAunctDZK8I48ibeklZX+cPDMrzcyji+nNj844?=
 =?us-ascii?Q?mOl9UROVFiZoIJco9xGFyCuFFP3Yrg+yWr4NI5RU0c2FLWaaBz98YcAp496e?=
 =?us-ascii?Q?U+qiUHnWTn/3sdpdoFmtjxTJsT/fPLAVVLxrJv39X/NuSYuC7VIK/BOzF099?=
 =?us-ascii?Q?uYjawnEwOMuTUnY0KWGeekCPMs6sxqxGXqJXua77S5kNS1HsqlfM2kGt50Cr?=
 =?us-ascii?Q?v2e+6USn2UfSW6MGvIjvamWzBu6TPNMFa75mlaKB+UQA4ZcqT+Gna1fUbSBm?=
 =?us-ascii?Q?xntZfmH4pbePysvrZgnDvckger7eswqFfCjJ+nfgARWTOrWgZj+h8voPlfEJ?=
 =?us-ascii?Q?Nytzan6LfKAgPsojVL8R1IlWhcuDcgvcrkF6iMmtJrnpSxDRzaHDc1EgtkRk?=
 =?us-ascii?Q?qJra85IvOFtwm4E/jE5BABqMD8kkBSHE2xCeyh4FU7let+zGoYtnEjLJzxfr?=
 =?us-ascii?Q?7M2A+bFst0eXNDmAjaKde4/yc6itExymBJnL0Im1GJMm3hPsunITqB8gerd0?=
 =?us-ascii?Q?Gi2hCE90cxS5PdLRLOfTkUpHT201HNcQvFARYehtTE3XG10FqyHpwRcFOPGU?=
 =?us-ascii?Q?Oy94flY8ZBgqN3PT6h/Jd96ItLbUbvkPhNkTsB66b/47fMKE0CLzqsizAZe/?=
 =?us-ascii?Q?w4TDj46PWa0KZzy+p4PcNvfLhqbgqi+fMnfmo0nX+s8WiWn3qBgxw567RvCo?=
 =?us-ascii?Q?KDM/CRNaSxnYQFyy88=3D?=
X-Microsoft-Antispam-Message-Info: YJy0MErqeCBibA6m9VPBET24iglmeOQNi5Gpb0DgCskPyHrhIswW5sgH5GyBNGh6bdpYZdZ57kt3Kw7OLIJ2uiYgzr5rdFnEGYvuZS+N/Zs80NheVidZnzy4klm3gAAvQrBWIWrZerjaosT5vPQDdzIgGwcKHndvKxj4MXt8WkW6UlyIfFnFzfo4Zd8ZonQzsmW/GQjR/d+uX2SBn0AbG50ONJwNlmCVd230uWH5QUCWkX8uUWv5ylStQbempsXOSzKqKC9i8W3K5UtQrNfBK+XuoP5luwW0BUfSVF4NGCkQoXS0iT/65xdyGS61RCuhfjAqp7oJ3EQbJJ/qclIbs5AUA4x6tIoFazOqL/QMqUs=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;6:ZSmQcpr87ZwdU8nmfMu+yAEzYTGBYs25YywCsKonRh7Zya1EJz3K95tn1UPnhyrwdTPxQa/y0T8Agc4vjfeiNhVJ8DWNemO9pNJw6db3TyFuQV3x6UUqoka7cE5sL4r9HtI/ZoUikIbXAvNh5k9Ffn0FLjby8Ft/WVfwsBLl11BU086pV9hJbvayIkCGL5Bc+0Pwj9SOpw6d+dYizxdUbaq6TGx+BxPlJFxquuQ5RsuTj7rfsRokgNXX7QXfYMJ4MelMD8tpBOp3KqYkdOnPsE3CW/ALeBArFmL0brWrxlrXzHomZJWjtMvPYyc8/GENHu6ShBqSaP1kTtLkITLkFY6YSt2PnQLbVk1rVGTuxPHbrmdW4/ooXRvmzbv5uRYjzpMdnjcxcsRTerFvZd82whsWTgddOi2WKe9JoTHSL1MTGjb2FDeMe310AtJIG9UEiER70PHXG6Pi0aJUOD9OHw==;5:0iIdPZ7SfaOkWSKPCaqqqQK8siUwQU7di4A2Vz85tmoEmjGQVRQs2mz6FpF2e8luA30gQAcje7lCYyYVvxKyZnRNw8VPh/Z90IIGy4ZVPVS7Ek6KoL6B2fm5GQHDtQqIu7tTPs8CQQTEn7yEGfRDOUv4VfNVChtmpWp1j/p3pmE=;7:6oNjbwE4cmiOddUYuifKRrqlsEcUdwDW6szHG+Hv2pEnufdO5kYtyM+4iHE5g6pqy5QjMl8QWjX59di33zAwHAIUv4D87Zcvkr9d4I5E0PkbY503mgdpCQLjNMQQYvrrlo9JMcKW6uK+vah62/EzU8yrdpgGKl3P1dQnC2MKCeOoFNGi0K+L8eQClSnpA8OAvlwOJoP7XWRiTaXkbb8Uy965kTwd0QTHgJ5gmy7o3fEbYxpOP4+YebcWZPob+U18
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 12:55:23.5448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e33c8eb-f7a6-4189-6d66-08d60daeb168
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the managed version of clk_bulk_get_all.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v3->v4:
 * improve 'devres->clks = *clks' according to Stephen's suggestion
v2->v3:
 * a minor fix of build warning on PowerPC platform.
v1->v2:
 * new patch
---
 drivers/clk/clk-devres.c | 24 ++++++++++++++++++++++++
 include/linux/clk.h      | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..12c8745 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -70,6 +70,30 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get);
 
+int __must_check devm_clk_bulk_get_all(struct device *dev,
+				       struct clk_bulk_data **clks)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_clk_bulk_release,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = clk_bulk_get_all(dev, &devres->clks);
+	if (ret > 0) {
+		*clks = devres->clks;
+		devres->num_clks = ret;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c = res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index e9433c7..c705271 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -346,6 +346,22 @@ int __must_check clk_bulk_get_all(struct device *dev,
  */
 int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 				   struct clk_bulk_data *clks);
+/**
+ * devm_clk_bulk_get_all - managed get multiple clk consumers
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field.
+ * Returns 0 if there're none and a negative value if something failed.
+ *
+ * This helper function allows drivers to get several clk
+ * consumers in one operation with management, the clks will
+ * automatically be freed when the device is unbound.
+ */
+
+int __must_check devm_clk_bulk_get_all(struct device *dev,
+				       struct clk_bulk_data **clks);
 
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
@@ -691,6 +707,13 @@ static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clk
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
+						     struct clk_bulk_data **clks)
+{
+
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
-- 
2.7.4

