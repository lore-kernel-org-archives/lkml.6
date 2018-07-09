Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D9BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D72089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xn1FZ+6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6D72089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933396AbeGIPBn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:01:43 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:9760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933369AbeGIPBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTWDXRCmUDV+gTwv1eGVRVpcXzU4du3KBep3CbZJxzI=;
 b=Xn1FZ+6GT4fBqDxru4XM6x96v860dKfL0+oNcKjlepSHJ2QX1v7S+eWx39iB+oB/rcMmKzqiPm3p0V3cnJMmid5qtu2C03MRTDcmRWzs8IyVA+CT5AjTUDqYisfo0odcsCQiko2eemZMGElXHuqrgU6tAYNt0ryNRfOSEDUX8Fo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB339.eurprd04.prod.outlook.com (2a01:111:e400:881e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 15:01:32 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 4/5] staging: fsl-dpaa2/eth: MTU cleanup
Date:   Mon,  9 Jul 2018 10:01:10 -0500
Message-Id: <20180709150111.8875-5-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4a739c0e-62e7-4124-fb56-08d5e5acdc74
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB339;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;3:i9TwLIa1QhfJ6aB8I808Am/U+hXXs7YK3KpTa+yZcTL2RIZNq8kHz+/4fStaCXGm9PvHGTxUMnNMDHuHtSa0EiuZeNPOfJumRPdzWHcf6vLyRGrPuL8do8ZMU4ql0uSYFaZVOkq1fIro4c6rqvhiVckiMFIfjXB6dhz35OUGpH3One0Ek4Nv6cdhOBhXYaAZdlcJ6TVvQjXNwJjP9/w0eZKmwl9aP6SemQqZgX0tyuJzjrF9brBoOtH/SesSeGaA;25:gotSGI8vCarGn8BpKA7xmP8f7WnbapJd9IAFpvAqhnnYXt1FEk+4UcbEJUuAHWk0gHyM72MnSdCMGqNGQPAYOSEWCYqHie/bdqTmwKqVL+es9RAv8c5Fn4DveTfpag8rs91f2+YU2SIshmIGMKqtP2DqQDH/sffkvlO22mhCLnvyy0V21BWX6ls0fFDJlkTXcDnnO0fZ6A6CR/oMOnqyI34N7CCDaN+yqyg86H0+uEpKmDAKvQRcZxkIn1T4ezj19wvShlUetujiLhjehe++y++tz8eiC3SuuSlbyRBtYF0n4nsGjsv3p9uLU22vTdaTUcOuEgi6VsqmuVAXu0JPbQ==;31:98g+MGACcvdrAkGLgqCEMJCgyVQ0en6yHFdDC5EDD3fBMXe7Yl43rQTUxWDqKYKMKF0PL35sDPp1/RI3cNvT4Usd7TWP5ho1Efe8f9KEOj0cXChkmzaRymIjFQeotQYs6r4MFCzErE4JOSN7gT2fMyQLsSw/5uVguqJI90r4AZAjr3B7Vq0/ByDc1hdSK8EEKFJsPQHGsjn2q/XfqRwKARjCKs8fu2dtgTJ7cUkPdwo=
X-MS-TrafficTypeDiagnostic: AM3PR04MB339:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;20:OUMEs11zNBPMUyN+StPKafWz1VSXS0xqFlxrvAIZLYgXFmvOjKjHqXugJmNGJ1waVx6Asm2WMb9FHpqY0YRJXZC4n7s/SdA/0MMaetEeWlORNeUnFap4IA1NzF09tSHBjqDfy5VJSfHX1ct3sPUy2cebsah4bXooSyT95WIDojUpxtAH1oZZvgn+sw/j0IM3JEY9Y7UKxuIviScuqxsK9nUI1mc4zN3PcKqMqWvo3tEm5Q4h8A//mbAC49vCp0yC2CzzOXtFOsZZpKxgUxvaEMyJMq5LPKoZTsXarinw79v/FoeL9zMeFPpRtVmMsPAOrZb4+6oNDkYZzUtSwrolArKwKjI3axWuIxYD2gWUcUIhdvAN88mLkueCJcAL04cKJcLmPggWNPr2sd3zvTjwD4+q7FIX2xj2h1UIBp1T09SZYjmffB2ZI32QqOQSEUsZ5DeylDl88xDQ+Xip8QkUDi1PDu+sT8YGEvehQP7t93KDoBH9t5yUV+AnPG9ImQEl;4:0zs85C74SyEt/eR48B7jbu4QVTSz+hAi1ACBrHx5Y9Z5cvidM/Btp/sgYtuTMhTmr5JdQyfqrBJlUcYv3YdPz9bhCJ7+P/qaU18ZtdiiFGCEBmdJoVywXxWREvKcS5Hshso1b72I0KI/WllxGOmu0YOmRhKhYvUmNYwBkgdazolMqOqCbo44+JQlB+adP6AvilPtPNhfoYhVI6T0xavP1UpS/60ioZjjP8qDSHOtpjQcKta88CTgjIcRpiPM3BcbRv2FKfAGvzH2g0Nl1ff/IjhXBYT+0Ah8kv0vmTFWdq0qh8Tr+bF3o8plswbU3wxU
X-Microsoft-Antispam-PRVS: <AM3PR04MB33992816C9E389D2B34895994440@AM3PR04MB339.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB339;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB339;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(68736007)(4326008)(25786009)(53936002)(446003)(6916009)(6666003)(1076002)(5660300001)(486006)(956004)(2616005)(8676002)(81166006)(81156014)(8936002)(305945005)(14444005)(3846002)(7736002)(11346002)(6116002)(97736004)(478600001)(2351001)(86362001)(6506007)(186003)(316002)(16586007)(76176011)(16526019)(106356001)(50466002)(51416003)(50226002)(52116002)(48376002)(26005)(105586002)(2906002)(476003)(47776003)(66066001)(2361001)(386003)(6486002)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB339;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB339;23:gIenGexlSTI61bwpucFJz3EcmBRd4Ub/0eg7M0mbvj?=
 =?us-ascii?Q?6og+UWEDhf3ec9oXEY3I8Ax73h+NnN7BCdF7K4dZoUUndpI5QCUzNT3Y1kV9?=
 =?us-ascii?Q?ShTyVy+3p/PxEuguR/sBGucv58GkeqdkZJj1hKZqC+gVC2PI2j3IGgyg3xDb?=
 =?us-ascii?Q?hiBf4uPVctklpjs5R5SmQeF/GBUaHjfK0rkHqIgACQqvKbLvgiF2VQkUCw+c?=
 =?us-ascii?Q?86tny66cfnJxVxYK9XjuNc/Z0y8A62ifP2p+0LTiA774c5MMut1yDz2s38jW?=
 =?us-ascii?Q?ifRG/X4GsJ8kslyOoRtTcBUMsD784K2ss1gdlzDAqxoUoDyn2/+VRSn6XBQP?=
 =?us-ascii?Q?h/8DrYh9TkCmfm+FbFpxJVFZLTG9Ibtzerft8wYlzUvkLaovb8lK4tcIq3cZ?=
 =?us-ascii?Q?ZDd4gF9fwQgVTNAQyUuTS8/4b66fonAJpkqLITaMYDmkwG6epy6r/w9b4MDe?=
 =?us-ascii?Q?9D5gpM+AgbgZu8aapFKlQyGW8mPz9RvgdE6v3u5Q2VrbQPu3r/jmNvC1WO7r?=
 =?us-ascii?Q?bmfMau9cWOc/CE8GFoACUZIkJvWKpFktVr04NHU57SgEML3Zs57CDo9cYQLw?=
 =?us-ascii?Q?qJmZ+aX7azBBzrhhDJGMAW9HwN7F8QrN7zx8aUj2Y6pAYrTC7rXy+iNAhmDp?=
 =?us-ascii?Q?EgoO8ZBm8+ZMvoGF1xYgp8y46BPjP8FuEW1UTNBJLWDKrqHIL7vh813phqAt?=
 =?us-ascii?Q?ZzxQ4t8RaJahV9zS6XgcU40b+O5SLBmETc2YzSG79wTWCexIOpno6xNkJbus?=
 =?us-ascii?Q?mO3vBlqlDiHYjqB2B20gWb6fYBVZcaprzD9D3LN/b5SIJbGbRNgOe6pZNWMm?=
 =?us-ascii?Q?fSdv0ObD0MMZ7CrY3//LrrIZ82dByRLZXR67bfJOxdfHA4b2rLjvqGyEhD+6?=
 =?us-ascii?Q?Jz8qlmyPekBC4iOuHv2bvToVMztPV/6AGj/DQYm/Km8aZFat7X04ZgntRUBO?=
 =?us-ascii?Q?boEv5z1R53q52lo5eQNG7hOCxuMWI0NQyqNv7AZgQgijzQnWLfKeoNDPlgCm?=
 =?us-ascii?Q?P17fICCTb7xLyhsxBfk5X5GraQRE1Qx4E/OvZwWkF2jTqPJq0KoEQSqWn761?=
 =?us-ascii?Q?z9cdJGQSZbmERidCiR1pTb/jHMtyK25MPXPqhjUkXgbpQH0q1fGqKxh19oC9?=
 =?us-ascii?Q?YuXb6eFgCVzQtovpow8VIJdOWKLAg3jBZ0BUUoFhkOQhPT+5MmokKioDYIAn?=
 =?us-ascii?Q?huKN2qTO6RF6o2dJ9jycW7F5zxlWo9XXfs/BBmCLexxkkHJjCdije284N+ET?=
 =?us-ascii?Q?4sqZqZ/93/JX1OMpM=3D?=
