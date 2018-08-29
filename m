Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63375C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DA32086A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wnGrC+Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DA32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeH2NjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:39:15 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:17666
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbeH2NjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcQpyyO9j0dbGfXZsgg/EFeDFwntfyDdVZEAUzQIEJ4=;
 b=wnGrC+Ds+SciZgaQFnc95xRecuUgmdYv7r5Fq9ZKBANHMmqcgeGrPKdGoTV7RsLUvobPH6mqTzoPYRH0gTpNQtKkYRtoAOPAvlP+gD4Mt6f6jqscgDKnleS/rCe8SPn8r8sq9vE9njmyLNuQ24rz7X7uZOSliCXdiwZxqUVz554=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB337.eurprd04.prod.outlook.com (2a01:111:e400:881e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 09:43:03 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     gregkh@linuxfoundation.org, andrew@lunn.ch,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com,
        madalin.bucur@nxp.com, horia.geanta@nxp.com
Subject: [PATCH net-next v2 1/2] staging: fsl-dpaa2/eth: Delay netdev_register() call
Date:   Wed, 29 Aug 2018 04:42:39 -0500
Message-Id: <20180829094240.27242-2-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
References: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:805::24) To AM3PR04MB337.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82a6aadf-0019-49c6-bf00-08d60d93d240
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB337;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB337;3:WpbB898SUj/L5ckpbQNaHmnPuevJp2vxe7t9nQPArZOTgkwEuzo/0ohKXSpdpVs3GJm4qW8qfrJPOWGlpP3YP9fcn0N0p8XkJK82v5d273BgEmJCtq6nWpBs1a8uF1WhSmGZpk/DrAGL8GQkEKV7Xw/d6/o/tKwp0LXHQStH20DlQWvj++nXYHzQPxXqrsswIOPmhGwQ5OjrsUv7M4jgWBRjR6JlUmMSXgCqpe/6aREQhj+MZH2WbLGx4aKa9YOG;25:QWqzEYHBc4PLSPw+asWl0Lxci0P32mVXDobGLhfEyGWLyeodaSbG7eJu3EVx/ZLkpm8iqqK2ZIs32IUNsKRSXgpMmR09/Esl+t0oLsn1S2YrnnUq3ld0MbEygqJPY4eZuxgwXYsLNFhU4fEvvfTB/uqw3T1JMNnPXO8x/lodLDGRg4pEf9KrDn8x3YCsKQUFoO5KqtRoahtNrVkl4HsxsjX5U/Bq73dExQsIyYEwczm6TLiygwLLVXnIDYeT07aBPKkoLTrNNA63k5GrQslG2gFoB7Qg4xy5B2QfnyJXskuuCTKxo1JZoLphYvbn+2G7ZjWthYJpsTIS7oOm+hfIGA==;31:r0+dc28pbOpF9Lt+3xLnKcDw/0Q6MpyrLSPhx/kSmIB0OfSq0pLYpuj5PTBYDsPoV1oR970IU4wYMqu+hRResXlecsDGvZFaqwZo4UJusF0aDrRrDtrxzxqqDMHC5E5YgPOYrFv6uLsdeeOnRJH6teY8G97zS+xel8SdeK1eEOWRaDDaw66P7enCaad045kzMX6lfy/+l0WXXQkrD9GX04rcDSb5qy5ZM17BNjd2ln8=
X-MS-TrafficTypeDiagnostic: AM3PR04MB337:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB337;20:eqVOZriMC8/iYEkmiLlTubjWCuLyZ5b/lWUFST/UEuD3wlv7FJ4j9cRxmbcj+vZkORAO9njW6pQI3I/ibL7fJowIWbYkVZPg9FHjwtvpPgfPQ8z9UA5i9VFqQ0U1z+Qu23mwyJhFbXFBRaLnt14f/nA+zN0rQOxEX9cWZb6cMnNye5PlQiAIfCOks/omxa4If7YazdwyE8kKkz+ving3OpeFT4DwC6lsi0Hmxew60+Ea/XuB07kqFBd/DCV391CxddPhsSTFzvlwaHZ+m8RRjnRXT9EDkyz4kR+tfzrDK9mPdTjW7hLT+XA40eL4dMN8Tnyo3jADByiLAyfx44Y7RbwnWZ/gSMvzxqKyg7UDwNi0K+k1+2ylEMFKpBuGIyEDyTTlgRglk8aRDT1hubL84+mBOuAw6EfEW/IU4MTPsLWOV7hcTpK6WzOmWbR/zSC1n5ANEtYMh6nXQbCVg8BMddBBZEgYG3pk9JiXPnaggYpdC9K9g5qjTi692sPnPdie;4:bD7uApoDbzwNP5Rl7Ss2ksD5NpDanRzk8BQjYXcZcOt7rt3Fw+ALdDyak5Syc9RI5/EzK6SF+tb+qtQ8vR39rPdsGNXAd2LzGTvdAAgvsbH51RNdk4QPo5V1EdRdY7hS7DLWKID3HnfWNzwACKXAI2kwx8vLlr9wik/oAgjKogYQTDwBxrJ8Vhv/23gFEo36OqCkMtazwA6I2rCCqMLuwQzANCQkxVCllbJNu4njcSeQpz2chdVxlSy/53eBWpGYGg+8Krq0Ekat1Nj8XR3IFYsIAOS36ylrKEZrkMYzSvsrM1/Yct+8wZ8eeS6+keHj
X-Microsoft-Antispam-PRVS: <AM3PR04MB337209E2D02EECFD1E8386594090@AM3PR04MB337.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699016);SRVR:AM3PR04MB337;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB337;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(25786009)(16526019)(16586007)(316002)(7736002)(186003)(50466002)(305945005)(86362001)(53936002)(66066001)(2906002)(47776003)(26005)(97736004)(106356001)(48376002)(478600001)(4326008)(51416003)(52116002)(105586002)(76176011)(6116002)(50226002)(3846002)(8936002)(68736007)(11346002)(486006)(476003)(2616005)(6486002)(81156014)(81166006)(1076002)(446003)(956004)(6666003)(5660300001)(386003)(6506007)(36756003)(8676002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB337;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB337;23:UDki2bckvq5WG5HGgohwyBAKdNFRI7OFn9+3kWAB+y?=
 =?us-ascii?Q?pk7qaDFrlr2L1RC60OaklUpfLYWVxzmYOQBHmF7oLIx1FZPRBWqNHQWnpH8g?=
 =?us-ascii?Q?fVILYkIMSJDLP9OJwl5DFGqei+bQbxxXATPikRxxUFJUE0OZhC9PPyVzjRX7?=
 =?us-ascii?Q?S5gjrBg6cVN2dVhCJjH0AA3wUddRu6A3T7udP5G4iV4FA8KW5wYCXpD0bdTl?=
 =?us-ascii?Q?KoptoOA+P9nY3BpczcoOmnw7lDQkBJdAgJWzmjg5g14ydsAGhM4ZBdnYr2LJ?=
 =?us-ascii?Q?oOLdUvXaUfvYkx/yU8XSq3R8HhxrJm9B08kUk3v8ov9db6mqfxtRFWhGrV7g?=
 =?us-ascii?Q?Az8MmwLhgNgZ8Xs46epqLUUTpNp7h4XFOiV7xGwtFB0hXx/YO3c3EbeAQLiR?=
 =?us-ascii?Q?lokJWKvsx94jNGz6Q5iXABGjipsp47Y7CdgI7fuBc4DGXsFd04LdXlSYPhA2?=
 =?us-ascii?Q?WeODQI1x+7UYZ++q/v7bu6r6m457pKHAURATVPzCce+loIpiY+TkplwuUbym?=
 =?us-ascii?Q?hjBYqkgREC+d0J9NHlQkYKENQ4RRXeA6ScyXgapfcFZqmBUIN7w2MJfkPn57?=
 =?us-ascii?Q?OAM38UCMaekmfFitwTs9CGxKiu+kGayzEiFxNefuHNm9DfbwD5+69AZducHs?=
 =?us-ascii?Q?Q2BIgTBWE4vk4FDi7+8tI2SNDL0sFzNDvQbyp+eJNSRulkp2qrv+86a8WKTm?=
 =?us-ascii?Q?4TXt4NcqV8U/lGi4d6zLsYNsZETUgRcmnTqlwGz7OZHxPpggsU4uDMpONhkd?=
 =?us-ascii?Q?qhk9r1+8Cb6W+TG75Caq9bWeUSCGzzidIWQHJfT+K2VEyXvZZGqHFmmuqq7h?=
 =?us-ascii?Q?uj/anFcQRtoabLCBnp5sdftyi2cxSKlpmud5RMZdWA0h9u9yUxl3emXV9dyJ?=
 =?us-ascii?Q?XGxgHGlrnR97pCSWKy8wxJ4PTXVv3cYy2MzNu8QtPxTppqPUx9tKCSgS+phN?=
 =?us-ascii?Q?3UPj5ya10HjWxaCsqjX9nvhCatD+4LmkiintiZWFYlvu2zE/rCiUGpnnOwoG?=
 =?us-ascii?Q?KnAZDoEn17FfdCNCQj+AeELXWzX3Mf53Uzw7cdO0O7ppaHV7DKyY7/qVBgqP?=
 =?us-ascii?Q?e2P10eDOGzOzDFeQGChTvXuCphVhhmN6Z+5nRMCQc80Y93sRSJieDH5ePO5n?=
 =?us-ascii?Q?sa29zirDeyU5fUDlH09hxVs/PjV53ly0TtvmKxXIe97W8su27HYA=3D=3D?=
X-Microsoft-Antispam-Message-Info: I86rNodkeP1h5/b9F8bIpWJEcTSuYUL+IgWI7TCXCmZvPwEl8r9rksAxSv20LOYafEVyAafZRsDEFNtRS5txuleTweSbpPjI+ripte/AbQU2Vcvytr794egovuy6wv8iInh/wUeSJzUXE7S3u/GFKTeggxuAYynQZtJvTt8KrPioCQVBw/7Rc15wQCO3nPFMdEO0qbzOyGv0T7DjVZWk1ovC3YBr9lQd1DfYOq/NSmxz5A1GqA4AbxTDjtICtUmAbe31mNX32n/XOamvKRfYRj64II/8BaDEt4JyTKNoAn2lxnZmONdw3f+2l3h/tzXFusIIKA2yQWZeSvLNryh3Emw3mPLeqpNU3tsrDN4lBEA=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB337;6:lt80M82iXo1CU3R9H5MefQzoyo/ANyge2f4cSWCfwimTy6WQ8mCBEEZIJoJaPRXdO8zBFCWZy+PRnCGYDTKWcTgofJhN7tO9sq8NJ6qXW4AXSvQPNZLNj4eSOvPcIEE5SG7cLSDp8qXIan56IukyWOXGujALqnFLWqj8imB6/3eh+yn8G+wWkfZjyvP16dpD1p7oXEmTbla2FRSf4WHRufl7ojTSdkwtqhabv3Ux5EpRcyOqtn7snGs0nZJoWSRg2pcSgDy0URMSQlwN2xv0G/R421sP36Z0JgyeMy9Ioq4mdsjQPtXTvl/77kA/Y16/fgnGmqWUPfTv0D5+tkaBSRVU6ucwfHiqpxV/ViN/0Gbt4ok+X8JLcAZm6zy5w358UItJBTxHUhtPDkQCitBsB2myEbpIWzWx2QSn7odYDKEONRmv8FUOgHfzuQe7BblaVDvWqf+jDug5eottACBcdQ==;5:mVaYdnGloX6j9EVQ99kgS6Nr7jyA/DKYDSBKocG4hr6FLkMMDS3upqgNklWn/OJk50Ewj/hNcWSk736pmMaTfwKZJxabSvW3PrxrBGSd2YeFqAOMtUB2WTyC+Karwv18S20HPGyFiDbR+nxsTD3b12PqiRDuGt93SBSgATZxAtc=;7:PWlbrXv3aBgpRJwvSFkT7gFDWBv4imnTzWBrpVMzdO/eR3aKm/1g2UhFEjuSHWL3yigQfU8Oe3J+5NzAyurWSBMRTfkkcgwMRZsaESH5JIdMnAeIKT9El9atHD4/nuCGNgCA1WHOnxhbqnqq5Knr2LGEOyWd+OkGW1422KDi7OLbNxOLVufipmW9SxUypwgQeYrGSyg7+3niJk5HY7cZFgzUCpnAga5LfKo11DUZpyPf5soippzCg0jWfMOz+6Y3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 09:43:03.8471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a6aadf-0019-49c6-bf00-08d60d93d240
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only call netdev_register() at the end of the probe function,
once all other necessary bits and pieces are properly initialized.

We keep the rest of the netdevice initialization code in place,
at the earlier point of the probing sequence, including the
settings previously done in ndo_init.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
---
v2: new patch

 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 71 ++++++++++++--------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 9329fca..559154a 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1143,34 +1143,6 @@ static int dpaa2_eth_stop(struct net_device *net_dev)
 	return 0;
 }
 
