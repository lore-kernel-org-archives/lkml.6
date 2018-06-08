Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1+EsK+dLGltXWgAAmS7hNA
	; Fri, 08 Jun 2018 09:28:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 428BD607A4; Fri,  8 Jun 2018 09:28:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="b33OOJVi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5AF08601C3;
	Fri,  8 Jun 2018 09:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AF08601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeFHJ2Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:28:24 -0400
Received: from mail-eopbgr730041.outbound.protection.outlook.com ([40.107.73.41]:10368
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751004AbeFHJ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLGLC8guoli7M5/U+TH4R8LcIAehlKlDlKdOHarNIog=;
 b=b33OOJVil2F1ibX8J9bbjUOLzZMfydTZkYLGsTdMI5XEPjWosglclhGWiIGJcKwRJTKEunQu9RvmWmquhKZ0fpP31xZc2r+popAQMpua51b6yoGl/mthuwipB54d0DZB5l/bn98g8s/hk34qbKlOPkDWLz04S0qV3hlfZJOZiIs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Received: from localhost.localdomain.com (50.233.148.156) by
 DM5PR07MB3004.namprd07.prod.outlook.com (2603:10b6:3:e3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Fri, 8 Jun 2018 09:28:17 +0000
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: davem@davemloft.net, rric@kernel.org, sgoutham@cavium.com,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH] net: thunderx: prevent concurrent data re-writing by nicvf_set_rx_mode
Date: Fri,  8 Jun 2018 02:27:59 -0700
Message-Id: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To DM5PR07MB3004.namprd07.prod.outlook.com
 (2603:10b6:3:e3::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3004;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;3:EFMFBYgGim7FAmtTFY7oHDdV6d6qXzMKMR6Cck3NW65Tc1rAbKhbuO5cAq8Id8CU/zuV4i3Z8ZZAc9SW5wECdw3+ng3F6TK/LPOAqkAObkA9cySn4h6i9WcpKgDzKwfPIXjit3yIv1tfUdcOaMwBpDG0QxjxSGbld7q7dF9LeZlShAS2fTIBK1Vy/1v2iDmyeBUKsmvEGWRUfBltXdsRST7wJUXhDpvz1Ka24/KnzUI/6B3lgBsVHCY/Qy5ik9iB;25:XyJJPBSFO1XQrrWdyyFvDXZxaoiQ7ivncWjFpqh583Wr0k6gqGMQWOKluV8pAt6XatyEXsG5Elwh0ssd844fdSK8QNrBo2kH6jtE4si0xO8PWNDwnYKrLh+e/emjOAuJI48G/Dpogb8CRZABV3p3YOlY9bCTpiL/AfGXY/DN2husmH2JG1t9HyuM9fy3QcBtl0lkmg6IOgeTOWYetuXNTTBzznOXyv22UMzyIykbC32qlzd8zzUsx22Nejo8cd3Yv1p9pIgN3WfbX1dKd9P3/WOA8xC2fSN8TU5a4YkFHFjP9AsiZPmZnYzz2v1TcA0rxz2kQHhyh8Hwh54QnqMkZA==;31:73Tsp1VfiT2CQNFcHRZop0Wu6oPcgjO6t2A5vGMwI0PGpxVAGMGbVVZ6YJw4kO0mZxBIhKAcwBH0R9ke6rWbWG6+QoJUdFLCo5aV31FpDxBz9M3UMDGlEoytc4zYtUTt4BQQsc5/685T5/DjXJ0z/T0zzYlX60wdxDuYWiW2D//m7ZXtNEHN/54f9umdX45IjkShrJ4fSmBrz0OOGAI6KPMwC+I4YRJe+vgBKJmTLyQ=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3004:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;20:U8AVRMSPn4a/58dBIOtKqAIwo3jSdo/HC0+NvJT3X86Ua/uOnkhapp83jMQx8A+qmVEYTLa68nhNGbYjloHdalY4rDGdjnYNagnP0JpMcIuTQjsw7VA8M2dBagkCq8htLQSzaMpUVcMyifgnOjbD0b//X+uSaBjUhYGh82zsaYNrRt4k/jD6/GTKPK+qQep53XMU9bkSTUzVDkdocGaC7fz8A/VuyAWsj4Rwkls9ajjlF/tfY8nudxIsFLCdGd1mI7pS/Cm1F8lbfBbAhspIubBa2UHvoA85742rrNOWLrYmzr5/fvA417zYGqe6Do71PMxdU0v9PMj66SryaMHeXK6eRELQReQu5nMn8c+XscKhaM/GyGrjrNORkYtUoqX/vp0IAiYgVwW+IGDMQCq2qNER+DgoYDvDcl6M4MGp9kvvWNvRh8pN11lQ6y28ritE80m8zHk3z6VllIZ7KZpaTXGFRl/Eda9no5eJT2e+S7caZ5u7wtffznIsBsv8nD4nx2+XGyvXCw7B4PYSIpEbDQCjTSfEigvuMe17IX1kyQwTiK8BJ3yuyCINagVtnzMMWK3DRwnYblNWNNaxKZhxCRlyKSeGchOwYWoy2uBIiSU=
X-Microsoft-Antispam-PRVS: <DM5PR07MB300499C0BD6509C4AAFB3DC48A7B0@DM5PR07MB3004.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3004;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3004;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;4:HjuazkO0qjdNNljH695Hw6d7OPAQyKoOq77sGs26KqpEiqIR1fOAlLMvv+zr/3BXHy0RFfySDj945/EJWL6E286z4l10ijCK5gCg3lk9Bwje9LzqRfa1G1OE5IkTV2N9f8tHEEdZaWnjyaXLqR7d5swyVOqNkmfDSditqEQXors5Xta8/vIBBPzhMumT/YcO2Yo/RNOttD8aLH2xMVCIhkBSQfpYWv2BhSsksdyzusyOZxXmFu0DCmp5i9KtrzqWuA86knHC939HeQLM/Kag80xb0Ugud2tBB3Tygtz6tQ0JPDe9ax6h+C2vNylTCgYrxNuM9K6HQf9Gjwll9J7ruRfbuiMNPgAEvOcqu0r52/I=
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(39380400002)(346002)(376002)(396003)(189003)(199004)(6666003)(69596002)(53416004)(956004)(476003)(5660300001)(486006)(2616005)(105586002)(106356001)(68736007)(66066001)(47776003)(2906002)(36756003)(52116002)(51416003)(1076002)(42882007)(72206003)(478600001)(316002)(386003)(6506007)(3846002)(6116002)(186003)(16526019)(1857600001)(26005)(59450400001)(97736004)(8936002)(305945005)(81166006)(81156014)(575784001)(16586007)(25786009)(4326008)(50466002)(6486002)(107886003)(50226002)(48376002)(53936002)(8676002)(6512007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3004;H:localhost.localdomain.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3004;23:AdO5as6oiBX4NfaDQiQt3slnXrUYFMGB9xDH0vYac?=
 =?us-ascii?Q?QAIAWmGdhWNKCs9pKBr580q5HCrPIOCD1/Jvwo2Z117Xiv4x054wiql2G48p?=
 =?us-ascii?Q?AMwyE8y/CvDdz6FyXbd0MRZURvX+Wwo8MRWBsdelZP8UtF5u5BidSYlKbGVH?=
 =?us-ascii?Q?5H/G8ecvktb8h+TCtwNts/nmRlo1L3TsIBk63gC5Ml1sW0tzC/k/Gru5xWR6?=
 =?us-ascii?Q?41+dLOtAQPgvHn07CM2UY8HrokNLRy97C+2qnHQof2vvPUvsrCWQSYRGg7sP?=
 =?us-ascii?Q?Y8XinEU1xZkSrw8cvvQynYeEuwTYYhE5ISRyRHuMjyzj7l+HxveEiv0idKyO?=
 =?us-ascii?Q?F9Ov19/hbBiB5FxQfyp7nZRkrbV7QgArGCwTC2ae3o8GgAq42H1Zr2bTkrtP?=
 =?us-ascii?Q?OZpEnpP4xbTC5yOmdpZXsdd2wStZudysFTvBIEv5ja8TcIuiqk52qOSexDTH?=
 =?us-ascii?Q?EAF5MaXUWYt68rFeGBkEw18BN9N1eXQsB7Lo2QFoOxB6mFp3Qo4oZjQnm2E1?=
 =?us-ascii?Q?uBVOGEEVyhcvJzUtHhFEpiYtQiwqLhhXR43QGQ8i0Sihxn8+jocTju5omUsK?=
 =?us-ascii?Q?beCtq7m+Q0WdCisg4nOtQt47cnAKPT5VS6010Ans/CruqtxA11SWRR/uWzZi?=
 =?us-ascii?Q?FDqJlMc/eRzsIAz/4liS1cEP4lKymcBREn7WtZmZnXI+4NB6yadmasso852j?=
 =?us-ascii?Q?ErWRK//t38q/9rEa2cSmqHOV6z5yw+6CddRfP9ozIhSlwsxhJeC/9Pfjfdq3?=
 =?us-ascii?Q?0MRuH8scUCa5y7AERf514b7+58g8SsBfCbBG1XsgXy2BmKoREwQAETAMoUHt?=
 =?us-ascii?Q?tXizS8TwviAn+yOVwJaDM3EFTgbVeKmRjUZgU3FOEFG/a6xdojo4COMMGUhG?=
 =?us-ascii?Q?f6x5jzzwNykWxQY0EU8NMfGahwQRNusPitPfwh7usx+pvXFOEVEJVaKsH4OQ?=
 =?us-ascii?Q?c1DS2DYjEu8fB69pb+T2qMwHKcLvNgceAbyv6+FNxMgEfL9t+97XRWOTf7iC?=
 =?us-ascii?Q?Ktv1Oqzvp7Vn0X/C/zMgPnlKHYVg/eT+CYFiJi8v/J/pRZEKUwOT2azcPVDo?=
 =?us-ascii?Q?bvSmxfznnJsy8557DeallphF02kM9lEZLJT6bbDXm/Kr4J1bGAe/3faDbPew?=
 =?us-ascii?Q?EnpluVd9mOEVBldi3jXQ5LLNIELsdcAykS7CPuSXXbKMQkPdubuvu2rPxiWN?=
 =?us-ascii?Q?DLcyJnxQR6PklcfY6L6TZzbOgsg84UNA1Ew6wrT3IQ3V6MzQMsTTp3c/iXNX?=
 =?us-ascii?Q?pNJzwnf1SXqRemParkAWQ9cV+RmBppGv4c9N7nNcAj98vQWJoTUOG8xwOTCp?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: YUvFj27ebuzRNrwbzNtpFyYzVER/V0tyeANkbmhwXcKC14E6WvN+6/2+aitbKkX5Q3gMT3DOVkTIpGmewlvsNyjIo4uIh9GmuGymEGrNearu0xSw9HuxS7SYtdWZSrDB3v7FIDTpWSCR+e46neEh8w9OUYDmCjkSO51bYrSYce+k/agbwyt1RF84RE4KJMc5
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;6:/BMjSIvrmkqKlMNDX3Z8k264Afh7KKTsyJ2hS+ZPKTcWLZxbFaaMR9msRv8PxcCrWW3cnrUo7vM8Bb3OpzG3adyto6fh9Z99K3NgeMGnTUTKwZEzr+p5dh8MECGXYJi/nopYe/QnDn9Tv7B0g4ZZiXGJNr7DKIJr+ZrJMME7KRhZjGt8OBZUvsjSLmrdnFnXzq4aj6Oej9dlUtttcRCSztKoVfvIta4oT4X7yD9nDKDBd0zPrheIsd2IQTm5MyVIMr+8N0DjAhaKZ+LVOdMBRH2Cv52EtZMtfJg8BSJCjgL6qKphQ05+zMW+KcsPX1MFK4E8XSRSwIJfg19962plAJvFaUfsbpcnKTze+Zc5+EDPcst3kgtrU7S3eqeI5ZsD8JuC1uWEXe4psPhE6F9r9Ki1WUZ4/VCKILxKFYll9iDa4/X8vG96yjblaJ7DyAlzChE8q/Z8xzlSDPxuvfgvjw==;5:CIcd5mccmw9GyqfEbc7dUgN5tfKPecRVbLQodxAsShh63bKnfF66c0H/k6gzqjhFUBVzzjQNf8gxdjFXnYg6MgZ4WTaD3FC/6E/C3QwJX+xoQieeXfVdvKPszMXA3CZvzaaqlByngwFpX3nmtTiXZa98z31tGmzJNqJD9DmT4gY=;24:r/PcSTglKavnQXLm0Z18zOv5roS8uOUeJofyVQqZdXDRuIyu7FqWA8rkTzQIgW9EDbdl9OOXec2brPTXzSrZw0fvRnSpBvlMzmbuZUex6lA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3004;7:I829W0s+N69R7JGVYoDJGB8mkt0BuOYZB/bsARp/pD3syBfU6sR73NqKU1DBKeHxmYDAt7i3vJu37MaJkHwIiIrvpS/qgKT2bjGVVWP00J6jMjx8egfpxd4P+jA9sqX8gRfLM2bQeH0DxYYBOKdbuAlFjHTqcwfuKknOEwmWJKygM5RAicI5D6Ug3vveO+AbWgKzujhw+iLt5WlunwqkzNpQXUqPhLK6Kik49PEfMkwyQYfUkwlm4ntucT8MsKHy
X-MS-Office365-Filtering-Correlation-Id: a2493879-50b4-40fc-3017-08d5cd222b68
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 09:28:17.9370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2493879-50b4-40fc-3017-08d5cd222b68
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

For each network interface linux network stack issue ndo_set_rx_mode call
in order to configure MAC address filters (e.g. for multicast filtering).
Currently ThunderX NICVF driver has only one ordered workqueue to process
such requests for all VFs.

And because of that it is possible that subsequent call to
ndo_set_rx_mode would corrupt data which is currently in use
by nicvf_set_rx_mode_task. Which in turn could cause following issue:
[...]
[   48.978341] Unable to handle kernel paging request at virtual address 1fffff0000000000
[   48.986275] Mem abort info:
[   48.989058]   Exception class = DABT (current EL), IL = 32 bits
[   48.994965]   SET = 0, FnV = 0
[   48.998020]   EA = 0, S1PTW = 0
[   49.001152] Data abort info:
[   49.004022]   ISV = 0, ISS = 0x00000004
[   49.007869]   CM = 0, WnR = 0
[   49.010826] [1fffff0000000000] address between user and kernel address ranges
[   49.017963] Internal error: Oops: 96000004 [#1] SMP
[...]
[   49.072138] task: ffff800fdd675400 task.stack: ffff000026440000
[   49.078051] PC is at prefetch_freepointer.isra.37+0x28/0x3c
[   49.083613] LR is at kmem_cache_alloc_trace+0xc8/0x1fc
[...]
[   49.272684] [<ffff0000082738f0>] prefetch_freepointer.isra.37+0x28/0x3c
[   49.279286] [<ffff000008276bc8>] kmem_cache_alloc_trace+0xc8/0x1fc
[   49.285455] [<ffff0000082c0c0c>] alloc_fdtable+0x78/0x134
[   49.290841] [<ffff0000082c15c0>] dup_fd+0x254/0x2f4
[   49.295709] [<ffff0000080d1954>] copy_process.isra.38.part.39+0x64c/0x1168
[   49.302572] [<ffff0000080d264c>] _do_fork+0xfc/0x3b0
[   49.307524] [<ffff0000080d29e8>] SyS_clone+0x44/0x50
[...]

This patch is to prevent such concurrent data write with spinlock.

Reported-by: Dean Nelson <dnelson@redhat.com>
Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h        |  2 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 50 +++++++++++++++++-------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 448d1fafc827..f4d81765221e 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -325,6 +325,8 @@ struct nicvf {
 	struct tasklet_struct	qs_err_task;
 	struct work_struct	reset_task;
 	struct nicvf_work       rx_mode_work;
+	/* spinlock to protect workqueue arguments from concurrent access */
+	spinlock_t              rx_mode_wq_lock;
 
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 7135db45927e..135766c4296b 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1923,17 +1923,12 @@ static int nicvf_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
 	}
 }
 
-static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
+static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
+				     struct nicvf *nic)
 {
-	struct nicvf_work *vf_work = container_of(work_arg, struct nicvf_work,
-						  work.work);
-	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
 	union nic_mbx mbx = {};
 	int idx;
 
-	if (!vf_work)
-		return;
-
 	/* From the inside of VM code flow we have only 128 bits memory
 	 * available to send message to host's PF, so send all mc addrs
 	 * one by one, starting from flush command in case if kernel
@@ -1944,7 +1939,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 	mbx.xcast.msg = NIC_MBOX_MSG_RESET_XCAST;
 	nicvf_send_msg_to_pf(nic, &mbx);
 
-	if (vf_work->mode & BGX_XCAST_MCAST_FILTER) {
+	if (mode & BGX_XCAST_MCAST_FILTER) {
 		/* once enabling filtering, we need to signal to PF to add
 		 * its' own LMAC to the filter to accept packets for it.
 		 */
@@ -1954,23 +1949,46 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 	}
 
 	/* check if we have any specific MACs to be added to PF DMAC filter */
-	if (vf_work->mc) {
+	if (mc_addrs) {
 		/* now go through kernel list of MACs and add them one by one */
-		for (idx = 0; idx < vf_work->mc->count; idx++) {
+		for (idx = 0; idx < mc_addrs->count; idx++) {
 			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
-			mbx.xcast.data.mac = vf_work->mc->mc[idx];
+			mbx.xcast.data.mac = mc_addrs->mc[idx];
 			nicvf_send_msg_to_pf(nic, &mbx);
 		}
-		kfree(vf_work->mc);
+		kfree(mc_addrs);
 	}
 
 	/* and finally set rx mode for PF accordingly */
 	mbx.xcast.msg = NIC_MBOX_MSG_SET_XCAST;
-	mbx.xcast.data.mode = vf_work->mode;
+	mbx.xcast.data.mode = mode;
 
 	nicvf_send_msg_to_pf(nic, &mbx);
 }
 
+static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
+{
+	struct nicvf_work *vf_work = container_of(work_arg, struct nicvf_work,
+						  work.work);
+	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
+	u8 mode;
+	struct xcast_addr_list *mc;
+
+	if (!vf_work)
+		return;
+
+	/* Save message data locally to prevent them from
+	 * being overwritten by next ndo_set_rx_mode call().
+	 */
+	spin_lock(&nic->rx_mode_wq_lock);
+	mode = vf_work->mode;
+	mc = vf_work->mc;
+	vf_work->mc = NULL;
+	spin_unlock(&nic->rx_mode_wq_lock);
+
+	__nicvf_set_rx_mode_task(mode, mc, nic);
+}
+
 static void nicvf_set_rx_mode(struct net_device *netdev)
 {
 	struct nicvf *nic = netdev_priv(netdev);
@@ -2004,9 +2022,12 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
 			}
 		}
 	}
+	spin_lock(&nic->rx_mode_wq_lock);
+	kfree(nic->rx_mode_work.mc);
 	nic->rx_mode_work.mc = mc_list;
 	nic->rx_mode_work.mode = mode;
-	queue_delayed_work(nicvf_rx_mode_wq, &nic->rx_mode_work.work, 2 * HZ);
+	queue_delayed_work(nicvf_rx_mode_wq, &nic->rx_mode_work.work, 0);
+	spin_unlock(&nic->rx_mode_wq_lock);
 }
 
 static const struct net_device_ops nicvf_netdev_ops = {
@@ -2163,6 +2184,7 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&nic->reset_task, nicvf_reset_task);
 
 	INIT_DELAYED_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
+	spin_lock_init(&nic->rx_mode_wq_lock);
 
 	err = register_netdev(netdev);
 	if (err) {
-- 
2.14.4
