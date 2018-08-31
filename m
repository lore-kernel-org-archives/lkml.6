Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD2220661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aGiyY93U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD2220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHaIzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:55:17 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:11232
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbeHaIzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw9+YfSA6MDu1qVOhtAIGv4iDtfo3XsUT5Y+EGVeicw=;
 b=aGiyY93UrBqIa/C5s/6WSsvNbUkBAz9BNS8BsEMCTO/PlbQjk/YPccxHC83mtyrUVjPKyo4OqyvvS6H9ifHS4BcYaQCLw+rolguKTJIO/twAL2vVfp/76+DrETy74Cr+kFmAVpUzGbQ/SNgxy5qkcJiaSBcjg4xL8VbaqhAeLwo=
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4212.eurprd04.prod.outlook.com (2603:10a6:208:66::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.18; Fri, 31 Aug 2018 04:49:33 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        hdegoede@redhat.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH V6 2/4] clk: add new APIs to operate on all available clocks
Date:   Fri, 31 Aug 2018 12:45:54 +0800
Message-Id: <1535690756-22234-3-git-send-email-aisheng.dong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e4dc8375-e66b-4290-96a8-08d60efd27a5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4212;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;3:vsR42QjYCeb2B5EWlpSueHHlHUzejhfHc+gEl9g1B3AcgaRiXl6rXOauPq/vUEmT5cXJVzURC3Clr4SFxyuKCmWw8qRQ/ROxz1r3Wy9DzP8joeHxuGHsqKfk3FmRB0bl2oL0owNouwyYAVH7jlxD6abKkrdBqlyq7b+hzcZsnv1oZbfuOBBh7o93ZrlG3DRkggK/rBnu4BDmall4R8IhL1MOkaA8Q3FtFEGu0jSNx9oqmlo38wQeR0nsfWSeABKn;25:Fd/N7LLxgIghDcqfvCxkq/Qb5DUeSzcYRdESkkkwyqs1MnIrjo13+0sQ7G93yj7kNfE84TZ6BSB58sDyuFXFw/21hZrAf987szCtHm9ndjXXOgncYpKhCtZru7V7MnJqNAw3+Vd9dp9ElHyAkMOT3lmIkoKoHmMLQBCYKY57/orShyInehF1jhbQueM6y6EZXfonYwfGWhhN2lYXwgA1SzzfO4zGgBEx7C9E3SV9D67/xZKC1H445imy2t3MMgFluYsJrd/heg1bAWkG+aSLf4piudrDz9olvX0BDN2mK/isLd7drq9/GmndBZtfM8VTYEWsPP6pjpmkvMLXCHGFhg==;31:LBQrH+WBcq4fvQOyh3PoQrv3ui/+EGyZbBpw//OxV9FREsmHu3PeCtGnItuQip1CKNtGmeRQcLoJSl2UkxqZsRA1UfudCXeG8wBKNb198RFuYI9niU1y9dXXwz6AZE3LEmkA/a/C3vSrOjOt7JPOPM9gt1aBNW+7I44Yyct6UPLwRwm9O64+pdFTyutFQPwVOXxNZZ5vfiqd2O4AuT3nMRizfhG8FDt6QXmDIAtf26k=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4212:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;20:6tG7GyRcFxlT/Kuk9fiIKxJ4u8DLgzzJrtL/zKlA2VvRgmpXXKmBFL3/y/nFMx5buMJFNw07MjxFwBolSxW/mdgedvTgeH0k7bXWuy7/l2ZBesuBOFLIXxGjd2QlreWkPLH15rdQX2ckkk4UKMyCjOZHQPEsXC6AvDlzxOCug4Y8xaOx3T2VrKTPQbwSIr6mKatko/jMeoo/YwIslsLm+G+8669OrVOxw0YD8rODYREkayvDw3OvhoMw869yT1Gjnn5sH0AFJdYvLrJzDpM6aoGm+yk+koEYTfhfSgeYYl/QUxSD6+bpPdQFrSnGPIE3QvDqzRAe7irLOwxoZX2vsvl6cE5KcJVZ2Iyp593JqP4KG4uyx0V2rOPRAa0fWfFdSeEAIMIE38YCmTuYd1JRCPG6mM4wG0EEjy297gEo7OKqki4LvFxUt+g0eeC8qDid2rtL+QKCcp8EQFwoniGqZ9MKITgVxfhsws6H+ag3qIyr6fr/ltgNwsktguCheIu1;4:Z5OtRLMcmw8mTsvUIbxQTt/KxlXR+r4W9UO28YQ672Ro/LBY4PlJqsPE2z7uYbliEbD/YYb+B8FoyHzvbAUHs6vIywOfbF0H66PNiYFdI8DStEGROGM61fEQXdu7vxiRS27j0LbpF4JOj6i6t+WIEE2OYDl/k09L+OCSvFOrs26pGlpB2o6wvOjtplp5WIBo2Xx/OLlveA9iROGWRgVu+ntMUOb0kI0NKPkPWG8C6oo9xdq66aq16g5JepExwxHqGgdKf1Z8MXXEwqc/Bry6JGUwstJxSZpNkG2qJu4xVud9sGDYyYKbWejD2XjhdxLv/p3gB+oldTHCcJk2+efbAHUtB8/LMjbPmlegb9C2oIU=
X-Microsoft-Antispam-PRVS: <AM0PR04MB4212083D06017210149223ED800F0@AM0PR04MB4212.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4212;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4212;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(5660300001)(26005)(52116002)(186003)(47776003)(16526019)(2351001)(2906002)(6666003)(386003)(6506007)(51416003)(76176011)(446003)(11346002)(53936002)(2616005)(105586002)(14444005)(486006)(25786009)(4326008)(6512007)(476003)(956004)(36756003)(66066001)(478600001)(86362001)(6486002)(106356001)(316002)(16586007)(6116002)(3846002)(50466002)(54906003)(2361001)(81156014)(48376002)(7736002)(97736004)(305945005)(50226002)(7416002)(81166006)(6916009)(8936002)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4212;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4212;23:/6vqMsdSMNQ3CAwXz9y37ccyHRPDoh5rR6qJCVZIG?=
 =?us-ascii?Q?n/vaOERzfT3bEFrUkamOvhEswu2s0dXcZde95mnVBa+dRjuExh/EwPiagsiu?=
 =?us-ascii?Q?LHx4UdAK8a/fEzQT9Q8Ito2AsQbgTQVDkpj1nUsZgr7KAB+eTYhcMHRQOZK1?=
 =?us-ascii?Q?qFXgCxXApklsjCiJXqWfGmXH2OyJPlmaMdFAuaoUieBlZK7tw9wAdC3b+dq4?=
 =?us-ascii?Q?bDVCBwjRNFWpqAtPYvJrFXZUnKYJ9Ryr1mlOHMI5nB55MuLY1PkLJOfdWKn2?=
 =?us-ascii?Q?MHkVwFJhuCnb2cmzym2rCG+OgE6hHIoRCmub4dGTmM4dMziXGs8tWR4ISosm?=
 =?us-ascii?Q?0gutUaPKkcwu0k7MGcGcDE6xtaxwasdRFe/xjisxQ6YO5906QEeXyTg1zho9?=
 =?us-ascii?Q?H41fIlqXZapg/JAJEN+Ey6u/xergMGkkIPrhEgvxhsYdGGS3ta8mYHz1Nd4W?=
 =?us-ascii?Q?4OcOJ5oQj/Fo2O61rKLGKAmVrlLVbgGK2j8mnuU26nnnowZwtpBzCzyPB8Qy?=
 =?us-ascii?Q?/0BZ1yHuNoxoIor1gNxMrBarKTrBsD7CnepmYvhFRkt7p779TcBMiKTs6SEO?=
 =?us-ascii?Q?W3cJ1ECS72zN3IvMO7vo+BW8TUQU4kgHcmboRio3IDQFYQa/56XuM+/f2Jyh?=
 =?us-ascii?Q?alGPw/jTkEu08acqmpw/UFv3afsk9JIP+TKkufHTrJY3cCr0smNYp1dlr3yn?=
 =?us-ascii?Q?JEb2fVz8MiR6+Cf50AyXVtFKaz7FE+bbHTnliKSffWEZ0XHgx+QyB+SHarph?=
 =?us-ascii?Q?S4oVgkOgFI/7Kx3VhYj+EwWfO9F7MQf88wxNCVpAJw8NvqkUVpc0ml1Spg/y?=
 =?us-ascii?Q?TAKgYq0V/qjAduWW7J1lyrOHGOy0HviHcgTJ7+DfP97FZY/kMwImjvqOHoXZ?=
 =?us-ascii?Q?LfK977lZUs80X0vf6OaGiigFNAT97Kf0INzIckLRHsgHn6wSGiBZHDkOJSHe?=
 =?us-ascii?Q?wEiO71qmfWM10yfoggDA+I48BvnpZc5yIQznp6tmTZvSyul9gSjL3iOMvivg?=
 =?us-ascii?Q?4ZUndLW9GPjpVf9ovsRMXgohlzI9cYIunGT+ubDAIOX7LoaI4Z90PjVjh2QL?=
 =?us-ascii?Q?zF7EbHwnOZT8YILqVAWu0mCrT3ltgswB4D2wF2z8JlYytqTIbvTEv9p5Hc4M?=
 =?us-ascii?Q?AvJ/iUEQi8KN0ErVUcLM5mO1IiOcaHcvlnBt5VtzmUEp2tORRROxwH68+M40?=
 =?us-ascii?Q?Jsr2WeZiQGKITC3l0wmBYphwMOQahRwlizjLXfnpQuQupzd6I55Lo7MO05F3?=
 =?us-ascii?Q?YPh9o43E+NAM52odI/DHy4PNDOHNSTQkXaLb/sy?=
