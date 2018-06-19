Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00909C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADA120874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4gJuJ3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADA120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965348AbeFSE3T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750816AbeFSE3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:29:17 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F337620661;
        Tue, 19 Jun 2018 04:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529382556;
        bh=dFalYT9mILSAljBoFp6rIikURZldsFLL31jACZnhyjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4gJuJ3GgdsncMQzNz1j6MkMHtBeme4w6jqcusulKAtn4kObNRB7F3DYXfi8zZbKc
         u1qDBet+8a527bDs8AFmRx7JliChQgFZ6hB0ssS0AfnOVXEqjtzhreEhLUiMbpit29
         OxWbBZt5U7n9/pQzxxH8vz+jikHlzd8WU70IXFTA=
Date:   Tue, 19 Jun 2018 09:59:08 +0530
From:   Vinod <vkoul@kernel.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dmaengine: ti: omap-dma: Fix OMAP1510 incorrect
 residue_granularity
Message-ID: <20180619042908.GM25852@vkoul-mobl>
References: <20180605165957.29616-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605165957.29616-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-18, 18:59, Janusz Krzysztofik wrote:
> Commit 0198d7bb8a0c ("ASoC: omap-mcbsp: Convert to use the sdma-pcm
> instead of omap-pcm") resulted in broken audio playback on OMAP1510
> (discovered on Amstrad Delta).
> 
> When running on OMAP1510, omap-pcm used to obtain DMA offset from
> snd_dmaengine_pcm_pointer_no_residue() based on DMA interrupt triggered
> software calculations instead of snd_dmaengine_pcm_pointer() which
> depended on residue value calculated from omap_dma_get_src_pos().
> Similar code path is still available in now used
> sound/soc/soc-generic-dmaengine-pcm.c but it is not triggered.
> 
> It was verified already before that omap_get_dma_src_pos() from
> arch/arm/plat-omap/dma.c didn't work correctly for OMAP1510 - see
> commit 1bdd7419910c ("ASoC: OMAP: fix OMAP1510 broken PCM pointer
> callback") for details.  Apparently the same applies to its successor,
> omap_dma_get_src_pos() from drivers/dma/ti/omap-dma.c.
> 
> On the other hand, snd_dmaengine_pcm_pointer_no_residue() is described
> as depreciated and discouraged for use in new drivers because of its
> unreliable accuracy.  However, it seems the only working option for
> OPAM1510 now, as long as a software calculated residue is not
> implemented as OMAP1510 fallback in omap-dma.
> 
> Using snd_dmaengine_pcm_pointer_no_residue() code path instead of
> snd_dmaengine_pcm_pointer() in sound/soc/soc-generic-dmaengine-pcm.c
> can be triggered in two ways:
> - by passing pcm->flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE from
>   sound/soc/omap/sdma-pcm.c,
> - by passing dma_caps.residue_granularity =
>   DMA_RESIDUE_GRANULARITY_DESCRIPTOR from DMA engine.
> 
> Let's do the latter.
> 
> Created and tested against next-20180531 tag from linux-next tree.

This is not useful for log.

I have stripped this and applied

-- 
~Vinod
