Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966178AbeEYKi7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:38:59 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:19632
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965532AbeEYKiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:38:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        linux-imx@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V3 3/4] clk: add managed version of clk_bulk_get_all
Date: Fri, 25 May 2018 18:37:22 +0800
Message-Id: <1527244643-10736-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To VI1PR04MB4224.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4224;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;3:N3kWeyRN2fjg5xqiPL4fETSe30sXjctuhHR0GFYbdLv4zMYydC+cM7wFn3pKjYgu6SBgZU41XrHN8sbrX542mHe5MQkDWuQICI2DNd1EeGTL3rzhiUUWqyFwgSJlycUNtKrHsL0GOFHBOvqrOtcYRqaTOSzJ0bX82Rv67R6eaMhGvpLNZ/m4+uTlD6c8LKMByQOSZq+yOsASsXGNmIfHGx7ejQHh5eakpbetLFzzEVU6YUVUm9m2szQur1GBS8La;25:ZoAG14ZIYVLZ2e7WP3WoGL1EIHlwY34KvPLApbxle4+JwQKolgn65e8NfcWfnEGoSIv6GHsnn3Y/tN7Avdf1SxkhTj0gdOTRxTxmk1jikJuwWYHx4Ltk/vfg7s17dX7juOa+N+JJ6jnc0tSNEXZjfIjwT+Zr20hx3PaFLyadP428seZaMmpmFt1KVeZk+187OUAp9R4xJ+UZM0oc+VHiVWwrxJSVZeXUWHjABGkYM5BonTN1GocrVovXTRw+qe5GHozuvLL57qwrKzCJTNfoH6zuv8EaU5SaSh80U73a1VesW8Y2bzG4sCrXAmtERX3gRsM7+LnFsoWWuV8AB3V5Bw==;31:nbL9+Lmzm0RkMP+UL002rq9bCi2qt7x3WzJSADdBLL7r5iA8KwR5pOg+IXDa8mknm4e6YjiI889bEWDIDvnGOAAl3f32p1JAHi0WO1LjefPvPMFyZ6cYzHI2vnDevQ39At/q5hN1+4wESUQAC1mBS/apNVinbNmfny16q4b5b383UQ93sfN7whQ5Zr21OzlSiYwqEsqHngcep5tkm5DJATpI7YlO6HK1STp1Mrlb5SU=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4224:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;20:TjmlC7+vaSK+Erx5/xpgSgPpmSUiViemgpxu5gmY/ors9oW57aXJWiOK3XwknGIevh25jzNzlMyoFfU7RIzJ+x9YObfstF7KCT8ne/KWY35GyHWz5MapYVxkizEFj0t8UPpVBQTQ2IblVaok8X9h5U7He46K98GGJXDo+gTU5i7BiIBqyxIvDDmOw64WobY8MW8soRJ3d58kCPRcKpBwkQ7Atc3ytJE44B4cD/0ct3jY0ZMhPVxckUX+NDgmnmJEoSe3IY3Cs3xGzcJ9zjMKJDEXbbHR4YxDCiLiI2vByDIjkLy8FXfGchg95rlf7BNStPAq/QYE+S+ZCrQJvdsDIbU2B9LNQ0Iy0CEyMCdeA/H60eO7W27oPooBOM0Yw3QFounhpx3Ewxhwqc8xRd7gQJsSA2kWwXk28bOU1Dzp+fIAI2awP5PHXku91AxD2QFZN219FEVTQ1ettv6oRo9EmXHIun4Ff3wcnXzJNAtBAiV4cqY/3/IIcd7FIZ/QwDC2;4:RyhxkTtL3gD0DLQJiDgGsNWo0a5Xz1ZuIZEGveEVAzmiN5lg6p6U/F1WdRK6rzozv/PgVlKYAelaKYAGQbk7LjED4rr+pSCRBvAckhdJjvZOVIeLzmqfBXxByzeED9VHCq0bkrJSTvzhPGl8qqe+OcmLX7f+zRxC865GSaojsOT7flvRznCCQTP2a3CVzMqSj1IhXEy5bGxsr0ghVT2zo93cgtsSx0mv763jY+azXPYthe74D1QlTSwEfsgit+EutDyxuw8vp2fJNh9FiEx0/iQTAoUd7+saLPIxmH7V3ACgdW5KrQNAF64qF9Q/nfI3
X-Microsoft-Antispam-PRVS: <VI1PR04MB4224B020E1F7C47936AA7E8080690@VI1PR04MB4224.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4224;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4224;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(20776003)(69226001)(63696002)(47776003)(74876001)(62966002)(74706001)(36756003)(77096001)(77156001)(76786001)(76796001)(81542001)(42186004)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(48376002)(77982001)(59766001)(56816005)(33646001)(80022001)(66066001)(76482001)(90146001)(89996001)(65816001)(87936001)(56776001)(88136002)(54316002)(74366001)(44376005)(87286001)(87266001)(50226001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(50466002)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(93916002)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4224;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4224;23:zKcH4L/tuZq25/8WIkE8ohRecxFXi3YqzYexH6k22?=
 =?us-ascii?Q?RKAtNk52j18ppoxg6MyO3JbDsA7GB2nqcFl1t8lyo6J4yud0YO6uDQ/9DCzk?=
 =?us-ascii?Q?2EKfOboVGbCgh09cNQGPDq/VbIWmyjfTrdneszd6uxuNrinRfzfr2NMAUH1P?=
 =?us-ascii?Q?6CcO2ufiawBjRC0vFNB0LOLyUsZLyWTEa5A9HUQ9ZDKRHsuk7RmkATOR4E4y?=
 =?us-ascii?Q?EGWr5SgbcdRPwD1UCYiutPTj9+cAlv9Z07z6+JkCclN+BUV8dJYjfoBTKZm5?=
 =?us-ascii?Q?z3YacSgnkqYyDtnwnbeevdlmmsAh4BcsMCun7AOEopffOWYb4w9KV+1qv6mX?=
 =?us-ascii?Q?NM+hF5FJJJXiF+XCQwwuNwzkHKgaDHXlny5bbf6v9p1eJPrYny1n6sE9ZC9D?=
 =?us-ascii?Q?mYjGuy3S3ka1IkNrEED/b3EZ7xYUjwWdDvr1BN/YsJV4WPur042Uu6F3G0rZ?=
 =?us-ascii?Q?zs0u3CeZEniZQqUvlJve7xcpM41RzP1tZkvBDeVMGwmN6P1KL1PaYw8Bahbw?=
 =?us-ascii?Q?zPAEoWAemPytX4hOJPje2SB5vYgmUKWNA9xH2ruHiZG1R3hXpr7RLc6lsgbH?=
 =?us-ascii?Q?MwXNLWxK71ApZumjpoh48l0aYGFYNt42g4qnIWLB8lLG5gXH6Z3VWLiXcR/H?=
 =?us-ascii?Q?QxMmFVH774Dl936qYGyAnUmQubdemnTGAgLRCADdBYeZvlP5tE4TRt+U+hT8?=
 =?us-ascii?Q?89kvMHW80Xa4JVwCE/ayBzkokXR9mkX0AbosvtO1M2OhQAtyj6vqU7+Q79W2?=
 =?us-ascii?Q?wyLOSHd1aYGmBX9lmwidxfR9rHjnwnP+n79FNTAPsocyM1raIOSzhaCDP++Q?=
 =?us-ascii?Q?i56b4YPTsNbnv1Z9HwydUOF77fkXj9qXpdNN7q2bbJjmFlJnMvfgkV8IXM6H?=
 =?us-ascii?Q?K0UsXkfgm53jNpLN48MPY80sW4EB8idFrRXgev2H6dfRYaDYdfHRcozJTnOI?=
 =?us-ascii?Q?xfVASsESj0yhYVtVN2l165aCPTqIj/OOb1mDrr1IDLiCj7kY0ITzHT3DqG85?=
 =?us-ascii?Q?M7tBa+qeciV2DlVfaeVjPjkI2HpLjszj6vtNiTbHqetPBnseJ/cJhZIgbfRi?=
 =?us-ascii?Q?XrSAiKB0vwcP0fRW32u2RWN3Cp0DkIgrxwSjm5ABoGje8ozxAopPRwOayO7V?=
 =?us-ascii?Q?2CrDKD7NF+C9XaA40ytEZ+MCplHW5YNxpEgP/R9U+loWt6dDjqeA8U65BY3v?=
 =?us-ascii?Q?R2yzLFJpQKpCDHywMiHj/EIRLNZOB6qr3aB9y3E7Cl51aFCBm8TBUnIQ9ZtT?=
 =?us-ascii?Q?ydJ5nEoVZGFlO9zM8Rx05zdZ6QmdRbIy8fal3nWu8nYZRzSYhVsyWlWrGCj4?=
 =?us-ascii?Q?QlcVuosNfOc17JUSGHOGBVg8IJ0vKGB5myoaImcF2RBxuDRLQv84cUTEf2am?=
 =?us-ascii?Q?Lk8JO+SREkaCLmw9aTNS9mpX+9XWDhxsVSKJxJZYo8wNbpjYVPfhDEdDBH+6?=
 =?us-ascii?Q?rcOkB7nDK35zDVh/uAnAbK4/tkUA/hKXiJUGqShyaLUtU2MG1oW7ndJDb3yk?=
 =?us-ascii?Q?9zQFRtLMxdv31W3+Jm0E52h+c4yIjcHKLszXPLSPAO8nBzIIox8l3vmCXN1y?=
 =?us-ascii?Q?3nuyerqkpwRAmOz8bfHe1aLnviIQg84J5NCu1RaT8Mhu0MV5mpN6jdNG8n8B?=
 =?us-ascii?Q?vLzN50x3KttrOmWJ18/ZTpaueFJ79Lj8kCG+M8sd/XynZVksN1K1vKy2Rp0l?=
 =?us-ascii?Q?M9OPl7kOZ8/tkT0cSuj2w0qx/TSIDkSN2YGs22VHtxZmldwdFQOxzwHOmECU?=
 =?us-ascii?Q?LsExYOIBL77Ndtr0YKuzN2GGZqb0pUue2d36LMs0VW2P1KAR0k=3D?=
X-Microsoft-Antispam-Message-Info: l8Upr0yoSyFEfmpH149uO6+4AxnyLPGYR7JVrxH7EWR2LB0m2b4xlIAdsaoy75a7QhxGfFCDLP0xntCteD9/QTf5YuQgGIcDxI6kZ+WT7Bm+NnQDfDAjhA0Dyvg4lddCRx+LG6l9e2fBUM6EE0edAQ+TnNYT/5zG6Sm0+CuLafQXLYM4+XBRUzx+fNLEmBOk
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;6:BSkYZ2yATUNFv0fpQLRbEap6ddzuw/W5eX82FdjOXwE/NArBt6QfVh0wMZwYElUqjVcJBI3dE/A+ur/IMHUQlm5JZJjKf6RIieu2X9CNQgNTbaehBINWibe07kZGRflt87lhPhNrzQAgk3co0U8gioMLBovsPbCTQuJ0ZjqpX2Vcx7T7LGnvt2+M450e4LMK+deYU2mw2/WRuHXYN9sLfz0IEyvepN/rvWT9wlcX+rVFNcEAU8YRoCQ2KjdPCX/CuwvwTzNTouiu5CrHeQT0J74GmcZRTjLYhcXrbe3F+P5ZspAtdzeS2ThZX4XdY1WU/bGMM76QISe29OAxDVALCov/IsWQ0mUQ45TZSxPbPrq4vDXnelr1r5Zmo936QzZHxpfSkaJ3B6Ebw9UTonUha8MogIDiTcBbkqChB/ULzsy7q4zkJqFHBQr+A6iw6eaWkbR4dFfp1S8XskVRI0kccw==;5:NIbysdaTY96LK5uPMxNkSLRKhWO2IrD640iFAH+4xK6d8veuXm5I22T9AEgDDebrIDZokiO9y4spMeY6YMkDuNidRTR1SRDzMI1g8XM6tFQKoSl9oMuaJPAQ29FOdwuxgkrCwSVkpEyhkdB/kASDNMZmzv/8F53pIwGaP5IVUN0=;24:wokqta7jLd88ae+oxkfxRZczVnbPxlz2OEVHJxkXbCapi5s7c7+dsenPWwx2DiSSL7isFPF0fr8ZQbsSVHTuDo7IfEj2+8MfLNcjR3FgGz8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;7:UB0abjP+z22uP+qe5cWlgQGVAKAEk2P+4Bc+ayAWXFlxqgYtuQHEp1XjLpJHIG+h1DaRcQe07ruaLcmvpGO7lE8gWAroY6wPgs4gVVNx8PDvp5Ucc/k7v0o16ejAIH4tEqPVOq/VRpt6Kg25t9nNu6pVFiiLbSkbkm35mHiYZAryzs/H0sRLVgB2ddIYDOnQBvhdLA/RtnNTHwl6f4N2JibKIajO3q8f9u55iZPpTqEhhDKCeSyVDDYI/uK4JkGn
X-MS-Office365-Filtering-Correlation-Id: a5472690-f3d9-4095-8607-08d5c22bb435
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 10:38:47.6206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5472690-f3d9-4095-8607-08d5c22bb435
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the managed version of clk_bulk_get_all.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * a minor fix of build warning on PowerPC platform.
v1->v2:
 * new patch
---
 drivers/clk/clk-devres.c | 24 ++++++++++++++++++++++++
 include/linux/clk.h      | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..6d3ca5e 100644
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
+	ret = clk_bulk_get_all(dev, clks);
+	if (ret > 0) {
+		devres->clks = *clks;
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
index a76fdff..ef20217 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -313,6 +313,22 @@ int __must_check clk_bulk_get_all(struct device *dev,
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
@@ -658,6 +674,13 @@ static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clk
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