X-Microsoft-Antispam-Message-Info: eyX8XMf89nv9WUxHtjf1k9g/NU6JcEiE/OKXQIbOngasBhS9e/qEqNHL2xqB+SfMxpYwulMtQ7+ko1+tpPTNvhyjaTnQD5Ztl+TX92VhnzPN1ve/O3jigMcT4/5YSPhC2q3o6AoSK13tzzjDgcYklFK+vhgGBPs2Ak6kwaRd3mlvJBkMXCuZiIcRCNU4AX8wLNqmQqygwrPMsucEP1a6hJtKEoVAizOxJeQP77s2M1/c4zdv0MKgPZpUrBeDBBFw4Wbrwqsr9a1BWgIFOLuA5j23vLQeB/n/dh4XCglVcya80bx4gXDgdZsXHC1zSNnVjaELZTBe4xaKfjz7SECo15KXvL1u6tAwIa5bt36Yoo0=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;6:otEgohh9hVB/3G+a4IXNRDbT7/gMuhu1VlSszJ44YFNw6Gu1DLOTXa2IZ1UbTO1UW/E0no19W8dReS/uvWzeNujpBrnwnW1sT/jYiobC34/FkTdlnmXWi1KyHykF3MTwtBsBUIAZoZ9sCeM5rDKDGVIos0wMLC4JSC4zGKUfU+E28yIc91Hgl1BpwaKkrs1c0toQa+ZoFgMZbXoy35F0caZQrjnQIPHvp8dugy74AaNME5ikkMRiBdk2dvf1SNRHrjGNK5jt4evVrE6hWKLnUKtoAWhKRMD4nshTzuf7fpynP8DvQzi2fkmmJu0uKEaMQsSGSaCMwJDxvh15cjozi5KF9QgWje6BI1Hlrjli3ddXxqfl5AzuEBcmoBZz940zJJOq+/LZn/nJBV96mD7tPt+g2EZR4YUhh7sq8zCXggMTeCqRA0e4Fjt7OUisKCPM37rfDZuMaFKHThO8tzd5tA==;5:VjqNCjQbCuawmWIRWq0fIP5u8oc2CFOLS66USr1D1vnVsNEJMhB4NfYegqCTkppBKyU40nrSk5QrIGZW4ILtspTYdI0VEsDZYJU/zwx6poPmfAZWgAbMBLamc9WUkev/OCVLGvOUZygk8vKJmBNgM4gtQ6TSZJPQiswId87jb3M=;7:jWL5mAgzivfl8rVY17yZk7SJ4IA07Yb0xD4HntVqm7oiXBE94m+CaqmX3KttUYX+F9kTL2rSulkWTSFEf4bUdA8qDhMXuSClR+PSRmiBMzkk4vs2XZKvKTw2zkVJQ84lKay1Lmxxvmc72cIaKZ2VilG2xtM5Va4093PXBq1UEsz6pIpGE59XO2EjCLLrrsD/wfvGcTJKapj79nd3QAPGivmsgWEwcyLaGvWyFh3YQsPP+mdWrCOdgqBAeVCxrSVE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 04:49:33.8088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dc8375-e66b-4290-96a8-08d60efd27a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4212
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

