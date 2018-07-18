Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250F0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16582075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0jvawnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16582075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeGROSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:38 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:46816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731656AbeGROSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3kMjv0swVoc/Y/kaVblKT/y9iys7V4bYCBZAm/oRAo=;
 b=H0jvawnMxrJtgl4nGEzpPKagg+Ww0zAcZKfqjhKMAn0z2YfrOqjlTxuhZe3R7GJ4CXZGhU1VMtK74BVRVNHjZlje8Cs1vT8kAI95vTh3traxwlxZKymMMfOzj/jntc6qWJHKOhewjQCB8kSe09JAeLodK2UGeqkUH6Pl1qaVU1k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:40:26 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V4 8/9] clk: imx: implement new clk_hw based APIs
Date:   Wed, 18 Jul 2018 21:37:02 +0800
Message-Id: <1531921023-18497-9-git-send-email-aisheng.dong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2394d81f-b4c6-48a4-d71b-08d5ecb4074c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:qPkcRwJSIZdpw/ETCkjwIKqk3MqrI2fYK6dZvPkuIFTDnK1dm9ercMVQTDTv5PA+yDT7KfvMnSIsOMv/Kq8iLH2ImKHguJ47RJCeYs5ThvVgfY6aucRn6Yy7dRineHlCmephyDL+A7mFuSKp3z7L45c4EdfVFCFrZUo43Ia1FlfVE7ffCOYsrXEW/eh7cEPN/0Xh761BdAVMHH4JPWAN/+yXs7ki0T9b+RGj8UqZIFn6N+iIlWx7VyYeJQSpurRd;25:9Bvs0gS41fqWLFEjU3DEU8Ha8U5MSHAiJao/abVT7j5tsTwMDC9548eLRnZxlT7JOBPiibXYkzulLLcTwwBZx1MhIThEi8jwkfDaUj/f54R/zf9jpq3zGqlYNhnuBu+KfOEkCLU2pbR/WDmY8VG584Pu6Td7JkUaWABZZg66Q3PMv3u4YFk5EiyCOYXSo3/v1v7tnYY/r/3RMmVY91jv3vQLOmks+1FnC0npLxPyxVEYEv86JpCAcYask+snwIsi/PKscp0/vLFQZqVb0oS8tAlfAVDDh/3IhHAcA6BDSloFTFgnr6gI1Lc2+UdqNsBWLn9q3qf3LhKGaSC30eMV+w==;31:RMta3YAwaaZKAVuKSWQ71U0ZprnA06RSZnDavSvJg+jFQ03oKYBp8+bjlRX8eyob7fTeeBD3JsAwMt7TUEyhViAY+euT4XWYBGrbScYbKqleWiWOdH1UDYUq8zzBXmzgTQ1zpC/XRXdCpNZMyBTfGdtDJG7ADePfWfMbeQKcNJO4J/gjy+xHsgZ+ZOxyQ0+GycF1wnkJCMZwUy0bSAvAlZ4XjSeSPL0IXZxh37X1zd4=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:hMw04xtCFlvKrVtfcTYh09Wo9ne4UX9Ugcdp2u6iSJN0DqYyc6RDCMm6wGrmoY3avUQVZtSwJ1zaf+1P3jieW/D/shlNLNpa3t+zryImjgGls+Z2LjWLZfnl9ihs2UOUdlKv05CwdrXuGjEfNQUp5vRo2x/GLPYnSH6mBqGlYIKEv4Wa9+O8xxp1j9F/OB5i39bxKLiymMSfMqZcgeMBtn7/KsOdqEEiylJGj0uwcHPZjLzKTc0BFelLs4+40fHViKsfD+UF70BZX8sudYMnfvtHPkM5FhxJR4vuu7YX2SypUXwaFOKHTGA6/V6173IKzsyqaMBD0Mrku5mEQzATx9V47DoKigPYsmCCpS6xiFHbl77On0I02R6rQua8+tUUwX+hRDaIpLjF4Gm/rcKi+OqK6pD24qxTU+pB8XFDxmYiIi36m990jNPZ2sitEQfVTUCnfempFJqWglz07NBL6SgcZwHnEwXncGCGqv0Tw4t8fg+1cMVGo5nXKLTirMnu;4:1O6LPuK6uNNgTRpwIPeIyOVkUbGTjvS+7v7PFZ1V9MkNsfjaJHllF5qALbNfiCKl367pXZCvwZ9hugIhpJUd+kdxyhK8mg/OhlYHKMC0a5R6YFSUQUP8LXywFyvipT9I7D+wCD0oAgGeBb2QaPU/JOxWIEdO7bYtXksCXJF9EevNsYysbmGoxLUuDb+C04YJfdtybbH4P6PMaFimVIKIbNR7UzqlQgWU5eQejPwDr4SgPgV3StcsYRXY6oBiB4CvdE9lW22VVzBa+3fmEMxwizqZUQf6mx1/0wEgA5Jq+NJkPlDbCJJdBirQ2aNPdIlh
X-Microsoft-Antispam-PRVS: <DB7PR04MB42190272789326FCB072691580530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(14444005)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(86362001)(446003)(36756003)(16586007)(25786009)(6666003)(81166006)(6916009)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:v7/byIMEQ5oUq7bK9mbwgcu3Im28c+k6dPkpw7l28?=
 =?us-ascii?Q?Lv/CdvkuMj4Qx85F7PYO/PhL1mdyCEovFaTBq2AaDfvRYu1STuVEJ8qNBX67?=
 =?us-ascii?Q?0gOUU876AOrBB4dIhmCXOxXEm/Z18ULTS3cylZQTGRDePrejsZR/dp3YwXGb?=
 =?us-ascii?Q?UiXiTjsJbVFPevwKO/3x7H2xrmwsShBAHSaammV/QQQ6DoSYXutpzbjwFcbF?=
 =?us-ascii?Q?ocPgXWhBtpR2PO+nZIAWDQ12Y9q2otzo5H5+L89U/cA9W2mWUn3anawP3pi8?=
 =?us-ascii?Q?4Ebdu/a2a/zL7RlW88sIYK9o6/TZQDN3yV3aJ9MmW8HmEwI1y9XhBjb2vaFV?=
 =?us-ascii?Q?NW35VHGc45HYh3YKmuriIxlwlqDFaj2q4y81KKHNo5g+MSmzKYYqdB1iCzLO?=
 =?us-ascii?Q?ekFjfdtbCrNKi7meQSvN61+XV5Mrc6KvM+2xf2WZeyLLnpbrGUaf+YHBbcis?=
 =?us-ascii?Q?gpCQosMHWOZEN3U0fOiqRjB7NkUnc4js/EHvrN1b5FSGVnQTJewE7RG67u6b?=
 =?us-ascii?Q?6L+B14bwznfUfOqiL7FGvAKW73aqwcxASHi6izgPE63MK+wmVwBpC87+m2/M?=
 =?us-ascii?Q?4xf9dffJnlDe+P4YWaL2Wji61ungFrUfq5IQSTczsR3g8+SFl58pSs4Tac9n?=
 =?us-ascii?Q?xRL7OzsYuP1oYFSzVjZDU08a4ZO6i4uN+nLvqtun+3mqi5aT4tI70CdMF3by?=
 =?us-ascii?Q?sKsHpefDvhdbo3IOwb4tcAEsiGq7VjwpDGFwv4ZggUhVe1NO+O3McwaKI5jK?=
 =?us-ascii?Q?fAy+uEaObpEMPfnEpu90xnh56ZkqvbE1tAOuJ5xyrsTZ1qFM+ROEOaap6SxK?=
 =?us-ascii?Q?FyeScs/pSYrWPqOaDA+f6gfCyo8sh6IccghMIsz0CWlzVWTFZ2I3dPLBxdQf?=
 =?us-ascii?Q?ydrtDCPT9ViJauSJlyk5gkFbaOGZ5B26cA68Mh6SYR/T3Rr6c5GsI4mFbRea?=
 =?us-ascii?Q?Z90E1xHprZ29OGO51RTSBFycPtJJZKT+Y5BTAdYtw0VNngfYJgOeH3ceLXPl?=
 =?us-ascii?Q?5hX/EMemLa9s8fyNS91uGRS2QWEbIabm9xssEDro1pnqCHKGBrPoJ8rOwbZA?=
 =?us-ascii?Q?M21NADAD8A0gHZn8EB1BgttZMibcp/M/Sbwq2A5F1WvWh4skwpNJTfw2SjyR?=
 =?us-ascii?Q?U8uWtCsFJLNwFPcYfL0YUGfR3PdR22lV96Srmn/Vz9/XDA0KFuE3eBKUYmXM?=
 =?us-ascii?Q?KejX3rjg6vJLESeZ2C1m4P321j3X9M8+s+NgllVXwbHePmY40GFMoQhxB1z8?=
 =?us-ascii?Q?l0gOvew/anqMoQhtUo=3D?=
