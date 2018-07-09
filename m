Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C961AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D48320875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p6IAX5IU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D48320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933306AbeGIPB4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:01:56 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:9760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932879AbeGIPBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytbN/x2PhiZdQMBNo4LWC1MWvTe+rXXGJP3fwL84c9A=;
 b=p6IAX5IUDn1NWJr+w5dWKLzp67RH2VGygkuapkr/LmQQbZUxIn1/r2y4mgpnU8USJ4GzSwoF+63+OTyUN31gDXd0AWREWY6bO1hJRZ75P8cUz8HrEGk25AiCF6vOB3TnKZmMpFwEzcUn3Xbvrhj+5ro83G7C3/2/62bQtco9tdY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB339.eurprd04.prod.outlook.com (2a01:111:e400:881e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 15:01:34 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 5/5] staging: fsl-dpaa2/eth: Remove Rx frame size check
Date:   Mon,  9 Jul 2018 10:01:11 -0500
Message-Id: <20180709150111.8875-6-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180709150111.8875-1-ruxandra.radulescu@nxp.com>
References: <20180709150111.8875-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0085.namprd05.prod.outlook.com
 (2603:10b6:803:22::23) To AM3PR04MB339.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77558587-d12c-4a5a-3e69-08d5e5acdd5c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB339;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;3:0cwMdB3TNpbsPOxYKHMMlmmfO5HBanWTF2F9klwtyGUJUrs0N12ClqmARn6LO4HRBHbjB7zfDcWVQwaFJViWfj+E3Cn1aNUnv1xty4SxeN5qaJWwe05yDVyeCurHJ48yqKcPW31nQeOT13z9Z52clr0a9s8gVqbUh9zisbJR92/OPVS+mzfcOU8VDIY9bBVxs0OnOyl4JWvUIuIg2hf/RFmg17t3aD9qJMfCN+27axBCnI1mSg1qpdWRyoXBMj4q;25:1ar8jxCaJRozOZR8K0iwjT3US4cixNjojaunBXTtmdXs6RUqZY0SuamrKROcNbU08Pe2KLES0gWzTBOam6GtZB5eCk5SiDG4CEDBgBbFcnDIvp6t3p/a1BgVZwK65sBSPZePnRVhF82Zdrq/fco63HbDfsnD4HKNwHXdkZ9Yt9YdKLrXUWFJARXMPm1aCnGO+MS+XoHVtABPXbZdDbpL00GbfRt2Ve/56FRhjO57rPX1QjK+vd1uFmOh0OVrfL6pVYoseSNDFElUBUneIQ4qcRCWPFnFJqY5ktGUUy/Fbx1CA0+cYXGl1a0U8wJOK5yZdkmPeZKJj2ALFzi4CcxZDA==;31:+7ZD1VEW0MqrgtitjCDcXa6tlHkAU5671+BEIhOfo/YKgpEq8NyahMKPkaYb/wg1MHmgmJAOvAok0Jz3M6Ppd2uApVo/QZ4oaUVCRHdw10f7pKqNODrR5z6l69CNDyLu9sKe9Xd4G/mD+7ylBHfynBk1cCA1dZh2rTkKukq91S4skpTpLoAKRoI6KJ/Z3vyGVuqY/78VMEPnvR56Nos2ec2RgXFevZRkovjM3qJ8mJc=
