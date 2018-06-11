Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ALqDG5UdHluRNAAAmS7hNA
	; Mon, 11 Jun 2018 07:00:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 43FE760850; Mon, 11 Jun 2018 07:00:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZuVQxH2x"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BAFA7601D2;
	Mon, 11 Jun 2018 07:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAFA7601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbeFKHAU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:00:20 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:47216
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753956AbeFKHAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3ndxmtutxkRv3J4C+/owWsll6uAFG8fsVPosRzsfpM=;
 b=ZuVQxH2xzm/NtcuCjdvpk02R9qaVNVrfJpx6kpCEYaGchJ1YEYXpkupqap0bGbZBW5xU/J4e24vFwmXZO/3OIQageV/nNMHGtnwKjLX3bqsixOUAjhJKeQrtcclq6wdj+WNdl0QcFrawgn7xkSvzZCUQTH4lG7ixtmL7H7TzX/g=
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3217.eurprd04.prod.outlook.com (2603:10a6:206:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 07:00:13 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v3 0/6] add virt-dma support for imx-sdma
Date: Mon, 11 Jun 2018 22:59:27 +0800
Message-Id: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To AM5PR04MB3217.eurprd04.prod.outlook.com
 (2603:10a6:206:7::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3217;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;3:E/srddh2mhW2J3QB21so5ojj3q/niYZ6TM9534XgnwYhJl8l1nJn9bCUUmrAaC9W8UHpkuyCoUQrVAl7k2pgKaHyBhc/NVS8n/1KaSfJVzjjlVz+eDimp1mCTiU0RUzOMo7sSZC4Cj0pIGVTYkC49PSKEGXdYIZ90rjNm3/ad56H8MK057Cu5NuUCbZZ8Vf4WJ++AbsAc3r3HurZWUk+lZm/GNLl89HgB2HG2YHCFT0S4hFhY4/fWg27MmzJOScp;25:wFSS8CuIdKC9ucYGwzb1YpIsav20wghugIFtejslbldOqU883JNd/PFb4St8EM+Vn0G0kmCAhOLpSjHCtVHtqnw6rTE9CjHhBibUW++/12I/LktDz2/NZb4XklWdiXe+O2uZgRehFwrIwJJnlWQqlwuZiai++y6i8AIQJvKPDVbfZXNHNsgbkskYtzWIZxn0MkW4gkQNU+ACQvSz9rjJdW1ahhR6/7VoSTbUHrstwz3mBdMx3NDVXfoltMUtHOTmNYrVtMXEXU009oSVFBSme23A+qCmloU5mdbiBsgND5EdnB5obrbjx6DheWn9RyciDoHV8PgbTvV8sQ669eldeQ==;31:dOYMrhCfokDq8TsGjiDuSz4r49ZXbkNRDA94M30YESoDZrkVHAnnJYOWEuDRh1QbfumUK2edCiWCPtk0SzlCy138gBRxbAQaP6/t8iunLdca3xiddWzyjjcLwHxPA/AygjyDodGNA29oHBUfXUPDzxQUJJmgK3Ng1CfykrpnbBBqCpTGuHZzpBy7hmla2s3NpcpFA2pkKewHUy6AGzDVA3fRQjvnlN5gwnLboYSnI3w=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3217:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;20:CFPTHI8nSaPRwpl2wxqyPzfBV07aOHivzx0H+I7NuTS8bpebb5mzXwnAWHRWD1c4w64/i5xjnOvEh8xCH8v0VWBroUEOuXpAidXQPUTDBF9kC8/WsObLhfoSNzkYZMwrcP+Og3M9YV4baQPPV7W8tN0jEZIW6FwNH2RN/RQHxm/sFfsz/faDQjZf/awfb8YETTLFK/gaVl2uNuDZg6uXbOR5srj4Fi9l8YoBnOuAJGsYEdLkNImhb+c/a52q9nQjGb0i1Bia3LG/yKBmhHCUFM1+/ncVkrxnOp0BKBlOF2WGJlOfnK96CxpoauF0htiL1yd5kmjQSb35zuyIn69pJUqPqv5lQuY78cgzHnBQWeTVowUh8JJZ3eEg74rZ4mjvFBITkYX1TEZOHNrFhO/9NQgVY5Vi2OBGeTbXmySl/77k7VDZ2Sc2b6AmHtLNf29mddrWuk4gUHRMfbgZ9W4EjqsG6neZYRR3rA5PBHpCin9CKYBHbfjzag1t6m2GVlSf;4:hhgAy8DH2tdoJMXUWXL9rRow4OnLQbyjzyltxvj5GPOcYOFMPjYo6WtXRSGTvcb4dj0NBEk1m8Lw3JAenv1Uzmy7o+JhhNuOx7q12faL773xgjfE7nYj61mhQKguWcGgP8ZtskY74Rxe7tmmhgAxdem04TAlrTRjertFs4c9mwnOhFohvf97Y8IEAbuD6ibzuhTa9mr11XBxihmgWRgjaETdeHN+cqZEIqcK9MXUdmN4usR26Mc4XStAflxfnzl/8el5SO1nfHnPzERmkHrNpA==
X-Microsoft-Antispam-PRVS: <AM5PR04MB32171B33187C8ADCFD808D9F89780@AM5PR04MB3217.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3217;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(5660300001)(7736002)(51416003)(52116002)(97736004)(478600001)(16586007)(68736007)(48376002)(59450400001)(36756003)(50466002)(316002)(2906002)(386003)(6506007)(81156014)(4326008)(86362001)(476003)(106356001)(66066001)(8676002)(16526019)(6486002)(105586002)(486006)(2616005)(956004)(6666003)(3846002)(47776003)(53936002)(50226002)(186003)(26005)(6512007)(6116002)(81166006)(25786009)(305945005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3217;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3217;23:zwlrSzz/H8WgwDUxvMLPhkpx/nenOTe9f2peEZJ5u?=
 =?us-ascii?Q?lb9kKQ3ELdKruJnLhx7ao2xamCyi/2O/gVh/rroRZVKnNoVyByAvbCh9mxAn?=
 =?us-ascii?Q?14FAaJ7YFnWa8PzRrNMhSt3jK3Nr7mmTwL2+ETPK7/rqt5egW9TSvPrS6EOU?=
 =?us-ascii?Q?22nJpuqM3Clf/fnD05QXjQHWjQbqK/HGj0xx4+H5CkvXIARZGHm+FCUsk8Yt?=
 =?us-ascii?Q?ZUc48Tw81oMvQSQWoe9V5pRRTK/Bm+db0glyfJpkgzj0DDYXHnKTQv/ncmP9?=
 =?us-ascii?Q?GB0vBF+OPEZG8YVh1nV46osteVjaTJfmaL8gk3EbvdPHFpRI8GZEgIvyPmfQ?=
 =?us-ascii?Q?F/vNp702y07LOQQH3gWTq35jWsG5Ue0xw2CBvkyzpSZK2GqAmfA58DgfBJ0i?=
 =?us-ascii?Q?8KuxVqbwytJ+7c8nOgvoxWoCpvw16Kb+QIgyCcTXE6wjYbvIONKhIPJRpLsb?=
 =?us-ascii?Q?ksOehLtZyZuTBFdLDC7CfIZBNuG9cxxkmIMhCEQbx3MpopULBMJ8hBlUTJfB?=
 =?us-ascii?Q?Bs8CsB/M02Or2J7SSAWsRjCD03gXEALrhcj7FY6sicQB1tGFEjx61ST2Nh80?=
 =?us-ascii?Q?p8oH+GA6QVbM7xVrV9RaNilbzdhnkJrwR8NEeTincel8O/cajlLRavVQhD2s?=
 =?us-ascii?Q?ummL4Xg7zBRGOO3U6WatoiKG+bIp2syW1aI1FQaGRZudFwzAa/uYMwg9Yj5D?=
 =?us-ascii?Q?d5VVGTk02hCDGwN4RnFp+Xw9vQYosPRTqB/xYhqBGh3chH3PJvK0D4GmpwrP?=
 =?us-ascii?Q?JcQRBVil3SCDwHXbmAo23z1j8ZXYp3e1jmF1HL6HZVi1MPFP8wV8px4KSOtO?=
 =?us-ascii?Q?KV+tyfOB425XZi9ycMa9s1QWoe+PT5GpX4FjOI1U4ZqmdrlPR9aqChv2VF31?=
 =?us-ascii?Q?QS7/NcqJLVtsvFdqsK5GBIjTzXuhEAJl7YAE7n0qK1aK9vbuA6sXcXHhVhjS?=
 =?us-ascii?Q?SZ5vV3KYW9eFHfCcotH1/t1SQQoeB/xJCl9zJt6HHZKOLy6WxtCXeWcOr7xq?=
 =?us-ascii?Q?SYQHEW/aZWUjx0Wn5ZamMCBBX8vBMBeA3QxPUtem8wdkxnYJ+03OBBjKjnVM?=
 =?us-ascii?Q?PXJtayzrd82cRa8zj7C3K4v9YT88hRvJQhk4hezFQOFIShY3/RSZCyAXfd/+?=
 =?us-ascii?Q?PnnWUTEjQg=3D?=
X-Microsoft-Antispam-Message-Info: fPI6M/Zq4Jy03h7uQJDqGOeChWwVnqK4ltYFQzIcfWUeuvJ8Ne75q5rVPJj0YDbapCyZUWiVByK6tj6xLyWcRXy9zfJ/AdM/EuF8e+73aO+XbkRSTXrgnAClnmaf+00D5CF5z2nOoUEcKQ6R1djg62Q1S+sr2eZU5ZPrlZhB6b7KAS/2hPs35A4gY0kx54jF
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;6:lCF00ozvrTQF+ZlfMnEJeasOyjiW96Z7EbxeuPUoa1hf46jV0jQc7yogC3G8a81rNNJfdObwo9pM4VBvFAlYXD06pFFIsxpOxFk0Sbxe9L30bMMAjo8MPtAcWPFpLo9+qK7KFf9MFGUGBmkRc+rVz75XeyABjkHo039iOEjXnF/3JjvMxKLHmBG41AGlPCMlihXNSE3s6gkZJ8HSoP+ZfA3qnvvGTYY9LU4MhuSZoL9ayWCWUTPTWz9hNrtCqVBVpFCNdZmN8W9RoiiTRpSu7nMpJJisxE8W9sqQKth2BwhHC7l/oHNdcUQsan8ZTyWg4XLLBnvKTPscmRijE2EyKq806BFb4jt09WFoOIN2vZF/ALCisngeQtwuzkbqpcqRCLOJm1bURG8fQVEOnojkkIyLF4Io3wgmz05OAKwwPh6z4aYiLYby0Ri+a0EB8MuiP7yZLCRckfszpkJ7VA22dg==;5:UKpRtaU4GuWHk9srMwc4X8SKsRxuU/v1Wc5uabE8V69tsSdy7Isld/fAbtkEkPPoAB69aUTteqNmm9lRJd1grIf2lpY6Ap9zwVtuYvNK3qrZsdjG8WLVgACehkhhSuTg0TixfUYQARXIJRC3h9O0WFI5WVotHuyHiteNhKS2OPU=;24:v05Cmu8scdVMhG9LpoD2MRz8/EQ/i/rt5ccbp48NB4XNJUckUSceXCRUC7Pyx1oDguq18Iq9z3dCbmr+rLTb/ul+LAmtK1sVzesB+iZW2tc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;7:BJadcfMNnuldwdnciSwG5HXmxf3Us5FQMivohyuHzyNGXAmY+0v1OGTBfVElJ/WRsK0odmhdjHdgq22qfoxzLrCPtmG4AmsWjIx4XGWTr2RTYC8YBVeFBNX26Ft/l9w36vz10Cgax3IhhuOofkCE+a0ZI5LB6N98Z7k/1Qaevhk0W6KggAjzuHg37/o9+q37vBOMyZpaT2AyIFP6mJJeNjaq/zNpFkQoacBGKHDOdytGbxw/atTkVp9YlLWJgFw7
X-MS-Office365-Filtering-Correlation-Id: 16c3de73-a266-4e3e-50f2-08d5cf68fc32
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 07:00:13.3591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c3de73-a266-4e3e-50f2-08d5cf68fc32
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

Change from v2:
  1. include Sascha's patch to make the main patch easier to review.
     Thanks Sacha.
  2. remove useless 'desc'/'chan' in struct sdma_channe.

Change from v1:
  1. split v1 patch into 5 patches.
  2. remove some unnecessary condition check.
  3. remove unnecessary 'pending' list.

Robin Gong (5):
  dmaengine: imx-sdma: add virt-dma support
  Revert "dmaengine: imx-sdma: fix pagefault when channel is disabled
    during interrupt"
  dmaengine: imx-sdma: remove usless lock
  dmaengine: imx-sdma: remove the maximum limation for bd numbers
  dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap

 drivers/dma/Kconfig    |   1 +
 drivers/dma/imx-sdma.c | 392 ++++++++++++++++++++++++++++---------------------
 2 files changed, 227 insertions(+), 166 deletions(-)

-- 
2.7.4

Robin Gong (5):
  dmaengine: imx-sdma: add virt-dma support
  Revert "dmaengine: imx-sdma: fix pagefault when channel is disabled
    during interrupt"
  dmaengine: imx-sdma: remove usless lock
  dmaengine: imx-sdma: remove the maximum limation for bd numbers
  dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap

Sascha Hauer (1):
  dmaengine: imx-sdma: factor out a struct sdma_desc from struct
    sdma_channel

 drivers/dma/Kconfig    |   1 +
 drivers/dma/imx-sdma.c | 391 ++++++++++++++++++++++++++++---------------------
 2 files changed, 226 insertions(+), 166 deletions(-)

-- 
2.7.4