X-Microsoft-Antispam-Message-Info: +UPM0E+FKA4tQNGP/SFM4Gs5NBZL/npVn5V+dXWXpbRf6XwS1lIVeooNHg/6xC/IeVqwahgEWTIKDZAlUgK+3rWJP4K7Jg8/5/KWuJMwTfJB8jRkROOYXz9bgnH6ov97pcxF+wmdViGNxOGaBmDiT1XUHbbCyU7o02e93HQOK1Z7CJP9Y3wqT4VwSWFc3U8bkH9OTFcrVONaOT05IAR3btqj1ap+uPD6GNzK6yH0eCpsa+lld7HKMWXBJ4/xKVIMChYRjNnO8yQh0lbH2EA1WxTgo6Xbz548RHpX8ah3Tt3xrSFD9SPcYSQY8O/n/1+FON9r5sQgRlkl80ETQEPjNYEfhRZMsLqsRek2skLnPao=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:r1meVB9pm0YJGst2+fvWFxTLkdsoStkOc40HFCt3JvERPBG2Pyf0V5fYvx2yU/XnVRhDqoMV63yDKwq0FAXNcpZJFjB5zjDbIi2il/vIKYaX+URhM48WjGhh0dU4FUYBm+zxUvRM5+XA45yPISCZqw4awXL7nWcZxsMjYcvecxnzq99SwA6GL0oMeMkEca0C45FwO0AxcGtU6A5/rALXa6lyjLEjRxEb/OoZlL8XBJAI97B62DjdfeseMo8Qp77nF/bjq1G2TYwjRd9UmoKH81UcN21gGeNhvjYvSdfpcQrrDDmaqauzMbl8kMz7biOfTs5nJyHxyfF/71VKkwhaQVFCa1aPKJYiCSoSd5oS9HBstqIYm2hwMRFTkFfx9LI5vvzCNport232QWnKYpCWDkJbsHwFH8s259XAhNONcLy/sqY7Gif0bHRfkjptqP9Yg9jl2ch+sPpr7W3myaLaVQ==;5:rpRvSxQLEwWWL4Z1eyVF2rGPT67h0jLsLUmzUH+NIVUiFhkHZEU4CYR0mW0x1JeH7kgapwfkbaKY9qiThqFQYUb+EPuZ3RtTf9IgKFwQ1QK5KapfWvUO4j1swhvJuLjdY5W69/4Fqb2ZJ3RYXLnUGC7p2E9SZjMa+9HkWJcvCNs=;24:fsP8jH6i7fU6ztHEWG/4caC34tG8K0ROP2SHGVHvGUeoAJpEG1p1X2IPnBcwOOaFUdANXkJCEDNO5LFUezlL400MOSrlehYx8AM0YCpxlN0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:jY52cvmplhdQOfXcLFv55+bj6gKxW5vkFzwEMnGTqhBaoyq1pyKdxbtpUMaZVMpZuo64rS5l5uf2QJqC9tD9q5BrNCSZgtizPgkmVFb/WpO9IwXLS8fUn64VViwsd2G+uuhV69DnR4aKy5V6e2UyFl2B+TR9eV1Q3X6tFBBQYYNXmRrSg88EiK+8rcX0iGp1YgxMQKQg88Koyi3PeTvjO8im430OeyfFKTlwybGjmSl9hu+rlPPeoDo4Y16brep3
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:40:26.5255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2394d81f-b4c6-48a4-d71b-08d5ecb4074c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock providers are recommended to use the new struct clk_hw based API,
so implement IMX clk_hw based provider helpers functions to the new
approach.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v4:
 * no changes
