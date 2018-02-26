Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeBZRZr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:25:47 -0500
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:4820
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751022AbeBZRYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:24:36 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net-next v2 1/4] dpaa_eth: fix SG mapping
Date: Mon, 26 Feb 2018 11:24:01 -0600
Message-Id: <20180226172404.25584-2-madalin.bucur@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75dc0ecb-ddf0-4165-370d-08d57d3dcdc0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR04MB3271;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;3:JdDYojt1RZValyq/bmif/bYtrDuFsQ834OUjVuSAghLX1EMknymKTCJvhImgYR+WtcZEzhNDFlNaNx1ffGysF8d4ANWqM7XnE1L65ujjW+kTxZFJfqA8Q2/ZgcrDrboHkS6YEYE5uB3D+4ZA96NR51555YU5n3mZJ55HiajwYwVZ92W0s3SGeV9mpOyoPwnyTq3aMB7iY1qKov4vMSeh83/rnopeQs6TsxvD9T43ra21hsimkuFmxPHYk1rp+1Bb;25:15LexDt2rj8+6lBoBadMuNURPfXIEbTQ5qix2LKW1jwbUvkmh/rJjxx9X7adQEqvsq14iH78VHRLMr9Rh0xl/2R7gfe9rSVfhWNThn+CPeF4xl8cIf+qNstKZIpI7lwIxlzQW0om4aV8nkf/UTdV6TihZZDsXOEsrDB6Oa7ToKcEo4XAiZNHvdRUKGGmFAzx7BzdEDrlgwiAlBDls0NCbT9DVWG25vUs9px33bP0PX1anq1jMMmUKZbBgm4isRREt48xTjz08Ni1fGCYoaLdIdSWbiaT7fDGrZ3Azpqn6imLsExX1/yY/8e4/elEFiXOFbGBj/mneyQxiZ+TZBoFYg==;31:UKvFBjxJ2HXbOdACRePmhJOY5EQSvPhz7vjBswJT6Waw+sl3TnSJ8/kdzMgsK9rCm03AdfDp9s1+orU56UoP6FVkOLifGtIdpDSaBW2vuXp2uqt7TpWtI7vxNnr95fn5/kqPjNaU36YQndHjcoHnT5rB0mI7kIIjF9KJqM2C5seHFnCpvdilXHZGHzQohoT8l50kWefVO8AX97Yb7sOkOeAwxP7sFGr5V6YwcOrlnUw=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3271:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;20:IZy7NnTQWNIYEe/WNaK6unBCY2vB3iDt603G1pzH1QURAYPFy9A+nYvrZ1NVJvusTfq5OByMm0sc/t2HeZ7uGsty1S+v1ODL0Rs6ZtmR0uo5BFo+M+PD7x3VekjAUv1FilWRTjz+hkf/lFCm7FKW0ZUOAfeyidvWuMJuof7lV47HhMQZ0fkR3EvUUR369GAHclo7i4RS81o5VJtFT9slcS7+5HJXIUgP7Asdyix1QfRF3T2EFZpHwl0WZLSNp2NX8y/lsbEcoVnEOHwInp5Sb2st6t0PDIDsJZQ+i8gk4WGRVduUD9qGqwDeQ/YdXIPIIevPKSZH0jGKQnzPC7d+nXvzuR/sWYinbbfBsn3veqOUzqiDPcY4HHb80kgnvBqUhH/vKwgPTWDt8OEPBIKzpT7G3A1b5qO3+5iI4cG4MY80LB195b4n27v+HXfO2EA63JaXdymCQvNz/oq6YmiLYg+vvZdqlUrGCELLax6kmQY0qMQs4iKtfp5Ax6rY46O/;4:uQFeJKKHBiQNcy7HRU7YTW0Wzat3aGFXfiy+VQ6be448Ve+MBhntdM5Mzqp8cq8mkDpmuoBd4u0qg3hlF3V47LmpYk68d1Tm4+lt2O4Ammj51K2wLRvb+8lcDSElDqQP2P7GMoCs2dYVkECVOvodUgXN3SUiEsAVfYw6mlFV+0v6y+Dsafo/HLYIU0zpyRCl8JDUO51LH/1hDuCf071+Rum/xdqS3r7S7aZHa/Fc5QGqr06VKXhK1pOhn0AhfkplBwl/mxoLW33CcAFC38BrkyI4o8KEGiimOQbkI6v1DR3dSU5eo34JBu7opxWaTpDQ
X-Microsoft-Antispam-PRVS: <DB6PR04MB3271C12F3B62063D811A08C3ECC10@DB6PR04MB3271.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3271;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3271;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(8676002)(81156014)(66066001)(76176011)(81166006)(68736007)(7736002)(305945005)(386003)(316002)(2351001)(50226002)(106356001)(16586007)(47776003)(25786009)(26005)(4326008)(51416003)(8936002)(52116002)(6506007)(16526019)(97736004)(43066004)(2361001)(53936002)(6486002)(6116002)(3846002)(6916009)(2950100002)(6666003)(186003)(5660300001)(50466002)(105586002)(2906002)(3450700001)(36756003)(86362001)(1076002)(48376002)(6512007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3271;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3271;23:JKP9YH/y6bHB+SUzm3WN+/jGs7Fr3Hlg6Q5ed86X1?=
 =?us-ascii?Q?Dd6VZUL5XcNJ+DfgPHsz/KwyqdpZBFk45P6+ocyX3DvOBkmzvsnZUHlkusac?=
 =?us-ascii?Q?EXHLFfxKiLu7+BYfeHKknDJrjB1LWJBTiH2ilDz5oJj/uty+ltBEIkUoahqg?=
 =?us-ascii?Q?P8qS/kjV35Mml0Y3vXhm41w2y+iJOZaVUIRCKYaDC0V3aEoD3w3InVU3WmvN?=
 =?us-ascii?Q?EGT8Pgs4K/k0niNgOmQJlwMo66M5NqeurMFxDGHiFGZIypvepK28smqE2DUC?=
 =?us-ascii?Q?U+jVZu3jotZGsPpFUdISNnR8Bhrmqb7AALwNKl1ydfzxA2x1t2Ap7+MskqJs?=
 =?us-ascii?Q?z/ACH53GDWakLBxWkMdjMCJ1xRDWPVcqMjRsckAPFbmv42nHM+DVnwLfwjW8?=
 =?us-ascii?Q?Ua40xXkZHCARgxm2nRQo/8RtamkXSfHeGIsL8sXyCi2zJkJaIpYzcKWVuNGE?=
 =?us-ascii?Q?LCYf+Wm56HJ2YxzL3bvWqn5u3yNfFnJp38e4boSV/QDSKnKRtOV+S7iZGxSc?=
 =?us-ascii?Q?YGr28ba1u4+R7Gusk1/MvamzgE7ktvmcfuYO8Xl3XN8Fo8IpgC0ODJGLNA38?=
 =?us-ascii?Q?UBvfrVNn6ubx9UjAfYjieFnJA0QJKsqIwiCFBGLCcGiLhh5FW88N4jVSL7/p?=
 =?us-ascii?Q?wxdZasIUbQf4tEi900lf1eDBipv5utxvHg2AsQH6kYXyrJ6P8s1sGsgWC3k0?=
 =?us-ascii?Q?nhRAMDJt14YfE1FV6jL2vDaBWjmLSKzAqA0Z3zOsc7yUQgbSxYlr6fVJTAU2?=
 =?us-ascii?Q?EyyJ85y7U+F8XlAzuNGzaS+QT72f+UIhw93lzXkfhFLp10Q7Nd2FzfM7p4Xn?=
 =?us-ascii?Q?k4NEzPLZAf6GxG0/McUSXRYk5HqVceDD6Vmzw9nmJiBaQ/zIFM2XND44IEZ3?=
 =?us-ascii?Q?sKUHPHHqQQrsJqQcA1GH45r2tBhqz6wH4lzlBHQXLX4iWGzdog6vebA1R1Tf?=
 =?us-ascii?Q?132ZAjYVn5uu3DN00Cx6g0j/K5vZnsv5rAuTWSSfmhbZKR5aZFeZpqev0Cbi?=
 =?us-ascii?Q?8RfHhyJ5o1ZzziAkN77cMXjTGeM+ffxe7CGoplxWIUcfkAiX+5X/yx6O6cHJ?=
 =?us-ascii?Q?iLyMHNZCq+4G+ucinO+sOxcUaq5syumkcJRrat/ivbiSHg2qBEhZ3yIVy11z?=
 =?us-ascii?Q?tBa8OXInZJA0Zksw73HKmBl41MtwakOY8qPQ6rD07Rmfw1VpUpeBIv73FAAR?=
 =?us-ascii?Q?w7KRLV95toK/PQpRctjK37YCWuJJ31gKr4m2LpWh0I00HW7cWxif0dzWPSnm?=
 =?us-ascii?Q?NbaCZM/qHbpMEkK2AHAntacYLfkRv160MI8B7QpPz8oItrDRZCmELnxlTy3b?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;6:wdhqJUdGImHu/JuW1cvu0PX4rP7dQH0mH1/Kc4aI02O7VkQ6+dwcVXGdmK4kzdSy5x0Jo3Qr2KAIOCKC+wDCyvlt5xbQK3RZx5VT56OvMvxRa7GOved1j4mzAjXgy+EHJA9Q0NelCxnkiYG0rCzHW7YxYM7t1iJl6xYe7xZTkOPtD9EoG75BwELnrKXR1y7pFogsJKOSNb/xcj+FRKqtJilx0n4AZzYq3LkMRLN30Q6ylf47uEv/C47ogwL3Ml7FWy8tZHA1adczNeKBRAosFrqcXTLzfusDiN98YtAHsuuvRZr8FDAdUoyLwKiYhiinx+DOMS81CHo/BRJQWad5cmq/X6U0dysfCVa94imiXV0=;5:1rBe6zs/5KZKrFwVRBZrz7dvv28ZuBGmE61cbPeIVBVY1vf8oC5Qrn9iAzZnMIPkoHcZ+8iVOHdheyOsUz5Vk/lxA36LOwbeoSh5tAXw3LlPgL77/JSuOMRC5a+edNDdwuOJtcinoOVTiwJRBEidx7Rb1i8IIPWBPEJTcMBd6g0=;24:JThrRFOFhVfwjFy+xC59oX9RzcSXWxUNJ4zHappW99S4FH+gzTlCwT9IgIiQZzztUw0WLu6gKGNm4AidGmmj+o3XuebK2+REFIWyV08XrIk=;7:TqaNrLi+wY0bu/7RcgKfj1jJuW2CxrP/0RUM9nDYCULV1tnW23b/ny2tKH2JD4k9CLALVK5cXgzmLCvzcL8z6i3KjwUcn6ApeIPhm5YU2Ogr3mcr0Y9LlPTyuqAq/smBPQf6lro6BqenL/bCHKK1a+qQrGf31iBcxQCLvydey1MbMRZp/8LzvN+JMzc8SP512PxQQfqmyS5u7PH+X3IaRV1Tql+aZgwIri5IY73e9FHKH6xQ6WPohW8lz6Xokvv8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 17:24:33.1040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dc0ecb-ddf0-4165-370d-08d57d3dcdc0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3271
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue in the code mapping the skb fragments into
scatter-gather frames was evidentiated by netperf
TCP_SENDFILE tests. The size was set wrong for all
fragments but the first, affecting the transmission
of any skb with more than one fragment.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index a998c36..ff110e6 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1916,8 +1916,10 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
 		goto csum_failed;
 	}
 
