Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46541C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB12E20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="piI6uer1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB12E20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbeGKQIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:08:48 -0400
Received: from mail-bn3nam01on0129.outbound.protection.outlook.com ([104.47.33.129]:31328
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbeGKQIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L40awJq+PfYUYSNSlGL4OPI0veqp58vqqQXXM5ycDhQ=;
 b=piI6uer1ODcdtFlKlb7/4NwrXihZsOsx++YNCnOLd8/2t/qrnM7yPiLCL6wbDCw/n4ZsinE+0rV29ca95r9VAvKYeivgboQFYuubATE4KM7dyePAwRH7AyLJB+6+TfHxI+FXjopzaTdmP4I6A/OdE533xukIE73+QOUK4Up1X1g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Wed, 11 Jul 2018 16:03:45 +0000
Date:   Wed, 11 Jul 2018 09:03:42 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: Fix mips_dma_map_sg by using correct dma
 mapping function
Message-ID: <20180711160342.ddvlqvjp3smwyido@pburton-laptop>
References: <20180711113852.2734-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711113852.2734-1-tbogendoerfer@suse.de>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d57bb0e-43e6-4e26-cb74-08d5e747e158
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:nP+9OrFxt+D2ue1qP5UW+sjxD5AxPZ6fzy+9werH7ccxvrS8FnVjNPteKOkpIItPY7+khx2ng2HF2ELRWIeqnAoBk+jOI3rV+R9l6bmdiyaK5KYXBYwImjgAWueL/9mrFBlF4xkZlns4Ch8g+jGktoPNLBVRYd4bn1Mp8jGdBj9Iebr8X2SdiL3FcMQfdgHoj3JlwrpVk1zIRTk3ACEv1dQFvNrAJeDjTRvpbkC9oCqjTqqOWRZdqHu56qIABgoa;25:rpuW8R4yTIyaeio4Halboi5L2j6Lces8XTc7AOUz8/uXFbavpKxjCq5NxdupXyMFXfmOCD3xygKn8TSwxphWWagy9anH4tuyqtd1gbVZ23YxFpaiJArTtxTYAhIAF3DbNj66bPxoI+5Zzt52sEhj4J27ReEicphr0JqR5x8GyRij+nBsYLnzQgTrU3xzgg7cyURbX/KVbk6B3QTur1Odfsy+BxFVVP7P4D8eW10A0Ocvez2lqQ063aVBrSn772F8JRG+z7jT0MKV8d93L8SpqrK/ZttXedkHKsFdkEMRXKobOJJODxIHwNa83JrOFuhq94LpTPCilSYhXNjKyifNkw==;31:hhfmPLQScl7yWFiCPG2DE+S6S8105FMBEbInk/VzaAxmO3FYa8Z1YXEFTeAc1itBpHVtPNiL+AYA9LVEO2PhGyoFk7a8FB0MYycey4aCXHyAG5vLAsTUqT7fmlnWRuwG8ktIjgTmmOMgGesKXYcATvFn0EE252tVFiY8TZNNyj9W9v2x0JF4NeOE9ELF7uaWmctdrBhOIoDhzzD79w2uMgpEEJ4DYNblMnl04LJ2u5Y=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:rin096IIoH69ynnV93tZiyi6/uPVUV3TFI//lHE/vVVNTeVfWt1HI7EfWZxfD/E8ZUUrO7res9KS3YHZpE/S1IFZZ6qnqoMzL31XAGMXyYaC9rD9IaGiT/VIwyshbHKK92MrA0woPf2UUwyVZCVBeg4NlKbEqiFNBAIRnLjmziKpmXAVK9D2pgw/I7Xa8DlMSyNda2lM5XpXH2aB5Lykg1JtfP08Ps5Q372rnZgkHWb4eRB4CSrHzr672lEFMOuA;4:lV7+CHUOwyMps2ndND4Jo7JxrosGIPuBrBmv4tCuYXLzBSKNffw4U8Nhko7b9lpOKCewe5xtVsFaTFrRgHDX7q2IrDwf9vS/NFh6hovY7CDk3INxwskKZsdFYlXgv8uzlYsgCXpVgJqXZ099zg+U7nWw1+V6rM014gogGiQPVykjFyyk8uZEnE0sNu/GZxLHXssydXurWeVFg5hYCAvSYoTuZVtKsj/ayyAj8UezjylyT0/eFh9yWyy9F1SVY7gvHX8P/ZCByEtg0RN6THUs8r6uOJGtEwLCpuBSfUcDfrI3awXZJoVPPtadWyY3rt2t
X-Microsoft-Antispam-PRVS: <DM6PR08MB493999917C24B0BA9FE827DCC15A0@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(376002)(366004)(346002)(136003)(39850400004)(199004)(189003)(76176011)(6486002)(6916009)(53936002)(106356001)(68736007)(4326008)(47776003)(305945005)(6666003)(81166006)(8676002)(8936002)(81156014)(5660300001)(7736002)(66066001)(11346002)(6246003)(42882007)(446003)(54906003)(52116002)(6496006)(105586002)(186003)(76506005)(2906002)(33716001)(476003)(6116002)(23726003)(9686003)(3846002)(1076002)(316002)(58126008)(44832011)(50466002)(386003)(97736004)(26005)(33896004)(956004)(486006)(16526019)(16586007)(25786009)(478600001)(229853002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:Bu2i1SKreQhLIs0Wqga1BKZ2ylGePBU3KHitFAPdL?=
 =?us-ascii?Q?fU/cYppMIVNQCgiqo6u7YOHsuo4wYzmFcgBtY343V2Zpt9w5+0Q5FlAFyCQF?=
 =?us-ascii?Q?ZxGn8qQHXaMU/MJ4U7zgCQ9plXJk/RuGrcOAMFy0TA3e9v/VGuf4W/leYQ6t?=
 =?us-ascii?Q?L2OaSDPDv+8/O8qv1qlx+N8WDMxx2wE17RJ9FnkZMTKTbffXFQWv6WtI5/xz?=
 =?us-ascii?Q?cULVLWAVz+7CLrOBFMN2hJ2dPYxCqXKxI59TI7P8K9v9eFmiccFYsXib+G5d?=
 =?us-ascii?Q?cvkuJGqdUxFHVK4Ez8Sr/I0rOigcv7D+GdJx4JE7OZuNUt7jK61y1HvqZUsb?=
 =?us-ascii?Q?Exl5f0oxKVQdz/Taelc7mEFQ0c5tAiakX+HnxErbVNIk8gxzlMYKYMLyRidf?=
 =?us-ascii?Q?B5/6hpj11QZT6GGR/YwR7FdA/n4RrdA6epmGpacR7lkMFiu7Xmq1hcZNDrAm?=
 =?us-ascii?Q?szCnWtpRxQhXiK+s5+UIlOXMvCsv7jR8DsCM4kQnM5CTzHpqtfpkdu0tBfCT?=
 =?us-ascii?Q?+ZvLl4+07ua9JPTMiHOmYOA+n+ti20Di4sZwktJQhZQFz8w2HILLrBQDDR+2?=
 =?us-ascii?Q?cDBgxz/tyvVZSystL2ZsPUHNmJ4iP6c3owRPGXsSSrPBmZAjuguwsTpzzWJ7?=
 =?us-ascii?Q?uniT//bz00iYoYU6qebbAoQFJqkE5k7HeBfV6EnYq3Igign4LZBQrKW8QkSQ?=
 =?us-ascii?Q?uIb0M9n6sfxlpgQpOWce3HhEg5oUA1fwvIp/xdfY7fasFxpSuWU4IX0+PEIo?=
 =?us-ascii?Q?/qT88EVRStWPsE02/fdOxeUOWoqWXWW6BuZ4UD5yeBV0NGwQH8S/pG48/Vb3?=
 =?us-ascii?Q?10DDXZDhQAbKdMEEXcX3Pv/j3LR+JFBTyBRopw7SzyfgiKrksdKIEG3sr8CU?=
 =?us-ascii?Q?cPyOVxei/Q62S+qhjrN06x5UbugEtfVBABNCVMszG0saY9tpJXgWvwWtTMnA?=
 =?us-ascii?Q?8U7Db+/Gw1Lw0cxScQ7PGLhhvK0UIU4eiRg0L9Gpmic77KbROs3wqYSdFKPl?=
 =?us-ascii?Q?EqXflBr2UjYW6QMfbJSLvUc9WWO76vhEWIMjOgNXqnhJBF6VuKjLxr92KiVg?=
 =?us-ascii?Q?L3p4fFTecdAwmU3EKLTtifsbFEEPkNM21mQfSGtTE97L2JKgDlrZE6pLDc7q?=
 =?us-ascii?Q?9QjW5Ll6ifXwZAv07Nz7SQCMJw7799He/4DF/H+PWyU7O3IgmW6V8wz/f8Mh?=
 =?us-ascii?Q?kHzI1l7p9sWZrl+HQTYZior0xNKxwNGYgwZAd4N4Zz7rcESMh1IBSHP0cRW7?=
 =?us-ascii?Q?ImWaKotH66ZLFW5W3KLWT3X6Z7WePpksi7qH7tCKS2u/4PQFzMwZqOPy+O0Z?=
 =?us-ascii?Q?Pl4TxFA26lYfuwMqFC4nRaK7duoXZwy97m7NxES9FKb?=
X-Microsoft-Antispam-Message-Info: izCvR9GErMmu8z3u59Txt7sVGa0Tq336Okwwczv+75ms9pexTaLrDyp8gROw0Vo1HP8ZeHiAbVIkDlMtELTn6170a5X2KEhBe+93cUO7EJnNbOkGrh3bIMTA5iSMf9DeEAqskqC/6FfSIdh5xqwe9OmfgH0hf0b5V+hz4tNHus6iJtAq6k7gA4RolUelVDArXqUbMnq8GSLl71+2nH7Pui2w8OIubfMVIngGNMUT0SrAZDJdLMvKcuD6GTJU7xS7/CitBKUvgNER/vf0e1Flzf+LcA6XiaHL69W8NYKAJz9ngG2u7Fe+GBjaWXaItB2VAn9XQDWocjQLg2jUdI6xzUT95qb67RosHuv7YSPYlIw=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:8lGVRSRhD8fCCSgGeTIdPvXJr1ffDbls40sodUdCNpMA/88VV8g5FrU7VdDtQI+m7Plyq42MJKrUwrsJchxhx16kYrXN/HQR3ZFShx1Kylz/ltnW/23fGbCCy2ldLzYG2I91yTaLlkadH5XhQY3PUlaoJkNIeBA0W2tg7U7yxULYUvoqNKB4R/KfW2lTW20oQPVHfUdbQJ4h3sYpIQzdepDxfYPOMPMyLCHAWrZgA57aedBXHH61YjplfLzUQ3DiMv2jtOiNdSVa3YeU9N5o7+8zQ1jeI+4pe5O6UDgNNsf1nyrPZozdu5wNjuH24RUK64Zw1PZYI0QMbqDUPokfcL0+n/F24MIFEw4EAtRmSyeteTCgrn82wa/46GCUa6Y2xuPxsL4yfuTNCzhxlSAgnnkGqVzEapWhlBzHoCcDQ0GjxcII0gKiEVYcp/27GqlJo+NTOIUo3842RVr0wWLZOA==;5:OCW1DEeiiZZ8hM/+8Vcs56S+UrdQ46CweYEqC7eR4AbYfpyARXOLWBxqusQLCiqTO2R7n4OQcxDlbf14+2CCx9kiA+WdGMSQJ5tuMJh+91JCj+YLz+LIbq158XO9mbJjaX1z8IXm0/qc3SQn8Oo5dyLOMyB0VPCVSV7j5WOyAXQ=;24:0VpfkTdttWUd5E3+4ehgJBne08NJwnGklqH99KA1SgOw6+LogQpiFIXVfbKiTzI76U/TY6evwxzoTgvdQgZIAKRQE1AVHm8jlX0VGGWCFxE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;7:glqsUFuGHZTqFXDe04oe1Q80oo/d2bX+X2gldZNbWrG0iazIkQruKu/l0dpcpJjJSn7/4OwirNjTTVLu7DvBVPBRWt1OLsJ2ffgDJ6u2Ud/RHs/kftFkUjAZvIvyg11KF9tRd2TVRigDotL0K6wuFM4nTM1GM5QRfFJ1YR2A8+GJcU8isIYGtkHsZqGXfWXZ+qw344xzbnZqQhysJp4hO4AmH3xlko97t14BTmEn30flFMiGDEZwoNuWol8Yqpn9
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 16:03:45.0789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d57bb0e-43e6-4e26-cb74-08d5e747e158
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Jul 11, 2018 at 01:38:51PM +0200, Thomas Bogendoerfer wrote:
> sg list elements could cover more than one page of data. Therefore
> using plat_map_dma_mem_page() doesn't work for platforms, which have
> IOMMU functionality hidden behind plat_map_dma_XXX functions.
> 
> Fixes: e36863a550da ("MIPS: HIGHMEM DMA on noncoherent MIPS32 processors")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  arch/mips/mm/dma-default.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index f9fef0028ca2..2718185a3d38 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -288,8 +288,8 @@ static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
>  #ifdef CONFIG_NEED_SG_DMA_LENGTH
>  		sg->dma_length = sg->length;
>  #endif
> -		sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
> -				  sg->offset;
> +		sg->dma_address = plat_map_dma_mem(dev, sg_virt(sg),
> +						   sg->length);
>  	}
>  
>  	return nents;

This doesn't apply after Christoph's massive MIPS DMA cleanup which can
be found in mips-next (or linux-next). After this work we end up using
the generic dma_direct_map_sg() on most systems, and the code above has
been removed.

Thanks,
    Paul
