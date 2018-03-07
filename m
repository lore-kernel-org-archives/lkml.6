Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754826AbeCGVMH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 16:12:07 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:59489 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754052AbeCGVMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 16:12:06 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Mark Brown <broonie@kernel.org>
Cc: kuninori.morimoto.gx@renesas.com, maxime.ripard@free-electrons.com,
        wens@csie.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [BUG] Kernel crash on Allwinner H3 due to sound core changes
Date: Wed, 07 Mar 2018 22:11:56 +0100
Message-ID: <1832733.mujlD9skaR@jernej-laptop>
In-Reply-To: <26212674.B0xcQEiVyd@jernej-laptop>
References: <2424862.oPtAVTfrB9@jernej-laptop> <20180302124050.GF6255@sirena.org.uk> <26212674.B0xcQEiVyd@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne ponedeljek, 05. marec 2018 ob 22:30:23 CET je Jernej Škrabec napisal(a):
> Hi,
> 
> Dne petek, 02. marec 2018 ob 13:40:50 CET je Mark Brown napisal(a):
> > On Thu, Mar 01, 2018 at 11:23:57PM +0100, Jernej Škrabec wrote:
> > > I removed parts of the code from the sun4i codec driver and
> > > interestingly
> > > it doesn't crash if I remove following lines:
> > > 
> > > ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> > > if (ret) {
> > > 
> > > 	dev_err(&pdev->dev, "Failed to register against DMAEngine\n");
> > > 	goto err_assert_reset;
> > > 
> > > }
> > > 
> > > Is it possible that NULL pointer causes troubles somewhere down the
> > > line?
> > 
> > Shouldn't be, that's just the configuration which is optional and not
> > what we're crashing trying to register, we can mostly configure things
> > by querying the capabilities of the DMA controller via the dmaengine API
> > these days.  You're removing all the DMA support there so cutting out a
> > huge segment of the initialization of both this driver and the machine
> > driver.  Other sunxi devices seem to be starting happily in -next so
> > there's something system dependent here...
> 
> I enabled memory debugging and it seems that there is an issue caused by
> loading sun4i-codec driver and it is somehow connected to
> snd_dmaengine_pcm_unregister().
> 
> Here is relevant dmesg: https://pastebin.com/raw/80K9GPnB
> 

I found the issue. Commit be7ee5f32a9a ("ASoC: soc-generic-dmaengine-pcm: 
replace platform to component") changes struct dmaengine_pcm:

 struct dmaengine_pcm {
 	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
 	const struct snd_dmaengine_pcm_config *config;
-	struct snd_soc_platform platform;
+	struct snd_soc_component component;
 	unsigned int flags;
 };

In snd_dmaengine_pcm_register():
ret = snd_soc_add_component(dev, &pcm->component,
				    &dmaengine_pcm_component, NULL, 0);

And now, sun4i-codec first time returns -EPROBE_DEFER since driver for analog 
part is not yet loaded. Because of that, all components get destroyed.

snd_dmaengine_pcm_unregister() calls snd_soc_unregister_component() and that 
one calls __snd_soc_unregister_component() multiple times (until it fails).

Issue is that __snd_soc_unregister_component() uses kfree() on component 
pointer and that naturally can't succed since component was never kmalloc'ed 
since it is a part of a bigger structure - struct dmaengine_pcm.

What would be the best fix? Changing struct dmaengine_pcm to have pointer to a 
component, so it can be freed?

Best regards,
Jernej
