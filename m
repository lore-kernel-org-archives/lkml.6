Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53794C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEB221A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ohuMRbw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEB221A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbeHFVmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:42:01 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:22570
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729976AbeHFVmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlRQX6NHRvF9Y8f8GQQqDP1Z4wdKXfI4mS8zvDE+9LY=;
 b=ohuMRbw5wKON+6S539AGVFXHw0uoxmgm4tg4wjeiRYadx1KfiSY+QHulb+93tkl+PutmjIRfkGB1MxAtHKtIlArzI+9eUA246H8dHqwMjBggJLZs7ZvC6rWHwLyarl/qPv4rhwFlKmGknhRzGQcS7pfyZPpcEIMc+rLsqBhd3jw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 19:31:24 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Date:   Mon,  6 Aug 2018 22:31:06 +0300
Message-Id: <cover.1533583611.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR07CA0162.eurprd07.prod.outlook.com
 (2603:10a6:6:43::16) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1376168-0a6c-4947-7384-08d5fbd332f2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:qwdOH9GP+UimPc6KS0Kl9iTNsz9y5Z/PzlM/fZ2tnyatf4Bphil8EZXiSskofUfS+pw5FUFDPAPeHb2l+cV20si35MIIltTHIY5NTx3tQ548bRdGXnIFcoScXfWIpRPXgwkdmLTy5iU4x2I22s+1yiygffzxfXDd4kMi8765ZDR0Za59hKZ4Cti6g+gAc9Ccta1SO/+2PwuciJCqGdseOG0avM4nQ3H+rw0UUnUWNgA+xBmHAsH0OxdkSh6ny3+a;25:QEB59OYHBufpV9ZTmDTUR4T5jaz+Zi3aiM/tRHKzArh3KiI3KSGVHg6gOloJ7yKXlDXWMs338H7iXqYLnYQVvJYZIaWZVrfOrbL5e1Q1hvr8vleOJm6AnrvKX4dBPCp2EOiWEWJ4uoxtxg4jFgMI+LPTwq/FMkRbRQps9sebmhChgGBbXMXOdMW2JaJr9upFdCKJie8D5Ff22TFegOoRZyyToBTEtzZb0XiQViR6FHPCIES4cOdr2zQxcb6In7j7SiMXLR46XeTqUMuqOMhbZkaG9KLZzWtzpNZqxh6KcFkwsyN7GHrx4cUyLn4qhBYlVIvuLS+7dUPcKnpTZwl7NQ==;31:RiPNNb+fG9DQv2mnXStJsTH0nf5kp9hRFmhP9yHci7YBDUSlEpQXmYr3cRnzLcJim4b+ztTLn3quMTZVcGd9ar2IBamqzvK8Y30vo1mrDYkcErLyU5T+BDI50jLJgCJyTSPKTnXyidVdWkL9TVc0Ri1M8Jp4JO8Ms67MwV6B1c5DhhgVVG9ZGmHEtXAoeQldVaLDkkyRzPYswuGh6Ty2J+e/p4TSwbgoj/o2lTKDojc=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:FsyJ1TaUPW6oJXzjZxOkfhpekegYf6lNUhrT0R8z9z/dB1Y6L73ygr2nARGmcxGn6O1syPPI+y6rMeYBoY8Gp4Ma4XPPSwUmW0v0c+Kh1WcNjZbAfBpETtvMpN/4+k5xFoX32xntwQQwXXkKAEBPDhWfebc1BooxR7pqam1SaV/2BPeuc3Ac8pBYHM/XHu+SjYYNmkKMHBkuTVDXxyFEDLuyeTHuXEbPrc3Z03Vwt5y1y2RB2xwApC/Z3oN+E6a/V00JcI0tlKYXYUNY70dMlujynh9FDgDJjBTZsAtsKVkvzJfXYkX6PJMS/aebxGXtUC8QhdYCrU1cNFjbblhwgx72icj/A/ymuuoFVdvbsC2MjwFuRsAdqfcWxCKVT8N/S11BZw9IqzhhP2L3+2bMHSQl6fo53kgZM/3mHpcxgvglAvI5ZptcEKQ+CGUtyV8vKpdGch0KRegETejE5RyyOYdGKtNkKp+a6sLBxRMjLL2h8pEv6lLouNJ/3MNDA2gB;4:fmMULWiODw4BuIfd4WBAGLPz2c04S+IQw1ziLptVMk8ckQYfmNSqO+PRqGbeKqQjoGzTdHfj4ZIOiT+PXQFPlvJkYOEFsgG2fjU1a/imRsA2NMX4mtxLI1wKhKcJediq/X9ai8J/XWNMiRkX3I4ZLc1KySgG/2tRjT3WeibnTtyf9VACKhyiRWyudj3AIQEtL1mrE/tFOJvyzrWjq0Fpd9RdY6MDe00Vg96EirB1F0q8QxHgxy0Jil65hiN9v26F5BPq+jLYV0AYQJSv3vPaVzkxr9U9Z79aooVD1ByaEsnv9x2RjxGlq5gNh6IXQM1G
