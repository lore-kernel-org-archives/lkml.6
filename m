Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755722AbeCVNwj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:52:39 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:39904
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755611AbeCVNw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:52:29 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <harinikatakamlinux@gmail.com>
To: <nicolas.ferre@atmel.com>, <davem@davemloft.net>,
        <harinikatakamlinux@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>
Subject: [RFC PATCH 4/5] net: macb: Add support for suspend/resume with full power down
Date: Thu, 22 Mar 2018 19:21:39 +0530
Message-ID: <1521726700-22634-5-git-send-email-harinikatakamlinux@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No-0.002-7.0-31-1
X-imss-scan-details: No-0.002-7.0-31-1;No-0.002-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131662003465050368;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(39380400002)(346002)(2980300002)(189003)(199004)(77096007)(51416003)(356003)(2906002)(2950100002)(82202002)(6666003)(15650500001)(36756003)(26005)(7049001)(2876002)(55446002)(50226002)(5890100001)(8936002)(59450400001)(8676002)(81166006)(76176011)(81156014)(446003)(426003)(73392003)(336012)(86152003)(83322999)(105596002)(48376002)(4326008)(2201001)(50466002)(86362001)(9786002)(450100002)(87572001)(305945005)(76482006)(5660300001)(61266001)(107886003)(47776003)(316002)(110136005)(498600001)(54906003)(106466001)(63266004)(73972006)(16586007)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB329;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT014;1:VyC8sK7kCPOpeQTy493oiRUNONHpq8+t7ySuibsXARwfQvXONaOEQnE4fRZrTGrGPDItrsadnf1WBFP0IJshCqW1vPKWy003TsujDHh4p+Z8X+qfZabM1zQBYv6ahPNM
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d2b1ba2-b5e5-45ca-f69c-08d58ffc2567
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BY2PR02MB329;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB329;3:GasWADx9kXkmBWUcvrWCCSRcAjIIpQK1tFPwcZSgrdwM/hcd+KMH1qO/PM/slujn4HApy3hxV+2LzJ4Thz3k8Ft1jveX+jdNdfyzacJCnLSTTuByZFcQDke3w50A2uaPKfrNG/N47bR6Dbsf6PCbe9fDTJPvYfyK50O2nj+aKb4p7CEV1jTNaNFvi681aZRx0oBmASa7vRbSMbWrsn9Th9GSQ0HeGh4Q/+ZjSeugO49yeBVOtBzWwOjruYQOB8rl+aHhS4bvWV/q0d5V9T/vqUER3koegPrbzpAkoIeVVNgTx4O+7wu2Z53X6ZmMU2OMNGqvx8i7ZCsVdBoQJ+uAC/6LSxxXMNqDk/ixobbgssE=;25:fwwD8Ijd28tHJCEbJy/gr3nXT52S9CS0+t5iYqd2BtqEYsIBTr8onw+aVHzsASX+yys6ije79LOMtX/NKgwGbfCrjUszYDEEV7h5fX+knSbWfFlhRncAsSEw/5kHVOZ4ECxFncVJn4DmeT+h0GlEAnFig6fzTVeOdBDbFi/5DX5dZY+L5wiJ12u6bfas7RzGlJLykMecpaF0KKkMRnvcHP1P/W+QQfJ9RxV/1EF98W9n4AOf/ie583eKEkngZg5OZOXbuv4I+Wx3RNgit2r30eG5+MYdBMAoTdShZiFmtKHogmKRvpyYj/KGUzbzumMcFtjlZtcb4U0eKNTk+OzBNw==
X-MS-TrafficTypeDiagnostic: BY2PR02MB329:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB329;31:lHYYM3hr5iIoWs7L9etpfZZsbe8xiMLKO3rYdnWPDmq/IWn7AIHCbcgUp7xcM2CvFXBeHhCfX2UmYh72LnfdFe/vBfadQMIdY0J4uoZcHe7TSmhQ/2XtPLnwHMn1X0yZV7zjT9F9m8wrB1369n5CA2nTSJvq5aEF77iVN9EUSf4oGz0GHgNdEQ/kMPuwTUKuPTIRosTpw4JWOAKpQEb9RNEdC2Z0BmbpnWDnZI87mNY=;4:SxuLiFFea4FTbs2A7zqfuTyyUBcZ1umxC+qGhD05HzBEs56tCZgu+J3AWUZ14DIehiKEkaIf0EPfY5HTslVkWlgAkNFvW7u4g/h3ij1q85kPvnASKko0DnKtGuVhOA3SGAaZLdurQ/EvJiOb49qSLVtf2aHcG1o4zYsA2LXIl6htc3xvYWk1TQSvUIhthJpcaCa/9C2TA5ZIOhNE7+Vwu+gii5k0L8o9tGigUBHKQW4qBCMDvw+cXMXw0l+Fsnk/okMH5rCmwXXKbLWwX6jjP0/BZdxmKqc8/MB9urVaeANz++EYYmlaiWIMfgRB8qhm
X-Microsoft-Antispam-PRVS: <BY2PR02MB32937FB229B234E40B7B0A1D0A90@BY2PR02MB329.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123559100)(20161123565025)(20161123563025)(20161123556025)(201708071742011);SRVR:BY2PR02MB329;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR02MB329;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB329;23:aYmPHg7TVDmWjz+xw3lLbFdbucFurCGY2jYE+DXDRv?=
 =?us-ascii?Q?F6aQcgKvcs5IwgRuw6wZZ0VcNXxK8A7VwgQO7ag9EA4dcXVBsf9yi75FnS1C?=
 =?us-ascii?Q?1RJ+WFtaB1IZPdkljLc+JJj0+O8TevcFncqyyVioBkscoV6klzqW62U1Sxsu?=
 =?us-ascii?Q?pXa+TRiDnQnaQlGinnOHjrkx5WCLCeXJyXYovBwh1ZLO/+fB5WhaMzRJNPTI?=
 =?us-ascii?Q?x5rasTekQ2uGg9QG60wTOhpI+MvBnapkyIUi2fXhgEezFq9s2Zb46A+Fn0Ri?=
 =?us-ascii?Q?T3Byd1dZD5YLrqjPeftVLeBGEal0lzQcdcgQFkUB66Q2/y6BPlH9K50/wtbj?=
 =?us-ascii?Q?fGIRbQR43y70/G3Ftz4g4u2K3g2c/sQ1oWcCHx8SuaSZa0M3lGiuMsqkxaF/?=
 =?us-ascii?Q?9kRD1EMvSxF5rSEoCpADa93TKj64SVrRVG1bsmOp40wp4WYcy4fDx9147eLT?=
 =?us-ascii?Q?kNMKJNzaXsGYO6IFonowp1qhQzBRLVidAqrP3D8v4hr/CC6rEpB3Drlk6U2D?=
 =?us-ascii?Q?BmqXeN/1GnU56EVRGKWT0XQDusQnMQIdrDRqt4ZYWPaNMqa4OUZOunygcBVE?=
 =?us-ascii?Q?3uDCMXkfhuKCzDia91qPTwfWPLNfpUD+qJ15cjjYysXPRM954V2TaPd+yWNT?=
 =?us-ascii?Q?+CW6irMFI0982grZI/Uq7uOAf/8I4WJbmJjoelwqHy/XOeV8oBCNg0iv+EW5?=
 =?us-ascii?Q?Ijn1gP/zM1VR/sOBoYNDtLr+h7lx0SkH0Ss3+7uAP6bFc/yBsyXS8tBYXxTL?=
 =?us-ascii?Q?ZWYfuOlbu4TZEMsBl8BUTUIC03ixaihcicdXxuXpiGQnYFwYkc9dCBHBYC5n?=
 =?us-ascii?Q?QPkg9xuodrFmB7PGGUApyIvwZWCyLbGG2p67OgVMpiYXdPvkiBQTNu2fD0Cd?=
 =?us-ascii?Q?KeBFfOYO57jeg6aj19Sg8Dzpf25JqVe+mM69GQNasWUu2Xth3/e8ufnf/lA2?=
 =?us-ascii?Q?qy2ImgaKh61AFV/z9VqJ+3SK4nEy9H5HmMHd5FCDF8gAAQwFrEdEJFir/c/f?=
 =?us-ascii?Q?pEuQxNC33oqckzjLiwJhvrNIzlzMM6MmHk9JQZ8IliN3qui9o4Rm61JGCP6I?=
 =?us-ascii?Q?VK8j3qn7SmBHC4orsYzaMr71S0rgXM1uUrr29up7uucDLUmBGcWZ3Q+7qbfb?=
 =?us-ascii?Q?Sv7iSpvDzyt35IE4d+kAJzW3NHTJoYlXy1govgPrdsC4dVMg92QipYBFhpdp?=
 =?us-ascii?Q?YwByyVyHihyDBnOx1+ReIh8723SwCKMr1fi0AJhYv+tpt9e+rQqU1QU4A6HO?=
 =?us-ascii?Q?6HdweO72YtEE5dYTaupTl+YXjSpe+GJjvT0JjuOdmwmGi/mektSGr5X3U5nc?=
 =?us-ascii?Q?3XGVWqjbfg7dQD35v+A/2ayAkoSJyu0JffJRoU3fAkMowBTOB3LnlN0PTQgr?=
 =?us-ascii?Q?bXAtw65m9gT7gUd3TqGBEah40=3D?=