X-MS-TrafficTypeDiagnostic: AM3PR04MB339:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;20:R9HuRxFVWrepQlllnWO1ABDNBkHib4C01o8Im/58r9ffzI15k6UO43IbTVKgoxskyTUkyzQcinfvEUCGrgtO1x+IKAsISQFG9G+Dj6fcmt17az5qJ430a44ET/LUpVySMys+go5PegthPoO8mZ8kuVgidGaV41kMzGCizC5pTJHXYB1QuiO3dU1Dag+8vZ/KDTptjHkSGlkTs4dHrfFyEChyzLzOsZWN05NGj1Cn2yyIylNLroh3emaZPlaNJq39FAZQtK5K7ga2TRUZprbZU/ZdSq/lHVC3xnA+YRd/dZscj8Iu0WACy/03nbzi+9Q7FlcrhmbakRPPbUVAOoJhJD1YWUBeLe57AX/bV0BTlNjeJTSXh+lqQTaONVX7XPlT9rjV81zzkRvXSech3+w19a3UeXZLCUy4UfApZV1l5Kzgn1kAzFxOv3RlLygpUzznAtDCR86gfHqqkAtA29pA4vqtAFUyefoX9tE5+VN2+KrXul4pE6izZLhnJtFYYWKh;4:Jlbk+47DR6lveeacUSrEewnvoCI7zQgUsJKs6MTyg1zRiYnSDVWfhp1NMadAiN70pzI1OWMs+o07EXMPSH/tpIs2X/qLHON2u2bP3tdHdwMKGgYc7hUvD95up8qu75O9q3XhMMLKe+6+k5G9F74QyebigOZ3iamHPdbeHXX5L/DsUBfrunSt3A+02KBupgNMo4mWNBjSZECQ7y2PQME+PqR1et0mHOozszgml4uoH3aLtX64Focm6TvCTHVuhT2nN3gOIBt1RbfydN15GV2brYPDPzX9Y2nFdq769BhS86pJOpL6Pbcwgoi+V5ZDf+MK
X-Microsoft-Antispam-PRVS: <AM3PR04MB339306E86DBC02B2F97F3E794440@AM3PR04MB339.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB339;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB339;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(68736007)(4326008)(25786009)(53936002)(446003)(6916009)(6666003)(1076002)(5660300001)(486006)(956004)(2616005)(8676002)(81166006)(81156014)(8936002)(305945005)(14444005)(3846002)(7736002)(11346002)(6116002)(97736004)(478600001)(2351001)(86362001)(6506007)(186003)(316002)(16586007)(76176011)(16526019)(106356001)(50466002)(51416003)(50226002)(52116002)(48376002)(26005)(105586002)(2906002)(476003)(47776003)(66066001)(2361001)(386003)(6486002)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB339;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB339;23:fso80EuC0h4EjjerBxtQjNiuZxyZx9Sv6aAlrmLUNf?=
 =?us-ascii?Q?ys9MFA7Vr+KLbUJE0bv0geoQGvbm8wv6ZIia613/YGGdBrlL8UOgmVdBAnI3?=
 =?us-ascii?Q?S2i3TV4WWyFML0/pRWisCuVPc5Z1qD+3OUVg44VUj0LSqsQM96jFIL91oCTZ?=
 =?us-ascii?Q?pKa1P5mITJOTfcUyt1FwG3OaNadGjy8xNnzF/r4lnS3BNMn5YFPCmJ1HgNsZ?=
 =?us-ascii?Q?bFupywEYWGeR8NLXBD4opRD0eECFB88u0jkVPZITOY1gHei0qN1YBohRhihq?=
 =?us-ascii?Q?PyUfkzF9bot4j4I8CoIjSSyMOFc7dLHMC0hAnk9zybkWkAfO0WzbuHZWM7X1?=
 =?us-ascii?Q?4aHohvwuqnhztFe8VjnGRgHhtB32bENNZWs1NkbxpWRTET5kQM6M0WVJbTqq?=
 =?us-ascii?Q?s3ktNR2PcjIOGfZE1tFvczm7zCm34sNG3SXOfYAQROVMMJkV4c0c5kDf5p6H?=
 =?us-ascii?Q?aoAHRZXsYeDzOLBrrWei65piMLZYBCx6KFrHPWACQDgeVn0HZ2IyqdANlOt4?=
 =?us-ascii?Q?SjfPpXBihovAG2vx3LP6fnN9MVTq8OlFeICKScS65TQ0QnC0YNVaj4PnkfFQ?=
 =?us-ascii?Q?NyckPCaR0OlN4IfA4IvQSRphqosQZrCNVeVLAKtUeJun6DMYKc1ficcy0yHh?=
 =?us-ascii?Q?3WDr0hqkOxyS5uz2xaZ3/+NhZ6Sm1AZySF6StfVek8/HYGPTTv/bRnOZv1gK?=
 =?us-ascii?Q?1wX5mnnU5UT7GR9ug8f2zz2t97afJKDYaazEfj+SMHCKLdFyHfNjowIu+tdB?=
 =?us-ascii?Q?dZFKkrjXEBFjmyM2a8Bn5uHxJEA3JCYFPA22P5tHZ+zFnbcGDddfcST1oXi2?=
 =?us-ascii?Q?wGYhjHYXDrG/zGzmH9tlPbzMfpbcdL21mYch+b58PAWIkiX85Jujr6YcW2S+?=
 =?us-ascii?Q?wJNy09P3o4jIhChePP+9ni2EEazQn3PAShRdE+m8CciyL5kdve7CVIe/jyT6?=
 =?us-ascii?Q?1sFABWTbrS0j/oTxj1dNOLyFcZl1NaqVtDSMgauzku4+w93tOZ4ykzJJon41?=
 =?us-ascii?Q?3KdBDxeGy+6BIXiSNgGLrtJBUvPiyHwMvQUOiSX25+ebpsixnVmm4CJXabmG?=
 =?us-ascii?Q?8PdFOUWJQixZAPT/+q25vN78jmtBXJenSkd2Dlh/V4hbZo6SsJ7WQVvAT6Jh?=
 =?us-ascii?Q?pWV7zHHeHxoqP75zcQMI3aRmf4mbBgDIUrDG0HZDH2bPkIGXihv4sPWRrTYU?=
 =?us-ascii?Q?qhHfP1jcz7PYKAUiZ3KiNKPal+J58AVRmX/ZDmLC1VZ0DzI7PScle+gzzk9+?=
 =?us-ascii?Q?ms0pLV96uCrEwvhNE=3D?=
