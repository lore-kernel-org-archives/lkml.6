Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5690C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615F2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="s/YOW9hF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfBVNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:21:04 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36356 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVNVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=78JcDlSA7SBS6O7ITKzDwl4r4hIpKzcdqBN3lyZBR4c=; b=s/YOW9hFo4kBJgJfOmJ/4zABC
        aTs0ED7i8QVLDwHzfTzXV3dfgFpQr098pM6ZvnDl8rVNaz/vWwBZkRt8dNvC4Cz9ySauK8heITbrC
        aopRX57Wksmi8Zd1TxurNVsKwAOnNDhCxzEkvNxXbPfMjULMFdBB+YaFwlBWT40lLfs7Wd4tSv8vb
        zSAxDFtXZpxbfAPKkVgSL0uWhuqxMFe9aw/K0pJTi8D1rmbJRfYBOm+x6z/Zz6/zrq0uIquYzizKO
        2xlMicMPmfef+MQ75og2vGBLHaHAiuQunzTufDO4TFp+kg+1/e7GU/N7i74cSL5OwzK/zaZL7MUVK
        rMqLx+OsQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51334)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gxAl6-00024i-84; Fri, 22 Feb 2019 13:20:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gxAl1-0002De-F3; Fri, 22 Feb 2019 13:20:51 +0000
Date:   Fri, 22 Feb 2019 13:20:51 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] drm/i2c: tda998x: adjust CTS_N audio pre-divider
 calculation
Message-ID: <20190222132051.voznrjt3sctdkpkf@shell.armlinux.org.uk>
References: <20190221181814.24829-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221181814.24829-1-TheSven73@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 01:18:13PM -0500, Sven Van Asbroeck wrote:
> My cpu dai driving the tda998x in master mode outputs
> SNDRV_PCM_FORMAT_S24_LE, i2s left justified, two channels:
> 
> 	[SNDRV_PCM_FORMAT_S24_LE] = {
> 		.width = 24, .phys = 32, .le = 1, .signd = 1,
> 		.silence = {},
> 	},
> 
> This format has a sample width of 24 bits, but a physical
> size of 32 bits per channel. The redundant bits are padded
> with zeros. This gives a total frame width of 64 bits.

The above table describes the memory format, not the wire format.
Look further down for SNDRV_PCM_FORMAT_S24_3LE, which is 24-bit
packed into three bytes (see include/uapi/sound/asound.h for
the comment specifying that.)

ASoC uses DAIFMT to specify the on-wire format in connection with
the above.

However, having 32-clocks per sample is quite normal with I2S.

> According to the tda19988 datasheet, this format is supported:
> 
> "Audio samples with a precision better than 24-bit are
> truncated to 24-bit. [...] If the input clock has a
> frequency of 64fs and is left justified or Philips,
> the audio word is truncated to 24-bit format and other
> bits padded with zeros."
> (tda19988 product datasheet Rev. 3 - 21 July 2011)
> 
> However, supplying this format to the chip results in distorted
> audio. I noticed that the audio problem disappears when the
> CTS_N pre-divider is calculated from the physical width, _not_
> the sample width.

It is not correct to use the physical width - as can be seen from the
table, if you check the 3-byte memory format, you'll see that it has
a physical width of 24.  That doesn't mean that the bus has 24 clocks
per sample.

Looking at kirkwood-i2s, which is one of the setups that the I2S mode
was apparently originally tested (not by me), it seems to do the same
thing as the FSL SSI - 32 clocks per sample with BCLK being 64Fs -
there is a comment "I2S always uses 32 bits per channel" which implies
64Fs.

When I2S mode patches appeared, I did wonder about that code which
depends on the sample width rather than the Fs value, but I assumed
that it had been tested with all different formats, etc.  Maybe that
was a false assumption to make.

As it is possible to have 16-bit samples at 64Fs or 32Fs, and if the
TDA998x is counting BCLKs, knowing the Fs value is necessary to know
how to program the TDA998x to generate the CTS value.

Now, ASoC has a bunch of functions that allows the wire format to be
controlled.  E.g., snd_soc_dai_set_fmt() sets which end provides the
master clock, the polarity of the clocks, whether the samples are left
or right justified.  There is also snd_soc_dai_set_bclk_ratio(), which
is documented as:

/**
 * snd_soc_dai_set_bclk_ratio - configure BCLK to sample rate ratio.
 * @dai: DAI
 * @ratio: Ratio of BCLK to Sample rate.
 *
 * Configures the DAI for a preset BCLK to sample rate ratio.
 */

which would have ratio=64 for 64Fs.  The problem is, though, that no
one appears to call this function, and fewer implement the method
(hdmi-codec being one of those which does not.)

> This patch adjusts the CTS_N calculation so that the audio
> distortion goes away.
> 
> Caveats:
> - I am only capable of generating audio with a frame width of
>   64fs. So I cannot test if 32fs or 48fs audio formats still
>   work. Such as S16_LE or S20_LE.
> - I have no access to a datasheet which accurately describes
>   the CTS_N register. So I cannot check if my assumption is
>   correct.

Don't think that any of the information that is available is much
better!  There's a few register descriptions but nothing that really
describes how all the various register settings hang together.

For example, the CTS_N register M and K values are:

M select: postdivider mts (measured time stamp)
0     CTS = mts
1     CTS = mts / 2
2     CTS = mts / 4
3     CTS = mts / 8

K select: predivider (scales n)
0     k=1
1     k=2
2     k=3
3     k=4
4+    k=8

Then there's the SEL_FS field in the AIP_CLKSEL register:

select fs: CTS reference

which is surely the mts reference, if CTS is derived from mts.

This doesn't really help in terms of working out what the correct
settings should be, and other information I have laying around does not
provide any further enlightenment.

I think what I'd like to see is passing of the Fs value into the driver
from hdmi-codec, but I suspect that requires a bit of work in multiple
drivers.

> 
> Tested with an imx6 ssi.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 4 ++--
>  include/drm/i2c/tda998x.h         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index a7c39f39793f..ba9f55176e1b 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -893,7 +893,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
>  		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
>  		clksel_aip = AIP_CLKSEL_AIP_I2S;
>  		clksel_fs = AIP_CLKSEL_FS_ACLK;
> -		switch (params->sample_width) {
> +		switch (params->physical_width) {
>  		case 16:
>  			cts_n = CTS_N_M(3) | CTS_N_K(1);
>  			break;
> @@ -982,7 +982,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
>  	struct tda998x_priv *priv = dev_get_drvdata(dev);
>  	int i, ret;
>  	struct tda998x_audio_params audio = {
> -		.sample_width = params->sample_width,
> +		.physical_width = params->physical_width,
>  		.sample_rate = params->sample_rate,
>  		.cea = params->cea,
>  	};
> diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
> index 3cb25ccbe5e6..7e9fddcc4ddd 100644
> --- a/include/drm/i2c/tda998x.h
> +++ b/include/drm/i2c/tda998x.h
> @@ -14,7 +14,7 @@ enum {
>  struct tda998x_audio_params {
>  	u8 config;
>  	u8 format;
> -	unsigned sample_width;
> +	unsigned int physical_width;
>  	unsigned sample_rate;
>  	struct hdmi_audio_infoframe cea;
>  	u8 status[5];
> -- 
> 2.17.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
