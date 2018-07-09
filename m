Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBD8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C1620875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i/QSzwiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C1620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbeGIPCq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:02:46 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:9760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932993AbeGIPBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xys5fYOBg+VqG+dV87MASMiZlTiH3i8Sc7HjcU5aYI=;
 b=i/QSzwiE3gPXlvlnuz4QnXtjgfJFpR+f22jj+Ygdq0mXhyCeBGj6RKFYBZxAUJBjom97lAW8jT6jG6LSXhQKWKt+uxtuPNU/XBj3WdWE39GcKdvw3QC6GNKUDxvk7i9VKXausTF9gpk+8lIJ0hwyaivzvgUKTCtZLBJ+bz9Nx2Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB339.eurprd04.prod.outlook.com (2a01:111:e400:881e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 15:01:28 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 1/5] staging: fsl-dpaa2/eth: Fix DMA mapping direction
Date:   Mon,  9 Jul 2018 10:01:07 -0500
Message-Id: <20180709150111.8875-2-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87afc2a0-44ea-4f7f-e275-08d5e5acd9cf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB339;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;3:6BMoFC2uCAccNoqZonjT9yGJZZm4NJ3d2ZpvajHOb1cM5SWkAP89MpkT1wEtLjIwZaJE81lnL4qh1MbqlzjeIfsPoBo0/AZgvX4T9l0WpSVMTV2Y9ewCwWgJAU7kc/fP8q0WDDyiDnWz1NIraZQiBi9F+gV0kTuhJDyoNCiF6R6IOSgJnBcS6bfWWbR1ObpNHoCg1p/JraeNdqzJ0OUcaMZDX7edgmWj/kR4JmLRrqZDTSCIqJEf8pm3Djk4tMrq;25:K8NPs1dQqNHtzRG8Cx7joKAnH74Jt2QEBL3co4cawjHv3lTo7PlFb2L4oPvgKxEMVh5beAqvoqvBYTtKbpjSvyFl+t3hk6P42kY6d5MusuqcIXWyQWIZRfwgmjCJncpap4F4M9CW0YQhbUcJQUYA4arbUvVpoxG0AtA6+Cl6xpj7S+VbVcNA4BG6+uaPE1JCrKp670sd+RWpw/Uu1ngErEOabKoFoPARrYy/HAowdfFrwKqwuAW254Yw1/gjlLQdLse0/Mi2uZRSygsLADRgxIWtbGXM1hzxX3+gbrIyWi76SQHsgXHViI0QG7cizunAZFCGp8Wyp27Edopf0kU3sA==;31:jzlrdyLbbdU58dzQUpaO03E5iAkm17RpWqa8zQ9OF0N6QyZQbkWTirJfxLDam6oE85qjnHC4IJVb0VeCpp1COlfgfUDiid28aLJKmly6jXP83PS01yBKRjJ9jYOLqveO1GGwTWM+n/QqPazAkMHSi2oO6PNTlmoU3LAA3w0ryE380K/QzkMUmffZQA3w1TShNDuwB9l+RWcxByoXSUzYRzMWuX7pz1DAnMixWTo6d6Q=
X-MS-TrafficTypeDiagnostic: AM3PR04MB339:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;20:HA5dgdv6bvtZ0sswsSwnrAE6rCUpaioUMHnPEG4dFy9HlcBWWFh9JF1VbRAHHoyIgyT9mdYT5D/9WBOJrF18rJOAMnnaatumcLxVNBK86ETXvEuKmPnojpMu26G9YZnmFafXrj4hUvPboUhzU9Q5wKhQJipK37Y/oAF9RMrYRTAHXBUB0ygeUgx9qf37xdFml6UaaMDz6JFRhMV7uA7bRw20dSxbMqc5SG2wxP43VcK+nQ24nvQEgawVQQrbqxphDuNj2JjFsleMI3QmmI3jDCW1rC3xSuZox3B0+myYiN3LX5cO58jNcHNdZ7KxK8tAaag8SGinvc7BcisTe+sE/PsncJPUfDCZGcAO2cIFbeRHp+b9RmCSg+FfbIJ6Q8/5Zd3Qihzsac4GSqBWGezx4Wu3kt0Yc+g39swMHRa6j7PtcevYkrXaSZ9OcS7PYphopkAQe1ZrfgL0EiZO3w87vTeGZepnPZnXxN+R6o0/c5X7cBzRV9trhe4tFJKBnyBF;4:1+5N1zdVU20hn4Ogta5kB0RZTURh3gc2RaJaPR8l+kZwecE3q+qAdSDP+oT9c0JLCQ3copUtXw/aRT/lSIrrE1H1GpXSKl3x7uCtuYDY48hwuRtMkPydZeITH7rx0d4dORSeYDZqJ8gueAzYnfNEn0QCuPVfFRy85XnIxUowTt4SHPB769wl3qtqNQLKMcBWUJGZ/5d4R7C7JvDI2EJ7JsrF2EmLWkDCWBiglUjeiXens43dahtqEGn5/+6objaKVFY61cu5OaJCpgW51GNheZs+CW596MORt9Yyb9HV6kFX2zvYfcJCL2LH/cGJvnSC
X-Microsoft-Antispam-PRVS: <AM3PR04MB33993B4C3897790B48CB2BD94440@AM3PR04MB339.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB339;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB339;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(68736007)(4326008)(25786009)(53936002)(446003)(6916009)(6666003)(1076002)(5660300001)(486006)(956004)(2616005)(8676002)(81166006)(81156014)(8936002)(305945005)(14444005)(3846002)(7736002)(11346002)(6116002)(97736004)(478600001)(2351001)(86362001)(6506007)(186003)(316002)(16586007)(76176011)(16526019)(106356001)(50466002)(51416003)(50226002)(52116002)(48376002)(26005)(105586002)(2906002)(476003)(47776003)(66066001)(2361001)(386003)(6486002)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB339;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB339;23:lkYGgUgKck+m3Vq4AHZe+ecutxHWBaKaRG/JL2l8GE?=
 =?us-ascii?Q?VyOsUQvm9zjbnhMKz2iZKPkdNlZzTn1e1SYMvLAdM41lmPlxcW3JBwVuxvlI?=
 =?us-ascii?Q?GWbCjxaodUMr+hdEF0U+srB0LpdKL7Juwtr5TRGAQeMMD5aPFmlaYyZyE4tM?=
 =?us-ascii?Q?Y0ckgg7D2NuY7dPYFzpl+HiKMetlvQ+6bhXEm2x+fJE/eehFAeGhPchII0dO?=
 =?us-ascii?Q?HHxIjn8EPtB61UwZLtxXbWtbv4Lf4hq8otnq9bPtVjnxP5K7xvvLkvXDuPdp?=
 =?us-ascii?Q?oT1mwibyEgzBzNiFhBIQ1i5akkTTJWHb5WK7Na+d5jwWTcpaUhgFicgC91Ws?=
 =?us-ascii?Q?I7ebN669+grvih+aXVHeZKyiHhp7jBGh7hnkMEZOh2H9GJwAm+nOKtJQN0wo?=
 =?us-ascii?Q?crPY+XNXd4QI//rTgKexd2Xc3mMyG8q486bT/q9dmvSN9Ddmungm3PejUWC5?=
 =?us-ascii?Q?41UefIH3IOV0UFJYfuc3JYRb0V/zle6oaaAXbQIwu5gf0oyFzbcNFOmTpZs3?=
 =?us-ascii?Q?ufWBwbW66xaK/pTixktrAf6LECCBw+e4YDMVLPbxV/6uW0O7pzTpmq47MQKT?=
 =?us-ascii?Q?dNLAY3ak4cvWRjhzcgOyTv4HWKRC38YlzD9k3EnOL7pFSF7PAYYA/yC/xb6y?=
 =?us-ascii?Q?uDzbcRCAgZ0Bh/VewZjeR50SWf+kQxhQZjKeuV/qmKLnyckMj2SkFIxyr6ck?=
 =?us-ascii?Q?tFyHVUQ9H/l63iU0Ukt2Ula6LQH/+z9zhy9aOdWnc6U5zJk8aNaFM4/HJjdc?=
 =?us-ascii?Q?h6n2PJVEpZemWHsrnRNtocHxKvRXt6w4l2OrupmPt2HMGPP0T2Ce6SAZRY1t?=
 =?us-ascii?Q?RV/+07ipDCn5TDzVttHVjIGWlbHNV6aK2aYI7llJ3Hzb6cc/kdZ+v1H8p62g?=
 =?us-ascii?Q?g3+iuyctqbx7pws7jx4Nr+xVADNmRskIAROSOxQaxKEecIznTb25QvdPrjcf?=
 =?us-ascii?Q?HtMKwoEZyIZrKHLqxaNVYCG9e3Sp3ZSVRkenFf4X6VkLSAiCYQuXfhH9W/ts?=
 =?us-ascii?Q?EubXeoucCESi96DJgl9Y+pRFF2L5ZzAS1X2e1ba2/+15P4aFOf5PPN8PL0tg?=
 =?us-ascii?Q?6utVURLRUdqdDio05d4tP6cPpQYcptha3Bl7EYB5LTJiMvZMyXQSCiPweuFZ?=
 =?us-ascii?Q?JRFR153oWnUbTMpkyDwwDtXAd2X61JW1erefHATaLjkMxQiSS5h4dc7N3gbg?=
 =?us-ascii?Q?w8NxKeUre8529BxJk8S77rkVpGsN2RPr9PeGINSxd1voCrw4PdGxeGtBDbs+?=
 =?us-ascii?Q?r6g/97xg+4El5xQHs=3D?=