+	/* SGT[0] is used by the linear part */
 	sgt = (struct qm_sg_entry *)(sgt_buf + priv->tx_headroom);
-	qm_sg_entry_set_len(&sgt[0], skb_headlen(skb));
+	frag_len = skb_headlen(skb);
+	qm_sg_entry_set_len(&sgt[0], frag_len);
 	sgt[0].bpid = FSL_DPAA_BPID_INV;
 	sgt[0].offset = 0;
 	addr = dma_map_single(dev, skb->data,
@@ -1930,9 +1932,9 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
 	qm_sg_entry_set64(&sgt[0], addr);
 
 	/* populate the rest of SGT entries */
-	frag = &skb_shinfo(skb)->frags[0];
-	frag_len = frag->size;
-	for (i = 1; i <= nr_frags; i++, frag++) {
+	for (i = 0; i < nr_frags; i++) {
+		frag = &skb_shinfo(skb)->frags[i];
+		frag_len = frag->size;
 		WARN_ON(!skb_frag_page(frag));
 		addr = skb_frag_dma_map(dev, frag, 0,
 					frag_len, dma_dir);
@@ -1942,15 +1944,16 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
 			goto sg_map_failed;
 		}
 
-		qm_sg_entry_set_len(&sgt[i], frag_len);
-		sgt[i].bpid = FSL_DPAA_BPID_INV;
-		sgt[i].offset = 0;
+		qm_sg_entry_set_len(&sgt[i + 1], frag_len);
+		sgt[i + 1].bpid = FSL_DPAA_BPID_INV;
+		sgt[i + 1].offset = 0;
 
 		/* keep the offset in the address */
-		qm_sg_entry_set64(&sgt[i], addr);
-		frag_len = frag->size;
+		qm_sg_entry_set64(&sgt[i + 1], addr);
 	}
-	qm_sg_entry_set_f(&sgt[i - 1], frag_len);
+
+	/* Set the final bit in the last used entry of the SGT */
+	qm_sg_entry_set_f(&sgt[nr_frags], frag_len);
 
 	qm_fd_set_sg(fd, priv->tx_headroom, skb->len);
 
-- 
2.1.0
