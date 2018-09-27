Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1939DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D132159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D132159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeI0Xj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:39:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:43564 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbeI0Xj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:39:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 10:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,311,1534834800"; 
   d="scan'208";a="236559983"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.132]) ([10.122.105.132])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2018 10:20:39 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] EDAC, altera: work around int-to-pointer-cast warnings
To:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     David Frey <dpfrey@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180927100949.973078-1-arnd@arndb.de>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <2d52e197-8ce0-e428-fb1a-e118a840fa12@linux.intel.com>
Date:   Thu, 27 Sep 2018 12:23:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927100949.973078-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 09/27/2018 05:09 AM, Arnd Bergmann wrote:
> The altera edac driver passes a token from a DT resource as
> resource_size_t into an SMC call, but casts it to an __iomem pointer
> and then a plain void pointer inbetween, mixing three or four
> incompatible types in the process. The compiler complains about
> one of the conversions:
> 
> drivers/edac/altera_edac.c: In function 'altr_init_a10_ecc_block':
> drivers/edac/altera_edac.c:1053:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>     base = (void __iomem *)res.start;
>            ^
> drivers/edac/altera_edac.c: In function 'altr_edac_a10_probe':
> drivers/edac/altera_edac.c:2062:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>     base = (void __iomem *)res.start;
> 
> Using a static checker probably also notices the __iomem cast.  Solving
> this properly isn't trivial, but simply casting to a 'uintptr_t' instead
> of 'void __iomem *' makes it less wrong and should avoid the warnings.
> 
> Fixes: d5fc9125566c ("EDAC, altera: Combine Stratix10 and Arria10 probe functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/edac/altera_edac.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 0e9e80789d99..c89d82aa2776 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1036,7 +1036,7 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
>   	} else {
>   		struct device_node *sysmgr_np;
>   		struct resource res;
> -		void __iomem *base;
> +		uintptr_t base;
>   
>   		sysmgr_np = of_parse_phandle(np_eccmgr,
>   					     "altr,sysmgr-syscon", 0);
> @@ -1050,9 +1050,9 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
>   			return -ENOMEM;
>   
>   		/* Need physical address for SMCC call */
> -		base = (void __iomem *)res.start;
> +		base = res.start;
>   
> -		ecc_mgr_map = regmap_init(NULL, NULL, base,
> +		ecc_mgr_map = regmap_init(NULL, NULL, (void *)base,
>   					  &s10_sdram_regmap_cfg);
>   	}
>   	of_node_put(np_eccmgr);
> @@ -2045,7 +2045,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>   	} else {
>   		struct device_node *sysmgr_np;
>   		struct resource res;
> -		void __iomem *base;
> +		uintptr_t base;
>   
>   		sysmgr_np = of_parse_phandle(pdev->dev.of_node,
>   					     "altr,sysmgr-syscon", 0);
> @@ -2059,9 +2059,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>   			return -ENOMEM;
>   
>   		/* Need physical address for SMCC call */
> -		base = (void __iomem *)res.start;
> +		base = res.start;
>   
> -		edac->ecc_mgr_map = devm_regmap_init(&pdev->dev, NULL, base,
> +		edac->ecc_mgr_map = devm_regmap_init(&pdev->dev, NULL,
> +						     (void *)base,
>   						     &s10_sdram_regmap_cfg);
>   	}
>   
Thanks for the fix.

Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>