-static int dpaa2_eth_init(struct net_device *net_dev)
-{
-	u64 supported = 0;
-	u64 not_supported = 0;
-	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
-	u32 options = priv->dpni_attrs.options;
-
-	/* Capabilities listing */
-	supported |= IFF_LIVE_ADDR_CHANGE;
-
-	if (options & DPNI_OPT_NO_MAC_FILTER)
-		not_supported |= IFF_UNICAST_FLT;
-	else
-		supported |= IFF_UNICAST_FLT;
-
-	net_dev->priv_flags |= supported;
-	net_dev->priv_flags &= ~not_supported;
-
-	/* Features */
-	net_dev->features = NETIF_F_RXCSUM |
-			    NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-			    NETIF_F_SG | NETIF_F_HIGHDMA |
-			    NETIF_F_LLTX;
-	net_dev->hw_features = net_dev->features;
-
-	return 0;
-}
-
 static int dpaa2_eth_set_addr(struct net_device *net_dev, void *addr)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
@@ -1418,7 +1390,6 @@ static const struct net_device_ops dpaa2_eth_ops = {
 	.ndo_open = dpaa2_eth_open,
 	.ndo_start_xmit = dpaa2_eth_tx,
 	.ndo_stop = dpaa2_eth_stop,
-	.ndo_init = dpaa2_eth_init,
 	.ndo_set_mac_address = dpaa2_eth_set_addr,
 	.ndo_get_stats64 = dpaa2_eth_get_stats,
 	.ndo_set_rx_mode = dpaa2_eth_set_rx_mode,
@@ -2316,11 +2287,14 @@ static int netdev_init(struct net_device *net_dev)
 {
 	struct device *dev = net_dev->dev.parent;
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+	u32 options = priv->dpni_attrs.options;
+	u64 supported = 0, not_supported = 0;
 	u8 bcast_addr[ETH_ALEN];
 	u8 num_queues;
 	int err;
 
 	net_dev->netdev_ops = &dpaa2_eth_ops;
+	net_dev->ethtool_ops = &dpaa2_ethtool_ops;
 
 	err = set_mac_addr(priv);
 	if (err)
@@ -2356,12 +2330,23 @@ static int netdev_init(struct net_device *net_dev)
 		return err;
 	}
 
-	/* Our .ndo_init will be called herein */
-	err = register_netdev(net_dev);
-	if (err < 0) {
-		dev_err(dev, "register_netdev() failed\n");
-		return err;
-	}
+	/* Capabilities listing */
+	supported |= IFF_LIVE_ADDR_CHANGE;
+
+	if (options & DPNI_OPT_NO_MAC_FILTER)
+		not_supported |= IFF_UNICAST_FLT;
+	else
+		supported |= IFF_UNICAST_FLT;
+
+	net_dev->priv_flags |= supported;
+	net_dev->priv_flags &= ~not_supported;
+
+	/* Features */
+	net_dev->features = NETIF_F_RXCSUM |
+			    NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+			    NETIF_F_SG | NETIF_F_HIGHDMA |
+			    NETIF_F_LLTX;
+	net_dev->hw_features = net_dev->features;
 
 	return 0;
 }
