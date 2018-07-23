Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD625ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784CD20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G10D2+L3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784CD20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388950AbeGWSD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:03:58 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:36744
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388744AbeGWSD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LsalBKgUJZq44g9mzRM7yamMsL8K21LyTWwijZcFmM=;
 b=G10D2+L3e4PHYC/prUpW5CiJ0L7rNMsApVKLqPThfBsG21CG/fKUXGuvnVkBCxWIyqFW1k2osG/m4NF1lqI5X2G9msfuDPQ4i3icNP76fr2Gmc/SP/5q9yhmCc+/v1gCFirpOxU14NTH4OASztV5pGC5QJD+OhKIXE++1nVRsp8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 VI1PR04MB4494.eurprd04.prod.outlook.com (2603:10a6:803:69::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 17:00:48 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 2/4] staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
Date:   Mon, 23 Jul 2018 12:00:23 -0500
Message-Id: <20180723170025.2259-3-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180723170025.2259-1-roy.pledge@nxp.com>
References: <20180723170025.2259-1-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:805::34) To VI1PR04MB4494.eurprd04.prod.outlook.com
 (2603:10a6:803:69::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a810a1-ba42-490e-90fa-08d5f0bdd83d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4494;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;3:wZ629RaGlFa1IlXeEIM51tp+ZtL7WPNUsV+HMtP/PM6WhPDEsVJtEzEiE5EaZCoP7DLM90mwo1t3OUDGh+PuuvPVXCXYGjLkXhXboOEwCvPBoF3FfFRj+EsEndl2HEX265Ln9eQaGCQQbYMe8NvR6G5OeRMwhW+HV1YzCwtVO81iIxH6i+DtGWZqnLBbpfQ/g58AIZNfJbyy3755bIgIQKFp8vKQo9scyJPFR9mbXMxrhcN+8pOJmcY6kqLOJJTe;25:coLJTiyqB3XRa/p/EYrIibtUdHL5iurz+FgdA4PyE8bvkkCJicdxn3NSeNd5q2RTvAkX1dHMyPiNAYvM4FHqT1mTGhqJz5KZC5464q+eDdSKNKGdx4ZyhzmOMdz8+LjF6dHJxhkCBjhZsMgzerIkQ1oEkvBiIyqYL9jgsLt4iW0uyek5h1r3mgr8dV5ng/HF99juJGK4OSdwBKIyXkwmCI6lTO6OcH/dCsM+/8E4PswYY7oJGOj8RSnSJLI+WcNj05/b4tb5lFyMbK1ks00bRaAz3P7lvlu+lZfietU1Jh2IYskFwXcgEv8HGTEWODZRrS7rLRQcwpSu2VBHMED2Vw==;31:DZguvrudYrKUvIyMrMziqH4ZQxRqcV/8+eWmHbSHBTb0a+wjowaSTbJoCyM71jK00gkLpKLdBzUGMK78CCeMSKFUzPjpcHVSik6LHZjHJDVd1Ji4LLIL9WarrspRp5iDzpNdzliaywfmRx9iCv/AgIJ0tB2q5v/DJwC4VhZZg663+s8mqjglte8RyOzuiuuWOuvTZm81fEgNlGY612+KPVmc7eA4hg7uReF4XqHyOlE=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4494:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;20:qtIBowXTs6lUiHPJHT3CnVnYKMVYsn0mXem0wCtAFGrVrTYKEnyM1kNbqCrGaFvBefKxMOAVOCYpWXlcNr4EjAIKJmkQVPG8VfTvWNRIUQXKeapldqI0Y+WTfddA51OBEopyIfWAIP925Mz159dyodR5z37O5PR7ct166uZAg6fLjbf2h7fokLon8XWyQnhve2Kp4wXLHAwgmQ86O0u0XhaGCBdHUrU6tZDr4V9SmKlZlBUcNB7d1V2Ipes6jEVuGSBsgHGU5wzopPRfuaiIVbL5s+PB9odZ4Too1HpygBDHf2B9OUDtwTuEFF7wMFBVYHG6PIiLkKZ0FmV2zpr5gZPNheqboXS/WbRHaQPtuo0wSn2YGu6IVjQ2VED5Dya7/XAmFzAQ+0ozymQSFtTzd/oKrGcD8FJZW4U3xVWaRWEUOAyiSH0Zeu4J59GnZGRDU1+ipx2s+MXODi5BPUMmCuljVhlaXu+OLlLb0BYHHPInD8bUyBgGbo511GCIb1jP;4:l1C07XkBxZwyMCN6KxcDmYu7Sy8iBRh0WYveLoVlWoJu7o0dLafvz1UjBtntvgP7WW7LeOZj6z9e3EAp8tkT96HY9/4wVPu6GI50nQPVrQPzBDw3uuKjpI8Ls1dpgu3blSNfu6nPsf7kSvnskJndLQByQqfRtw087NsQRb0gfMRhIFLdccUpEecnNCBsFMB6/PajOHXhI0y8Vn7bDXuUdfPHo2RmA26gAdugZW7nXxb1UrVGBebZIfA7ddDBNYp0efVwz+WUgHVg6yp+4/EkKMicx6jCLu1IQskmmxFHNAC5A8oBonnfwbRVYP3m/+1j78ph7O1BiFXcVjvUOMI/ZVoo5fMnQxGrhFsp3v5Az7aGo/c22q12r26pRJAxG8xk
X-Microsoft-Antispam-PRVS: <VI1PR04MB449485CE018DB0D763403B9286560@VI1PR04MB4494.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(35073007944872)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4494;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4494;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(7736002)(386003)(6506007)(76176011)(105586002)(5660300001)(6666003)(186003)(2906002)(16526019)(6636002)(26005)(47776003)(8936002)(316002)(81156014)(3846002)(6116002)(50226002)(53936002)(476003)(4326008)(68736007)(106356001)(446003)(11346002)(956004)(2616005)(25786009)(14444005)(43066004)(6486002)(16586007)(48376002)(50466002)(51416003)(66066001)(52116002)(478600001)(8676002)(86362001)(3450700001)(1076002)(44832011)(81166006)(36756003)(486006)(305945005)(6512007)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4494;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4494;23:3S9IyBZw0zqOY3m8KEPL3rGUWNmt7gkUHk7If0ixy?=
 =?us-ascii?Q?2Ur6wrSggS3HMzue1baZLApSx/1GbXNc9Whz0a2YDg5VKqinyUz01bo7w1p6?=
 =?us-ascii?Q?M0T6mIgV6f2ybF101vIN4lQ8OCK73fhcTb/C9VYVqW7o9IMGQLqcVqLKu3tv?=
 =?us-ascii?Q?Q3Glf0fWiQ+bVTT6dsUUIq5S9z94549ocuGyqvpO9xm0q282hpuC211QJS9I?=
 =?us-ascii?Q?jXOdLz1mEeb4/N0RoVQ80jeP3d+Cr2niGRaFPJ4dDn9/kQUI86mGgSBO/BVv?=
 =?us-ascii?Q?bm7n4Hmwt/yYFS4+1oZPwQdFeP1lJNRH3s9OSj3v/2+8J5bFY+NOWpTfEXnu?=
 =?us-ascii?Q?+WnGrZlKO+3MXZunJnQa3Iv5irwgP6ZjTEUhs8VF0K6JrSGCcDbAMA4Dk0SZ?=
 =?us-ascii?Q?M+LBM+BdmEH0vw2oyGCqJa/Mze2eQ0XUAsLsmiGeQBfuA3BvOyNtOhE1WZ8p?=
 =?us-ascii?Q?xI+NHQYKAPr7FnEiAfvXF5KjdRbDGjY6SuQZ5af1yTFbb//SNlsgdbBlnGxH?=
 =?us-ascii?Q?A/h5ZwDy1b6RtCzKjRn5zMsyHHdkxusKChTmv9rffs23RaHSVosT0QVLP47r?=
 =?us-ascii?Q?80cGwZjVUKM0oCyQwCinLqRmOoPcNERTk5tsD28Mk18UuVj//YqnAC/xom5O?=
 =?us-ascii?Q?WIhpb3DK+fSkugv68KNiaPG9KPuIfcDjAqwHpr11moJqEabFjmqPd1NxsScM?=
 =?us-ascii?Q?DXnSoWZiSuTEiWsLMx/I184na6AtAlrfYVVpXvo6gcbpNF4gXEiEdqSniot7?=
 =?us-ascii?Q?MqNEmfrxUzdF8Y9JFPtct/1hqJrEPE+lTw8EP0cqK4m6tFH6103gbg8ZpJG4?=
 =?us-ascii?Q?FI9RGNMm1UMrBDaLIVxuRcvMBNc7Wfi31UIhvd09mgOlFJLTX3v7XWgmJ+Yk?=
 =?us-ascii?Q?WU7Edwv/uixQsFvE+E070tSQWZbL2zNpeBVoFuT0K+Cxdt7kKX2NptcrpVHY?=
 =?us-ascii?Q?2vUFTkkbZIm9L1ryTpk8eJE3CIKZPZEuVITNeb2rAIw9s2d1D/TAum2lABD+?=
 =?us-ascii?Q?7L2alD2H0+IpQvGbGO+L1xlvsz2HNpoFZ2MIU9h3Dr5MHdIHgHHhOrZdCl2p?=
 =?us-ascii?Q?d+NJjqSsmkqVNBAqK/SOcvuDSExW18pV56Ge5e9yob13u+RmwI4LiWKYe8Ad?=
 =?us-ascii?Q?75MP76D9JGqU6PqYfh6vOxvN1cnrkN0UZ1fS/toIqbd/hWwRSzfvrC/ezDPq?=
 =?us-ascii?Q?svgJnVOEM681qF3ocwsVtGIDNfV5RxMgT6RIFtlON6poXfjHvxDY+9jNHYII?=
 =?us-ascii?Q?LOPZ4N4CLN8vVIJpipLVZLIrThcmH6rbVKrPStg?=
X-Microsoft-Antispam-Message-Info: FafVJDqpWm1AOSfF698mcYxD49wJ1m3Aawm7eOrZ39HfGziTseSBswnlZ97tX4nqlTVb42hIkF5eqFDSqeinlbtz1MXuB7mU45dZyQT1lO9aNtvlEAGK4GwFsISwCugcSoTtCQF7wuUn2tyEfhJLCTIRPv7po/vjb3f3Zf0rb8VNOBYw3ffzHLlFgXron7FM2mW/UWY7lTnJG/SOikElAQvBLbP9Nl9CtQ5LuHVlg38XZy+TOX/D/w3H8+4WSU1V9pxuzWGBXxOxpX/56HrprOXHyUonnHq2IGS3iJQ62CMpIOcDjbO6fGFQ3oAb0zT7gFgCOEaLjzXQy+ht902UdCHexYLSqJv/FTs2imaEc2A=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;6:YBrHHC8nXUeVX0hGodq4Digklt8oi3w7l1g0qMismRvnM1KtzBsCUlWBv4SkQSUVX1E5aOLwGeK8td5a3uvfNLhcC3+/XnkM8SjNQto4E8WL6BCcozsIZryyePK3STLzvVxZIru1UZY8QkTS09t1LrMm4JoX1kkdddHAJb4oR1sgerU8tUJB0gTELZdQxyiY0jA4rIXJFSi7l09kqX65NDmBKDE99gcMdbA5FZ6kSjvFzHwpqlq0P4MzLKSADvvKAnbBViH7LAL4rUx8ft64x1xYA4mRadszNGkDBWeymSgHLamYay7mAU9a+kn2La4RH04AQPVTI7rskNkGLlPOkJ+zPZ1DKzRwrG0S5ANotD9Jm061Kp+PzabUA6PwLz+XT+OcNmxIwK5HU06TeYWPwBsXZSsE2QQ2lYFeBnAPwwyRXzN+kb9OcYE32eNQ0saRBUH74J7yJO+CeTH8f/Ytpg==;5:kBAlAAy22f7aKCO9ejeM2wepZ7TEtqu8a5XohHYnASV+CRS6NBOXFO8MiGIVv82ep9nhwDgsqgSTUE/4E6/kKIPzaUgoX7ZqKsfhz7Y/KuTGeF7mwv0PNSp4YLcG3VgIKav35Hxw9WHfcU1peRGbAs4ldDWFc2QafkNGLYf6uWI=;7:Re7Xn0SZBgHRRRhHAySPj78YJzXtLfAqmJ05yJ8GQoKRUZs13AZp1mltpgAB85q/cuIzb6F0j969ta2CQth8qByu+62QLVupImC6TvDvCbe1jwMkwgCMk+VwgczK0xYLLPFCWs4ChFR9YVg3DAJPFlzOkGKkhdDAazacz4GHcYitdAHGFFDKLQjNx/9mD+jbAE9cCemrGawNQ+S8uqYSfbTCTa4Uh9UfQnJUJU1/NPwu6qNj8a3nVmx8FN7019Vt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 17:00:48.9879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a810a1-ba42-490e-90fa-08d5f0bdd83d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the NXP DPIO (Datapath I/O Driver) out of the
drivers/staging directory and into the drivers/soc/fsl directory.

The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
hardware on NXP DPAA2 devices. This is a prerequisite to moving the
DPAA2 Ethernet driver out of staging.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 MAINTAINERS                                                    |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                                |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                               |  2 +-
 drivers/soc/fsl/Kconfig                                        | 10 ++++++++++
 drivers/soc/fsl/Makefile                                       |  1 +
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile          |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h        |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c     |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt   |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c    |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c            |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h            |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c    |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h    |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h                 |  4 ++--
 drivers/staging/fsl-mc/bus/Kconfig                             |  9 ---------
 drivers/staging/fsl-mc/bus/Makefile                            |  2 --
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h |  0
 .../staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h  |  0
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h |  0
 20 files changed, 20 insertions(+), 20 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228..34ce842 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4418,7 +4418,7 @@ DPAA2 DATAPATH I/O (DPIO) DRIVER
 M:	Roy Pledge <Roy.Pledge@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/bus/dpio
+F:	drivers/soc/fsl/dpio
 
 DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
diff --git a/drivers/crypto/caam/sg_sw_qm2.h b/drivers/crypto/caam/sg_sw_qm2.h
index 31b4407..b5b4c12 100644
--- a/drivers/crypto/caam/sg_sw_qm2.h
+++ b/drivers/crypto/caam/sg_sw_qm2.h
@@ -35,7 +35,7 @@
 #ifndef _SG_SW_QM2_H_
 #define _SG_SW_QM2_H_
 
-#include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 static inline void dma_to_qm_sg_one(struct dpaa2_sg_entry *qm_sg_ptr,
 				    dma_addr_t dma, u32 len, u16 offset)
