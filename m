Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeCIGdi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:33:38 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:39276 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751159AbeCIGdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:33:37 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        wens@csie.org, maxime.ripard@free-electrons.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [BUG] Kernel crash on Allwinner H3 due to sound core changes
Date: Fri, 09 Mar 2018 07:33:33 +0100
Message-ID: <2477367.T7DEPNfgqC@jernej-laptop>
In-Reply-To: <87h8pq166i.wl%kuninori.morimoto.gx@renesas.com>
References: <2424862.oPtAVTfrB9@jernej-laptop> <20180308111348.GB6019@sirena.org.uk> <87h8pq166i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne petek, 09. marec 2018 ob 00:49:18 CET je Kuninori Morimoto napisal(a):
> Hi Mark,Jernej
> 
> > > Ahh.. indeed. Good catch !
> > > How about to add such flag ?
> > > This is just idea. No tested, No compiled, but can help you ?
> > 
> > I think this makes sense as a patch.  We might want to disallow
> > allocating components as part of a bigger struct so everything is more
> > consistent but that's a bigger thing.
> 
> (snip)
> 
> > I tested this patch and there is no crash anymore. If you will send it as
> > a
> > fix, you can add:
> > 
> > Reported-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Tested-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> previous my patch used new flag (= .alloced_component),
> but I think it is not good idea.
> And I noticed that snd_soc_add_component() is
> also calling kfree(component) (= has same bug).
> 
> So how about below one ?
> I want to post it instead of previous.
> 
> # I will go to ELC next week, thus posting patch will be
> # 2weeks later
> 
> ------------
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c0edac8..4a8de23 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3476,7 +3476,6 @@ int snd_soc_add_component(struct device *dev,
>  err_cleanup:
>  	snd_soc_component_cleanup(component);
>  err_free:
> -	kfree(component);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_add_component);
> @@ -3488,7 +3487,7 @@ int snd_soc_register_component(struct device *dev,
>  {
>  	struct snd_soc_component *component;
> 
> -	component = kzalloc(sizeof(*component), GFP_KERNEL);
> +	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
>  	if (!component)
>  		return -ENOMEM;
> 
> @@ -3523,7 +3522,6 @@ static int __snd_soc_unregister_component(struct
> device *dev)
> 
>  	if (found) {
>  		snd_soc_component_cleanup(component);
> -		kfree(component);
>  	}
> 
>  	return found;

That patch also prevents the crash, so you can add my tested-by and reported-
by tags for this patch too.

Best regards,
Jernej
