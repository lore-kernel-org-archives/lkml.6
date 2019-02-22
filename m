Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3802F2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wy9T2SEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfBVQ1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:27:50 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38832 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfBVQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sUi10VCgZ3lSLRMixykJ3Gxk9j0n6HpSSrL3SDR5Sgg=; b=Wy9T2SEYUzjwshXAFekYoyq7/
        20rnSgd8Ov8AUbAGySL0fh/beeXMYix41EP1EOH6je5aW+SUKrRqeRFZJycG1atVvL0q1pQNXdSg5
        XvVFlKb/MfmLn9lHfPD9OXpQ4ughUOp4Y++cqt6pm8/xtrP+fqSZR6Zcrk8lcAOAmcABrTNZaYeLb
        9DEB+4zuOgxf4YkGKhtcBznLsqIJzEWLJYRUDLynwkE3ANzoatp2vtJyICsjUM4n8S6qwrza/0gn3
        KsGYo6CTuzk9/eBr1GTR8S5ZS3LP2hqxiiA30h0X/sS/PGXXbW9KWYb1wotfUiOMn3gFVIwc5zN38
        m0F+2UQuw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37006)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gxDfo-00031N-ET; Fri, 22 Feb 2019 16:27:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gxDfk-0002L1-00; Fri, 22 Feb 2019 16:27:36 +0000
Date:   Fri, 22 Feb 2019 16:27:35 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] drm/i2c: tda998x: adjust CTS_N audio pre-divider
 calculation
Message-ID: <20190222162735.t2t57wvawpseax3k@shell.armlinux.org.uk>
References: <20190221181814.24829-1-TheSven73@gmail.com>
 <20190222132051.voznrjt3sctdkpkf@shell.armlinux.org.uk>
 <CAGngYiVU0wLVOm=tY+TZ9h1P+qNnDdv_3PybfhRreuBpCZ6D1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVU0wLVOm=tY+TZ9h1P+qNnDdv_3PybfhRreuBpCZ6D1g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Mark, ASoC maintainer.)

On Fri, Feb 22, 2019 at 10:47:35AM -0500, Sven Van Asbroeck wrote:
> On Fri, Feb 22, 2019 at 8:21 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Feb 21, 2019 at 01:18:13PM -0500, Sven Van Asbroeck wrote:
> >
> > >       [SNDRV_PCM_FORMAT_S24_LE] = {
> > >               .width = 24, .phys = 32, .le = 1, .signd = 1,
> > >               .silence = {},
> > >       },
> >
> > The above table describes the memory format, not the wire format.
> > Look further down for SNDRV_PCM_FORMAT_S24_3LE, which is 24-bit
> > packed into three bytes (see include/uapi/sound/asound.h for
> > the comment specifying that.)
> >
> > ASoC uses DAIFMT to specify the on-wire format in connection with
> > the above.
> >
> 
> Interesting ! So you're saying that currently, nobody strictly defines the
> layout of the on-wire format, correct? I'm not sure how this works in practice,
> because codec and cpu dai should agree on the on-wire format? Except if the
> formats used have enough flexibility so you don't have to care.

SNDRV_PCM_FORMAT_xxx more defines the in-memory format, rather than
the on-wire format.

As I've said, the on-wire format is defined in ASoC using a completely
different mechanism, using the definitions in include/sound/soc-dai.h.
This describes parameters such as the polarity of clocks on the i2s
bus, the justification of the data, etc.

Bear in mind that SNDRV_PCM_FORMAT_S24_LE in memory may be right
justified (using the least significant 3 bytes of every 32-bit word),
but on the wire may be left justified - using the most significant
bits.

SND_SOC_DAIFMT_I2S defines the format to be "Philips" format, where
the MSB bit is sent one BCLK _after_ the LRCLK signal changes state.
There is also SND_SOC_DAIFMT_LEFT_J, where the MSB bit is sent with
no delay, and extra padding zeros are sent in the "LSB" bits.
SND_SOC_DAIFMT_RIGHT_J is similar, but the padding is in the "MSB"
bits.

Then there's the polarity of the BCLK and LRCLK (frame) signals.
Finally, there's whether the codec (TDA998x in this case) is the
origin of the LRCLK and/or BCLK.

This information is passed via a call to snd_soc_dai_set_fmt()
which takes the DAI and the format - this calls into hdmi-codec.c
hdmi_codec_set_fmt().  This will be handled by the core ASoC code
if the DAI has a .dai_fmt member set (which can be set by DT -
see snd_soc_of_parse_daifmt().)