v1->v2:  new patches
---
 drivers/clk/imx/clk.c | 22 ++++++++++++++++++
 drivers/clk/imx/clk.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 9074e69..1efed86 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -18,6 +18,16 @@ void __init imx_check_clocks(struct clk *clks[], unsigned int count)
 			       i, PTR_ERR(clks[i]));
 }
 
+void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (IS_ERR(clks[i]))
+			pr_err("i.MX clk %u: register failed with %ld\n",
+			       i, PTR_ERR(clks[i]));
+}
+
 static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
 {
 	struct of_phandle_args phandle;
@@ -49,6 +59,18 @@ struct clk * __init imx_obtain_fixed_clock(
 	return clk;
 }
 
+struct clk_hw * __init imx_obtain_fixed_clk_hw(struct device_node *np,
+					       const char *name)
+{
+	struct clk *clk;
+
+	clk = of_clk_get_by_name(np, name);
+	if (IS_ERR(clk))
+		return ERR_PTR(-ENOENT);
+
+	return __clk_get_hw(clk);
+}
+
 /*
  * This fixups the register CCM_CSCMR1 write value.
  * The write/read/divider values of the aclk_podf field
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 7fca912..d3fcaa5 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -8,6 +8,7 @@
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
+void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 void imx_register_uart_clocks(struct clk ** const clks[]);
 
 extern void imx_cscmr1_fixup(u32 *val);
@@ -54,6 +55,9 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
 struct clk * imx_obtain_fixed_clock(
 			const char *name, unsigned long rate);
 
+struct clk_hw *imx_obtain_fixed_clk_hw(struct device_node *np,
+				       const char *name);
+
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
 
@@ -90,6 +94,16 @@ static inline struct clk *imx_clk_fixed(const char *name, int rate)
 	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
+static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
+static inline struct clk_hw *imx_get_clk_hw_fixed(const char *name, int rate)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
@@ -113,6 +127,15 @@ static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_divider(const char *name,
+						const char *parent,
+						void __iomem *reg, u8 shift,
+						u8 width)
+{
+	return clk_hw_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+				       reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_divider_flags(const char *name,
 		const char *parent, void __iomem *reg, u8 shift, u8 width,
 		unsigned long flags)
@@ -121,6 +144,15 @@ static inline struct clk *imx_clk_divider_flags(const char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,
+						   const char *parent,
+						   void __iomem *reg, u8 shift,
+						   u8 width, unsigned long flags)
+{
+	return clk_hw_register_divider(NULL, name, parent, flags,
+				       reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
@@ -143,6 +175,13 @@ static inline struct clk *imx_clk_gate_flags(const char *name, const char *paren
 			shift, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_gate(const char *name, const char *parent,
+					     void __iomem *reg, u8 shift)
+{
+	return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+				    shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -222,6 +261,17 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_mux2(const char *name, void __iomem *reg,
+					     u8 shift, u8 width,
+					     const char * const *parents,
+					     int num_parents)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+				   CLK_SET_RATE_NO_REPARENT |
+				   CLK_OPS_PARENT_ENABLE,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux_flags(const char *name,
 			void __iomem *reg, u8 shift, u8 width,
 			const char * const *parents, int num_parents,
@@ -232,6 +282,18 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 			&imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_clk_hw_mux_flags(const char *name,
+						  void __iomem *reg, u8 shift,
+						  u8 width,
+						  const char * const *parents,
+						  int num_parents,
+						  unsigned long flags)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+				   flags | CLK_SET_RATE_NO_REPARENT,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
2.7.4