X-Microsoft-Antispam-Message-Info: u9cGtCmH6NfvfI+Zss2CMSsx+v9ArlFmYAco3/Pzm4jsZuIBR72FcOgIBuCxJsTNwX+9ALwBZIAX5yNxZw794gGaSwTONLi8Uz+7FcHHCUF9UyHoP0rSUrWdWrrmApqsNMKNQ4uJRIx8EMRSU6EolRRrZl4yhmytiKrBnYwQdRknvT2yKfPTRXwJUJNQmvRhxP2euAacublobFr29SCCPx0JSgxJTdf6imLZq7zhwg53A7skLdY54UISBIboolP8Uagy550LQW+CDgCJIzc5ayH2nkZog7EjJ00Ffh/A8xkjaikXLRUOMoxdWrLEl1NRnBbc/M9BqblIVmefHGTVuVaa7cSCh7BXiVbO5mOWUqI=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;6:NYdQ5Y54WoGq5bNr/jW5lAhzN1XACsoahr1fnAWDAae9hT9Aus95PWn3XzUxwcxPKSsWjdE4IcjoX0c6R7OcGWXbjxQDo4A2DCTgFXXL9HGNwpyctXC0uV8ktaRA704t+NZ81k1c2EIO3vr1Qf0qDMLn5IHMLKS1NyHu3Pz0MMt+JE1jY1vffiFoNKQ/fzZgtGZezACl0dbIhZB1Qs3rHkdWUMigw1zGQaOpdrADubLuzPM0UUelmLRd4xID9MsiVn/XJnyojomG4/l4GCwb795lCNDndlyVzrFNZklONFm41yZ6GyNjvY+3JCunD/q3DMgAoo59VVCcvldbQOWlSY91QR4Z0RIew6585Hb52UhW95miPQQx0CZ/xahOeOz4zfns+e60DXdhNWp4547O1Z9TK8Fo1/o6vDxGmcJROQFNMWzeJmlRhDjN3N3BZnJGhRn1NHjoIEWUtotVdKCVdA==;5:WwQYx1q2Lu5ZxaR+rRH/e1vB7bT/Mr10nqzvKn0Np86XS2+dKw+hztCp69RcTQZjEZGrPteE0ILEskNiBhtMkTnTo7G0RvNG9R7fMl3zrn/1GjVI50gYDJHaLmPuooquJjZJoS/xsb+FzweBIE+GOvKWmJvCrSo880+3m3FSV5o=;24:Ct1YekFyJosJ2Wa6H5etXFl+H2jHcMJm5IcuO8zmSEi1MkvHcYuH6Xs9edI2t2xQlcv/8g8epuOxI1ZLq3Kf/VmJGlk/46gYvAUrU41fGdU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;7:tYvGNnC8D8/jxyFjBbhwc+rlopGWPpATEW9t6TGgRNKt2PCS+htCBvTf/a+jp3TvsvyfeJVaYuUQuAaBWaPECq2gDBAX7mc0gukcsbT0SULGQmdsD2gxz9IiuS29DimG1x0tEAVdmgEA+CYmcEhgwxRO+E7Rceex4GwfXrvwdIHYk2+rIlNCJbu+GqB0YqO2bScktxTrrt/PE5H5itYK9MWiPUtm4a9PCldoYN6+rVgrGPNRfcyzRCoi3twUUoc2
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 15:01:34.3426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77558587-d12c-4a5a-3e69-08d5e5acdd5c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most Ethernet drivers don't enforce the MTU value as upper limit
for ingress frames. We too support receiving frames larger than
MTU, so allow that.

