Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3163EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABAE214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABAE214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbeKVEIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:08:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:42821 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeKVEIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:08:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 09:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="88191040"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 21 Nov 2018 09:32:59 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gPWMz-0005Ov-Tc; Wed, 21 Nov 2018 19:32:57 +0200
Date:   Wed, 21 Nov 2018 19:32:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] ASoC: Intel: Skylake: stop init/probe if DSP is
 not present
Message-ID: <20181121173257.GR10650@smile.fi.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-3-pierre-louis.bossart@linux.intel.com>
 <20181121142925.GP10650@smile.fi.intel.com>
 <1d06c878-c69b-a627-b7e6-e9d92be3b08a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d06c878-c69b-a627-b7e6-e9d92be3b08a@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:48:57AM -0600, Pierre-Louis Bossart wrote:
> 
> On 11/21/18 8:29 AM, Andy Shevchenko wrote:
> > On Tue, Nov 20, 2018 at 03:36:40PM -0600, Pierre-Louis Bossart wrote:
> > > Check immediately if the DSP can be found, bail and avoid doing inits
> > > to enable legacy fallback without delay.
> > It does slightly more than described. Please do either remove unrelated changes, or fill the gap in the commit message. In the latter case it may require to split patch to two.
> ok, maybe I should change the commit message since there are really two test
> conditions: DSP can be found and DSP streams found. The code really does
> just that, nothing else.

How shuffling DMA mask related to any?

> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   sound/soc/intel/skylake/skl.c | 26 +++++++++++++++++---------
> > >   1 file changed, 17 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> > > index df36b8fe6d5e..1d7146773d19 100644
> > > --- a/sound/soc/intel/skylake/skl.c
> > > +++ b/sound/soc/intel/skylake/skl.c
> > > @@ -931,6 +931,12 @@ static int skl_first_init(struct hdac_bus *bus)
> > >   	snd_hdac_bus_parse_capabilities(bus);
> > > +	/* check if dsp is there */
> > > +	if (!bus->ppcap) {
> > > +		dev_err(bus->dev, "bus ppcap not set, DSP not present?\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > >   	if (skl_acquire_irq(bus, 0) < 0)
> > >   		return -EBUSY;
> > > @@ -940,23 +946,25 @@ static int skl_first_init(struct hdac_bus *bus)
> > >   	gcap = snd_hdac_chip_readw(bus, GCAP);
> > >   	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
> > > -	/* allow 64bit DMA address if supported by H/W */
> > > -	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
> > > -		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
> > > -	} else {
> > > -		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
> > > -		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
> > > -	}
> > > -
> > >   	/* read number of streams from GCAP register */
> > >   	cp_streams = (gcap >> 8) & 0x0f;
> > >   	pb_streams = (gcap >> 12) & 0x0f;
> > > -	if (!pb_streams && !cp_streams)
> > > +	if (!pb_streams && !cp_streams) {
> > > +		dev_err(bus->dev, "no streams found in GCAP definitions?\n");
> > >   		return -EIO;
> > > +	}
> > >   	bus->num_streams = cp_streams + pb_streams;
> > > +	/* allow 64bit DMA address if supported by H/W */
> > > +	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
> > > +		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
> > > +	} else {
> > > +		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
> > > +		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
> > > +	}
> > > +
> > >   	/* initialize streams */
> > >   	snd_hdac_ext_stream_init_all
> > >   		(bus, 0, cp_streams, SNDRV_PCM_STREAM_CAPTURE);
> > > -- 
> > > 2.17.1
> > > 

-- 
With Best Regards,
Andy Shevchenko


