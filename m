Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeBSQLS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:11:18 -0500
Received: from mail-ve1eur01on0082.outbound.protection.outlook.com ([104.47.1.82]:51239
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752857AbeBSQLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:11:14 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH net-next 1/4] dpaa_eth: fix SG mapping
Date: Mon, 19 Feb 2018 10:10:41 -0600
Message-Id: <20180219161044.30279-2-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180219161044.30279-1-madalin.bucur@nxp.com>
References: <20180219161044.30279-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:301:39::33) To VI1PR04MB3278.eurprd04.prod.outlook.com
 (2603:10a6:802:f::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0d4315a-5924-4fc5-63e6-08d577b364c6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR04MB3278;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;3:bLJTZ83sK2kf/IZkuvjZrWkx1Ljfjvjx9uB7VIeFwAKq/h+fVNcOp3Zjq28y9XtR1nORytV9HT5aHUbyrNs4Efu9xT2gcGJZF8z/6scslXJHDIXpDl5WwfaenMWoQuFQPm/H6Xdtsip3DK0RE05ocy62ZoTfmGH00YJey7FR/+ZPlLQ0dlsjtCavfeQQfxKL7+mOcGVlLCGvfHHi8nHJm7PzhE/szdltE6ZUaFTPL4KVCbpuzZKfO7OfN9ID9lC6;25:ZUQ6PTvDMeYlybrBbeqrconKzV/w8c3v9b1C+rgq4FBOFcVLSG3CDYvr7QrdlecKJyFPjHIXIda3UiHj/F6BM5QCDYWDmAfzFkZXTlU+e1gPR1vZvUaKVtykpMet6jl9/gxTP0jhtzmAa3t/JBbdAPUkGYSVK4TqL9UKctWYeqCq78WkALmwrANqAOGi48ch1BKN/Uc2O3RwyGAAYP1HSvIPt3w7nR7ARjTo7wonQQDnYsF2ytOt4edv+npMwWOlyIJzcl2ocWCh88wlTpVVmbGHpQ7ab/83/FuzI5qaHewhfx+2N+pJSmiSjvUOVJRi7iQheZ38DD2f3zUT4DgKEQ==;31:VOehWudLQ9Y3gth/eTVmvFtGPrOzjSdPO28/xacY9drp1koqYhLjRxeiFw6DnayVDH34gCbxcS1GWkNXy7EQG5vTfie9O8gNyzUNLhO2Z3mZgMMsT1FRzgdNY7dWxMBSMjh/Oy8lmVVe+zLFNCw4zSaG5IAGMbK06libeCbGvahIMJ16lXUi2vNqHFGzSMIT8bx038NyZqIpzkpsqI5War9TtpVShzyhQRoI79AZOcI=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3278:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;20:EtiDUTs5qpZv2TXPe81s4BSqH5oxR7fJ3H9PoyevVN72BNiZzwURhsn/zG/veREcfFO5U6v4eYcIWCP39LkHKa6rCcOX1VCDdFqLt4Rbda/ZPnrocX+jgvEJqC4YoNtIWm+lb/hc9afUZ5vOx9zqpANm+jZwyQc15Q1nzO7NeIDjkilhCwy9o03mb3tG/FWe8GlnmGQ3jwv0ElRcjiFJJpsRDTuAZtUQz46NHvX14LC1X/C2SngnAKOq8cfrprdLFg05rTylXZ8dMBD3rt+vfshKXG4yWdM5nQVrV5KAxUKV/fHs5pPlUBZNzuvlUTyHrRmOQjJ987/7V63SFCxPk1W60C1un8iwku6E5RJggkW5pWQ31X3XMCbKLlkhPfM7n+G1n3a5Nu0AHy+KppyS6TbcJRSHA6nzd7AzqOx2Pgoke6mcig35QX1+7c/JbTBf+E9h+dAqZh2/lI6uvhvpM3LLtv8t+lRsDg231d8NEM8suCOqT3ZSM1W7doKNMvzk;4:My6zN1g5YDMGMiwg6xfSav9i46zSiufF1GNIhauruCyGj5Dz/Iypeq6N/A2eqrfjgJfltHCvHLi7tvOGhOSMYRKnH7AiviHfLD8orUTkQohGzRKtc5w3mrXXLtJMDSfJUy5tgrn+fMBtEb2LPU2GhJCncWSvL7yQ1OC9elrrfI0YtfMkGfMogEUu0tMSwj196QSPD4NuQz8uqfhPVVRwdvRD34g3wPZF1JtaEGKO1MHm8WYXzUVfOvAd515cwRkOMBXXyRoBgB5d2sQzpvTLx+HrwE8A4SEijv1KU1dgp8fPsdwVpGsQCdg76lXpd182
X-Microsoft-Antispam-PRVS: <VI1PR04MB32780F1E1FB6A8AF45D88C19ECC80@VI1PR04MB3278.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB3278;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3278;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(68736007)(105586002)(26005)(43066004)(6486002)(16526019)(3846002)(81156014)(81166006)(6116002)(66066001)(8676002)(1076002)(186003)(2906002)(47776003)(86362001)(50226002)(2361001)(3450700001)(2351001)(478600001)(6506007)(386003)(4326008)(7736002)(36756003)(76176011)(52116002)(51416003)(48376002)(50466002)(305945005)(25786009)(6512007)(6916009)(5660300001)(2950100002)(8936002)(6666003)(316002)(106356001)(16586007)(97736004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3278;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3278;23:LWK6x4eLIjc7v65e3JJ7PMa9z999qzY+uZ+ZbN+K7?=
 =?us-ascii?Q?UZjKfrImCJCV216+4eSiEZe/448ZLeCRwTC3VG7wyfooJGi0rlQGILxRZLgD?=
 =?us-ascii?Q?UHyg8V03Xx271cRrc3nQwbsocbCQZm0Yu83Nz0aPB9Cr3R43ppsT8TGIb2TB?=
 =?us-ascii?Q?WOZECOYtB90tH1eBwm5feEtyetiehiF6mDHFZ1rHdWPqrqNE6ew9SfPf5AJc?=
 =?us-ascii?Q?TqOl6YngpNsivyAue1/HVjSnILwq/3HRqDnyTzqDJYi0obCL6quHpXVYA1Xw?=
 =?us-ascii?Q?iOvODdy5jdSVV/oKcR8ikrnYXelNkgmsvILgvmAsDYNfqXX3LwoPb2ts5+1T?=
 =?us-ascii?Q?njTcVsbh+BL3cAC4wiL91I309wabnOkmPR6Zr3q+ukvt9XLVT51beGwMF2Qg?=
 =?us-ascii?Q?5XrJ4MCNZ2Lh9Q3XlLEcbk/WJOdXZlAWIE0ljRSCMpUyj90mX5xAEyMx9zNm?=
 =?us-ascii?Q?fLOJoKNU8sKPjOvQi//7LjFtQucDaiASeZettNjt0mgKoI83wGOu4LdZOGQK?=
 =?us-ascii?Q?vvRDevI1+qADVH0bRQIadSwTyHEsHLUotQClT4eJwtjbC2WLgf7Sj/Ba3jPA?=
 =?us-ascii?Q?YSAuxgm76p65O73+oSYMzQMNPSRMmJIwl8M9bFYpLz9sMUkJ5XQ8igY3en+H?=
 =?us-ascii?Q?U1AuWoFSn16FVmbaR6dGqxEFOsdOUn9EX6x3+wtBGNEM8iAMRP+/41CPg6q2?=
 =?us-ascii?Q?sNp1kzEm7HdfZNujW8Jaef5y+qv3R/cRi8kzUhiVCbsBpYT1ObK2OmAi/T8I?=
 =?us-ascii?Q?z3E5IwAlHdunUcHj1/Po3AWbE9cNITaDZM0RVzbUfEjHovGH81K4n8aQPwmg?=
 =?us-ascii?Q?+XUTlOxNnTNxyL1RVAQhVBOIa8W7BAMAvHhvho4a0kim1fVV7uwcBHwR64on?=
 =?us-ascii?Q?Y35tVInYvDO4utxaYoWuMaqGjcXwiFbu7nToNpskMCOVU7VwM0Gvkyya41RC?=
 =?us-ascii?Q?zu6PqSv90i3ZZ1C9/KMc7YAwMgEl2REHfL4QvR3GsrsQMWpFGipcSexCFPcu?=
 =?us-ascii?Q?4E0AdlbEEs1PejnXJ0cf5bUoLTMoXvYvI+bw8YNnQUahqBfrhnWFG6J9CIGl?=
 =?us-ascii?Q?d737qIiw6DDcDjfw6tUXJF2OLJzhWOHH0Zd3GXABULFsD8kJRGlEeWTjm01C?=
 =?us-ascii?Q?IoackIprZ13yoUYMllAcbhT9w9IH4SiW0Cc7ciLdz/ku1RMFi130SjbC7sj0?=
 =?us-ascii?Q?K8sVI1VR4aHjvJcsSwgUWHp8PjL28Q3uEOe?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;6:CLXet71cOvTe0ZCS7q/03sj26KebAXns6K+ACjunm/V1RP0x6ma30qozJBo3X6iDsE99Uy0mBxB8A0X+zsKgNFmWgoRI4cXtYQ6JxS6Zt6ozvnBm5stC0EzU/jM/9U2AlyRV+yS4YGDC7EEoommDCKXS6rdlNXc2HBmvRNC09MGMNnFerRHyjvKPHE6P3SYVKqX8s1G8rDzeQRDh4T9waB3VVE8FYZUzs2FbUsowF/TTwBTP9qWq7gET7SmBHNzd2/Akn64uWZG56BLda8Angvsua4ydvvCAgYVEcR0g5e/wtGwPeeNilAY3D/xMfq5zmPdW01cdwqIBEa0B7+1mXQKjH6qtv8EvI1U3/jGwAes=;5:wm8Dh7//GG5glS22hLiEHbpD1YD0A2rcmV2vaouQc2zXqtDUxfuNtxQjsZ2D+XTog7k0KtFTsAp0/1NbEhko0MdPHS9TaCsSgke9H3hbrejmwQqmhimihDNPTkER3yGIPcs1bj1do88bsGUAYltZ8TDkso+C85qlSKTbp519ZNo=;24:KV6EsaezVZB990ck4Ct0uxIFEA/Oyt3Ox4dNAQPYConT7SgNpVHklfKl/o7PTMNXskPGEd7vb9w5fokD/Q03NtXLA3U7hYLUV1QGRv1Pegk=;7:fxNmT+QwYTfwFAjMk9/05ofA4HCG8aC+HzzdzjBrspf5rxG1dGYmG8XpIUOtwHygNBK1ns+/p6hXppWS22tzAv3VAdJYYspqF9nOocol6RKx6TLf3HbpRUCLe8HEHQcNlqNhvqvcPrDihJX4TYMEiUkrJQB3+DQpMI/FUfBgGESIRy+yxDQMXusY3+4ijD/AGft8c4zVp8GAAKM5btlWVY2YvQ0X0d2kjL/9SSZhet4qrUtm/cZzNHrxfWf57IH1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 16:11:10.3711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d4315a-5924-4fc5-63e6-08d577b364c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3278
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue in the code mapping the skb fragments into
scatter-gather frames was evidentiated by netperf
TCP_SENDFILE tests. This patch addresses the issue.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 27 ++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index a998c36..a5afa60 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1889,7 +1889,7 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
 	void *buffer_start;
 	skb_frag_t *frag;
 	dma_addr_t addr;
-	size_t frag_len;
+	size_t buff_len;
 	void *sgt_buf;
 
 	/* get a page frag to store the SGTable */
@@ -1916,8 +1916,10 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
 		goto csum_failed;
 	}
 
+	/* SGT[0] is used by the linear part */
 	sgt = (struct qm_sg_entry *)(sgt_buf + priv->tx_headroom);
-	qm_sg_entry_set_len(&sgt[0], skb_headlen(skb));
+	buff_len = skb_headlen(skb);
+	qm_sg_entry_set_len(&sgt[0], buff_len);
 	sgt[0].bpid = FSL_DPAA_BPID_INV;
 	sgt[0].offset = 0;
 	addr = dma_map_single(dev, skb->data,
@@ -1930,27 +1932,28 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
 	qm_sg_entry_set64(&sgt[0], addr);
 
 	/* populate the rest of SGT entries */
-	frag = &skb_shinfo(skb)->frags[0];
-	frag_len = frag->size;
-	for (i = 1; i <= nr_frags; i++, frag++) {
+	for (i = 0; i < nr_frags; i++) {
+		frag = &skb_shinfo(skb)->frags[i];
+		buff_len = frag->size;
 		WARN_ON(!skb_frag_page(frag));
 		addr = skb_frag_dma_map(dev, frag, 0,
-					frag_len, dma_dir);
+					buff_len, dma_dir);
 		if (unlikely(dma_mapping_error(dev, addr))) {
 			dev_err(dev, "DMA mapping failed");
 			err = -EINVAL;
 			goto sg_map_failed;
 		}
 
-		qm_sg_entry_set_len(&sgt[i], frag_len);
-		sgt[i].bpid = FSL_DPAA_BPID_INV;
-		sgt[i].offset = 0;
+		qm_sg_entry_set_len(&sgt[i + 1], buff_len);
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
+	qm_sg_entry_set_f(&sgt[nr_frags], buff_len);
 
 	qm_fd_set_sg(fd, priv->tx_headroom, skb->len);
 
-- 
2.1.0
