Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C26C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590B12087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfAGP63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:58:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:24419 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfAGP63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:58:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 07:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124862031"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2019 07:58:26 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ggXIH-0001Ur-5C; Mon, 07 Jan 2019 17:58:25 +0200
Date:   Mon, 7 Jan 2019 17:58:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] irqchip/gic-v3: Switch to bitmap_zalloc()
Message-ID: <20190107155825.GS9170@smile.fi.intel.com>
References: <20180830103114.60601-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830103114.60601-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:31:13PM +0300, Andy Shevchenko wrote:
> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
> 

Any comments on the patches?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 9 ++++-----
>  drivers/irqchip/irq-gic-v3-mbi.c | 5 ++---
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 316a57530f6d..497589ebd950 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1577,7 +1577,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
>  	if (err)
>  		goto out;
>  
> -	bitmap = kcalloc(BITS_TO_LONGS(nr_irqs), sizeof (long), GFP_ATOMIC);
> +	bitmap = bitmap_zalloc(nr_irqs, GFP_ATOMIC);
>  	if (!bitmap)
>  		goto out;
>  
> @@ -1593,7 +1593,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
>  static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
>  {
>  	WARN_ON(free_lpi_range(base, nr_ids));
> -	kfree(bitmap);
> +	bitmap_free(bitmap);
>  }
>  
>  static struct page *its_allocate_prop_table(gfp_t gfp_flags)
> @@ -2215,8 +2215,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	if (alloc_lpis) {
>  		lpi_map = its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
>  		if (lpi_map)
> -			col_map = kcalloc(nr_lpis, sizeof(*col_map),
> -					  GFP_KERNEL);
> +			col_map = kcalloc(nr_lpis, sizeof(*col_map), GFP_KERNEL);
>  	} else {
>  		col_map = kcalloc(nr_ites, sizeof(*col_map), GFP_KERNEL);
>  		nr_lpis = 0;
> @@ -2226,7 +2225,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	if (!dev || !itt ||  !col_map || (!lpi_map && alloc_lpis)) {
>  		kfree(dev);
>  		kfree(itt);
> -		kfree(lpi_map);
> +		bitmap_free(lpi_map);
>  		kfree(col_map);
>  		return NULL;
>  	}
> diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
> index ad70e7c416e3..7d783fc56169 100644
> --- a/drivers/irqchip/irq-gic-v3-mbi.c
> +++ b/drivers/irqchip/irq-gic-v3-mbi.c
> @@ -284,8 +284,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
>  		if (ret)
>  			goto err_free_mbi;
>  
> -		mbi_ranges[n].bm = kcalloc(BITS_TO_LONGS(mbi_ranges[n].nr_spis),
> -					   sizeof(long), GFP_KERNEL);
> +		mbi_ranges[n].bm = bitmap_zalloc(mbi_ranges[n].nr_spis, GFP_KERNEL);
>  		if (!mbi_ranges[n].bm) {
>  			ret = -ENOMEM;
>  			goto err_free_mbi;
> @@ -323,7 +322,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
>  err_free_mbi:
>  	if (mbi_ranges) {
>  		for (n = 0; n < mbi_range_nr; n++)
> -			kfree(mbi_ranges[n].bm);
> +			bitmap_free(mbi_ranges[n].bm);
>  		kfree(mbi_ranges);
>  	}
>  
> -- 
> 2.18.0
> 

-- 
With Best Regards,
Andy Shevchenko