diff --git a/drivers/crypto/caam/sg_sw_sec4.h b/drivers/crypto/caam/sg_sw_sec4.h
index e586ffa..dbfa9fc 100644
--- a/drivers/crypto/caam/sg_sw_sec4.h
+++ b/drivers/crypto/caam/sg_sw_sec4.h
@@ -12,7 +12,7 @@
 #include "ctrl.h"
 #include "regs.h"
 #include "sg_sw_qm2.h"
-#include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct sec4_sg_entry {
 	u64 ptr;
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 7a9fb9b..c17bf38 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -16,3 +16,13 @@ config FSL_GUTS
 	  Initially only reading SVR and registering soc device are supported.
 	  Other guts accesses, such as reading RCW, should eventually be moved
 	  into this driver as well.
+
+config FSL_MC_DPIO
+        tristate "QorIQ DPAA2 DPIO driver"
+        depends on FSL_MC_BUS
+        help
+	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
+	  buffer management facilities for software to interact with
+	  other DPAA2 objects. This driver does not expose the DPIO
+	  objects individually, but groups them under a service layer
+	  API.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..803ef1b 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpio/Makefile b/drivers/soc/fsl/dpio/Makefile
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/Makefile
rename to drivers/soc/fsl/dpio/Makefile
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h b/drivers/soc/fsl/dpio/dpio-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
rename to drivers/soc/fsl/dpio/dpio-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
rename to drivers/soc/fsl/dpio/dpio-driver.c
index 11a90a9..b60b77b 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -16,7 +16,7 @@
 #include <linux/io.h>
 
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 
 #include "qbman-portal.h"
 #include "dpio.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt b/drivers/soc/fsl/dpio/dpio-driver.txt
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
rename to drivers/soc/fsl/dpio/dpio-driver.txt
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-service.c
rename to drivers/soc/fsl/dpio/dpio-service.c
index 14ed2be..9b17f72 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -6,7 +6,7 @@
  */
 #include <linux/types.h>
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.c
rename to drivers/soc/fsl/dpio/dpio.c
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.h b/drivers/soc/fsl/dpio/dpio.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.h
rename to drivers/soc/fsl/dpio/dpio.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
rename to drivers/soc/fsl/dpio/qbman-portal.c
index 116fafb..cf1d448 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -8,7 +8,7 @@
 #include <asm/cacheflush.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include "../../include/dpaa2-global.h"