Then there is snd_soc_dai_set_bclk_ratio() which sets the BCLK
to sample-rate ratio, as I explained earlier.  hdmi-codec doesn't
have an implementation for this, and afaics no one calls this
function.  So, it seems assumptions are made throughout ASoC
on that point (probably because most codecs don't care.)

> > This doesn't really help in terms of working out what the correct
> > settings should be, and other information I have laying around does not
> > provide any further enlightenment.
> 
> I have access to the NXP software library shipped with the tda19988.

Yes, I'm aware of it.

> The library's release notes have the following entry:
> 
>   . "I2S audio does not work, CTS value is not good"
>     Check the audio I2S format <snip>
>     CTS is automatically computed by the TDA accordingly to the audio input
>     so accordingly to the upstream settings (like an OMAP ;)
>     For example, I2S 16 bits or 32 bits do not produce the same CTS value
> 
> The config structure which you need to fill in to init the audio has a
> "i2s qualifier" field, where you have the choice between 16 and 32 bits.
> This then maps to a "Clock Time Stamp factor x" called CTSX, which maps to
> the following CTS_N register settings:
> 
> CTSX -> CTS_N (m,k)
> -----------------------------------
> 16 -> (3,0)
> 32 -> (3,1) (i2s qualifier = 16 bits)
> 48 -> (3,2)
> 64 -> (3,3) (i2s qualifier = 32 bits)
> 128 -> (0,0)
> 
> Does this information bring us any closer to our assumption that CTS_N needs
> to be calculated off the bclk to sample rate ratio ?

I'm aware of other users of TDA998x, and I'm attempting to get out of
them what ratios their implementations use - they've said that they
have confirmed that 16bit and 24bit works for them, but that's rather
incomplete in terms of what I wanted to know... waiting for another
response!
 
> I'd love to take a shot at this, but first I'd like to understand what you're
> suggesting :)
> 
> Currently there is set_bclk_ratio() support, but no-one is actually using it.
> If hdmi-codec is to retrieve the ratio, wouldn't we need to add .GET_blk_ratio
> to snd_soc_dai_ops ?
> 
> I could add this to fsl_ssi in master mode, but what if somebody connects the
> tda to a cpu dai for which no-one implemented .GET_bclk_ratio ? Do we guess?
> Or just error out?
> 
> Also, what would a proposed snd_soc_dai_GET_bclk_ratio() return e.g. on
> fsl_ssi in slave mode, where the value arguably doesn't exist because the ssi
> will accept pretty much anything you throw at it?

You appear to be thinking that the codec should ask something else for
the bclk ratio - however ASoC is designed from the point of view of
the codecs being told the appropriate operating parameters by the
"card" or core at the appropriate time(s).  Hence, something needs
to call snd_soc_dai_set_bclk_ratio().

hdmi-codec then needs to supply an implementation for the
set_bclk_ratio() method in struct snd_soc_dai_ops, just like it
already does for the set_fmt method, and pass the bclk ratio to the
actual HDMI codec.

Something like the below would probably be moving in the right
direction:

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 9483c55f871b..0fca69880dc3 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -42,6 +42,7 @@ struct hdmi_codec_daifmt {
 	unsigned int frame_clk_inv:1;
 	unsigned int bit_clk_master:1;
 	unsigned int frame_clk_master:1;
+	unsigned int bclk_ratio;
 };
 
 /*
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d00734d31e04..f0f08b7a073f 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -524,6 +524,17 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 				       &hcp->daifmt[dai->id], &hp);
 }
 
+static int hdmi_codec_set_bclk_ratio(struct snd_soc_dai *dai,
+				     unsigned int ratio)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+
+	/* FIXME: some validation here would be good? */
+	hcp->daifmt[dai->id].bclk_ratio = ratio;
+
+	return 0;
+}
+
 static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 			      unsigned int fmt)
 {
@@ -593,7 +604,11 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 		}
 	}
 
-	hcp->daifmt[dai->id] = cf;
+	hcp->daifmt[dai->id].fmt = cf.fmt;
+	hcp->daifmt[dai->id].bit_clk_inv = cf.bit_clk_inv;
+	hcp->daifmt[dai->id].frame_clk_inv = cf.frame_clk_inv;
+	hcp->daifmt[dai->id].bit_clk_master = cf.bit_clk_master;
+	hcp->daifmt[dai->id].frame_clk_master = cf.frame_clk_master;
 
 	return ret;
 }
@@ -615,6 +630,7 @@ static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup	= hdmi_codec_startup,
 	.shutdown	= hdmi_codec_shutdown,
 	.hw_params	= hdmi_codec_hw_params,
+	.set_bclk_ratio	= hdmi_codec_set_bclk_ratio,
 	.set_fmt	= hdmi_codec_set_fmt,
 	.digital_mute	= hdmi_codec_digital_mute,
 };
@@ -795,6 +811,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (hcd->spdif)
 		hcp->daidrv[i] = hdmi_spdif_dai;
 
+	hcp->daifmt[DAI_ID_I2S].bclk_ratio = 64;
+
 	ret = devm_snd_soc_register_component(dev, &hdmi_driver, hcp->daidrv,
 				     dai_count);
 	if (ret) {

Then tda998x can look at daifmt->bclk_ratio in
tda998x_audio_hw_params().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
