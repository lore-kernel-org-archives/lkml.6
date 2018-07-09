Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B5C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E449A20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZFG77paY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E449A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGILUJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:20:09 -0400
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]:14912
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932519AbeGILTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3LUbKn+NfpULplUoriITqfUZ0k7NzbW9xgQogrfMms=;
 b=ZFG77paY28DK2PRqqA1ed0wkDebFxPm4vS/kttuc6c5gYhiFydxngIPFy4+lnEIyKvjTsW3Qs1xy3xJpOKnNqMC7YGNBvYq2qRE4/lqQI55m8cIUNjThUPvTBgs5y0s1gpPEHsj7NnvdaWvopzfmn6CaoZHQMQwkh3Z38+ljTew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 11:19:30 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com, hch@lst.de
Cc:     joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 6/7 v6] bus/fsl-mc: set coherent dma mask for devices on fsl-mc bus
Date:   Mon,  9 Jul 2018 16:48:22 +0530
Message-Id: <1531135103-10699-7-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To HE1PR0401MB2427.eurprd04.prod.outlook.com
 (2603:10a6:3:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 654a7a6a-00c2-498e-f491-08d5e58dd9b3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2427;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;3:o3S0g/4NcHFlVMBHHu8rG1F9qpu6aKAl1sK0HVbvHqLGQedlxIrFndcAcQh2gWKqp2AatxQzSXLT5I17bbZcV41WAIFPbCoMvAMfV9KZaSThKK2f2z4DNwW9Ye5oWXRJDNMBUKDzYKUCjE4VasCARvqf06SG2a6b5VBpFmfV7Ze2X9qTNaKiGr5vtyUPN/nZuANCj/uH4stDt+AqEMuEj7Wgk1Lx0rYCXDgkWJLMbWqjjOnLZm1J4z+GYZtqXG1O;25:zlObgAL20Y5kPtKY8GPu/99vdfuI6u42+7gi19MlS2jZ47fzxQ5ZsvQO/F0/zn/GU0rg8KgYX+P0wpH7pi/4TVKiX9008aDoSj7RJ9lc+r6yTpkxOhjpn4z/XKRtn6BTfMfzSHWI989umHmIkp07jC31NE678wfc6PIjZF5sGiCcrmAJdygYj+fHb7I5ELV+QOlpmhQ07yVDxg4X8fwTbERGEdoQ56sZ+kO8Pnx9bGUeOurgvvaf9dJ008+vaUEvddTO0K7gmdPSZBcZpAoJJPQhpdK6t3d5VOTtqIDRGb7IotfcyJ2Fc+CYNa7KgEurwIC6upAIQNrh7wuVAabvfA==;31:EeyLtWGuNqTyB1c+n8Oj1/jQWDam7Ws2TC3228UJ/7MrpTMl9qSShy86IVT5D58lkKyXoKaaKquHw8ltsM6DL0v1CSOy13RiT+tEUqAwLw5gEaTAfXFDHII+JiRMmvb5Dm5hQedRfl2bPh+siFvTXoVNlyNrehFQhFDiZ1IqygTHwzmHHr/vXCQrWsVjWNH6LSbWYFzy3UET62aclo62qDlImGaAR2/XwN99Dq5Ygd8=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;20:hrmcaRxNqyxcVWfOnJr+NAxL1TBacbBIVjT3/PSnKyuBGR/SIuC1gsUAYdVbIreRwrPc6CG92eDgCI4YPFkAaH8kW/OVuH+0gqYPdHGgeJBZqmP6GZCHSW//VGCtFIfPlFiEH4B3yxmCN2JXiXp1MwiLXH/NfM0j/p/5bRNH1tcF4yIggmNWUm/EkvubwpHud8bu5wXeoWI3WBMEP7o6iUZLRWcJAd+bQoejNTsIMfziwktKE6wKSaVxYMoL+AU6k+aAcfu21Td5zQKnnI6MO/QhJQeweNA2jaq77OoMy9J6RWLP7d81jz7yFsZLv3IM/6Cd93rrHj7F3uiijFoj8HyvcILAwayEmp7fEmtTOF8TXm/BFgQnRkbKKb9yS3yr4BBSDnvkr/NuXfAKxo2pZylYw2tqtQmNqtqh4I1a74VxyYp+brVC28OKad1yKLBENnJM82rcK35QiwRg8hVY8Rvp9JzfCJcAdMU4OdkluxOzG8NhdvLEAhyiN/KZz4jg;4:BTAfpjBmaFmJYm59gi6Mn9cjrzcx5YxbWczmAAOM+F0zFx0mSeviUGElVcgzqJhSkWRyVwR8gfa5Xo3Xkq3I/OHVvmbaCgH1tTYV9+UrhvMgNfCiXeIGRUTQKejmFZ+Gd30F6a5Eu/qDqlMQstSUj5ZkgIwWJnhJAHYEwdOvMnucQBwDWmCWuNYhMIax05xI3CpwWq3BmKFtscgE6RijUZgeDqrQ93q0+Js61NR8VYqafsGdPf70EyCLXyVqL+b2xzzLyU8+riGGhJchdRWoFQwAgU0g5UPTUUkMbdm2m+OaenuDo9zYUY+5oJD13Hp7tkdZzKlUFdmd6NL5i6obC3fNv6wIsD97aJWtRNydyNo=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB24276017286CD10F955D0E5FE6440@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2427;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2427;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(44832011)(446003)(25786009)(51416003)(486006)(81156014)(81166006)(2906002)(39060400002)(6506007)(386003)(50226002)(7416002)(316002)(476003)(4326008)(2616005)(50466002)(11346002)(47776003)(8676002)(66066001)(68736007)(956004)(48376002)(5009440100003)(6486002)(7736002)(76176011)(16586007)(53936002)(26005)(478600001)(55236004)(106356001)(105586002)(5660300001)(186003)(52116002)(305945005)(97736004)(8936002)(16526019)(36756003)(3846002)(6666003)(6512007)(86362001)(6116002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2427;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2427;23:t7TTPZvgKQRUauCLKU8Eeh+6fcjBI2loZa8oUfw?=
 =?us-ascii?Q?gj45CfzrIoMZmz1E4/APNAT2/hL9I6vU8NVbRXRCigftvBG6l0n1CeJ9c59p?=
 =?us-ascii?Q?TeHSET5HXJfC6+KcBPjysFLFxrBrMCGSV9S0GppJI8LTvYfhv8q6XZZbVd5A?=
 =?us-ascii?Q?HhcDlFSZnaMr0Lhu9kszaR4ljgh1ud5ePNcaJ3FjmHfnWSquG71THbeenz0E?=
 =?us-ascii?Q?LJ7Ri1epTV3uFRJHD+D6/TmphZ/JGvcmrN++YD0jF6L/B5CCEompzg3J0Npy?=
 =?us-ascii?Q?g6shFKBSnPYF9PlwR6VlZIGtRfFCX4SjQsubzjwytDEXY8HJRbqS7ihMnNUW?=
 =?us-ascii?Q?Zu6iWRKgIG3UWhiA5eSZCJOrVyazKbHA/RNr1tsfbi/w4d8wZt/Acmy8aErz?=
 =?us-ascii?Q?v7U/F3qnTplHG+SJ9L7oy0t5q17/qDzPwJn4HQ5aJpLd3N5koVnZYjzcFWyh?=
 =?us-ascii?Q?iWkL7p2JPG/he804+h4KD8WAzy4S4kBwW+n0iDW9ujQ09tfat43eNYbnv/y8?=
 =?us-ascii?Q?A5RqlyYLHCmJZlT2O3FSLQEREweGJk4ZCbOerAsIqq3eB33FuOVxUrpayjHF?=
 =?us-ascii?Q?ZgrTo6ootBs27T51o1tL8eZPW/k4JiuBABY9c1urvjVxqNZqZ17qEqpGyiVA?=
 =?us-ascii?Q?7LMmDM+B4s7Aza2/PNZmS8Xf6oNhEkQ0SmkYWN0J+/mnva+MoOlTJt+b9qe4?=
 =?us-ascii?Q?jVlc+xvGZEt2rARwcoocUypHmBs6c6ZpMUakWfzgtp9H6xCV6WU3cCN0bOJV?=
 =?us-ascii?Q?xxgldqhvxEarU7/soi762g538O6eVuLIwEOgLMdiCEOxgurp32npBzgtTGNU?=
 =?us-ascii?Q?YRPdvFvAL35tUnuY9P6ddXcxc5TY1RILfQLu+hHFUXrOk/T5y38JIZvPys8H?=
 =?us-ascii?Q?TAkBO5fsPs89Z9/1x8Z4V/25W1rNbuuRf7elqrMEwarES9SxGFdpbDgPEtSG?=
 =?us-ascii?Q?YcUga7UBrGRRe3gKGN8KHqSp1NhWgSzpfmJG525EUuFdoFl6i2D3rcoIUuob?=
 =?us-ascii?Q?76Wm8G3Yc14Jixm8SgyQzxsvbNEJI3+Q0m6/Mi6hof3DqXcTb76sa61Nvbof?=
 =?us-ascii?Q?P7pBxHX2tbZb2tOQxA5kF3za31CpYzziO4nCXhjdFMUSMzGSUSWLHoz5569o?=
 =?us-ascii?Q?xiKt+DNwTxixjGDMIF+5bEzyT9g3pQxIlAnnvG1knF25PFLPnqIucOIWeKYk?=
 =?us-ascii?Q?K6cm+h9MM8Wo4oQH7eHZL+e5FG/BesocFUO0LyF7G237By0eY2JT3QfrEU/G?=
 =?us-ascii?Q?ElUGEqDZ5hjsDIoGg7wB5lz955IbC3Xyuv4kZBocLscINaLXEobmtucvijzB?=
 =?us-ascii?Q?23/V7pYdZXWJs0LWj0K8AiQxuLO5gqELOzX1R7de9IxV/?=
X-Microsoft-Antispam-Message-Info: nVu1/vAo2XiHgcL6rhXDfiyNWM5Hdgud5vVgIXEKGJb15g+I1+QUTRT8WpzAbRrEgBjssfTAFKsumx0MnvODYWsrVXzB/amD24HmLzgTl4PNHBwTtEDk3VCpM5Ol96UCvKV1Ysbbtbk7Zm5GCuwWiotIlAAZ9AXh3npa4yUWMxTJgaPltjVl5XFYal/ZEbA0gmmeDxLbPH1e5PY/NuZ16DdhFwoM3JyxbJpF26RVmtTrmUioTYP90KOsMScEDcjTM7A3cEISqwW4nWQ7ByoU3/81V8tdS9jWR1ZU/SHNrFhxclwn3UCe3PHZpVXixoEf/fnkDLZq/fN5Zlrl1pzJdZMFmZSk8nGqkFvT6x3BWdA=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;6:nL3ccDImSq656LbsEy+1MF1/wkEMt8Mr4JqFWvNfPQ1yXVRlQrH7xRGYhDyZSd04Kylx55SVxqd0YnMzmnXmlf6kL84q5HY5WC88GPyM83QGpU50XIeYlqekSxC3AKX4g8gaUwmpnoCLp/8FGbgEvYvAjKfpb+Gmh/ne2F+eoiZwdtfMicnI8NuUrXk1GIbd3U6Jzh/WPInpWXDFSUIj3b/+boPhXoT0Ex3qWiQwMn0RU6vWL6R6SZk4R3orinmn56I4+BHKwK6Yf73V/tVahOzNW6M3OrRyxVNvTk5RTJAl/BwOr21Ue7HW6D0Ya7x8be/L8lnN+rDbTOwUii4P0L5MPAMVqiA5z4HHILKP8LuHV8ncYO/dLSkONON5rCI0hpVoE97tz6Xm+FeP56qCBBB3Lr3/9HSXnd8oonXM51jwiKh9druQmv4mfrkLgf0mN8ROxcKg8ZLRndwcN0HGyw==;5:Qh2iunb71QuyRrV4RkYEpwF7nRWTRROgz9mLPsVySeP3UtDZhfqCqtQBI9X8H7cyvoE9S5W6CSHRy5nzGNrxDSwUWJZZKbgPzTrOPCZ/KD8aUU6Qmh6/YRXVcChDxhXAGTA1dzz8yNOvxPhxT1IYI7W6gmDh280ffUtA+hyJq5M=;24:ni0JQQKWJdR7+fremItK2JxfiBr9MTlUn26knUvpT23acF7WgtdxDHRcFLwX+R0CVT2WDlPZ7g3oNhI90ARnaBPKN/a331fVDnvT4xCruks=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;7:xpiSJ1e0xXzLJ5OEJzsNcr0ephk6i8juagQg1xDthMh/25rd3rOuK/9NzbsLNrdjSwySOiiy5iV1pr1JT5455HuERb4LMe2dt18O+Y63uvI8m6vRkmXOn2VVDrVhig6OXNL0QUjHgpMLEBMlP7ruNqHBy7CMbGSe4eaXMsuqAeun8LBqtkW1QPs+KwGY4Whe+wbIqW0jXtzKYa7opTJL94giLrKkt3u6mcxejYp5HXV2hOU53Ef5IdzEoPsdKMrc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:19:30.5928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654a7a6a-00c2-498e-f491-08d5e58dd9b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_dma_configure() API expects coherent_dma_mask to be correctly
set in the devices. This patch does the needful.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index fa43c7d..624828b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -627,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
-- 
1.9.1