X-Microsoft-Antispam-PRVS: <AM0PR04MB42905109DFA9813606B54321EE200@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(486006)(86362001)(50226002)(316002)(6486002)(68736007)(14444005)(386003)(6506007)(2906002)(6512007)(6306002)(50466002)(51416003)(5660300001)(478600001)(6116002)(16526019)(3846002)(66066001)(25786009)(26005)(47776003)(305945005)(44832011)(186003)(8936002)(52116002)(476003)(48376002)(6666003)(2616005)(4326008)(966005)(54906003)(8676002)(105586002)(81166006)(53936002)(7736002)(97736004)(110136005)(956004)(106356001)(81156014)(16586007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:hrBHMVBSfn7RAPc39ZmK7TTJ++6haUe8O4M1WlX9K?=
 =?us-ascii?Q?HP6nTHnUqeSpTu66MvLlu+lAF5JgIpXOEEhec+sIZWrmm/laC09bHeTBFgPz?=
 =?us-ascii?Q?BzaFVUBUmO+Uw5sOPiwQiKcRHdg9t3wxPQ1Xsx4M3G/PkktdS0HzvFfZ2m2Q?=
 =?us-ascii?Q?BbH5xhhntAY3JQB4dQdXfE09hgDejLV8nIZ3eQucoXSUUeJzBSZthBB7tiqG?=
 =?us-ascii?Q?v7MQt/UGtLmjY883GZgoQBb+ux6CxycQf3zaTbVTwefIv7DqvCFE4ZNU3RgU?=
 =?us-ascii?Q?wC+iR2xlrJBIQ2QK3eEAaLZXDzW80tCaqsaQx/35uHKSL7jporQIEu8wmzmv?=
 =?us-ascii?Q?4MA0DLesYMGBbWAxmVx+cptK9TvMFv7MmVTFm1lainlH7ld0AlQummeDrsex?=
 =?us-ascii?Q?C56lXJrtHNnO+mWs/khVm1xZbMa1bdkMso8RAaWFYwMpv2q2mqCP7iCGQMYd?=
 =?us-ascii?Q?IOJeSQS/KsDN+AO8rCMRx+7OiQYlqy+GWXBxxO3CtSmoEtPnzXQ/2GxBQlxJ?=
 =?us-ascii?Q?3TQtqLJOHM5NiRC4NexyKX54PTFPy5P5fKFTSN8u6u4e6Vi2pFL0N2AxrIZR?=
 =?us-ascii?Q?xDpyiQu8gOOWZzSissDBo6/qy3BB3G8x6QRxDcb/RJSbrJ6WPrGZ3XVKUs8m?=
 =?us-ascii?Q?5OQu++ejwONZkfOKC1AET7jcB5lwHU2UaDr+1UWCo5S/ak534XWEaIytIIsS?=
 =?us-ascii?Q?5MqDO3mBHAOgCewuUl8bay1rMSciI9EhT/meOmmbs4lyTHIvvjfzhcdnxH/l?=
 =?us-ascii?Q?7iiDZ3HN08kfhl/JQximvivOIuePTCJdrDjXW1q+LZLj35RN2Q+gPHlZ/cXh?=
 =?us-ascii?Q?b08nu3+PvhEVUbOIuG7N/L2hMF2Ua8z0Tj4JCej4a3hFQsd+BRm3MEL+sGi1?=
 =?us-ascii?Q?2FfeuBwKiVmbrhkyg2JqzL6I+XJ4CKAucYSWZw96NHVyaryJW0ZeNe5es08b?=
 =?us-ascii?Q?e/ufpJeARauLg5zQ8+pB6hPsqXoqsGMJg/1qphyUL1JuDvVsPr0MHhe4pKRB?=
 =?us-ascii?Q?PMDFLj/aYWefyjAMW9T+uCZeAmvD6NJ/rdOXM19CC3LwM6GBcQOxvyJgja5m?=
 =?us-ascii?Q?Sn3BFAj3cEY/CoHlpX9tVM1jixiYzdbTYh4d6TKNgXwVHEdTNB+/Czqh/Ovd?=
 =?us-ascii?Q?gr6xjqjBQfW2kM4BSAaUqSkYkkYW048zGSOPnIkj3XlxEdXa+EwQZ802dhVo?=
 =?us-ascii?Q?6AlIL6RENx2HuY+JzdMY+H6Mgsb51E7thse66UIbU7N3Gj8hMM2hrmtWg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: W8Sk1v8tG7/G4HVS18gOBxuf/+GtyyfZOwFpbNIGezjOFpcZQ1oHIdnxPJqgWnfOAII5BgLPBygQqbk8aiGPOgVlxWGMqp7ghHBhz4M02c+DNnW6sLpujnyOY6bLrR3eXSKlyoZGes2tNthySIclwc4P4RypuKGDjPY5X5QCyd8xhGm8YLurh+BIW8cQrVLJQxDsqbqvwF+TRl83rSXRhbxDWo4FXoUj8PrL/e8iFZoQOp9AWnC4r7v8Mi6UWdqEQBG1/2SieNKjHBcz6NfBrBl1cvjqKLE6neKQI+aotWBYw8wt5S85cHiZuA7tYq9JXwdpyr0HbLx7GgHLmQ5dlIS7uIG24fq8dq2iv/MyFZ4=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:lMeGsREnOv2YbpnKTrmebRKWCfyxS6gGGxJSCQwv5S90o7r6FXLoTubXUVw3aMjpj0MeZyudAIo3CLpWhgGoBS3k7us/SmmlDa8QsWeUQq1LcPS/mQGoiiCTXgROnKXSFXzrm6HKeVvTD8gpx1wLNuFWcP2lGxJi+vRR7UDTR4IQYFbi8eAk/t0U2qUyg1SdDl+Dljxns+0zawGeFCnEUDNpfzZSaVI2o2qMLntJuFmiMInfKOOxO68bIN4akYkHoW9aQ5/G7LlkrKhwqc0Jk/p0l+kqzbpcUDGQSo5R/H6Q2xyslrXiraLR4c5PzJ+xB8WzWED980Mt0EayG/VLXChPZ8mBKbwF7d3/7snVfpk/Pvx2P3ARuCwLJQdR/IcyovNsmKCy5GlPzvYCAlB6wrLVzqtrby7C8083q9vqchM2CY7xQdNDNVM/LescEKBxmDl6FbgKhDWgAsd8JuM6Og==;5:k/ZQ3XC4eADL2VrcxW6BJK+MZiiI6xAj6PloTJ28bTwlDNzGNAvFv9iobwXfrSqQg0tAtk8Cu4irJ7Gjmx1pUoQxq9xfe8UY9npMkdOqJudmSn4ETrDZo0nMGaiqyIL5ic65vdfzDpp4gRV3ZSS5F5QSMLs+Hhrj8ccduJNrwjg=;7:SpsWufIha5/A1xzs3aHOXwh8vpMA7ljft9Bs2SvGhw37HmI4zG4hIC41AGye7vr02kbPusYLXBHWZsw398oTzSNxXN6QSogkTh330OZb3l1mLAOmL3zJrc+eViUHLDh7DIaviLX7cFj1SwOFbZP2hBFrQMvbagSmH7z89rKXFCidNS7QVahzszw2pctCfGpWA6vPsunZBpu9+ckvpDe3RkDXP4bI5aiizSMP1mtpgz0XJhbFCH5Ljm4p2sVO220O
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 19:31:24.2706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1376168-0a6c-4947-7384-08d5fbd332f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding lcdif nodes to a power domain currently does work, it results in
black/corrupted screens or hangs. While the driver does enable runtime
pm it does not deal correctly with the block being unpowered.

Changes since v2:
 * Split into multiple commits.
 * Use #ifdef CONFIG_PM_SLEEP.
 * Switch to drm_atomic_helper_commit_tail_rpm

Patch 1 was split because it's useful alone.

Patches 2/3 could maybe be squashed.

I'm not sure patch 4 handles vblanks correctly. It does not replace
patch 1 because there is still a small window between enabling the pipe
and the first atomic_update and also somebody needs to write to
NEXT_BUF.

Link to v2: https://lkml.org/lkml/2018/7/17/414

 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 42 +++++++++++++++++++++---------
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 40 ++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 13 deletions(-)

-- 
2.17.1

