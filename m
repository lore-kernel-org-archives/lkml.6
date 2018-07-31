Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B555C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F407208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="G/YEjcmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F407208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeGaHeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:34:05 -0400
Received: from mail-sn1nam02on0049.outbound.protection.outlook.com ([104.47.36.49]:39904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeGaHeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7xhR+SEvFHogB2e6PovTIgxMSfbolumkcpJU428NhI=;
 b=G/YEjcmT19gxQhmE1uG489k3wg/Ho1hWRNgUqUsNRGQQo0xlowuFvuHbgQPHeBboNbUJtnFQWdhBJM5H0Sa6N6bfdy5kAQvLUCro55fE84+kFoHUhm+UA513kbpiI8o48ZeqlFGTuYxX+i9rGMYEXRsKnQ5k7tDAAt9/KfdNOm8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1570.namprd03.prod.outlook.com (2a01:111:e400:52a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.16; Tue, 31 Jul
 2018 05:55:25 +0000
Date:   Tue, 31 Jul 2018 13:52:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH mmc-next v2 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Message-ID: <20180731135257.268924f3@xhacker.debian>
In-Reply-To: <20180731112924.6a1e8388@xhacker.debian>
References: <20180726151017.4da1e336@xhacker.debian>
        <20180726151424.4bcecf41@xhacker.debian>
        <edaa7605-e0e0-b17a-8403-c3d7d60d7989@arm.com>
        <20180731112924.6a1e8388@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:404:56::30) To BLUPR0301MB1570.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cec7be20-11e8-4e60-3933-08d5f6aa37c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1570;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;3:/f8dQNS966WRo21gGYTkBhKm1104PZBlCQc6TA8v9hLq7p7pciUt+euNpqYQyKAh3PoWD5bEw6dT7dPvnvvWFgtVrBYBk/Z2/BYKJo4izQVXRnhnt7cG6Y+rWcBocLn40gZLXPLgIZwNG51PCaIOFRFiZ+D8Cf1sgzDO0OolD6hfwaLRQbPq6aHvSG+kEVVdDeeESkt2i39j589QN7rLGI7R68kNOByjvnSd4nu4fY7VVOK/3I04Qw/DhIkwstAS;25:hg18DWWrkaorKgXRWGiqymMTks8GNksdWLGiAxUykIJKpe399vmEEMZCK+PzFQOHMCwEsTqmQq7KVAg3KEnmx9T/Dna8eqYTISZdqMRZ/H64+x/Do052UihqyyrCbc4JKN30XkpwxSqg2o9mP8umWBcGjDhgg4Rkp2NJlNBPGO4UtG3iDOc0tOM3tPVcgAjt1LOISHv155WyXNhIMKlDvOl9DZ4Nq6fvcRzGh3O8oYkaiCfgoAbWQMR6STKaXodNtb0ZSzltLsNTCQI+d4fof11sn2jxrx/riRbpb9VIvZOosBRZxlcaAbYpWjEQwmR5P4XLHW6M/8o0nji/oa9KFQ==;31:genMOKne9Z3EDa7ZIaA3C3GjdBh8p++mtp3k9AK4cnLdrFh5ENmTplnwB/v6Isi0ObQXVbjCgMXLlzz5oeG0cdwm0oaFaR1jU3kbgvgDbam8t1xRFtwNMOsGh8yIp4Sli+G9PTsd+vJ7boZSr4+c9/xz0LL8B6D8RevNqxgxrS20wPYVjwLVj8Nhk+RmqfT2aj5m7EaZSs2iXaeQ4Z3+q7035iHS8pkxJP0t32QSu2M=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1570:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;20:OFB/U51uC5q+TLfPXSboSgF7IznGoMBkt4x/Hcav/BhZRktyzPnpMa0H760F25s5PxBakjO43JW7rOsU3CWUV1mKkQkEPkVwheV/lZE5ARj8ah7wqJAIro3o3nYkaeb211W49HeouuMSXSkjzahnLH+tw+ojtV3sNRydj3BSSo2gpQ89Mt7nSXIHNvpb5262JErAmzaSCIYk+xA5CQFxD2DkwotFLeJlZMYVJ9kWD4xBwi0KRTTcsxHEvcLYbL4yCav6v4FFeoKeFW4U18tzBphka5NT8lup0Lgk7haYhbXUetpftKwfGoDOPwQr9RHCSSewDeC22JPadHb7kgmkP6OYVazOmx6/FXFuODZe1ZC/R6rPrdSI0LQr7TLrCOfI7HfpabOeiiST30Uh3AiKvAxXiayO9LSfEyHvajWF5O7m7tDND9Eh/SPrJavEDaQvSj93FOJGu0fH5FnjXp9f0DN4VJLVrKT2uIIIqUZCNo9tmkHH/5dxZZtLxXLiQjh3;4:PsdgMsIjRT6FAz+14P6gRm4UThczrsvZaGpi0jM37l21gmGUIfWVj+i+PoCn4BVarfV+M7+i+nv8EO8m7aIWWrT9R9V1zLDMrz2jCGwpPUYIxgRLFRshdxPfNdqMJn7ojFMO6sYdm4i6kw8BIEZZrvqp74y8zbm3kqbw/+pJQ3W64soNfRxljG0fgcYtV+t54+CxrJv9pyThUa4xFFZdJ8J/6LditZIebdp9vf4AfhM9fy9dxn42Oq7a0J/AOO2PM0k5Pxs9QDL3UvwRVGslrQ==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15703E50DAFEA2BA3EECC5EDED2E0@BLUPR0301MB1570.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1570;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1570;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(366004)(136003)(346002)(376002)(51914003)(189003)(199004)(97736004)(50466002)(5660300001)(6916009)(1076002)(3846002)(6116002)(23726003)(6666003)(9686003)(54906003)(6506007)(53546011)(386003)(53936002)(33896004)(16526019)(8676002)(26005)(229853002)(7736002)(14444005)(186003)(81166006)(55016002)(446003)(476003)(486006)(316002)(230700001)(68736007)(81156014)(305945005)(93886005)(106356001)(105586002)(4326008)(47776003)(8936002)(86362001)(6246003)(50226002)(76176011)(52116002)(956004)(11346002)(7696005)(478600001)(25786009)(66066001)(72206003)(2906002)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1570;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1570;23:nuRMELwoE/9lXitu5/CpTHmNVhvD+bpTPFCbYfv?=
 =?us-ascii?Q?3BPKGTfYAwLnehm9oQ9Az7ThwucdGE30wGjnf1uRSj2Z5mHmL5C3zPxZRjGs?=
 =?us-ascii?Q?VGRHhwS3k28BgFGLNvKpvQsuwXsNiBp+jV83NEWLJ/tWvZNLemjbP2KpaVX+?=
 =?us-ascii?Q?+/Et/MTa7bvPS5n40aAlk6PFPKolQeChZ+MD2y5n/whezMxOoUS5nmq1Ko1f?=
 =?us-ascii?Q?0M20tMX7YqYciWZf0skKIIxhDM//SqvWbttC2DZLC3BzMBlkI9bJqaFPZJwq?=
 =?us-ascii?Q?BOYesQ7eERM5kI6EykQVzthcRX75sekpHW45AXMqpgBDRMIP1Eq5GUyRsRli?=
 =?us-ascii?Q?1z4nxwO19+c+tq7yS3KXm/pHgAgEUZ4usZjeu/4oQ5EzGCMf8exeSyNUIcEL?=
 =?us-ascii?Q?XsFLGXU5NVKU1TNvUqkmZOIvVBLYnqusPvb3tHvB6Z3h2uxzlN571NF17O2A?=
 =?us-ascii?Q?D2Fd9/D2PFTFF82tbkUez/TXSMZRoMpn0p9D1WaYrbgRD8pcftnNg0NCaGg8?=
 =?us-ascii?Q?ZUHKHauiZuzyXwrUEMXd0CyoQ4+Z+16cztyebk4Z+t4xC+6xj3yePysp2mqd?=
 =?us-ascii?Q?H0Shs8LPLev316S34yDhHhrU6n3nkW2EP41ZPdFEuy5LodIhRqhnnXIbzdPd?=
 =?us-ascii?Q?Bl6T/t2blnRI2S90OYPQEgH2vCdaQez7QOWJAeGRpUDwHmEAFpzCoSY7s5AT?=
 =?us-ascii?Q?Vo6oqhmq71lODLT02UQV5/fOF+iFw7DuGka9CTSuCsWt/DJoSH0TBvrIof3t?=
 =?us-ascii?Q?pOMbTTrwHDAYPXsUX8DKQXZ7GXRs6N+WF2jXlk+RnN/lMrKG13Fp4CMQ6zYF?=
 =?us-ascii?Q?kBhjnolX59MmRPG7nMcMaNj69tNjPtkuPsDkYwcACU03Gb/ODTAVqr1sAxwA?=
 =?us-ascii?Q?x9dAwvwrL22+X14Df5CQSz4vlTxYu6pUrz1Niyyl0THqx8U9MpMn1hMsVlWn?=
 =?us-ascii?Q?wOf2cfPRQIfTB0mzQEuK12E7rHnmxYDnh7AbqrvWmqcMgcrNa+xl3WwVPRaj?=
 =?us-ascii?Q?Y6VJDW0yhbIga79zqByqckKqio9jBmSRBos4L0wnQQeY73V3n8CyGFshE11c?=
 =?us-ascii?Q?ocwzmEdCuuGJhbjLdgJYq8oBoEAq0n13ngQO8Z2OuSlaxOdsjMJPbf511WN7?=
 =?us-ascii?Q?5RZnA1DQ0dldvlR1O++q3qmPWOHh8vJ/hr0/fRSzeJPyp0ANSwJRmmVgkNbw?=
 =?us-ascii?Q?6NA38uF1h9Wwce7D97oNcohahdsWDW8Sa4iuc8oNV1zs7420xlciqFDT4pd5?=
 =?us-ascii?Q?m0iAxpUAY3TPibBkOu56Hs2LI+quD86VySYOYiLc17lS/RJQ9r2smn0P+T+B?=
 =?us-ascii?Q?Lt+nSQY8u7MCPsIj7ORVe6vKR3PAevW5evkGmCAf2ARRMh0alt5FmdVrJKK/?=
 =?us-ascii?Q?5mhap3f4MI7595zf+pIpe8VpdeR4=3D?=
X-Microsoft-Antispam-Message-Info: Vu5Y/k5gREyxyG5Com0p9rZGA05fetOZS0qpeIeVYZhc8A1Ku1S3yKWM9gxKZCNhBVuG+UvIQpQKI6b8rGBrPH+RooVWICgBWYTayuwQPrFan4hAtkWS0zsNTDhp5rLsR+VgH+0qBUvVPx+n7k+rUjmTvuWAt/LGG9CYO7Z2TMci4PEGAfV4o5jDCBj69Pb0zEsLboVQ6hPdUyeg5h8jIHYwbwgZl2+YBX7VWPxryHJelvxUm1/R1zY4kGLCi5RMVVeSOAa235gN144xusBy6fYXCv0MCPZ7Oo1Pq6YgcPwnCRfpfuAnBKKlllikvTnT5IMoQJzA/sMEi5KIYQOJo8ikhfODS1ptJwZB600PelE=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;6:UmQ3UXWPW/9KnUZKt+00Kg/EJ6lz/ze6yINM0AH4qD6AykbFiRuaRG2tXJPpEbACdCM9AUwSM8EM6Fsj6Gg4g9c3mAwWtdKXvrMpUK5mslvaQ+HpqvZmFARS9twz9+YKMpV/Ssl2jOiTA3EKJ4pnDCpwwWZwQ9CPBH3kDqbDLMw3YIJA+vmGMER8IBIf0ZDieUoY7poVQPTA94LIxORIi1ETuA/t9BIVjJ2qOWFPrhGeu1CdbinaozwDFXpDAxxh5kzQL/pCi0qpBoPlwsebPu+kdaoBjHol4zY/BYzVcye7t5agvAZJZY/Fvz4ElRN6wx2LMMVHuo1e9yeNPvfn/kYkVlUkLBp6kshu82WjCJvBHUKFR1f0PEntZEUpdAkFjLdC85SF5sVHPTuSNfOeM2cVoilFaEihXtI2hHytDO9GjJrOSN3PIhYkf9pepQpIAj/KhrawcibG/mPdma+d+Q==;5:XiGauQf92euACkURR7djCJkKWJZcLvTd2BLJW7Wmt16t/ud5J48nK5h1041KeZfyDveu/01ai6nyNXxHDhaWFW0T9wq5O5Lp/ByKA881kN0txbPXT7v3ozPIGcq63F2ogc5Bz0s4EMkQZwWr10LnXpavJNcDwmznGllqwjXkUVU=;7:S7xGzlps88Jet4a0IYL1ldGMNiXdFwSvaqehO31XE0rUn2m9ZdwRPrFZVjTZfqR0xK1Ayr2M2HLYllOeOLzIs/Qw7j3vDcHW1vKLxpfyUgHY0dQpHClmYaeXY2wdxWGwMiRCei9o8SOAXspkmLOPDSBQ1zEW7P3z7S71x/B+CwzvGnG+IxAmjRxGwezv3VhmUV3U7nP9dfrtRcDeG/IEivxmepye/RqeZKXiuFLQyx6VpuLcPc4UAh05NB+ZwMh6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 05:55:25.6357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec7be20-11e8-4e60-3933-08d5f6aa37c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 11:29:24 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Hi Robin,
> 
> On Mon, 30 Jul 2018 12:06:08 +0100 Robin Murphy wrote:
> 
> > Hi Jisheng,
> > 
> > On 26/07/18 08:14, Jisheng Zhang wrote:  
> > > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > > the DMA transfer into two so that each one doesn't exceed the boundary.    
> > 
> > Out of interest, is the driver already setting its segment boundary mask 
> > appropriately? This sounds like the exact kind of hardware restriction 
> > that dma_parms is intended to describe, which scatterlist-generating 
> > code is *supposed* to already respect.  
> 
> Thanks for the nice input. It may provide an elegant solution for this
> limitation. 
> 
> To simplify the situation, let's assume no iommu, only swiotlb. And
> the DDR is less than 4GB so swiotlb on arm64 doesn't init.
> 
> There's no dma range limitation with the HW, the only limitation
> is boundary, while dma_capable() doesn't check the boundary mask, so if
> we taking this solution, we need to teach dma_capable() about the boundary
> mask, I'm not sure whether this is acceptable.
> 
> Another problem is swiotlb initialization. When to init swiotlb, we dunno
> there's such boundary limitation HW. Is there any elegant solution for
> this problem?
> 

One more problem is: swiotlb isn't available on all platforms, e.g arm?
How to solve this SDHCI HW's limitation on arm soc w/o iommu?

Thanks
