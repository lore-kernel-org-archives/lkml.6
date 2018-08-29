Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC32CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76300206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="MtYHMV63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76300206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeH2M1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:27:32 -0400
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:27631
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbeH2M1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GpQ1vdMRz74HnBfPeLYxMzVUTwPtfd+1sLQlXdhO1o=;
 b=MtYHMV63QDVDDeAyfbTzrmM+H9IwndPYUeMZoFTxh75UZq8wdvjsZm4tlmkYXJXkRF2U5RFgUWSnzfY2ZdphwjC8tDc1SgV1Jx8l0sh++vvkUYg/NkpS48rcUShq46jXAwt6D4Ll2JAHHGMeRVrxA+G5Z0m/gnQo/SSSGMjKoyI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1569.namprd03.prod.outlook.com (2a01:111:e400:52a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Wed, 29 Aug
 2018 08:31:41 +0000
Date:   Wed, 29 Aug 2018 16:28:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] net: mvneta: Don't check NETIF_F_GRO ourself
Message-ID: <20180829162836.2551ba46@xhacker.debian>
In-Reply-To: <20180829162456.2bd69796@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::22) To BLUPR0301MB1569.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 805f038f-1079-48c8-296d-08d60d89d9d1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1569;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;3:Ph22fHJZlCf4w+ZVO7s/oNBf61zTffZQX8F33XezsKa9cP+c5V+4NdJDCyO24nRQ1QoxCEK9peNnkQFYyQLk6CndEHN50w3Ep81D6B6onv7ePcAvv8UmshG9riWD/Z/EzL6b0iyFiMmgvZdVaxtuubYFTisK6aFQmAh27uJeUqDOTOn2/Q8yqOdCmrwWvVVEl8r65r64EJzu58WmhUfbyK7MFzA1GvNiqExKyxw4/HO5RFikGnQbT44ie5ndfYBc;25:UBydm+m+v3FaOH2OeMMnrBUfMGlczIiCcXTiZvLt+DgtzeTqFUPrJPF92saKV6hjrOvQES0Y0ZKplhjBuMX817Hh+Sjeh0ojx+cnFvAgcusEJ0z7ixMuq1lDoxRoUxOgOMC41nXGfJ4AQ0AoPGX7wO+pb3SlJjC1t6KNDPfTf+3ujUoVa+f3wr4jDhJEMyJ/ylsZp9I96YPlTCRgqqC1tRDyZC3MxoDrWwewIg7uXc7WaNxvbJ8CRGvuoqvPjZqJKMoJZbv/tCcdqwh+flFbvxeoFGtf9v1XyYTZftIs9jZ6T97Lu/xrjSGWBjxYRgxrsKrb89euuCud5vvfqTNAcg==;31:btyBF+0Sm2MJAZmq/F9yBm7hMui7pTduuq/fGhmPq7fQO6t4SDSiqOv0GCVv/I0Xu6GW9fye7gLFNXpV5MBlYWL/vnF17OxJ3E+7t5eCvTFfgioVGVreM4KQ9o6zVrPGz5WY6U47p2lwgT8fm/CrmNztMYAWeE1R6DVPZtI4evW53qJb/glNh1Lc1CiYXfu8Sl9dGiSQhzJj/ibJ+WZpVGPP6aAfzQXAH1dfRyVeXN4=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1569:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;20:IRf3lD3xXRuVLmix2jp3LnQcJo7rvpP+gEte/P4kiQBEuaO3RuOEzfizOaX8Ej/Ot6DcfuMk6l/1JxiXRHtY46P/m0WTt1lfnrCVtS/Jgy9rsXyxjPYrf6qqSXc4si97sQ9tXF6q8QRLfa2eDlVK3Qeu5+f1QLFi1t7Bw4KeLd2c/BP3vx2HEiqyk4T4gIItdcUbFT3CqLc7oTndKBR88mOGEFiabvwP12PX+s+wA9f7xVjM2MfWHYNQ14NBXGg0sl+mFxLJfCRnOdjUN8UEwQuxqtZSjEtKGPa3XyZkLGPx5x9e3odEX0Iewz8q01BWVjcJKkHUQ3rRVY7iPL/UEoHHCjfwF7zMcJcPlfa5mDl8ACJTTIsRFxXhk4hooTVgQHhDaklLr8a3otScob8mXy75BInUJiwL+eGEvSPRFQZJ9rmIcQagN8NCn+7rRDvdJqIUX2VkVJawNRW4lVFqGnfPJYIzvS3hF0TGUp/NiRSTQHRYpO02mtlj3rguxMEv;4:TIe49X96dD5q4z007QFFh8pjRCRTyvzI/qlb2thJGW1tayv2moKqOhdWlkRB/ago/6/IpkJVOkdRQUtlE/gTiRfpFG422K1trv2uxVJs7+3TTFzXtmtjTyRu6fJeAQeN/tANimybCSAKxlb+KHqUozcjng0J9/9tLnT91ss3VE5XQHJiA74End6jNWMJoSYvSIMlFdcM5gtPnscGoAlMpfDbPE8p+WDjrUUF5rX6lu/u8laaOnReE92HPmHryB8sB2phoChzRMbhKTKk+Sa1iQ==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15690F3E8C9F11AE9C89FD36ED090@BLUPR0301MB1569.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BLUPR0301MB1569;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1569;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(39860400002)(346002)(199004)(189003)(478600001)(23726003)(2906002)(72206003)(1076002)(106356001)(33896004)(105586002)(230700001)(7736002)(6666003)(3846002)(6116002)(54906003)(476003)(66066001)(110136005)(956004)(55016002)(316002)(486006)(305945005)(97736004)(47776003)(53936002)(76176011)(7696005)(52116002)(50466002)(81166006)(81156014)(446003)(11346002)(5660300001)(9686003)(8676002)(16526019)(4326008)(86362001)(6506007)(386003)(8936002)(186003)(25786009)(68736007)(50226002)(26005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1569;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1569;23:1czOTk2tnERmDLtxTTybRBjI7TUkg6Ue0Qu4Bop?=
 =?us-ascii?Q?poA1WmwM0XThXZawUGaoO2ocAe0X4sxT0nq8jYmPoViIH0U9u/wtQiS+sbTl?=
 =?us-ascii?Q?H5x5YABGWQhH6J2c7/BwBU5/swEa8Mowj1smHfNT+TLk1AbkfmzDeK7gYUtF?=
 =?us-ascii?Q?qZUZUdJVMvCpTN1XeR+gmahJZ58kuswowBA+FKfbizkt95QJAK18VcVZMZ9X?=
 =?us-ascii?Q?YOPFRLbRAIxG3DSZA4rEWFNJFg7lOybDCeC5N8O3yu9qBoduqCKHfNn+DoWL?=
 =?us-ascii?Q?9G2YP3IfjTcBObV+sJ6NpDp3RiQ+9UclltEDwNobRvl4AI3KpJy8UQnNBY2C?=
 =?us-ascii?Q?lcZ5o7A6TaC2vwyAB8VUnuk7uqpLCXuBQzL3l+IHF20V1dLAIKqmUR4kS5tj?=
 =?us-ascii?Q?Uh15UIH6+5RFZvABS/YRECqj9xrBDSLjHp5dSa6R90IfGBUX72voOA6gbaka?=
 =?us-ascii?Q?8lAZzTEDvLoQF02wsd3epU6xgN3bnm1JugW3pgEoj/5u4GAhMLJ9bDGK6hHA?=
 =?us-ascii?Q?9LiRo0b/OcvSLZBUIjoODOdWhrQGxE711Oe07OwWqFtCja8p15AYoXHb14qi?=
 =?us-ascii?Q?6F3fjCqLxAqqF4KEco3ip19srqQBldgAAPQfn8aiSkDxIs/KIvRzG6ZIH3St?=
 =?us-ascii?Q?WZBcoULBB3pC/ls1NszmGLnM12okJG1008w2muWT0h4OH+fToIGBxiDDFeOr?=
 =?us-ascii?Q?nC1yK08rSGO96p4TKjJDWKxG58S5loVeje0pq5skuJH+dudmZT3jjO7kP/s5?=
 =?us-ascii?Q?NJKE/LW5Ivp98BckSWKJkrayGU6tIcz9JliBoFHyFYzo75GQO4Hw6WOQ+lxP?=
 =?us-ascii?Q?v0+sQ3FI4muwZhso4pg+l+LeNnp8osLnguDe2ICU//JxwPEOkrO4k1TNk9Iq?=
 =?us-ascii?Q?KjoJ3YsQZXR3A2cZQtSJpiHGwtMwlmFmhfzCmYpIHMol3UJu0fX0ljtohQbq?=
 =?us-ascii?Q?zOFbqo5lfVOtqyLHgA8ILNc+dfcUNA7ejoWi2B6ZXUKGmsRw4AAFyuHnt+LT?=
 =?us-ascii?Q?IfeUG5knXXj+DMavRR5dQ5CZWAaxGdD0z9cf42sp2X9+MqkSXNK8lWCKoW5+?=
 =?us-ascii?Q?asyDwiEyyeg7SggDjSIbYWaF5FuTVqE43v76xBp3O4lPpSQAXwcnmD4Fihoc?=
 =?us-ascii?Q?tLi7B00cVOlGDsRS7i2a8EJKiBf5omx18KP+PlEl6ifG6MLkGrBmfP0meZTP?=
 =?us-ascii?Q?nIZ3Xb8tiNxXslyhKgQEye8+4hNOcgj27AmSc6nfmG/mf33Pvlx1q2FgDSKv?=
 =?us-ascii?Q?p3CG+JJgPorXMI8BEKjE=3D?=
X-Microsoft-Antispam-Message-Info: nFqi4DSpmHzhwu1gG3btB7fz5kR6J++uOaWF863670uNdGF9XBlMKlvcPrQAQSwaWIBuo45gLxYD3/xJlxxQt5vcGjY429ImQ4tkGKjCWA9xukkvfPE/Us+l1RVJlLg1RNjYVDiNbW1Y1jVR9rUl93vHa2/efcpjei8RnGmv9DqBa2c8AyN8EDuRKKcNUYBSHO7ljOn8/MbMHr0nlp/ojyzbUPTn4GDBwrAbJjH5tHa0xu6ZfpPlEh/DssaC4FAQaP/Gfslk1r6sqThzSdHd1RM3ZcN1K0CgqG1FaGR9rCm4a506smG5eShoCRuYTe1V33tsSeaDVRhqkEKFvKV+buF1MIr02iIkwp+3ALp6XeY=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;6:ugdYt6/MylX4uXVWuPKyknsnPECV0VPrMkyIJw9JXeAR18rqkVOIi/Pzme+X6quU8g1DIx0zexArCYf3ZMmjQ2BlH7vnbkO9KPWSB7hhZH0MZBIi3hnVlUNSH338CY75Fy2rOt2kAwrDSWiHt+M90QTREVusL7HTutMV34Zaw34Mui3scwFqlXM/t6WWzd+A+vrq/ysa6XTgcJHX1KHpv90c7hwiRpuWo3ODPEjfpDplsUGURwZ5nCq66AFDu0ACwyCZAvJkjnZnrCyAaKlwK6qL1CMSejTC2jNqZiTGcf/gP+fOkM9Okjo/2amaxG6UsS57M2CSsUENKitga8rYIYezdtEvgccfgb4muzdKBJlTvXb5M+zquu7Omq036Rul2D+bnBWhp/BZQw+ZKBTZTF8m5aTJnHf/2DPf+zy/l3yBaSSeWs53sFjji7LJB0rxAnsUyuiIlnd04YPMd5pPQA==;5:jnDPZ/sMv63UOz9k0Ct8s0iWnxIX3KSnctCbiYN4EF35PJlQQP24Unfx26kx1F/ScSUnFq3W65Q3g6ew7Bzf1aPagwioRpvMODL/ybjMn0+DSdS2w7U4/2Neb6YhDrBSd4Xus/niORit2+c+4nJ70jRz1sFnc47AR4DsP9Q6pf0=;7:07Voa3viSUhvopnsBNcojW/L9neqSaXMpaiAbH1QKtpF258MI08rb+FJ+4HovJShYCgTCfsixxeJhS/cl+YxspR2vWDbi7Z2ULjR6xM3arZO0c7aesE/jh9P2LEFkClOVecI9vKUWfnIIMuLu09zcR7KudMXZSB9woLhoopMlJ5xV7rEWJArdotkNDWE0/SU7WrX/z1PEbkRj38ypVa3v76qlS60ijZLTjXSTWgj/y5/IOv8yDC6hyShP/iqo9OW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:31:41.0565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805f038f-1079-48c8-296d-08d60d89d9d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

napi_gro_receive() checks NETIF_F_GRO bit as well, if the bit is not
set, we will go through GRO_NORMAL in napi_skb_finish(), so fall back
to netif_receive_skb_internal(), so we don't need to check NETIF_F_GRO
ourself.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d9206094fce3..06634d4f9b94 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2065,10 +2065,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		/* Linux processing */
 		rxq->skb->protocol = eth_type_trans(rxq->skb, dev);
 
-		if (dev->features & NETIF_F_GRO)
-			napi_gro_receive(napi, rxq->skb);
-		else
-			netif_receive_skb(rxq->skb);
+		napi_gro_receive(napi, rxq->skb);
 
 		/* clean uncomplete skb pointer in queue */
 		rxq->skb = NULL;
-- 
2.18.0

