Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeBZRZW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:25:22 -0500
Received: from mail-db5eur01on0062.outbound.protection.outlook.com ([104.47.2.62]:2949
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751505AbeBZRYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:24:41 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net-next v2 3/4] dpaa_eth: refactor frag count checking
Date: Mon, 26 Feb 2018 11:24:03 -0600
Message-Id: <20180226172404.25584-4-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180226172404.25584-1-madalin.bucur@nxp.com>
References: <20180226172404.25584-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: CY4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:910:4d::30) To DB6PR04MB3271.eurprd04.prod.outlook.com
 (2603:10a6:6:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9daa95fa-7f87-4478-3630-08d57d3dcfa4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR04MB3271;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;3:Kw2FucPtvh+TKJnysv4jx0obkRWWFrFHasZ3gITbgUuYe6IDAfBi53Brnm1iHbQTFvHJYMuQk6Eet9Yho1yrYF8hhSJrolxKwM9d22IIXYfBYQfogpVyUO17czCoUO+yXFBwmeCFPKkTn5sJi3WKD6wlNJ+gpi317tetb/MwsXZbEFNQ5PQeUsrFOp25hQ7U3/QUrtzXrahZSDsjG1IFXEw+404azK/B/eWJWln4GAKPeSrRg10iQj/K0lB5as/L;25:YHL8vPt9lwx2fXkE6Bl631MvyTBXxg8/HDDQmbHo2k80wkclWamORQXU77+9r2oW3b1ngFTpqEp18Z8BBXHttxsekZJGrfmpa7uOazSQadR+dcyWf6xTcY14KAscKRFDsO6aqilS817RoV+TopYfWmcO/Mfk0tBzFN9PZW6O8lodx5/adeGPVfSj6Gws6kCg2fTiwWeb3dl9QbNFf3o/q3jKk4vX2L/qDHKsKiZUq93ecwgWw46z17iZdp5htjVUX2NmscC/TgJgpX98HdhH1SDw0JftstKljCj/rtnCHsgSOKMV9sGLcux6T+whdkVw71iVJzlTnwj34r57dTjIAA==;31:V4k7Msfv7zzLLb6oOSK/TQita1GemJ2a0DlPqS1y3D6Yeba99Q1p99FQEJgYR8u+FTwhySH2YPBX989yGBoS9+/FCV+QUFFYNWfiOD9M0sk+BDmYG3W3k0Gxw9Es7i73OTnqTua96jaS8bmZQgx6io/eAc2/KyPli6e/jxuDHKhVCAvpXh9aqH3oqQdn/b65JN9RwHplmFlRLCqqwo2gMgkfcgrfmyz2pH4uc/YAK9c=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3271:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;20:1Vk1bH6Qv+3Zp3VjAQg5E84r8K8HbBK96owWnAzzFNDdwPYLL4a+IMrvZb0CSp3JOiau+BmHpqFjF42HT7FWBb6mRcrnPps1H19Oxlbh8xuldR6AI+8XRcARWUgV85CqwBbgUF43lmS+5/ilnUwosVoxBSu69byFkqG7mw+0+U+sEz4pFwS9/wzkB7EIQb3vx59k1AsjwMMzl8Eoi31RuS3Cdwu2JEsjm+FcJm+4ym3f0JxQfFGs6CZPShJk3j+WWky2a08s2X6n4rmr9zQ33JDHt3j3Qs1YfN4NYIWywhNSfUjuY5gMkV1/HqW+bzCAt+C53lXhLphjc0rUNdme166ovTNwDlpbqiTZSq3bnhg575sNVGZwJE0KBmzAzj+3fiycadvY3cABrOqeC81JEBNHXk8hGdPsuQ3fcq+8nlpdhKcy5p4rVEsnVa0HjyHGHUHsxnh8tmOM/1OgIKYD2qi4B06pnK2JQA5WJoIyHfw4ALzK1fdJwIODclJLyBCK;4:5YBT1beuzbnnICIRM1JWJzWAQ6hl1pouJFXuLciiIMP/qTOl3hX/aFVS6Cz0/WeNlX3HfS/g4bNusLI1CzjB1EVEuGBoSBIGD+w+FntmKuYBwzJ2gdmarC2kKBABgxFjR2wejq7QrwRLLBUILO/qK5goJOCbPOY3v5vPtmcLCeldjt/QMbTNNFr61M2SHwQseiTT8dJlTiEHN+AdJ3e+P8IWiKdqkJesm01mTbAQRMgT5EHtcRSrkBrumo1dzPfQCW1RhhuV0jzIrv3PF3Zo2dUYUWsRmiaJxvpDkMMEaC5fBDpGjwbnNving+DtFJnZ
X-Microsoft-Antispam-PRVS: <DB6PR04MB3271935A32FBD5596FE8DB88ECC10@DB6PR04MB3271.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3271;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3271;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(8676002)(81156014)(66066001)(76176011)(81166006)(68736007)(7736002)(305945005)(386003)(316002)(2351001)(50226002)(106356001)(16586007)(47776003)(25786009)(26005)(4326008)(51416003)(8936002)(52116002)(6506007)(16526019)(97736004)(43066004)(2361001)(53936002)(6486002)(6116002)(3846002)(6916009)(2950100002)(6666003)(186003)(5660300001)(50466002)(105586002)(2906002)(3450700001)(36756003)(575784001)(86362001)(1076002)(48376002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3271;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3271;23:0MoFAth5hAY23IjAk3Ihhrg16000TV6VUmlp7qdy/?=
 =?us-ascii?Q?xV/9PWQ+7Q21zuUexFU6aOZcE3QXAxJddVMM8d/bB28bUBgGVLvsMdhO8wfn?=
 =?us-ascii?Q?SwCFSHumx83xqVXTt8oybEk00vFmrYCITrV3+ZnPjXOykm2qwkn39aLGJsS5?=
 =?us-ascii?Q?IJQHem6lREtLx8Meh8DbSkehZmQibQJSPaNaYBqvaJRVbTXmu1mhM/1tvBjn?=
 =?us-ascii?Q?DEdLnW/DjYPl8bksMU7u1bFC1IDCG9+L6VdVrWkgCesJYktiDwnbT48ERdqu?=
 =?us-ascii?Q?oBPuV8At8KR71Swz5cKZCwm55e2/2ZsWJ/qW++MAT2VIrsJi7a0vOcemgzhD?=
 =?us-ascii?Q?y8ugQuSjLSqrHqHHppdGi4rEXLQg9NvzxwhDnQTuxmjS7TDxc1WT5Ace9N+y?=
 =?us-ascii?Q?QyfjCKzQ+6uNHtWBNMF82Go0Vx7FjH/JtqWY7gBS+wt+5WBkVr5kotiqZB/S?=
 =?us-ascii?Q?UEN2GkCPYyAVPB/wpvSASwTCcnMjy13qpOfMeIgCAiTOyjajuD+wsxm0H04S?=
 =?us-ascii?Q?/VFfiZS5rbNnZtqKdJeeYjOawZeq0aXhBmZEb83aSYyorzoHJy/OaJypmPEA?=
 =?us-ascii?Q?XSkkphDPpxWpRdxvuank82j3vo7j9riSMS/2bUFfcIcJTp4osPsBdpul1Sw3?=
 =?us-ascii?Q?GwWrWHJC3KoqJuZk7LxE+7FskoNQjQ/Y+MvBx+oRmkBGcBqGqxnOLsZeJdZU?=
 =?us-ascii?Q?KxZpDwHOE0pawYydYiO+YwyoFbd95HJL3V+dNguvEmuS9T9vL5iB8suN1hQP?=
 =?us-ascii?Q?B3FUbUujub6l+BXc4aG7R/dWGNMVLdlEkKYpc28ARBHUtgdewfqvKJgEKkcW?=
 =?us-ascii?Q?L69puKmh/OU8Ewriq1kGYmFjclcTFviQh75M0nfej7/zQCA36BQFTj1xAZKq?=
 =?us-ascii?Q?65S48HAehBKIx/O1ym2S1xY+rwNxsUmB2UCeohtX4BM5DCA+Lz0KfA1WjJzf?=
 =?us-ascii?Q?3Cfq4ZPslQiOihom51/K9AzDBonsfQbvrR/l79+YqIlCcMr3Y+1omyeCMLKn?=
 =?us-ascii?Q?zYtrkKMh7eivKxvF2r8xYKLTngncApYqqsnXVh7Kfj3IPaKloyBQthWLB4pi?=
 =?us-ascii?Q?GxZbJL2Hor7z53nBtdANzEcwdK0zCCkMJnmKgz/K7wBUAJZOWMOc/3Uuem3G?=
 =?us-ascii?Q?tLSB1VUJZyYinGqRU9L9nNwMNEwgjZS+QFVYmfW3AwyleWedW6GSRF15dpGR?=
 =?us-ascii?Q?SNXdH6GAL17J9AuKx1LNJ/g9erW2iLpY/qOoTEaGZuPnIqJld4AraeUNw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;6:GaVR1SUSvbg0I0CgxF6u3BaW+6s70CWWqLpk7LWbxNhbwSHnLnptSW350Sfw0jIVaS+yhFq63EzfmGtYF+UXHMdbSJFets+h0vvVcI5dVnjGT/02cgddrwd4lNpYjLA52ef+0/JRQJFVFkkcS2044zQCzVX3HGcZhAntFSPK+nEa2uIL3M7YKQKUJ1rM7j/6EhMZIFgmvyweHb8LEqS9eEcqVw60VM2N5AKuH92BHdGqJ8FUn6CZVTrHSuSeyXiUTD3EVkyd0eJ3FNdzDBSDr+9+Hn1UVrJJsw+DuNzB++TNaa0ncGFnB26NcopazoXsVhbzjcEZ5q6qWHl5Rxvc36we9WAjmW7irZ2zcXrWTp4=;5:jc9AbFiyi2r5ie62M7az2OwNwqd5PT2SlGCV65ZoitnPDlSLG7riT2IRHP0SHsS5ivkfaivx99GHAaeax5LnS71AIYzrj3Qw7xKyhIk0HZaK70Rsh5M2T9eNh2SS/T4DMDaB/bBGiyrk/aI7LZ7A1zu/2IWgHdXxREKSo98tQ/o=;24:m6a4TQyUHrMrYssjFJtbPJkOTiEcMn4AwBElAGm9i46mZn11Dn1RoW0yG4M6Ql14Z+2gNVNwP5UihpqtHwDt446NBsCCfecipoh2Qq4Levg=;7:yVyUSzfgAZGiQpHUwIRMee/AWIfygFcMp8Yt5Rym8xvP/g1+0RLi6F8J6rT6irDAU/Hcg7g/uS8sPEpU6w6oZ4eTu895UeLLEfBH47uFPVy/3xaaEttnZUZikZpM9k+sBaQ11kaSN8Pi87oX4pAonarfairGnIWkdp3GmixGUfeAdptwFcyDSnuVst52xam8OU8ehgWthvsXFz94Qcy60KXOHa63JgYVu8kDgc8OyrGGkBuWRMwXmw70I6z72+R6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 17:24:36.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daa95fa-7f87-4478-3630-08d57d3dcfa4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3271
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index bdf57fe..9bd0ff0 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2055,19 +2055,23 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	/* MAX_SKB_FRAGS is equal or larger than our dpaa_SGT_MAX_ENTRIES;
 	 * make sure we don't feed FMan with more fragments than it supports.
 	 */
-	if (nonlinear &&
-	    likely(skb_shinfo(skb)->nr_frags < DPAA_SGT_MAX_ENTRIES)) {
-		/* Just create a S/G fd based on the skb */
-		err = skb_to_sg_fd(priv, skb, &fd);
-		percpu_priv->tx_frag_skbuffs++;
-	} else {
+	if (unlikely(nonlinear &&
+		     (skb_shinfo(skb)->nr_frags >= DPAA_SGT_MAX_ENTRIES))) {
 		/* If the egress skb contains more fragments than we support
 		 * we have no choice but to linearize it ourselves.
 		 */
-		if (unlikely(nonlinear) && __skb_linearize(skb))
+		if (__skb_linearize(skb))
 			goto enomem;
 
-		/* Finally, create a contig FD from this skb */
+		nonlinear = skb_is_nonlinear(skb);
+	}
+
+	if (nonlinear) {
+		/* Just create a S/G fd based on the skb */
+		err = skb_to_sg_fd(priv, skb, &fd);
+		percpu_priv->tx_frag_skbuffs++;
+	} else {
+		/* Create a contig FD from this skb */
 		err = skb_to_contig_fd(priv, skb, &fd, &offset);
 	}
 	if (unlikely(err < 0))
-- 
2.1.0
