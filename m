Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78BFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A73A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u+6NEH7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A73A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeHaIzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:55:13 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:42982
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbeHaIzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8lMrKi/+vt2xJ54YJ0QBIBy7vs8gaLUNa0N+REDGwI=;
 b=u+6NEH7Zr5SRGWO/XaG+8Pc/E0QQ63AsQolWsP2YzPoYSL+LCAzdkEhmaPXjlshRkL1QVZBPxqR5nyjq9pQcxBTpXTlxhNGoM8zX0k2jR/5hz9kS15pfsn40Ypm5C9b2D/hASz8MkbkHBsy5nHVt8B5pcYjIJ8RnGOiic1qztkQ=
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4212.eurprd04.prod.outlook.com (2603:10a6:208:66::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.18; Fri, 31 Aug 2018 04:49:29 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        hdegoede@redhat.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH V6 1/4] clk: bulk: add of_clk_bulk_get()
Date:   Fri, 31 Aug 2018 12:45:53 +0800
Message-Id: <1535690756-22234-2-git-send-email-aisheng.dong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 210ac8fc-ed9a-4f06-50b4-08d60efd2537
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4212;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;3:34JX+g54hAowwSSp6B2gWkZZdvsCiFTl++od2/nFqjZCAz9T/5F+xxA62vQ+u7DNciSWi9ILdAz1K3kLo+VqESxUJvBmGhaysTg9uR49pNIpSoi+ks+vqbhcbPvHMIyFLwNJruuO8GRAFYLTVkkKfhAUHrkYOulomB7e3IoVf3mADz3XNWC1QIz0yhyERr3PCp2OvSxAqleQ6DF8a2vHEfg/A41PjkZR26+Y0WXjycMW5mljMTb96X7Zk+dj04DB;25:So3a9E4g+fE5hGZx027Pq9TAFPJtBR21tK1iVWRgb2gfOnwWoSZQtXtQodJUYQax/HLZCnletYgVqvdwd5SmiLPDC1GEzXV6HNDNayM30i1QuAk1R6GYx9JiWiYVYs5jDmLbzZDFwKPYBkkuVPMZ0kL9P7XpIc44Djvzdu2MfCun6iiFbU8fKLI12ND6KA2epcpn6ht03cGwQqpjM5npsbhK2QvlhNzU2bTqgwseYPhtGpuL7djAk0BaSYnhK68fTQiSFGpkdQMAmLG4czobQUmCE6wI2W3hRP3Z1Hz/IUHJvU7iX2xzfsXVLYL8lLCiclV0/+gBSRzxm1whc7lpCQ==;31:jH8vk+VzlOJNep4/g2zRXhnZnQ25cnfASYVu1ftVdLZabdyaVkgJ0wUoWwDccqva1Lk6GpoWp2IihZ5IE4SHwRDxXgxpDperk2iHTMYWQIDJLTJF7Y3eOJU3q8RB725mQVv4UyVgKfpgvKtSiWOolcEWN1liUfy5vrQBTxC4K4jm/N0r9brKhu7G9t1ImyIwkDIl2kSmS26niWkrQBL1H0b2wn3tKjwHWqg+8JgMl34=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4212:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;20:mJFtbdPYRNEmDxvoxW8sIfsPncOLecA1YYsQ44jKNFrExpGIEPdp8U+X5iX4t0V60j/HZC61kmRrRy/x//dg+31nYx4lnBey9niWNx2+HxitOy+myWbZRfqfsZi0f9lYTYj/1xMBJ8vyugjGhg6yiAhXyXqEBKzrCWjS0FTC/yPJ0D9+WGGWdQZ2JbddkMKDmUUhzG/1tAfOu79HIXNDmkbmI90kEuGKPAWiI2b/QcdiiE+szq1d8DZC6ah6gk9BBrBdj99nFiwoXHKssQr7WcBPCcU2r73c6+3F2XBKcmmZ4zrydj5d3PGpiA50jVWC80STY+RxOvhZjMkHuY4uD90qIQB/6y+1r6Y7FAzD7mO/CYAdc402xS2zUMnGo2Dx6tzrX+/YerO8vku0xtKWpyBqmhk0IGBnaAod0xEQs8gS+BfBl7aCypHzVIPIOHag36Cqe7nYlZxVWWowwGzPaYvkWNxNmhHmof6VPit9iYcdZRgUO3SkqsxSWC9teqCx;4:PmW4f9pJwhOlQ0Ui2vD09qEjNURhm/2QlXY6S1KXX/wHq/HKy8tkCixFe4WBQDyXIsi4qlkNxcO/ZelV/5Oqetwxd4eLqO52HDIOFm3AaOxWvfJIBJrphOny+BiExzcka5Ow4t3pGtFMlEg5iz9qfMazvr5xRKBtNZgdeKYIK6WrBi2afivy4l98Gp2YOcI8p9sRvaFHMsjelgDF8rMqbJ5+Y7oFngPZdRuo1s2w2TkqkYWctqh+rl653Roqs9h0jCmwH3lzC+BFFABsxoUXC3tMmdrq/C8RG3/Ml5PjmSSN+KKnv9C0BKbGwn9Hxf63kKytSwU5OBXtdK8QtG7CD35QmLGZxg8a+/kNW6+fa6I=
X-Microsoft-Antispam-PRVS: <AM0PR04MB4212DF6754827958E630B375800F0@AM0PR04MB4212.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4212;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4212;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(5660300001)(26005)(52116002)(186003)(47776003)(16526019)(2351001)(2906002)(6666003)(386003)(6506007)(51416003)(76176011)(446003)(11346002)(53936002)(2616005)(105586002)(486006)(25786009)(4326008)(6512007)(476003)(956004)(36756003)(66066001)(478600001)(86362001)(6486002)(106356001)(316002)(16586007)(6116002)(3846002)(50466002)(54906003)(2361001)(81156014)(48376002)(7736002)(97736004)(305945005)(50226002)(7416002)(81166006)(6916009)(8936002)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4212;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4212;23:/0d+WHTBrNMP607HtM+xhJIcQnyPeARm32JCpF9OU?=
 =?us-ascii?Q?VEjDlCa7pcSGPfcTqC/VS4Dz2+6Ps29oxLXWl4mCDu9GzoigtGhgz0v0f+DN?=
 =?us-ascii?Q?mPNo7iOClCyXsykEL50D6gj91l/mZSEpEsk0wMl6Ifel7lqY8WCTXFMLaIUD?=
 =?us-ascii?Q?kGQKgteFlilJiMTgoctmtK5WWQofRqNRzlqiPH3J5OXbdqF35KTQ0bcGDgaQ?=
 =?us-ascii?Q?BQCQgCUYyZTH2jjIzdy9eUJDqntTBO0KhMvauattKbl4L5LoFepChhee2UxB?=
 =?us-ascii?Q?Xy6O6R1MalbUBVE0udZyG9OoAb3LrV8Ml43Smd/K5KNP5/uoWWIVmCrD3hQB?=
 =?us-ascii?Q?oMo0l21chdFFPHcWk6nLnmZwITrqDBoVnO1Gq578to9nP33LcOoJSIBgrFJ+?=
 =?us-ascii?Q?3RYHt8Xgt1/s2ByQMeWF4ntJXKvxtA7HDCnDKX6TvNGMGzZFU56PEfipEFNz?=
 =?us-ascii?Q?H5J7CiwN2R4xaQR/eCoWCdNA3/Z3+1Lohv8sX02y0k4r05tbY186K/p9g5Dm?=
 =?us-ascii?Q?heCc3ZCedufX9BKuPDvJqJpLOegtOZwiDzDHPPYgU2FobJdpY45OP26U/HSm?=
 =?us-ascii?Q?ZUGaw3CJVCxUb1s2tnfi8qRZ9S824ThrAmu9lHEYMJky98hxDRvoK+hlAslt?=
 =?us-ascii?Q?kLkVTFK8tV4YNCCg0IY/HxpUKBAu9PYV8OVq6IzzaHWYNvtEM38Dz7NZ4cQr?=
 =?us-ascii?Q?bW4RybGwYHQRz26rsZakX+2QdmuQwpM7LSAbST35Cllm9Dx1wY4UJrBrF6kT?=
 =?us-ascii?Q?awRp6lGuRvA+C2Wz1igR5L2CnL/fR8jj/zcz+BVG+rjD3kdjERRjIJHuF/PP?=
 =?us-ascii?Q?X03Xg2wCVe5Ao9Cz4dAdMEzgsPYsg5Z2ttwcXuTdy9OkOWAKrPiCvk+SvA7o?=
 =?us-ascii?Q?M1euBkAqsSYLqA/IRHPul8pOgu/w3IE9/q5bVQtpghYijNGPfxtuodA+1EFP?=
 =?us-ascii?Q?iDEpfYUJrwXRWuGYzmeoz6cGxFM9SahHx47wqsnwXmjwfek+3Q9k/mDG0ZtY?=
 =?us-ascii?Q?YC6cJ8+Eh+v20XoOfzBQcpst8U8H1sqzO9vNUgVPP3hCwThJ9VKy6NRD19Ph?=
 =?us-ascii?Q?3aljyS3mgxuYZCn71N7Ie1K08+cr0VsnQ+m03PP4RAzYS7qoA7rhnEP99rRw?=
 =?us-ascii?Q?O4iUU34gVLOXX6UM2pB/qkGaSAHhNyHPBdtUiKrFVaeackSWCPESBfaMI/JC?=
 =?us-ascii?Q?SiqaKQKcE9RbRWeU8VEMg+4FrEQ+wqTT9IuT+B7ze3dcQA5qq9PqhbGooLYP?=
 =?us-ascii?Q?mDvNkW7jT7IBKqz3mQ=3D?=
