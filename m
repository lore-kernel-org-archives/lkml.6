Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeCUDV0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:21:26 -0400
Received: from mail-db5eur01on0066.outbound.protection.outlook.com ([104.47.2.66]:37712
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751951AbeCUDUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:20:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        sboyd@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
Date: Wed, 21 Mar 2018 11:19:50 +0800
Message-Id: <1521602391-30356-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KL1PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:802::12) To DBXPR04MB320.eurprd04.prod.outlook.com
 (2a01:111:e400:9425::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45fc6d1e-f66e-483c-5f23-08d58edab9c5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DBXPR04MB320;
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;3:UXlbbxDImvn7LmV0CI3fB+JwodHeja9UmFYzerCM1WP5YH866yseVK9VzRmFwpQfKt2AUF3JwZdI7paB6im3UIrKgAUKlhx4zMgpwtkfWg3kKCLTH4YCp8kjnXlV7Q+c82pgfzsLWKgKtoS6Yp3Hrqtahy6qkk7sSBVgF+fY94HJYB/YqOkyMQddRbIBwB809G1IrPwvy2tL5V/nnFmBBXeZTqY5+DDfzV8OjbacmTKT8WUxp5rMNvbabSHQsqsj;25:/geJ67lZbaM7+SD/b144UJoAqraD+Eg5AYhf00o+9+W7GidrhoHR1MjQ3B/WrISvWyciBMKWjfcqZGodcR6wUfS36xAlJzWKVwbvMANNykL2cmWigc4126KB9XyFF1cRgbdDmwLx3ys2bx6sRFacguLv4bHncb8Tr4B3JHEZKoyn9Do55SYdaA33X/xOcXFCCRZpXPTMn/mohTmK2/VPW21IQR9CPYlN7H8xJ6YvrcyBh9aGQm3FMEGbQdnbgd2+8P66u6J6TQNtMZKQqEY943wDgNIlhQIgYdsumlfGAO1luxpqn98DNEDYSJO597JcpTyZ+ine199t8dznWortfQ==;31:eMTYf8e5wCG35ArWM9ilMfmYqqZPIhoBZgl2j0rVqmpkWPZ4Pfjo7YPbNJgKTaSYAmt2vqriO4MN90jNy/EmV6GT4y+dRHA+5w2OYYReDlQGkc2A4iOa6Nbtk3FglZp4TrsJnXZ7/JxX7GQ7G9tb9vuLIhlSBPrn9z1xuispcvwljnL83x7Woh9x5DkANCr/lPK5cLToxw8h9aXibtW4UJXi3Z3T4sybahHmD7r85eI=
X-MS-TrafficTypeDiagnostic: DBXPR04MB320:
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;20:bSl8JuvYdezDqfdxvLhM7ZfuiONjJvOpOsyoez0p4wUWTY++73chlJZTTiOUk63BfcBBdVldZRb9BwcNpZTpbEyF2W/xKr8rme+9JEmeJe7nW00zyYpqEsycMWS1EzvQWfmBmD/2Auxntbs8L4Kw2etSBBe6G5avHrU6NfhO9NrBVZ+Qj7w/hQcUxYmfT8zq9q90DDXvIrYTGE1f89LfQvuAqDK+/6OOvyaenBfqCjQ0FSO0a2ZbPi0pTCvEbreH81RsG+Cm4CQxn/nnfKmwQGYFB/sgtL1Bqu5AGFCoxsd/qLy48mbZxqK8oebrZNvAwyJJ7+LxnTTWTUrJaV2w+Nks+iMZz4Jy7mTStM7FnCESwZdLh/lCZ96BiKeepRV9nrsz+4mQ7vFHp2dL0Ec4EmUtwIAGYXFsn+r8siwA9APjcOmqb5qpZ1e7JyPDklOfVmCuL5ICVS0csIFg15aYKcfK/oVSXOc9VokQdrJTuD5bU4Lf1yVTWZKlRDgGb+V/;4:PvfwYoJ6z79zH6C+nnM0fpsu5T4dw4RJTiq3gczNcKa7To37GGF4MKahJ4p+9Buap3vuziLQKwunLkKh4ZFO7MFQO6ErTHxk/dZkQYUVJuYfifo2Oo4haEbCIScBISSglzD9GL0s0tQ128OvIEj3wHt/4ME9aTRuBiQKl7BY/gCap1WbU1U9QvtQUDdcsXJ23r+HQVyxRDI18Ru2wE0uw1C+BxhVHgvxu1G74DiXiFSvr4SCqT/UlyYvxuDPJsS7tOOHz/2N35P8/LQ9mXSyCklFmJ9P0kQ+Y1To72VlsPHa48y0jeixJBcKrr9gdeS4
X-Microsoft-Antispam-PRVS: <DBXPR04MB3205B7327691E5679707B2A80AA0@DBXPR04MB320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501318)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DBXPR04MB320;BCL:0;PCL:0;RULEID:;SRVR:DBXPR04MB320;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(346002)(376002)(39860400002)(199004)(189003)(6512007)(47776003)(53936002)(186003)(66066001)(50226002)(54906003)(105586002)(16526019)(478600001)(68736007)(25786009)(106356001)(4326008)(6666003)(2361001)(6916009)(16586007)(2906002)(97736004)(2351001)(316002)(6486002)(36756003)(8676002)(305945005)(2950100002)(386003)(6506007)(3846002)(7736002)(6116002)(5660300001)(7416002)(81156014)(50466002)(48376002)(81166006)(26005)(8936002)(51416003)(52116002)(76176011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR04MB320;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DBXPR04MB320;23:h6zvoweyYa4Z/ZmZK7hJxljsf1qqg7rSMT7aThYuJS?=
 =?us-ascii?Q?aiFrpHAZjlTQheCJjKFKcFejrq8v9tRafLazZi4v6TXgBpTnd2GXa/KwD04g?=
 =?us-ascii?Q?N+yDI+Vd1wPMh2j7w2xUZFwC0FqTDaebVmuokW2piS4rAA/b2/UlavfhbV1o?=
 =?us-ascii?Q?k/hk8viFrhXyW21pHqeT0LT3NjlnSA1mGIpPlvRFcs8pxDGCUOD//QUMpBMy?=
 =?us-ascii?Q?G70UJno6c7l4VgfTGR2OnTpqvhufIUfSvfw6dXzAVk+vDhc0uW+wgLEiK46l?=
 =?us-ascii?Q?y+0mzVMfD3TPicap5fosefzEYQLqoFDJB2JkCDdt11WwUZUgaRDuVeEmfcmc?=
 =?us-ascii?Q?R5ZObmBkiU/AJ9CY+apL+i7tpNxtJhaUWpx+8yGpBk0hADLK/mP6WXTTFVRi?=
 =?us-ascii?Q?hJ2hdR7kXwgLx7mlYm9E6QtWp1jXzF8PneLrgoJUQqLu1RxtKzzjBls3dETs?=
 =?us-ascii?Q?OiZ6WG+NyJaUpvdnl0tuc30uJM3VsMtqdXxwWXOuvjZWKHR9+f8JmDlqpo8N?=
 =?us-ascii?Q?Wd4IEaQzrn5S3T7a8gXcXNTzkdX+M6HySMlcUBEINHuscydqsJKE1cBTIpcC?=
 =?us-ascii?Q?yaaEEb4/vcMXP6Xd1m8EH5Vw91JgPZ02hRD7q1upGouqarppEqJ+ucTBZYG6?=
 =?us-ascii?Q?zOtx25bRFreuc+O6bewIlPFgr7bkmNsrWjd0C3AlRwXiMn0oQaRjAF8FUOHw?=
 =?us-ascii?Q?nHw2iOdcMZogwF/NVZy0wMerVsh81AsrNcTw2YRgHx3YvRwAyqj3QMjyCe1J?=
 =?us-ascii?Q?/LIp6fP8zfn2fZSQYilN1uYLgxYynNp6NCkJ+wQZmP4r5ckvMiTeGTU6q25v?=
 =?us-ascii?Q?zWogUfEIXm95cLHNVsHyGEWXicUedkIFUW4NVKPKZeLjugQqnvfvyLP6Yw3h?=
 =?us-ascii?Q?7XKpe99cd47CmoLVJNNl2JjWb0GNZubl5QShjliZ2NOVXEEfU+/qL5Lq7LW0?=
 =?us-ascii?Q?bpHW2/ZCe3kxwuwY0nDgJNwR6kFRO8GkzHIkzFXwRqmj2996LPS3U5sUP0A1?=
 =?us-ascii?Q?V1FjEBpT0Yp0tc50NdD6Feo2+EcfCxmOLjf5M239oOpygexp+ndUQdSPOIzQ?=
 =?us-ascii?Q?CHKDdQxG07L+jpmVSgAJCQTx5sHKoeRet1Pf7fBd986H5WrFdd8EtMO4JgWj?=
 =?us-ascii?Q?D9lllSFPc4An0oALdDlpiqwUf+TvKnHR8daKHoyFtukav8wJSNrbiodkq+/F?=
 =?us-ascii?Q?wFOxIUwaJOjTg=3D?=
X-Microsoft-Antispam-Message-Info: U7FOFvmnmcPjJz+fkAyNlVwKEEH3OQLIe409ClOr+49edNBjEx1e7SgkAZfPsx1fggZGWdgv6Rb25IK7OgqRtQqpJKVMQTNVMEwBazTsVtqIpuTeV2ToiQIJgVxOxYc5AQJKnRdQCYFwiMhBB+yvjxRb1MpI0vABDIy6eA03IV5js6fPRPafV0wcuGCrFCj5
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;6:aStCVddDKOFdOMi7dKGDQFw0uP9xzPwV0UieOBhgdDX+bWNbGxof1k+GoX7cmt7O/1u+S3ClzFDw5WAhshhCPe+IAofh8CYFTJ3WlNBFVenhh68MTavyj3jgSu+Aha1TJZ/I78SCKA+0LrSHXpjM0DVeA1qBID2j0bbn9NDIlfrXhsYskrmRjfFTKmbmM25UUoo5eU3pRoVLR9tDAuryw8AG110e1ckJke8P3wyRCZA/27Pg0QeMdEiz0cWNzW3ou4UPV2BFLMsflJ+IPNLLZ2qpYuvOxwnJskd/a5L6AUBjYg5oFwaxE3mG5e6l/mRyUltLxnrvuU/6IsSXMV0OpIEnzpPh92rbuT0cViGZiDw=;5:/lnyJpw0Jf2JI2UQYYAtP1bUj8MJIKhvAlAQmIXPuIcGsVpiBYYPSBZeJ5P61+4AdzD4p+nKfHRdRKitkQfPMI52CZqVYAYnmN59TJkEXvoE4yxta0JIxjcneaxpZ2zunQzROHCD6IYiRKPTT3pnNTb7QGp2G/dHZD9rt7CTpNM=;24:KZ/DW5d70ZI7XRHjLNykDoO7qSuZ9WIr4CIyJYx+6dEGH3U6sGRvOjZ6NdUAyLtdY2etpA/UE6iRpB6mV+9T7LxLIqOxju3pSTgkaMgEVbc=;7:oLXqI1HwonZ1M6yIuktw9+A894I/M5SOixz9FBuv0N+QiomfieygzpjjVyoDgAqcXLyMyrCjD8wVrJkoVrLCADlxsCIcH2UqngMLHvcZBodT2bARBLW6aFor+aN3ZeGyw/HgOefyA4+cWFj7hl1lYLKICcanZMGIsNRx6kmjoHIl+702qsfcP6s/Hf7XGiwULWoXHihd6Nfymgl5zV5Q1nAwOhlEvlcmlMo+nskZFU/SHVaojcJGcEWIG2jxZCJX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 03:20:37.3371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fc6d1e-f66e-483c-5f23-08d58edab9c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR04MB320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the managed version of clk_bulk_get_all.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
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
index a76fdff..fe48e01 100644
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
+						     struct clk_bulk_data **clks);
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