X-Microsoft-Antispam-Message-Info: Cho3Ky0PXM58bel72bpIeNP9bQ7rVQrvjrdBXYHXTMPbZgArPG8WDj4eZ6c4I74bN2b624b5xU4Di5BWFgUktJWwot+wOx9On/32BFMJ8QVKOyw3sXNCDbfs+F3p1J9ez2eRHObgv2L6m0iMW5fhFTcoAj8npUBv/eAEK8sG1dgbCBbkYJOLU0bPLBGOGQv/
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB329;6:sCTLNZ9AWNTWNTLy52kEDXTzzx92C/6fQog8EKzKEevL0ZzJKxT++fZ+sPTM9Yt2uOQ9KO5pFRNzBdx3J/XAvl30wx2ouljc1EqXJxdqt9auYqB+8kcSvA3ubHdAkwcwahxbAENRdlhIs+fBskA57CjYJBa9RQbJ88w7OevqGqmDZ0BxZtzE40gTE4RB06erVCnCdo1ftulxSdVbm6s5hett5kBxFYT1PyRvrauUgNWeTSV4h3KH/sVhuJV4dNkiT2/NEZ1wJgyjkaaj33GMC40gU44CT+iXes0JtZIBISWWYPYaLSlwDhgHsC5TPw+qDAAOnaZyQO9F1OuTv8c37TYMa2l5e7NBqOVT04OeqrA=;5:YVHbZF1whC5V5keDf00MJnyAMqJcBxegxFYZeg890oJeI8ebB3ussJP1iEONnfO0Fw1x9pbZw6XgUOdQwfXsJ8mUR00sK7vPf8Z+drrLtndazbEI7A0MkfsRSZ3jmQ9tQ/3uPZOfjvkZWhhNGvK0dLgNFDRb7lDmomE/QMO//pQ=;24:2wgZNpVlADKsYtR7T+h+fgu7UldTIoMuqTqiW66QNITBAguvNNz+qWdpZkghaV0ME/KftXatCq4TJ7QOgG/58lyv3ou5L3QStO4GCfL9XDU=;7:5tVaLMJ3KDvgodreqGU7kXpmInB4ytymjRHi1QvzoPYMbVFfIyxHlu8HSabUu0BYJ/4qcjnPaeyOX5zXLxnMhBU0izyioyCGAqaDQXahZ0pLoU6Zy605pikZhAdWJtarIzrDilLCvkPs/dHtUHtSQ8QWdxhpxjPYCfp9/VftwEGus1zDq4Py2CQewv/heZqH0SRtSMcDBQqQip128+Udz7Gkf3iEuJdaXirs3gFgLiAHpKCu2jl0c9NcYyzSPtl/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 13:52:26.1612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2b1ba2-b5e5-45ca-f69c-08d58ffc2567
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB329
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

