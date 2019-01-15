Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0968BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBF220659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfAODLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:11:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:5767 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAODLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:11:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 19:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="114721324"
Received: from unknown (HELO [10.254.5.67]) ([10.254.5.67])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jan 2019 19:08:16 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
To:     Mark Brown <broonie@kernel.org>
Cc:     rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, Ajit Pandey <ajitp@codeaurora.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        srinivas.kandagatla@linaro.org
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <163e0e01-fcf9-6f9f-4317-e71bd9cb47b1@linux.intel.com>
Date:   Mon, 14 Jan 2019 21:08:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115000610.GM11073@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/19 6:06 PM, Mark Brown wrote:
> On Fri, Jan 11, 2019 at 03:49:08PM -0600, Pierre-Louis Bossart wrote:
>
>> Adding some traces I can see that the the platform name we use doesn't seem
>> compatible with your logic. All the Intel boards used a constant platform
>> name matching the PCI ID, see e.g. [1], which IIRC is used to bind
>> components. Liam, do you recall in more details if this is really required?
> That's telling me that either snd_soc_find_components() isn't finding
> components in the same way that we do when we bind things which isn't
> good or we're binding links without having fully matched everything on
> the link which also isn't good.
>
> Without a system that shows the issue I can't 100% confirm but I think
> it's the former - I'm fairly sure that those machines are relying on the
> component name being initialized to fmt_single_name() in
> snd_soc_component_initialize().  That is supposed to wind up using
> dev_name() (which would be the PCI address for a PCI device) as the
> basis of the name.  What I can't currently see is how exactly that gets
> bound (or how any of the other links avoid trouble for that matter).  We
> could revert and push this into cards but I would rather be confident
> that we understand what's going on, I'm not comfortable that we aren't
> just pushing the breakage around rather than fixing it.  Can someone
> with an x86 system take a look and confirm exactly what's going on with
> binding these cards please?

I am actually not sure at all why we need the platform_name to be set in 
Intel machine drivers.

I ran a 5mn experiment with SOF and we completely ignore what is set by 
machine drivers, it's overridden by the component name:

             dev_info(card->dev, "info: override FE DAI link %s\n",
                  card->dai_link[i].name);

             /* override platform component */
             if (snd_soc_init_platform(card, dai_link) < 0) {
                 dev_err(card->dev, "init platform error");
                 continue;
             }
             pr_err("plb: platform_name was %s, now %s\n",
                    dai_link->platform->name,
                    component->name);

             dai_link->platform->name = component->name;

existing machine driver (info is incorrect btw, should be BE DAI link)

[   36.628466] bxt-pcm512x bxt-pcm512x: info: override FE DAI link 
SSP5-Codec
[   36.628469] plb: platform_name was sof-audio, now sof-audio
[   36.628772] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDisp1
[   36.628773] plb: platform_name was 0000:00:0e.0, now sof-audio
[   36.629111] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDisp2
[   36.629112] plb: platform_name was 0000:00:0e.0, now sof-audio
[   36.629422] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDisp3
[   36.629423] plb: platform_name was 0000:00:0e.0, now sof-audio

machine driver with all platform_name commented out, no regression at all.

[   15.839652] sof-audio sof-audio: created machine bxt-pcm512x
[   15.846990] bxt-pcm512x bxt-pcm512x: info: override FE DAI link 
SSP5-Codec
[   15.846995] plb: platform_name was snd-soc-dummy, now sof-audio
[   15.847325] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDisp1
[   15.847326] plb: platform_name was snd-soc-dummy, now sof-audio
[   15.847657] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDisp2
[   15.847658] plb: platform_name was snd-soc-dummy, now sof-audio
[   15.847974] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDisp3
[   15.847974] plb: platform_name was snd-soc-dummy, now sof-audio

I checked for a bit longer with the Skylake driver, I also couldn't see 
a difference with or without the platform_name set.

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3ec977a..0fdf99ec17cd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -918,7 +918,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
                 if (!snd_soc_is_matching_component(dai_link->platform,
                                                    component))
                         continue;
-
+               pr_err("plb: binding with component_name %s \n", 
component->name);
                 snd_soc_rtdcom_add(rtd, component);
         }

@@ -1041,6 +1041,8 @@ static int snd_soc_init_platform(struct 
snd_soc_card *card,
                 if (!platform)
                         return -ENOMEM;

+               pr_err("plb: %s: plaform->name set to %s\n", __func__,
+                      dai_link->platform_name);
                 dai_link->platform      = platform;
                 platform->name          = dai_link->platform_name;
                 platform->of_node       = dai_link->platform_of_node;

[    1.345143] plb: snd_soc_init_platform: plaform->name set to 0000:00:1f.3
[    1.345148] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding 
CNL Audio
[    1.345151] plb: binding with component_name 0000:00:1f.3
[    1.345153] plb: snd_soc_init_platform: plaform->name set to 0000:00:1f.3
[    1.345154] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding 
CNL HDMI1
[    1.345155] plb: binding with component_name 0000:00:1f.3
[    1.345157] plb: snd_soc_init_platform: plaform->name set to 0000:00:1f.3
[    1.345158] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding 
CNL HDMI2
[    1.345159] plb: binding with component_name 0000:00:1f.3
[    1.345161] plb: snd_soc_init_platform: plaform->name set to 0000:00:1f.3
[    1.345162] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding 
CNL HDMI3
[    1.345163] plb: binding with component_name 0000:00:1f.3

[    1.349607] plb: snd_soc_init_platform: plaform->name set to (null)
[    1.349613] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding 
CNL Audio
[    1.349617] plb: binding with component_name snd-soc-dummy
[    1.349619] plb: binding with component_name snd-soc-dummy
[    1.349621] plb: snd_soc_init_platform: plaform->name set to (null)
[    1.349623] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding 
CNL HDMI1
[    1.349625] plb: binding with component_name snd-soc-dummy
[    1.349626] plb: binding with component_name snd-soc-dummy
[    1.349628] plb: snd_soc_init_platform: plaform->name set to (null)
[    1.349631] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding 
CNL HDMI2
[    1.349632] plb: binding with component_name snd-soc-dummy
[    1.349633] plb: binding with component_name snd-soc-dummy
[    1.349635] plb: snd_soc_init_platform: plaform->name set to (null)
[    1.349638] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding 
CNL HDMI3
[    1.349639] plb: binding with component_name snd-soc-dummy
[    1.349641] plb: binding with component_name snd-soc-dummy

Audio playback works in both cases.

The funny thing is that the list of components is right in 
/sys/kernel/debug/asoc.

My guess is that the required PCI component is already added when the 
platform_name is used in soc_bind_dai_link() and snd_soc_rtdcom_add() 
does nothing for the back-end, so the dailink platform_name has actually 
zero influence on the outcome.

Another way to look at it is that we already provide the 
dai_link->cpu_dai_name which is enough for soc_bind_dai_link() to find 
the relevant component and as a result the dailink->platform_name seems 
redundant/unnecessary. I am using the conditional here since this part 
of the code (Intel driver included) seems to work by accident rather 
than by design, and we'd need a set of additional tests before removing 
these hard-coded initializations.

Does this help?
