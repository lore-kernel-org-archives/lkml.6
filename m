Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396CCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15E02089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Gtpc12TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15E02089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeH1Njf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:39:35 -0400
Received: from mail-sn1nam01on0054.outbound.protection.outlook.com ([104.47.32.54]:34748
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbeH1Nje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPVqHNByEiCSqnKU+rkrqKliRa4UGfRZRbWYP+VbAfE=;
 b=Gtpc12TQfcGZ9tucbf9U5zU8mUNaP4Fgi73aXG84nZOmBupv2khez/jelR0stacmvqLmP3S6/2A9hv12Zwai+MgS3/A74E654IurRELfImZkpZ8zLLBmK9G2R3BAJB87K9/dR6IVDoDnkAzw0EgF1C9bs8iBMiU+FgESNsb9uyM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1569.namprd03.prod.outlook.com (2a01:111:e400:52a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Tue, 28 Aug
 2018 09:48:40 +0000
Date:   Tue, 28 Aug 2018 17:45:34 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 0/3] solve SDHCI DWC MSHC 128MB DMA boundary limitation
Message-ID: <20180828174534.00fb5e24@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:404:14::21) To BLUPR0301MB1569.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e702f29-6c68-414a-1003-08d60ccb7019
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1569;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;3:rTe2k17tzChjyrTJIqSzjsHRyGZaJTThSYq7TLFCOhZqdm+ziL+DFnWmic53XnIPir2CVS7DxCllyFEfwO7vGwe7w6EZva+JREY6JPNBGzGaO/5Tv+lySK6vxc9sfEGEclR8b4n0Y06NDJlA+0BFREUbWDDwChBSSItKXqcveMcdlfPRmicVmHqIDBf7nW9q19NesTNFbNwqB0iNK499nTYp1ktf+MsZVOBHN5sQ1KxIOS5q5IedWRLcODWWXWK1;25:m58Kmjywa7PnsHQZuG1WcJAquM2pxmhxNKiJkZaVBB8hgKUM7W0KA/C5PjhlogjolIffPvmFrtaJHQqBoMK7LMQTCxA3J2kCKN3QBHzerGp7iiPzxDbJFC0xIZqCxT5bDjcNWmoDmCRHdu4rCwg7XAZMn36IoTsKGq8ZuWNbsTb/taoGx5S7GJNbGaKCmMK2Xbwm6VqreU1DptKId7T2WR62Kcc9+iqgOfUZ3nFk7t8rV0QmDjX7TngW+O+QfK87O0Xh3fFx2I1bmUEvYG1dGwWvDbYpKJ5chXzjepepbSCUNswK30PkQISFwWZnOwQbfMj4crgMn3bwiuq+hYJMuQ==;31:zrDCA8a1wdOkxek6DXxBFaAoFQxOuu4UcjvyyK4n9SYMSnL0XhPEjecnl6SskeK+a4bCXe5t8vQEl/vjK7NJSDdwDfUB/F7sq8L3sQq6FqIpy/B+9yvJsgb34U8lHnbDpXkO5FrfLq5eHjviNHxRJwmyR1yGabRwQ+Em+1+Zi3phXLeHLGa6hBOv/NsFlmXOG1g83PtaEcsKr5Ks6io591CtqNAVyjS6svX0BVB1wfI=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1569:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;20:d6SeXD6kr4KbXIPr6uDlx+OCRvPfEsr8FSAyc4gR2t+Mnw4jImejY52lZQZpnwirtvFibRKwYfCKKctLSGUUP4FDii8JfzaJA1eJZfUSaNAuePgXAeWLvmsX67sOPPspQTbNeV0BnsYWeBwj9NnRsqkNIVqltb7QPqoo9gfqOu5TLWnnYaG4NcOASTGH9sjUY3+05IUxgjMwCsvDWG9HCHhTKZ6WkCvbq+b1mB1ik+EiYyNx+spIUNZ8zTbObmw4FmWzyrU9NBMuX0gIfnu5CTyPM77mmcTgqNFG1VoiPCEuKhf1UJyv1w153R1xfc0JdLEh8QsaYMPkhswMSa5LbtRV43juaakOec9lf5EoO3Cf0e8nLcEqPi/WYwew0ubyMN5sRgUoCOqKD8a2pXCG1ibaCb3kKMc91mJTRRg91S5WOpA1NbNHClxBNkyxc+3+ubyoFGcjyu8sSyIMz0mmT/y4FTK24fEvKTMoU1+N+hWd4uX0a6CDmCw4TxPj56Zk;4:A8XEAeSJRt5EFkRzplCOdCCMq9GMoOhhToHFfWgw39s2iNtKKpl3WOeL12gq7aOs8spcPN1DAq4oitg2DreIt/D6uEFY0kqOWSeeE4tbGppT/rBKbKX28/jJemIJsWCMFWEvsFBoPW+ev8bjdpZO65INsIMF8RXqd/ZrRD+072BSGgVIlKeFTeSnJMGR9Y6qomcNS0FL4WITgSZ7T9hyqh7fE/kyCowHx6/lKxb3DLp2iAINs1j9IvG4BOM/nxeAsZM8hIILCci5/RDz+R7sfg==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15698E8E304D5B0123D99068ED0A0@BLUPR0301MB1569.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BLUPR0301MB1569;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1569;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(478600001)(33896004)(316002)(54906003)(16526019)(26005)(230700001)(50466002)(386003)(6506007)(8676002)(97736004)(186003)(50226002)(8936002)(25786009)(7696005)(52116002)(110136005)(53936002)(55016002)(9686003)(1076002)(23726003)(217873002)(14444005)(81166006)(5660300001)(47776003)(105586002)(66066001)(956004)(2906002)(106356001)(7736002)(81156014)(4326008)(486006)(72206003)(68736007)(6666003)(3846002)(6116002)(86362001)(476003)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1569;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1569;23:nk4ihayggfty6stxjf2n+MXAVbxPuao4mEcC91+?=
 =?us-ascii?Q?eWr6RpMmDf93cMiw94ct0gs/qVexI4MJ+FYEJL/MHCr/zqt6Io5RPRtoTbes?=
 =?us-ascii?Q?SdG98rPjAyil+blTSRIge/gxz0N1MF1t2w5AdJrxwRR2D5gVst69coYliue6?=
 =?us-ascii?Q?H/iylx91DsS6lRx55VwIHAXvnWAvW6walLKr2K1FQgpFbyagntpIXnBDYCn8?=
 =?us-ascii?Q?afNK/qHVYyxrbP5w8Pw5Mkn2Rt6k92oa8aB6jkNcL2nfZpEVhjOYexatDgy7?=
 =?us-ascii?Q?rZnwfalN+AwOuIyE8spuCI4wnYqQyTX8iM0tEF2wn4u0dYpjn4z7/1dVHnR+?=
 =?us-ascii?Q?tEq2YwBRObBYr1J7dbL6cVEDQ16Qs0Z2spjXzWXjMsaXfjV1xTgIcw3sLAuK?=
 =?us-ascii?Q?xlqRGWVz04B99XaMcM5A1q3le2VeyOX8Z5FUJBWbE/Hjow7KAEqzfbhiWKn4?=
 =?us-ascii?Q?iqxgqGrX5KYMP4wd0wQbvoh1/eldN8SphgUCLa/3J5+ba5fWrovOnSIMAQrs?=
 =?us-ascii?Q?G9T3yaFjCUgZgfQnLaLnt7YsfMcKt5113Y4ddrEIugfkZFJri/uAc2HXPv2N?=
 =?us-ascii?Q?tiDrloqz+yG7PLEiQuVqB76GYUe5NR5bela2tF9by3QrjIHAHi93wUwfeRZ4?=
 =?us-ascii?Q?erTioj/W97gcWvhxmha+4WQHjNY4xoUh2jvAihqX49lSgU13/0ZlP7MVVqqO?=
 =?us-ascii?Q?SKAUc/XuU/KvkWO1/2dA95EviuEU+PogEIiHoiXHXppPubZHoqsIbXlnny/G?=
 =?us-ascii?Q?6LbcIBjBl+g9wZ3Fnog5C/NvCR0vhmnwd92Rp7BZLiGuKRbpEo1//K78QNEz?=
 =?us-ascii?Q?Y1id2KkwIAZczW/U9f1RbIIhDceH0rn1Hty0Oshi9+cs1mGnB7wzJjZCvMQZ?=
 =?us-ascii?Q?9WVVej7PnllgCzF0eA8FTlOdwJroWzf1fR7Voi+yhmvrNAblGYgzXWovOIY/?=
 =?us-ascii?Q?NBUDIPj4ANmgfA+itGyYOo7InAXl0Owh7bhxGrahlvLsWJP59ENATpbhDwxG?=
 =?us-ascii?Q?YkgF/E2tTqs4XkLTVowoJXLy2UeXzQ9XyHQ1UIAwSFR/8aufT9V0QzkiMzgR?=
 =?us-ascii?Q?gftCi/s6amuGe10IF0+2jowgL0FWio860/xWrbMhBJE3T8RV7qpzAeCh0dYK?=
 =?us-ascii?Q?yDG4kgItoN4wj+P0IRGhRebD8/z/OO/BBoFQCgF3RAoNZxamE6uxTB3Cnbpw?=
 =?us-ascii?Q?Y+g3JfbJUN16eUIgbKBv6Ef+n4m84FmXz8fVKStubsWC305wGYbiXlfaBtw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: gmmP8CqW3kzb4HQFT2Q5QqqDh+R+TZML1N3WUx/LfckoUk+BaYmD1dCtTdv1/8Alq13aUYi+ogYF29FUeXgxS7Cg2otjAgZTf+ByHyh99yASCDikfy1RA/Rv4e1bE6jF/VoaxSJPN+go2Bj9j4LozbG8bMsf/iRT55TktbvqZlWOKmdnC8rq9dfOumRKUy1Men2Cbgku1lPzscmyiEeE4fA1K85PzV8leFx/sKJ1iaYOOdVPjzFDJakaFFtJ4mbdQsOse7sQwl4dtP4Go6MN8QedIFUsrv4gtG5VhkGVBPE+mZKQlyrlRxOtowrPcqksAnId+wZe8MxyGFqARpXTIGXDkDpcOP+C5dGdhGNYsEo=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;6:8tTlfKzxJ0LHO9O4itw8xVFeyTkN1urY6pc3ANNsTD6Nc+7EvPD6Vd3/U+/BC8eRBUV+kA0eRCWWljPySQeDyL7YfBqfrcLBl0BGka5gX0ypuMvyQkIvMAf2uCNOZvoY4FDbPWATAXP+724bFgYs2cW3bD/XHQYGGtyxVHJ22dMWzzyNbqkJ61FC+O7nZFRjbxxAV+tsHKFcTdRgliXRcXfFPQ+/QOxXy5FVgvhYINRAUPNmlmdadSqOFmfe45ELU7RO7njnK+HJOx7MbOxCe6UtISoowQL68ev1FsnBQhBTTvk6XtmmbmYgO/toqx/k6mMGdVt7OJJ/kQ+0nRe9bfIyZLSC8GgNxw0b+slX3DvxxI2DcEeH8IZMTf0mZOyy5CauMZt8DyMI5loxC5H8S4yC9Ykb6a2dzt5lU/TEWwu+Wvw/z/8nXbDexVyun5stfE8k1rb9mcFyOSvV5xX9BQ==;5:fKX5x0bUONBxcJFmbx8ILulu+xOdywlxUgdNmVmUnl1C/SZ5jkRO5e270PFpfdnj6WjZkS38ABCdr28IrtSxQmbZU7312wnyujUHxKG1qJWjAnU239wTWbIBxvt7/iCtcX5yxmJNx5TL7yfwalUBfAc9y0rase0O5sItVz297fI=;7:e5UPPSRdERNWyPJpjiGAoNGqbidCvO7wGl/gOBPjHkuTfxOPxUvigmqe7GWlo8Xda3kEpwOgiMOv0L6Wj59equgmIIUlV7YMVaoEMU6qtdR467xq+yuqhvLukFQQ9x12vqgH6uqUgsiLdWm5QW6yYp3ejnBHIMHqk/UpAV9KVW0dOABvrWRCT5zQN4DBN/RqW4ajlAjRHOVUYcdMIj4T+pK3qClsGhHuiwSfcHKcTo0PQHMQ1CwcztpVNNpd3YEN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:48:40.1784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e702f29-6c68-414a-1003-08d60ccb7019
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

