Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA1FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50302083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WpJozmn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50302083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHaIzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:55:21 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:51856
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbeHaIzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iN9uc1R4Ctt5/eBOt/haNNMwfWSxMKXuI49Pwtddzo=;
 b=WpJozmn+5SK+c3l6+BtdFY+gbwDbPdu19WCzDwJ+U8uv0riCgfapnRepNHLjwpqHMizUKKQP28I/hR4Ib76LYE05pzQ/C95dnyNFrUxX3QUjiOaZKMYkere5WQQnvo8pF7a+EImkcBUCLghuDPC7cbezrp3o/XLvMhH+BrshFMM=
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4212.eurprd04.prod.outlook.com (2603:10a6:208:66::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.18; Fri, 31 Aug 2018 04:49:38 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        hdegoede@redhat.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V6 3/4] clk: add managed version of clk_bulk_get_all
Date:   Fri, 31 Aug 2018 12:45:55 +0800
Message-Id: <1535690756-22234-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:203:52::25) To AM0PR04MB4212.eurprd04.prod.outlook.com
 (2603:10a6:208:66::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ec1784c-4091-4c73-5339-08d60efd2a0a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4212;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;3:JB6FcyAA+WylosnqxeoNXRwrZ+1WvL3jGKYWlSXJG5+1/5SiFTkQXIrkv3WdHfl2ci33NvKUwAQ4yxP7e0oPPL2RgW4mhZiotvOeLww+OsadazOSXCvhpBFnpt5uXJtcAQk7bcJRGBunO5h8jqt8DuDxmwvnBJ38eGgN/oPRRIJdqAu2bRwvWdAbDqKZ4x8CZfvaRW02UUyF4HFl7D7KagkFbF5C2dAERhTZjdufJVZlYFhxHEIaeCyRpxgBLoa/;25:Y21JppRwBgla7eKU8gwJSl09/MekUZw4wlC0jUFkbkouJqQ/VwgK5XcPLTeNghJ+YlkO/DNIaH5HT4zdPZSSOWVypii9qPv4ny+/oe+mA9XszAqM2FPNqn8/H3uZ9+NU4snxcdp7Rz9orm/bkDvdGFZOpX39WBc+iVgtnUXySiPpPp1tCT2WxfsVTC5dd401XRCpJwtmaUHMDrpd0X7nyVaJC6yqIMal5Ykz5ZuAhzaE3ApEV5fhtt6hz7Us4HZeWk7EcxfYb9WNOPS60VNb8aEpE2ZHzrkNTvuqMf4MYsXgdxDpE+nHSwnNAEyASh5zGXXCj/sPDWxV8bZN1s6KKA==;31:7HSD26gxzyp59lmzgGscvpKYg19YAhQCQFw1x5QqgHXJtoUKEDFGNVyoZ1ylAK9Iox/y3VwBVtnhIT4zlNP8qQJFFDuOxEZqiBoJh1RQQ0uoGhqM0BgkKQn0EgfV7oCDvS6LhaOOzeiMTu09zAasjiQGFYtUI47hE/TN2uoKaj1qlRzOZpQXzvwT3vm4+nEdeJz+jh5LEXC48HRIlEjj8fPhaY92Y5uMoxLjlQHFniA=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4212:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;20:QGPgbYAb1SE/yACLyiPGZXpWv1bqW1Qn7qgpNJ/+s1HnbiewHriX+iSkMQ+5126LxihT29GQqnP0NbGGdT4YwCrSCtelLDr+uYi9JDanLCNhFLv6AID8jrm5caFoUYh4CYFfpIGmSDdvffxmSojssNUui5rxckTHIhfkDqP/n00lWfmSb7MHPrp9tYjZgNP7TQOWsz1mYjckux1xDH72DKPpw9FAhlOK9ai2s+6f0HcpJgMnAf7yKCculv5lHbgV2Nvcu7V4d+sEJZa1Qzu2ZWICQmdeDCW2TqPB1bcpLqPSS4fluV8F4W++puizTM0DVdHfWpMos8nLiHaTEdnueAj1CxAVJWXRqQM1l99+OM6o+AS39M5HDUbL3/8A6n3tMe8g7iFZSrovmnpWGVPkQMi1BRVC9tGv36gcCJOXyyDesjcDv6aWneGe8bQzBmWO8zb4CyWr6+gRsFgdUDMMNl6SUAFkujo9xaJaeRDB/9mN6zbKcfeTHrTV79IH36xm;4:jMXu11gtYkM1B033D+QdX7m9VKtFiH2nnPhYqlYMQeNc7nZSRVglzorO3wZPCZ2SnVRX+DawKpO7pSifFOf+AbR9SOg9PzC2QY+EMIaiXMfNgJ7idwa+YAX53F0AJI9Tje342/H+007GC7DEbLT8Y4DRG/vVh4+7ABo33OJbXLglkCW9Up8tBtmjKk/w7TV1uVx62CPLlHoOVe5DRoGrOM+rlHqhEzXwgJcXE2cvL01UU16DCKv7V/iTT7aloUoDFBDaLQqxCZusaBrHv+3vL8wEpEil6w5FJltP0WTGe7uRlXnlMY+2SXmHGt1s9Mwif9FxDg/qJ/mhNuL23a/2tgLM81FxnLLYZT1o2GZigy0=
X-Microsoft-Antispam-PRVS: <AM0PR04MB421227833BEEA6EA1911427C800F0@AM0PR04MB4212.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4212;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4212;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(5660300001)(26005)(52116002)(186003)(47776003)(16526019)(2351001)(2906002)(6666003)(386003)(6506007)(51416003)(76176011)(446003)(11346002)(53936002)(2616005)(105586002)(14444005)(486006)(25786009)(4326008)(6512007)(476003)(956004)(36756003)(66066001)(478600001)(86362001)(6486002)(106356001)(316002)(16586007)(6116002)(3846002)(50466002)(54906003)(2361001)(81156014)(48376002)(7736002)(97736004)(305945005)(50226002)(81166006)(6916009)(8936002)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4212;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4212;23:mepacjAbXBWJ7wZX0xtp98ux4F2PjcB4gOvbjquaa?=
 =?us-ascii?Q?ba6QlGy6a2B8bUGapR8Xcefp1oz5qUtGxRovYyi7rTFOcOQfNPk2FXekGSgb?=
 =?us-ascii?Q?pnfsBKMc2JQH8ULEyTtmI6LlRgzFXnxsjEq1iYY13FGe7Zf02yCK27bTnfXd?=
 =?us-ascii?Q?9XfBJRL6tEytXnBNHlyHINyrY1YzsKC3oTHv4IVR/ekOywOPpj1Pv3p0RukY?=
 =?us-ascii?Q?ybrxO4ZnQIOI6t9gfGmZJWZoLPi6hnSmhVFIjxkKfWNHuY+NYhD/DqIYlkII?=
 =?us-ascii?Q?Nj2S+Q/+jOqwqMrx2URAKosmR/n3ZT9d1saB4lXIVzyyLI7OuGtvIxFOfpgZ?=
 =?us-ascii?Q?XRSLPjdLjFJ3ArhbySUromQp8S2kMI8Y1FwXh8hr2OjbWtj0TZ3GKPg8XzMQ?=
 =?us-ascii?Q?N0kmXBBXHD3fpG7JYtuQUdgaeQWvdcDE/Klnnt7ZRx74F+KCZDVyfZHfpBfK?=
 =?us-ascii?Q?2+uXVqASj4oVxvQpISIAYJ5LTziVk6bcAPlEXT6T9SGkwc4gXt5VOe7t8hsM?=
 =?us-ascii?Q?GLDt6XydypF7cMrJLWJOk7FErHhMuBWHUSpMHmWkptewTxq2kNlnv5/haEb7?=
 =?us-ascii?Q?4XZX3Imx4f2xoolM1IS/wVG3cKzWfRgclpT47hAJLLr+eCUzw+YbOQUbbcJt?=
 =?us-ascii?Q?aU+j1NgwjkcnQbu/Ljv+fgljA8jhk/rxrjpWJrb4c+nLd9RJcR4D4cex4t7m?=
 =?us-ascii?Q?M2Q36TUe5PBBPhB1O+2cUtNrq6i+HAGhLTeuY/0qYBPOKfz67m1eEl7T5Vj/?=
 =?us-ascii?Q?figL6cdqWw/f0rKPcoPaOP8QSa/bQSgm+FZU0ogk6FiNHJTfKVFH4+dx0FKm?=
 =?us-ascii?Q?1XreZKnUZo3T6xnOheTO3+oFrTfbYNk1SgcKeJ+6rMECGzLb19FpHKHlDwgF?=
 =?us-ascii?Q?3TOu9QHJ/ayy8WFXWM4OUX+iQ6Eil0BeMSy7LXqpDUXuKUrmGgmn8G8dLwK+?=
 =?us-ascii?Q?ccDwo6CsoZoRLrsYqabVM+EZWNHjDUH6kWocUAOycFN9RU9J/vdPQ8N2DfvP?=
 =?us-ascii?Q?oK5vtvqzVozHIyW+BozGTnS6Kf7FESjvkEqP3CYYMv17YUoj8KBKHFloh5mF?=
 =?us-ascii?Q?lH9VdS2O/HMQnPOh02FHrHHJnRL+WfNaPGdvtPYieE9XlsaEY9F0zDC7yd/0?=
 =?us-ascii?Q?AvsgX0UNNUX9CObooU2iKzE+XGauI878f1OuLmnR/SQfRB9BGZXnRK8wVn/Z?=
 =?us-ascii?Q?SO/o8EG8AkQbHOuRaAl8KezV+bgvBfJIR3dgPW5wk/h2IQxhbCu04+KsRhLB?=
 =?us-ascii?Q?xPRz6NwnIjkyA3096I=3D?=
X-Microsoft-Antispam-Message-Info: g290VsfVLsY8HtPkaHitQ1ZLwZ8gmVQnsJKkUts5/lE28U8l4rGtNwZBLhdUqBx/IoxAdiJ88a1RJ1fk9KZmXEThxQyKC8P/AS8KcnsVLEl+8OJZKE7nUa0kyIZDyK7BUtoe3rfbKi1ovoC1loy6UufqfYFbTrJ9O+LW8Mh50ymBmmABoW+fyG3d3VB2EACwrpjLHHXOEmElqZgGaD68abg2qM+odoE0F4rbUHt4rD32VG04tOoAoJZ5rr7WDo19clthGBugRiVbVyQ6AxjlscLSxIjP9SXlXnGVJVefNReeWatvB098uWEp3MwXMNn2oPPr8eKYc89rcHGsRCYuvjp39CKh5gBktaiiuuTLjrs=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;6:36Nq5B6ZKll3uPg+bYprw8BU32dIByOegl+NCW1ncCeTYTIhiqBtDLKgs3hqgJbQbLAMGN23eFOpsRakobgPhnlOiFpgNxyjCKfNPfBVtllfA+XVpp4pQ565xpJ795SOyHMkfLX8f89ckWCjmvgkdfpsvBiecZifLmhxsTA1SGt5hdY1oSUZPM0w/lQX6EJfMr8wHdvvpobjZyTmK3vP1H9UwGErF6ISvuUP7ocOwIzYRPiJKacfGLDQDyftq0mvb6FN8CaYoyCq7kZ1JJz7mttxXvgjXoNLE3WIxApsbEYjRq+xuvRYdhpLWgARx0KKrARw/vhhoze3IUe+B9fYFGqNsPryWmTGGVaM6hQU8u9MH3eBSZcbDq3Zb1t/pHJPAK/PyBiVc0xVrYCjmfr5LZvd+7owvAU0kePY/3FGf7uM+RHY8+Ix5Hvruuoy61DiPz8keZJ4hRxe1ZDxZdS4Ag==;5:T3GbIud7vBpuxj1qqphIuk0e0yqkQGoIlx9VDeXMlaWU+dJFOIxHc6/mHVVU0xZD1Z7zPBEaq2wYPB922ps0eAcyaJ9LlAGVUuEZal27ruFJcQGAeEI4LGtuxWF+r7QUCm+Mai5VVZcMv25QndRZsCRmNdZ5ab9a2zx72lrrBKI=;7:f9lYVpnJxHJH1jEXT2zjr0A9uGST3N0alFKw+rAjeLIP3Hgm9hAkrzNiDjJrm8NWBOVpvxagrn7qQo2pvK74dwwPxmiOCoqVR+jS962FEqMmMA39CUJwXJAT/m5UouYvBZl7StR1c7dR9iAAXs/gCcdjTucTYb+wmnYKra0uj04/jpMn1yY6x4Ej5XJY0kEHXaVNGJiQCAn/gCtzDfMGnQp6NWk37azxU0zzBAkwBo8wbE++LGstE6H5+DGet+8x
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 04:49:38.0744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec1784c-4091-4c73-5339-08d60efd2a0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4212
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

