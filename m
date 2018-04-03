Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeDCRas (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:30:48 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:36174 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeDCRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:30:46 -0400
Date: Tue, 3 Apr 2018 19:30:44 +0200
From: Ladislav Michl <ladis@linux-mips.org>
To: Joe Perches <joe@perches.com>
Cc: Colin King <colin.king@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
Message-ID: <20180403173044.GA6031@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180403134540.GA29017@lenoch>
 <1522770597.11653.49.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522770597.11653.49.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 08:49:57AM -0700, Joe Perches wrote:
> On Tue, 2018-04-03 at 15:45 +0200, Ladislav Michl wrote:
> > On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Hello Colin,
> > 
> > > Trivial fix to spelling mistake in pr_debug message text
> > 
> > would you mind making this patch a bit less non-trivial and
> > change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?
> 
> Presumably, then all the pr_<foo> calls should be changed.

Yes, that's what non-trivial means here :)

> Something like:
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index a1e2c5682dcd..594228156b2d 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -291,11 +291,10 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>  	int dir, dir_mask;
>  	int ret;
>  
> -	pr_debug("atmel_ssc_startup: SSC_SR=0x%x\n",
> -		ssc_readl(ssc_p->ssc->regs, SR));
> +	dev_dbg(dai->dev, "SSC_SR=0x%x\n", ssc_readl(ssc_p->ssc->regs, SR));
>  
>  	/* Enable PMC peripheral clock for this SSC */
> -	pr_debug("atmel_ssc_dai: Starting clock\n");
> +	dev_dbg(dai->dev, "Starting clock\n");
>  	clk_enable(ssc_p->ssc->clk);
>  	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
>  
> @@ -385,7 +384,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
>  	spin_unlock_irq(&ssc_p->lock);
>  
>  	/* Shutdown the SSC clock. */
> -	pr_debug("atmel_ssc_dai: Stopping clock\n");
> +	dev_dbg(dai->dev, "Stopping clock\n");
>  	clk_disable(ssc_p->ssc->clk);
>  }
>  
> @@ -794,13 +793,12 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  		break;
>  
>  	default:
> -		printk(KERN_WARNING "atmel_ssc_dai: unsupported DAI format 0x%x\n",
> -			ssc_p->daifmt);
> +		dev_warn(dai->dev, "unsupported DAI format 0x%x\n",
> +			 ssc_p->daifmt);
>  		return -EINVAL;
>  	}
> -	pr_debug("atmel_ssc_hw_params: "
> -			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
> -			rcmr, rfmr, tcmr, tfmr);
> +	dev_dbg(dai->dev, "RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
> +		rcmr, rfmr, tcmr, tfmr);
>  
>  	if (!ssc_p->initialized) {
>  		if (!ssc_p->ssc->pdata->use_dma) {
> @@ -818,9 +816,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  		ret = request_irq(ssc_p->ssc->irq, atmel_ssc_interrupt, 0,
>  				ssc_p->name, ssc_p);
>  		if (ret < 0) {
> -			printk(KERN_WARNING
> -					"atmel_ssc_dai: request_irq failure\n");
> -			pr_debug("Atmel_ssc_dai: Stoping clock\n");
> +			dev_warn(dai->dev, "request_irq failure\n");
> +			dev_dbg(dai->dev, "Stopping clock\n");
>  			clk_disable(ssc_p->ssc->clk);
>  			return ret;
>  		}
> @@ -839,7 +836,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  	ssc_writel(ssc_p->ssc->regs, TCMR, tcmr);
>  	ssc_writel(ssc_p->ssc->regs, TFMR, tfmr);
>  
> -	pr_debug("atmel_ssc_dai,hw_params: SSC initialized\n");
> +	dev_dbg(dai->dev, "SSC initialized\n");
>  	return 0;
>  }
>  
> @@ -862,9 +859,9 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
>  	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
>  	ssc_writel(ssc_p->ssc->regs, IDR, dma_params->mask->ssc_error);
>  
> -	pr_debug("%s enabled SSC_SR=0x%08x\n",
> -			dir ? "receive" : "transmit",
> -			ssc_readl(ssc_p->ssc->regs, SR));
> +	dev_dbg(dai->dev, "%s enabled SSC_SR=0x%08x\n",
> +		dir ? "receive" : "transmit",
> +		ssc_readl(ssc_p->ssc->regs, SR));
>  	return 0;
>  }
>  
> @@ -1050,21 +1047,18 @@ static void asoc_ssc_exit(struct device *dev)
>  int atmel_ssc_set_audio(int ssc_id)
>  {
>  	struct ssc_device *ssc;
> -	int ret;
>  
>  	/* If we can grab the SSC briefly to parent the DAI device off it */
>  	ssc = ssc_request(ssc_id);
>  	if (IS_ERR(ssc)) {
>  		pr_err("Unable to parent ASoC SSC DAI on SSC: %ld\n",
> -			PTR_ERR(ssc));
> +		       PTR_ERR(ssc));

Well, these are usefull, but unrelated changes. But while there, above
pr_error deserves to be replaced with dev_err as well.

>  		return PTR_ERR(ssc);
> -	} else {
> -		ssc_info[ssc_id].ssc = ssc;
>  	}
>  
> -	ret = asoc_ssc_init(&ssc->pdev->dev);
> +	ssc_info[ssc_id].ssc = ssc;
>  
> -	return ret;
> +	return asoc_ssc_init(&ssc->pdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
>  
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