X-Microsoft-Antispam-Message-Info: dQz8/tnqTPJCyg0Vk9uxcCtKhsv50Zr5qOu1vcRSTTkgnyRxFQTJ+rf1+r6vn4WXYJWJy42sDm4eBwbsszBBk+ahJHEjRPm7HF1UokzQ9WNz+Nz4yusEcnBhYoo978aVZGZng3z7QWBI07U5mntgyIAVf289ya3xUKAMi+tdWeubjMZzRA9AoiRfvnkFsghCFze6OZ8gKjPo7JVLZODZ2quq5hfQYpMtju/GDMga7RS265Rx1iFRqmbvB3TUDcukw8m3rqSe6XZeTq29l6WgiHyoXtdwdQ9YgcuYgydGmTixJCa2xwItKU42s8obuD+xwWRsaBJ0XrwzaDUvUYleaJiDbBNS/8XBG6r9+S+1Y2Y=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;6:ZipBPic75VjruRwnPwMUIP/V3avswvXkpB652nlcnrOM8wDKuaOsa/P5MeeUqnSeJjX1fM9oQKf7U6AHBV6vfRmYIPNyEfmzt3w06NUyJpqUM3WCuHyR6dkwIbZF6acZ9q2MLLHmJUEbhnYsUY831HaquY2fICJB+VMlmhOe4Sufbq/ta6hfSNf9SHQOULLkoPBAbXpmU3gYMmGHmqCvA3UucbmttNQNhkiNDWX/laS/XLJesy53X0JigjRgVAipn5pNarhus2n7+B403T0rNCN9AU2afyKhmutFgWOh7s1emnxAsGAVhaTDQSMWZJE3IA22YuZ6cyMg4uCl9DYRqUI7LuPsa254haNumMENcnRy/vFuaWSO/+YF+JtF9pIXXvZje8WL94vqgzquwUU7FohLPV/sVSUH80RkafMDev2Mxx8eAklliPhAJRhtCxX5w/12YfW1zqfc6S1hJ6ZvcQ==;5:Agjh6xoUMdwMlhzV22KmsE+fGoeh5RRw2roaawSNeEQxOYp0Jiy7pFVFq7nSS1bqrq2V9azj03YwA0FVSCukIExWPyyDGIqUzxoi3DULdPWWJQ5gE5VYsDprX0w7uR7Fcyum9xmzY26rxV+L5M11hSnxeqE2bQqNBtWk8xRC3vw=;24:1/k00In54OqK3zleV68gjJZI8O7zPA2L+LEs+hvZZDqT0lAfxhyRm8EiErawwb6bSX0WhoSCyNHeAKCThIlUWkQ27eyaOk4Ho+3Z6ScewiI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;7:czdJcBUgowr2RuDg3dSc/8MMFlcrcAhbnvaRnaAXavAXj8p6o7SV8Hx5uRAJNkCpQqErYkOgwR1oUpTzuDhFX6nrt5FBtF4xhzZvpAofA71sG0aDH3c+BH4VpOI+ZP9neiYAtLR60uBsiWFMU2Dzz70KKrkPYiJSFXvndymXrwqIz9vdDABmgFywXtrqcys+/W4fEXKfSmLK3SycQdXpVNKQpWxQBetKAl9YLvtBh4cklQ9/Ayeebns2rZe6sOY5
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 15:01:32.8270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a739c0e-62e7-4124-fb56-08d5e5acdc74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't set the lower MTU limit explicitly, since we use
the default value anyway.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 439b260..24e069c 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2383,8 +2383,7 @@ static int netdev_init(struct net_device *net_dev)
 		return err;
 	}
 
-	/* Set MTU limits */
-	net_dev->min_mtu = 68;
+	/* Set MTU upper limit; lower limit is 68B (default value) */
 	net_dev->max_mtu = DPAA2_ETH_MAX_MTU;
 
 	/* Set actual number of queues in the net device */
-- 
2.7.4

