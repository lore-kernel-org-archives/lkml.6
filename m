Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30362C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C0520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="l7fbP1vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C0520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbeHAHHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:07:01 -0400
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:20875
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733008AbeHAHHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dptg8hgS2Yvi0Bx1/9R8h8eSx+xrL5WuuiKioY3YrGs=;
 b=l7fbP1vNLmRJGTje2QUJkLmhjLnNxV/YBT27puOfrVGjOWkRvHhuYyj201TKlNLNeEgbMZUcimrq34ZSuINAY8wrWGoNx6PT5TTY6EpVV4cAFdgwz9t4n9ndvpKdQ1diixlXjN9aCcu/sQuk6X/HhV12FOO8avyEyLUhvNI475c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1570.namprd03.prod.outlook.com (2a01:111:e400:52a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.16; Wed, 1 Aug
 2018 05:19:18 +0000
Date:   Wed, 1 Aug 2018 13:16:46 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <linus.walleij@linaro.org>, <yamada.masahiro@socionext.com>,
        <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3] pinctrl: berlin: fix 'pctrl->functions' allocation
 in berlin_pinctrl_build_state
Message-ID: <20180801131646.1fcc19f6@xhacker.debian>
In-Reply-To: <20180801051049.21360-1-yuehaibing@huawei.com>
References: <20180801051049.21360-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAXPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:402:1a::21) To BLUPR0301MB1570.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c68d5171-697b-4fc2-eb3a-08d5f76e55b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1570;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;3:oA3GWjGT6ch4LjWCzbDrlgtzyUeSDCgLuyPgpgYBN6txFilsx2dBkx/7uAeDSyH6Fu6FM/PKK4ujjJRSlCW+wijvpGuZAaMG+zGrWzFK5AtfDhYMlQtCGQOI2hUhnZRiw1cMo0dYG2yhETuBAqe/rPBvZCV9vh4gRkGtSuyUs8tK6V9b4vH6PYFeN9m5PUdjRUS+NXJNwSMKtrsQerJk2KjxZ8xFxdz6QVqNxf/ItK5bR6AmoxFji9JwYH8jeWpa;25:EdV1pRV6OaVEe35NcPrbkXflb4qjxNGdQgEeayPp+e5iM5tIqf3pU7MbqOkWN1jc2tBInmeQSuBGW6v2JsVDwm3oeR3PdoMPAj/ZQOLDqExbSz9aaGAgVSaLbp0azGROCcCs1uBYJi/UJ9PZc88pvNOHg+7w9172P704pKNlPA8rSkX+dJNjE7EVMR6nnusI+oAXEqKro5gn1uJxKzYzGKEBY7tPW1WofAOyXTBT/fYLW50dS8GgLotuhPKs/2QG7XVDQF0+kiD6Ab84/gspN82GKFcA1Wtf9E9XsYBRT2KQmlSFw+Dn9jYDekyGBAVWy4uwRxAMj2vIDlhDpmw4xA==;31:t43awCRc/o6XsNEAGkkbgG8a8snZlXZCyx/3iurYY7Y9D+NyIUNIg5WlkY/XRxVLfITCMAypijh5LeI7hKGQchYWIWb6EWnaG+MF0k+9xa7Rz20R1PqkKnML4m//DnGa/3YlCpqGVgLBdepAPVo5QftaHmmtH5mpW1No6QhgqdEmZkUJ/rjGuPO6mL3x/ehAN5j5w//OOjXc6nAdrnQn3mTTSb+VkT/HgbkdgECkmAY=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1570:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;20:y1qkTZJgXBFoNVPD1yde3fsdp3OT9Q89rp59BFKFJgUP6RAb/W8/U9x248XRw7zzAWzUDdtaBygpthqCisCx3P+zAOBXa7WGiFp/2NYkHr3BLEoWxOIMoJyqVcBHK71BOE6ZIsHiy7ZJeQDmD1DJ+Ump8/REl2XbCAM06qRkSm9r1eCmVJhUpfhm2No99JDyLlnzetB1I7wZd88OnsflffUZXvsZ0vFjD+abFl9HMR01qxyqYDnoIqiiUBkZP5w4uK4KJ1vYuDUT3L+P2ADAUMGyNFltebn8Bhk/kVa54AlcO7aItqiNq8htLv50+wCVfwMNKNXc/WmGOV2GZz0l+ZKUjzX850aO3yJuemhm2TbYc/THY/xFkvUcUm2k1kHHd1PDUQR172pVcSSMrap9fIzAEiVLXEbmiYKGZCq5RaFJ6Uxbe9pE7F/qZGilsm2MeDrz2KYhYwFD3nV5ddOUXUrFrogDHVkgVeMsT6catKqsu3w0ECALJdny63TVL+jf;4:7Qi0lIR07AmusvTAQVOafZj55SP+hk9X4xXJLZhUEbxMRvKVTsaqUZiqcBBNakywPYKzFkOpc+ieVDueYJARIAdXu8K7qSvqWnebqS0xVU8tunq94Kcu5omnt6LpFZK4/pfjqBoFs+VCpiCFOBQIDnxFpi6mHX+RfmbrcN0C1vKP+Gd+hXgkPfetM+T10e0hnXLhxbprYSla72t03r3eAWFIDtd1bhl+AWhtKIKCw+U6dHv+zWRGPTWmwtRiQ7CjiPU9qW4KM9MVSgYj5rYyk6H4Ik3tEyT1qBO72e9raWhHlkC+nFthKc21PyE8OwQB
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1570F037F27E5F19A1FE780FED2D0@BLUPR0301MB1570.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1570;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1570;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(11346002)(956004)(8936002)(478600001)(2906002)(6246003)(50226002)(86362001)(106356001)(105586002)(47776003)(4326008)(25786009)(72206003)(66066001)(7696005)(52116002)(76176011)(386003)(54906003)(9686003)(6506007)(1076002)(14444005)(230700001)(6916009)(5660300001)(23726003)(6666003)(6116002)(3846002)(446003)(486006)(50466002)(476003)(33896004)(97736004)(68736007)(316002)(229853002)(8676002)(7736002)(26005)(81166006)(53936002)(55016002)(16526019)(186003)(305945005)(81156014)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1570;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1570;23:Az/IKLwLswTf7IuEPQu+vZytz8k+LITpTD7Co82?=
 =?us-ascii?Q?mbDYrbolX4o/r0xFtjBnWLcji/dhIa5C7RyKlAD+JsK4ZDBgUxrOVpP+/vgH?=
 =?us-ascii?Q?P3DrevkxddQBjVC51Ec5uXC4RKTHJtqdFBVw5oxfZqPbcZyMakkZZQYiw3TC?=
 =?us-ascii?Q?KVAJ+/LjpMK241UI4PUbdp0AK8bWLPZY5ctO7FLhd8tDSH54xPrraayEdFkP?=
 =?us-ascii?Q?wirsqNtsve8drnc83NKYmJksdEUH6+tWY2Y4F5zkIVJEOvM7gjtqAURnXI/6?=
 =?us-ascii?Q?8KmL4JQdw/x7EIko6cOTcj0Yy29Z9cznx/2LD3hCrWHA/PR6vKyIRRuYBeol?=
 =?us-ascii?Q?04OcnQJ8CCBfx9GLO1+kXMussi81tACWF5djQKr8O8g5IqUpGtkMirjZZKGx?=
 =?us-ascii?Q?3mVvtXzrP5q+SIP9NauvKFixusWmIq0J/DBolG2RAvKbMofODPsLp50M+v9G?=
 =?us-ascii?Q?GBcE9EvP3aaXZZ0JCeRoFmXg/zY85Csw/XL+JA2e9Nrg3DkSW4HZzltx0cXG?=
 =?us-ascii?Q?CY0EWFtg97kpZYx0C7peOSq4MYDBjl3IJTq9hrtRbzztMq18Cl+aFOAbDy1d?=
 =?us-ascii?Q?5+edkZfa1n/ZZEDmskzDKM7Xo1DS2DsLC0SgQW47L+7XqxhWSXp0bZzRAgdb?=
 =?us-ascii?Q?e2H88MMoGzqRO3vGo92LnyP2Fp7VJ7t3VSWxqPvNRI0Ihi1L952aWj4IrNEq?=
 =?us-ascii?Q?z0DimCGEnhnK7bcK36KRzZG5PPab7tjsB4K2A81VeIgDv7PzFAMtfvK3d1bq?=
 =?us-ascii?Q?q5YrDN0hdQe9hQeeTe9C11ACff/VQbR5eZECewX6CQWyd4GQGJd5E8x3ky8P?=
 =?us-ascii?Q?HNz6AGwAbO6b3spBZfn6G+QZAN9xkO25J3u5XRI4yTqsBBJ+qRsBAL2lX386?=
 =?us-ascii?Q?QdnlV2xlI59Ln3JvltFL1rFMfhnvRgVGxbc4vV9igT94vNAWyoYb94lSv5r5?=
 =?us-ascii?Q?4ik6mjuhEcqnsknu71neGVHaxTfSjSywF1dLMdoxNR7v4RAut6UksHvtVTXD?=
 =?us-ascii?Q?fJvI8JU7AuEvhW5KZKw0gAOzgk2/AtTBtKRNL46XxuEG9NFpEtKRDSV0FQtv?=
 =?us-ascii?Q?TJGQHH90kma3iigsp0UefX2T1JegfIPcZeaEjDFM02D07NXNdV1jpDwxHBF2?=
 =?us-ascii?Q?8EoTNTsng5YWYrSJxri5AP3rRdUrJqGZHiyQOQFqjJDTzEXwqqha1A2k493p?=
 =?us-ascii?Q?LsDFGx50Z/Q6XZnk+aufTG96kapoMcL+DDX6wUR4smF6QtUai8gySH82pa5o?=
 =?us-ascii?Q?/ChdYaa9WpS10APfShVqmjvNOvrKpCLL7u96hCuF/bReex/9S3UCsYTSyGsQ?=
 =?us-ascii?Q?0fw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9wIhJBH50NVkXOPiBp5Ro726Es4Owvwj6+jldUtiRAOmZBK8C609Jigge2ZARbDz4h/srPhUtFWI8rG7PMaJj/1wJJqPbGvTyXYSaNYTBj0ng+ZD6ygCT3bJZWJUGtBDR8kToJI9y9fnSt2g2QKraOuL6ICxhFqyaxC6Mx5FbSCRmxky6a7gMqpnKTFZ+O/watyzfAnzFnXlGMbjSOchcHlLK51ykzHjkwBH8Aldd8JGVsIikMTEC16mGG2qHBd6ywI9KqQZwVINnn18NBNGwOjK2e/AqhC8AsgcTOV1FkiNhOlK0HsK2zt9YI4iRQBe6N1kqmq/0y1k7wTvcjVVkWJASm7PdzVwpFyywU1yaCk=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;6:yQvnfBkE4mV5Aryb5yp7R0p3C/5GOuZlIq8a9jEryCWjYdg4glDZR26qrHfasCY2Thpym9mdYVECem1AeUjBW75Gmv5KilpNGbaFXIOTBOWSdTwhA6dWe2jFKjj97EfyGVYeF0my3F/qa41wFzW2TZF2Maez9j3WpVoQ8DNV1zvsdkFQYqAJ9DqaGjaoeEzNn1Kq4yIkLk/0R5EOpCNkCh8hAG9RVvOuEmdW3lvskL2iNkFlImkBa6JF+pGlGUoVSHuSxYlrSvAKRehjxlRNegH41SaeHi2PyQrEPCsemE+gBU13m8+kJRYhIUEjcvPRecG/IG05mNz67A3CGreB1W4NSIOtc6XpScTOvgWemnoZGyu13tUPhsjtzkmq/Q8V8PCG7U+NSaISFJMBWQLrarL1vkviJYbHmuoZUvieSWoJnsu/F4CZVV9qj2Tx6k+K+cTeTRvXsqG0xJqd2JAvcA==;5:L2mviGYplz4fab1Y0wh59Sj43TH3VWru6OKekuzqmYKmba5CXDP6rfM8uWrCd3Rbj27ZMgfYAdacsc/hdlnulUCWonBe2PWQIYLqUHxN6J0gn3TQU2AY9ALB/OxgXWl9VmvnC60rOvNoR9u4NGOEeqtbU5/7MIH+3RNfXTzga7I=;7:uc7Flj5swxuLyysxWKYO6rw1ZD3kGgmCZgJRZ3lJEZ/U2mbtm/cn2V3KiD3VBAsZP2Uph3VKSGVl5JCRMCyDBJTOaEmQVq276xwBWkweef/dlTa1ICjX2nCvfe3Wiezw8QGe1a2wuSeA/xija4yZm0S9VASweFSaTnz+sh4UbOQnJ506BPMt6bJ+zMLVqfk2fx40EbHTlHdgn+2KnIUqDufTECCRPgFhOl++RRiAnYmQB/UHg7TqH1Nz0xHy4wDp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 05:19:18.0163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68d5171-697b-4fc2-eb3a-08d5f76e55b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 13:10:49 +0800 YueHaibing wrote:

> fixes following Smatch static check warning:
> 
>  drivers/pinctrl/berlin/berlin.c:237 berlin_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
> 
> As we will be calling krealloc() on pointer 'pctrl->functions', which means
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.
> 
> Fixes: 3de68d331c24 ("pinctrl: berlin: add the core pinctrl driver for Marvell Berlin SoCs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

> ---
> v2: free pctrl->functions instead of function as Jisheng Zhang suggested
> v3: v2 I send a wrong patch,this is the correct patch.
> ---
>  drivers/pinctrl/berlin/berlin.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
> index d6d183e..b5903ff 100644
> --- a/drivers/pinctrl/berlin/berlin.c
> +++ b/drivers/pinctrl/berlin/berlin.c
> @@ -216,10 +216,8 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  	}
>  
>  	/* we will reallocate later */
> -	pctrl->functions = devm_kcalloc(&pdev->dev,
> -					max_functions,
> -					sizeof(*pctrl->functions),
> -					GFP_KERNEL);
> +	pctrl->functions = kcalloc(max_functions,
> +				   sizeof(*pctrl->functions), GFP_KERNEL);
>  	if (!pctrl->functions)
>  		return -ENOMEM;
>  
> @@ -257,8 +255,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  				function++;
>  			}
>  
> -			if (!found)
> +			if (!found) {
> +				kfree(pctrl->functions);
>  				return -EINVAL;
> +			}
>  
>  			if (!function->groups) {
>  				function->groups =
> @@ -267,8 +267,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  						     sizeof(char *),
>  						     GFP_KERNEL);
>  
> -				if (!function->groups)
> +				if (!function->groups) {
> +					kfree(pctrl->functions);
>  					return -ENOMEM;
> +				}
>  			}
>  
>  			groups = function->groups;