Remove our ndo_change_mtu implementation, letting the default
stack implementation handle things. Also, set the max frame length
allowed by hardware only once at probe time, with the largest
possible value.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 24e069c..4ae2371 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1243,25 +1243,6 @@ static void dpaa2_eth_get_stats(struct net_device *net_dev,
 	}
 }
 
-static int dpaa2_eth_change_mtu(struct net_device *net_dev, int mtu)
-{
-	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
-	int err;
-
-	/* Set the maximum Rx frame length to match the transmit side;
-	 * account for L2 headers when computing the MFL
-	 */
-	err = dpni_set_max_frame_length(priv->mc_io, 0, priv->mc_token,
-					(u16)DPAA2_ETH_L2_MAX_FRM(mtu));
-	if (err) {
-		netdev_err(net_dev, "dpni_set_max_frame_length() failed\n");
-		return err;
-	}
-
-	net_dev->mtu = mtu;
-	return 0;
-}
-
 /* Copy mac unicast addresses from @net_dev to @priv.
  * Its sole purpose is to make dpaa2_eth_set_rx_mode() more readable.
  */
@@ -1469,7 +1450,6 @@ static const struct net_device_ops dpaa2_eth_ops = {
 	.ndo_init = dpaa2_eth_init,
 	.ndo_set_mac_address = dpaa2_eth_set_addr,
 	.ndo_get_stats64 = dpaa2_eth_get_stats,
-	.ndo_change_mtu = dpaa2_eth_change_mtu,
 	.ndo_set_rx_mode = dpaa2_eth_set_rx_mode,
 	.ndo_set_features = dpaa2_eth_set_features,
 	.ndo_do_ioctl = dpaa2_eth_ioctl,
@@ -2385,6 +2365,12 @@ static int netdev_init(struct net_device *net_dev)
 
 	/* Set MTU upper limit; lower limit is 68B (default value) */
 	net_dev->max_mtu = DPAA2_ETH_MAX_MTU;
+	err = dpni_set_max_frame_length(priv->mc_io, 0, priv->mc_token,
+					(u16)DPAA2_ETH_MFL);
+	if (err) {
+		dev_err(dev, "dpni_set_max_frame_length() failed\n");
+		return err;
+	}
 
 	/* Set actual number of queues in the net device */
 	num_queues = dpaa2_eth_queue_count(priv);
-- 
2.7.4