patch1 adds adma_table_cnt to struct sdhci_host so that driver can
control the ADMA table count.
patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
driver can override it.
patch3 finally solves the 128MB boundary limitation.

since v5:
  - use dma_get_required_mask() to calculate the extra adma_table_cnt

since v4:
  - add Adrian's ack to patch 1 and patch 2
  - address Adrian's comment -- if the boundary is fine, we have to
    return after writing dma desc once; adma_table_cnt updating could
    make use of the fact that it's already initialized by the common
    sdhci code, we just need to tune.

since v3:
  - s/adma_table_num/adma_table_cnt
  - add comment to adma_table_cnt
  - make the exported function name without the _
  - let sdhci_adma_write_desc() accept &desc param and set the new desc
    value

since v2:
  - make use of "likely" to check (!len || BOUNDARY_OK(addr, len))
  - explicitly include <linux/sizes.h> for SZ_128M

since v1:
  - fix BOUNDARY_OK macro if addr+len is aligned to 128MB
  - use DIV_ROUND_UP to cal extra desc num
  - fix !len for dwcmshc_adma_write_desc()



Jisheng Zhang (3):
  mmc: sdhci: add adma_table_cnt member to struct sdhci_host
  mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
  mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation

 drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c            | 54 +++++++++++++++++------------
 drivers/mmc/host/sdhci.h            |  7 ++++
 3 files changed, 78 insertions(+), 22 deletions(-)

-- 
2.18.0