X-Microsoft-Antispam-Message-Info: Q3Y1JIjXVwdXowAQmPHbTCOgRrA/ARRxmb2ZxVbyFS/XydUBcH0htTkj9fBmV3jmI8OE/0Vlkn1xWYwbQ0oIJ0Ty9+/5l3jIXDFWovI/oeHa6+CarIeAYunL0EevvUci2kXObsShePlmi0NL5CGsUbZdLqcvRG54Phl1Fr12mwCWFXvb8S4vRYeXExPVzz99tjcGS861+rkdMwJULeswUC13KpGsnvy9Ty2Hulw85n1kK1xADgVWgVk70nbfgwlLTJnHKCQ4WbLU1B5YbVRje+dEbleRAXs1B6U4F9Ej7kJ3JfjMvJFCBl/UKDQG+uq3+FboMFxyUbZ/QqTlkfzmbduCnL9V/lixTlD9zxvutow=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;6:DePZDdvRuS6ugRE+Kuml8AECyOIzHwhHQalFgZ2M/3Mz/wCp/JgzxM8MSvXodto0q16wBg7/YsqlCLMBAhfIJIfkw3/aUUZCkSMU9WVuCrBOEo2Si3P6XJN9Iw67yL2BpWlVU2NV+P5J2I/HuKiIGc5JATtnyqOF34BTb20sAKoBCOuZFaAHMHWgsBUqn6Wrf43yAi/cXFqwVYmNTtY2/7vqfu9maRsHr79h73wmdaTO7HPxcceEPGxt9CRJDhJOoDOsjQg/zFn+5E4kRtLUAeG65su5I/RrfE/R/epTs5Og/Bo0gfR7NNqVlx4i8V6c4MZQHj9qLW+hyDG5s2Mteag96K1cASVYQOeT0G3DvAzjtIFQ341IJqZv5t4EAk1Md9GxTVXf16z1Edqc7P9/Qeu3ZvDDv8mMfmOUXIeFCTnZC1g443G34CoXuBRV9+Vg9udrt8jLk4bA0jxD5seE7g==;5:yMD5L6ZHCLbNnfSSVumQxVvXRRdoELdIz410Epm2pVYGycf2qvkmO+NdspAhboxEttg+FUdSQZFW5jGlH3DJ6wcIR/fGFAaFxmxun+vvct318CsTyQuL282DT3svhYz9EnAxwIpe7G2/pfXDZUnlMMGrEgzcmcwZRW4kxU1aRow=;24:bozBbttfnS4W9dDunDW6FwtzSjA6eEUo/3/Clr4+osEhmCzxComqeRbVCvOmDYjY7azj6FkQv0PFFNX+155ZtVD7oIQJ8PQXNNQ2ndBxhZU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;7:QIGBkjCuwwK7J6DWmDHghbULo0D3EQ3zLQEDoDZ4RXKNhS2aRIMurCtLxAVulYKm/jwgWkcbite0h/oRcnZdD8byNPVxvyi1NYOdmAaRK1Rubucin4X7KqlG/6NFSgw2zU9skDYjKPdFFAvdDj/xs5eDPb8gWS27s0uAnVBtnA3PBzch/vqd6yra9s9NMiTIqfLtPwL4MDU29dlAxGBoDdnYcvNVchDxr/ja6dhPCvx/wHN/ghZIniwgrxJP0YHS
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 15:01:28.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87afc2a0-44ea-4f7f-e275-08d5e5acd9cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using DMA_FROM_DEVICE when mapping RX frame buffers,
but DMA_BIDIRECTIONAL for unmap. Fix the direction for DMA
unmapping operation.

Fixes: 87eb55e418b7 ("staging: fsl-dpaa2/eth: Fix potential endless loop")

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 3963717..537d5bb 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -767,7 +767,7 @@ static void free_bufs(struct dpaa2_eth_priv *priv, u64 *buf_array, int count)
 	for (i = 0; i < count; i++) {
 		vaddr = dpaa2_iova_to_virt(priv->iommu_domain, buf_array[i]);
 		dma_unmap_single(dev, buf_array[i], DPAA2_ETH_RX_BUF_SIZE,
-				 DMA_BIDIRECTIONAL);
+				 DMA_FROM_DEVICE);
 		skb_free_frag(vaddr);
 	}
 }
-- 
2.7.4

