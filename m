Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966050AbeCHGDe convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:03:34 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:49188 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755374AbeCHGDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:03:30 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, wens@csie.org,
        Mark Brown <broonie@kernel.org>, maxime.ripard@free-electrons.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [BUG] Kernel crash on Allwinner H3 due to sound core changes
Date: Thu, 08 Mar 2018 07:03:25 +0100
Message-ID: <4224437.y2AcdKYxFF@jernej-laptop>
In-Reply-To: <87efkvtldx.wl%kuninori.morimoto.gx@renesas.com>
References: <2424862.oPtAVTfrB9@jernej-laptop> <1832733.mujlD9skaR@jernej-laptop> <87efkvtldx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for looking into it so quickly.

Dne četrtek, 08. marec 2018 ob 02:21:02 CET je Kuninori Morimoto napisal(a):
> Hi Jernej
> 
> Thank you for your hard work
> 
> > I found the issue. Commit be7ee5f32a9a ("ASoC: soc-generic-dmaengine-pcm:
> > 
> > replace platform to component") changes struct dmaengine_pcm:
> >  struct dmaengine_pcm {
> >  
> >  	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
> >  	const struct snd_dmaengine_pcm_config *config;
> > 
> > -	struct snd_soc_platform platform;
> > +	struct snd_soc_component component;
> > 
> >  	unsigned int flags;
> >  
> >  };
> > 
> > In snd_dmaengine_pcm_register():
> > ret = snd_soc_add_component(dev, &pcm->component,
> > 
> > 				    &dmaengine_pcm_component, NULL, 0);
> > 
> > And now, sun4i-codec first time returns -EPROBE_DEFER since driver for
> > analog part is not yet loaded. Because of that, all components get
> > destroyed.
> > 
> > snd_dmaengine_pcm_unregister() calls snd_soc_unregister_component() and
> > that one calls __snd_soc_unregister_component() multiple times (until it
> > fails).
> > 
> > Issue is that __snd_soc_unregister_component() uses kfree() on component
> > pointer and that naturally can't succed since component was never
> > kmalloc'ed since it is a part of a bigger structure - struct
> > dmaengine_pcm.
> > 
> > What would be the best fix? Changing struct dmaengine_pcm to have pointer
> > to a component, so it can be freed?
> 
> Ahh.. indeed. Good catch !
> How about to add such flag ?
> This is just idea. No tested, No compiled, but can help you ?
> 
> One note here is that reusing "registered_as_component" flag is
> not good idea, because it will be removed
> when platform/codec were removed
> 
> ------------------------
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 1a73232..b9b1b4c 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -853,6 +853,7 @@ struct snd_soc_component {
>  	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
>  	unsigned int registered_as_component:1;
>  	unsigned int suspended:1; /* is in suspend PM state */
> +	unsigned int alloced_component:1;
> 
>  	struct list_head list;
>  	struct list_head card_aux_list; /* for auxiliary bound components */
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c0edac8..0e33bcf 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3492,6 +3492,7 @@ int snd_soc_register_component(struct device *dev,
>  	if (!component)
>  		return -ENOMEM;
> 
> +	component->alloced_component = 1;
>  	return snd_soc_add_component(dev, component, component_driver,
>  				     dai_drv, num_dai);
>  }
> @@ -3523,7 +3524,9 @@ static int __snd_soc_unregister_component(struct
> device *dev)
> 
>  	if (found) {
>  		snd_soc_component_cleanup(component);
> -		kfree(component);
> +
> +		if (component->alloced_component)
> +			kfree(component);
>  	}
> 
>  	return found;
> ------------------------

I tested this patch and there is no crash anymore. If you will send it as a 
fix, you can add:

Reported-by: Jernej Skrabec <jernej.skrabec@siol.net>
Tested-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej
