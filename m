Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7868C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A82B20847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sBSticgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A82B20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeH2QwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:52:11 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:57440
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728483AbeH2QwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8lMrKi/+vt2xJ54YJ0QBIBy7vs8gaLUNa0N+REDGwI=;
 b=sBSticgTRMGX28mK58JlSstID1tmicEMCWCay/scZRaxyBZKfFf69XKUaTQ5SLT6ZESSGQYScBSzFDuUp2ytZOyNAL3y44zhrqBYA9LY9htktFiLmrF3ORGWEAzYl4FMb5rvwTtTvw9TPGABYgBeppvDDcUt0ewNEaT1m6c8hJw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 12:55:14 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH V4 1/4] clk: bulk: add of_clk_bulk_get()
Date:   Wed, 29 Aug 2018 20:51:37 +0800
Message-Id: <1535547100-25634-2-git-send-email-aisheng.dong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 696e3ce8-b44c-40c2-70a2-08d60daeac38
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;3:IYSOdWRiKLY4IGBk9Z0x6wqrgrXKQ8kGAvfgk/QSULAWmMZpfO1ii61mdGLyuZnoL3nPxrGdLFkAL3z3kC4acnvWaJBIO/Pt5y29YVmikR7Fsz5nxIRCmjY1xIojHQU0Bh7MtuxSjdOIjL2shFCUF7a2eZkMZGORnw2LLjjEpAoYiQRRFRwkngrQwqCFm2oYPQqmRFXTs/fGYw4SFE4sw4FP+IdVz4Wd0XcMkvdYKVthAscRVK/s/gZxNR7poBUP;25:hRQFsunOfkBGFYtiOVmOPLneqF1r8otsTEaq9VCp1Qdc2VMik2gR2WdMG0lT2lJIHOY1qyIcwB1yrzqIMnv7C7sWArVNc4JbdG6Old7aYk2Yy1AD4BQf5uosm2uWkW3zuq0RBoEQSxJHhcibo4955uQm2dGKwJUt00v9Hhr7KtUBt5B5Qu04rFqLUjOTrCIs72rpN8+OD/s7cvp55vRTeNcHdkgnKsheAab9HhQxsZ1WgzRCtpkzLm0tRDNXAxYSTATE63PTPgpn7Z6csIJ1YutLgK8pvlUlLPEwJE0Vi2n3IyYRSFlMyJd4/cl/wHlga3ehDL/+Qz/NM1RB/YPTvw==;31:0043i6W2p/zy1aJnGZrSa9012UHz8u40T3eL85EuBCUch/vw/8dilNt7aMh/vp7HwmL3aPbKSdkmt3rWMHcxz3bf7BG76lgjx4XP1InsxCE2kYYsn05XrsyYs2P8M1wiiHcl5i+kBMux6RAnO4/Q4T4om6vCieDUtl/3RY+duqEhQk/FLfHF9ZJQAL084c02Thy7hZPdEdc2kv4KV551W8j28IFzCWWQ6Q6m2TQRbfc=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;20:p3xxXGYYEyQXqdoECTgizVd5NXRO5FWKEwVxPMgv5P6H29zzb1Vq4jqkhfxJxVqcTKWWYyOvRc6CzwwvqNEcbdrf4+kxPFs02UDhNLfZilnpmXEOxYul+0kkCCp5T7nv/i1TjIsVFXSuThyc2mrt8h2PUqrZlUq7dzne7ke3M3YUnY8ihKPe/PlkYJhqGmOXBWHP1sJ8LZhwPTv1JflHy3QntqzAZmapQ9lymX9Tiskongu5LxK9fJX9m53RvemMF8ZpH6LdTnfnn0SoG/Tl96CEZ7Mw9akPn282KPeL5BfYBGFirl9M0zYvDSlCkZxyaXUEhdXwOmLkxaXj9xSwSpIiAmlKLcMwzVVAY9MhRzGL9E8YBVT3XGa5b41Dhcx0kbNvcP/DANu2pGfzQDr48g8F+D/OSzYhclT9wzLDPtuZrqjNCPm/Jbc5YFG13QFhbSIaHBcFfnzK+nhvDnTqyNwuAImOzL8anxIKPtrXg70zF9pxR6LZhLbZ9OaZXgLq;4:azHgoWbfRDdS1OsRgpEbcI2l0hKy9NuIvetpmarbkVXTQFrnb8tGDfa1fKfxLGTqFVDyZHw1Fh82Jl+Omf+9vKa8ZnUBuRkYuIBmdJGOWkK4BNZjtSncU8OLEQ686fdtFqMV6suIOp1Fq5lN3a559q8DTxFTk8x5vKQ2eRYQflS92nxUsfD79GW1qV61J+PQx01uJImB6Kh5YcjSbprJe9xjt+Nrciz94r28PTXkKyom+yb7AQ5FDEnmlJTWtDf1VdHKvmd7WXmjo6WBqtCpxPV2Pz/ccMOmEMeGCCqIfgIPuKlTlC3Xa4Xr2BwRUoAvobuIuulgs8uB7MP3lthmXucNr85n6cr2kz2BjlkIUW0=
X-Microsoft-Antispam-PRVS: <AM0PR04MB42110386D4ACFD071F56582680090@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(51416003)(50226002)(3846002)(6116002)(68736007)(2361001)(8676002)(50466002)(48376002)(2351001)(2906002)(97736004)(106356001)(105586002)(36756003)(8936002)(7736002)(305945005)(53936002)(6512007)(386003)(47776003)(81166006)(6506007)(6916009)(2616005)(4326008)(26005)(446003)(16526019)(66066001)(25786009)(956004)(81156014)(476003)(86362001)(186003)(76176011)(486006)(5660300001)(16586007)(316002)(478600001)(52116002)(54906003)(6486002)(11346002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4211;23:/mIHy8uvTFpufVyupmYSLZJQ6Tb9n2VchpJ5UyfF8?=
 =?us-ascii?Q?iS37rXbnfBbacLrnribJV38+GSpYhjY9Dag2Ta94yMhXJabjQj3iraK7uKkE?=
 =?us-ascii?Q?8GZKaD+6w38LzMptGfTkHQBu7X/T7w/kHAbigT+f7NKDHRiGmfrvGeTE8zor?=
 =?us-ascii?Q?qcnxXn1WRLH+FRTvqy74WWxhhBHSa0vLvxkWoDXAEX2BpXPr88tmILVEvPht?=
 =?us-ascii?Q?sexDbwVA4p+602iwapGgLe/iB7bA6coj8vya0y0WWDQL/qI7vvkDSnPAQiW6?=
 =?us-ascii?Q?/P9KoyM4FeTmU2jMTiqBY+T15dyFFFl8TqgrRyO4G6z0L9l0qdw9Be+E8iwD?=
 =?us-ascii?Q?CgKfY+uuGDj0sKZ5pnPBsjChrItdQYuuk5p0S3brU8cejCAXaxbmPMy4LO1Z?=
 =?us-ascii?Q?3oq7z/mmjPa/UWEa2JmJBix/+E4WKBzPO/DTev6YYC/SCFj9B7ir7vos6KAc?=
 =?us-ascii?Q?ajqBJWPIGD7rMUrlTq0K8UOSERNlg2ljC8nsm/1i+4nFzPz37jLjDnT8NchZ?=
 =?us-ascii?Q?IXeulSHSaqoDWqdWCN+FzCvnr7+xYfTKNb1wBgLGYAUjaZjuowrI3r65jQ57?=
 =?us-ascii?Q?Jel05IEQMi/D1CmuCucB2tJYamUyCWbfxjiZGfw77rTqk6V2bH86nskgnI4i?=
 =?us-ascii?Q?zrVpYRg1le7Zklg5UMIJzYT6SuK0YoFUVMd62IyyzAdFaiihFQMA75i7dyhI?=
 =?us-ascii?Q?5QwrYKsn7yvvsXNywHF5wwjgy0HaJPb80u6bHOxQjl0DjXY8uNQPwDZ+llOh?=
 =?us-ascii?Q?JoOWSFkPpJ+hyKgbvP/QYMJS4QBi8K+wPl8LcgJ7d+lDtW7XdQtZMK8aknj3?=
 =?us-ascii?Q?05QOabsHJXwG3tFK6IIdqCOBJako/UT88HFZ33qwCbxjJwYFzNlpmvZmclLd?=
 =?us-ascii?Q?Q1vZViE2/ACeJ/v/fEp8xJULI/mcOLmgne8AK7z7THAuUvnrr9rpPkzSppEE?=
 =?us-ascii?Q?/zbRnUdWf2YhSIH/GmyuU+y8iV46OyKK91lUGkQwXlbPCQBfMHU0A3T/cUXn?=
 =?us-ascii?Q?cYFQZ+rlSM88ptTCU1MxOOlybXiOcmZA3Y7xBd2sZPTG9DwgS+yXoTd8CstJ?=
 =?us-ascii?Q?TUKvIPDhsTvS7qzH23K58yDkvJ1gnqRUrl4EXQFtqyZOs+pHtE6ElDSR4Emw?=
 =?us-ascii?Q?s1wp3ddfZdJZxjsT3loORf1cNRjJ3k5u/OhuJyfTNjaJVIKfmjqnl7WZvlWa?=
 =?us-ascii?Q?KhPIDol0Uv0DjVMA9H2yNOEMOjgXxWnHujjQpm9AO7ziSTooouKXa2Lqg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: eHBlQW1OfyVN/s2X1gI01Yijs1c6Leovnpxakv8GsLH5NxnolyDndDmvh+QQNTP3i4obcI7NhE+eyTkAeRoCRf+73twjsVadQr9PHjy6Xcabu6+Le9Noc/K/25YBR2svBUnJHdPDrp26AGrOoVViNDjR1J6aNX6jBwOCDIeCB3nNfzlre6FFWg/tlHdzuidHB4Df/GCH6rGOJspgFPA+HNi3ZbPTdxKkT5ZEzxw6T+StJpgk3om2mKwhcfL4DDlBfo5SvZhTxI8eevEx2kmF54Ff4Ff2uE8iLZJk/UYOJx9UPg9GEhJqeeebkfd5VtkbOsbMjnQM5ichEQq6QMAPHM6MF1NlqE9bF0LFB2T+LNM=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;6:CFGLyN30MJpJtzK69B6cuJv4toptvguclRB1n2qy+Vzf1WrG36S8dzAb+fZ04nkbuO1oLsw/zo+trMgHjL8UCANdjn6iqCGOymqkqnGUPRbAqRuxpxrxFmnWslz3JXL8z+dSiUcsImTUS9RcEG76kEFbHo7Od4AVqZe6GGRG89T0i7XQJqj141+cpjf1FMZKlvnapMvnnftUI8gYHdXAK6z47AOLjCsq9bqAGF/NBAqDVhfeCByy5OfwsELl7yQ+C59/5JYp+TIFgXwXx7ylwc8KerEpU8z93e5rZcZmEc2P/62bUf0hnrf6JqC/DpnhZzPv1DnxIJDqAMRiNeTXbHJrTLdcHOJRTNe0s6mR/27wzaMP0EctjcoYd6WsX+N4oj/iNBqMXNo1Owo7pGZ2PJojf8XGeqHvjJI8zGdvx4BNh3zEojjqTzrUPmhXZhMq6wQSBzf3zIfyLHy/e6BMMQ==;5:NtfaG1jDNpGMGDdijW1YOWE5JnJe0ArTH1ALeqZv41RDOweel2PVeMPtCoRBQgg1QtBBJXWQA1eEen3xw3anJxq5vLkYEtDrTSuWsyrPSUAP++VswBJlb2G/Kcm3jEA5TVuUsThYG6GizSZ3sDUlkAopbRn/Jmqv75OtkPpj8uc=;7:MHGYoZLkZ/l9+4QOBs5l/eNKgPBG9LRQn+qNseN98YtLVFh9mtXZYE8o8//n46H7OS4Zel0HSEVQnI84garW6wVymq4VFgavvOn2YTp/4BLLtYZp0CxS37HNQeBl9PiRPhfsOrVQbzQiLDNrewiKmgLuS699x4NDpS9k2TyR+BJFgkpEBDfHenTq6B5AeZyi9EK2KH2JhCnO/Cd/InWdbGxQ/X3mHdJc4FJ18475mE2YEJuM8+yX7CbU7GdLW6Vm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 12:55:14.5604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696e3ce8-b44c-40c2-70a2-08d60daeac38
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
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