+#include <soc/fsl/dpaa2-global.h>
 
 #include "qbman-portal.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
rename to drivers/soc/fsl/dpio/qbman-portal.h
index 69db3c8..89d1dd9 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -7,7 +7,7 @@
 #ifndef __FSL_QBMAN_PORTAL_H
 #define __FSL_QBMAN_PORTAL_H
 
-#include "../../include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct dpaa2_dq;
 struct qbman_swp;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 9269cb0..f2917b5 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -37,8 +37,8 @@
 #include <linux/if_vlan.h>
 #include <linux/fsl/mc.h>
 
-#include "../../fsl-mc/include/dpaa2-io.h"
-#include "../../fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-io.h>
+#include <soc/fsl/dpaa2-fd.h>
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 3424530..90f234d 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -5,12 +5,3 @@
 # Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
 #
 
-config FSL_MC_DPIO
-        tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
-        help
-	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
-	  buffer management facilities for software to interact with
-	  other DPAA2 objects. This driver does not expose the DPIO
-	  objects individually, but groups them under a service layer
-	  API.
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 21d8ebc..2141e4b 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -5,5 +5,3 @@
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
 
-# MC DPIO driver
-obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-fd.h
rename to include/soc/fsl/dpaa2-fd.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-global.h
rename to include/soc/fsl/dpaa2-global.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-io.h
rename to include/soc/fsl/dpaa2-io.h
-- 
2.7.4