@@ -2561,28 +2546,36 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (err)
 		goto err_alloc_rings;
 
-	net_dev->ethtool_ops = &dpaa2_ethtool_ops;
-
 	err = setup_irqs(dpni_dev);
 	if (err) {
 		netdev_warn(net_dev, "Failed to set link interrupt, fall back to polling\n");
 		priv->poll_thread = kthread_run(poll_link_state, priv,
 						"%s_poll_link", net_dev->name);
 		if (IS_ERR(priv->poll_thread)) {
-			netdev_err(net_dev, "Error starting polling thread\n");
+			dev_err(dev, "Error starting polling thread\n");
 			goto err_poll_thread;
 		}
 		priv->do_link_poll = true;
 	}
 
+	err = register_netdev(net_dev);
+	if (err < 0) {
+		dev_err(dev, "register_netdev() failed\n");
+		goto err_netdev_reg;
+	}
+
 	dev_info(dev, "Probed interface %s\n", net_dev->name);
 	return 0;
 
+err_netdev_reg:
+	if (priv->do_link_poll)
+		kthread_stop(priv->poll_thread);
+	else
+		fsl_mc_free_irqs(dpni_dev);
 err_poll_thread:
 	free_rings(priv);
 err_alloc_rings:
 err_csum:
-	unregister_netdev(net_dev);
 err_netdev_init:
 	free_percpu(priv->percpu_extras);
 err_alloc_percpu_extras:
-- 
2.7.4