When macb device is suspended and system is powered down, the clocks
are removed and hence macb should be closed gracefully and restored
upon resume. This patch does the same by switching off the net device,
suspending phy and performing necessary cleanup of interrupts and BDs.
Upon resume, all these are reinitialized again.

Reset of macb device is done only when GEM is not a wake device.
Even when gem is a wake device, tx queues can be stopped and ptp device
can be closed (tsu clock will be disabled in pm_runtime_suspend) as
wake event detection has no dependency on this.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 38 ++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce75088..bca91bd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4167,16 +4167,33 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = bp->queues;
+	unsigned long flags;
+	unsigned int q;
+
+	if (!netif_running(netdev))
+		return 0;
 
-	netif_carrier_off(netdev);
-	netif_device_detach(netdev);
 
 	if (bp->wol & MACB_WOL_ENABLED) {
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
+		netif_device_detach(netdev);
+	} else {
+		netif_device_detach(netdev);
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			napi_disable(&queue->napi);
+		phy_stop(netdev->phydev);
+		phy_suspend(netdev->phydev);
+		spin_lock_irqsave(&bp->lock, flags);
+		macb_reset_hw(bp);
+		spin_unlock_irqrestore(&bp->lock, flags);
 	}
 
+	netif_carrier_off(netdev);
+	if (bp->ptp_info)
+		bp->ptp_info->ptp_remove(netdev);
 	pm_runtime_force_suspend(dev);
 
 	return 0;
@@ -4187,6 +4204,11 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = bp->queues;
+	unsigned int q;
+
+	if (!netif_running(netdev))
+		return 0;
 
 	pm_runtime_force_resume(dev);
 
@@ -4194,9 +4216,21 @@ static int __maybe_unused macb_resume(struct device *dev)
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
+	} else {
+		macb_writel(bp, NCR, MACB_BIT(MPE));
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			napi_enable(&queue->napi);
+		netif_carrier_on(netdev);
+		phy_resume(netdev->phydev);
+		phy_start(netdev->phydev);
 	}
 
+	bp->macbgem_ops.mog_init_rings(bp);
+	macb_init_hw(bp);
+	macb_set_rx_mode(netdev);
 	netif_device_attach(netdev);
+	if (bp->ptp_info)
+		bp->ptp_info->ptp_init(netdev);
 
 	return 0;
 }
-- 
2.7.4