X-Microsoft-Antispam-Message-Info: HuC6wqXTpk4FXGXe2PD6PPS/FqVgFrwSfCQuo2xCVAySa30YPMIYVi+svrowLJ1z4s30sJbpKhF1RwjMuM3CWQkxPuV4/wXa7xd65yqOrSjwi/C4KWm7P7xQnVXBU14yc6S3/ffcsKmeBD4C7vGXJ/CZaCDexcnfdjmOQy4fipuKfEcIKTjLfBiQqYbz8cTa6ny4COBLEf9LIv75+SCfjxJzT9NOY/soGLKz6iz//GmCrgb12z+fi7kxSX+CatH+67hCvdCpt8GRbilpFZLYrt8FHrcA30iq8cC9lphXtoFqI45h9CMWZV00vKvZQ+NcMLQFCHvcpBfF0sbGrK2YHiFDNJJOT0FYJg0o3Q1HMN0=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;6:5QO9Vc29oZ2eWeqEycCu6K2nSe2zYf6pANKlmLTkTc86aXtTuXDEjApfLv2AH5njoq5dxuKgWHMlr5EctN1lCykc8Ed7ToO9/iQKHU6ITLRhODkuWiVf7vRjwlkZ88oJegPJhjtulzmdNmOm7N0f/9I6vqqii8/iQAe1fp9O0l3ReXsDAIQu2D75tsaC1qRo89VX5S9NXt6oVNr3ydxkadXMpzSOWRLrEhpDncKDmG/R4IeScvumsPMW4+O34TiMO3pcKB72rBW41mjmKTV3Jp+lnooG0+ugnyPBhS+7fH52J9XXnNDxJYnd0wJj7FpngXVYE/Hg6OC2F0pd3gWcvoBD8dnCZ8u8zRxQlQ+y85U+NHpTfjVmIV3/VDdefW+aKMPEtoYiXMvsL5zXQ0II+aNXo7ENgLnVRzNoiNiZqHjwdGG3YNF8mEPP4NbiP+ykcbpIc5MYPjN9MeOU8G5Lww==;5:1BYVyL4qZVFYusThAeeOBv2xMLiMMGBFcEMmpxtcKMpitkWW1z0oV1PIbQd93rvo9aklAjYamiime2p+Ddvh45zEyLs3nm4VRyuK02FDsPKJOAS4F3uU7ODjwMUj7gnHsWpepJeMXiUAgRCCRxv+E00BjnQo3k+t7bn36oDA2T0=;7:NBVy4ErDi2DP5mIJaMxqO45RdFtDZMADF4zSDOMazaFqHBn61q0LIq8XpQ7jlHpgfcILf3MiXHI7C95yt/v5+80k49imt9saGRCsFmoOHq8bghAXu4ucSPwPCukc/7fWYwaNG5/yvVNdgJJ+5qVXtm2vHXtt72m3Pl/Vk5BCMd08jTq+Km8lIEJ+TD7LUArYC++kxpOkXPatWLf8XNFn7mhNLyRnCfxO+rVhUbZMH0CrMswcCWNGu3erxtzatgsl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 04:49:29.7150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 210ac8fc-ed9a-4f06-50b4-08d60efd2537
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clock-names' property is optional in DT, so of_clk_bulk_get() is
introduced here to handle this for DT users without 'clock-names'
specified. Later clk_bulk_get_all() will be implemented on top of
it and this API will be kept private until someone proves they need
it because they don't have a struct device pointer.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Shawn Guo <shawnguo@kernel.org>
Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v3->v4:
 * no changes
v2->v3:
 * remove #if define condition
 * remove EXPORT_SYMBOL
---
 drivers/clk/clk-bulk.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 6904ed6..4460ac5 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -19,6 +19,35 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/of.h>
+
+static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
+					struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clks[i].clk = NULL;
+
+	for (i = 0; i < num_clks; i++) {
+		clks[i].clk = of_clk_get(np, i);
+		if (IS_ERR(clks[i].clk)) {
+			ret = PTR_ERR(clks[i].clk);
+			pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
+			       np, i, ret);
+			clks[i].clk = NULL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	clk_bulk_put(i, clks);
+
+	return ret;
+}
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
-- 
2.7.4

