Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D703C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515D02133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfAKVtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:49:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:32825 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfAKVtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:49:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 13:49:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="125243462"
Received: from brichar2-mobl.amr.corp.intel.com (HELO [10.251.132.14]) ([10.251.132.14])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2019 13:49:08 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, asishb@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org
Cc:     Ajit Pandey <ajitp@codeaurora.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
Message-ID: <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
Date:   Fri, 11 Jan 2019 15:49:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks for the overnight fix. This update fixes the issue on my 
> Skylake XPS13 test device (blind testing since I don't understand what 
> the code does).
>
> Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I need to take this back, this set of changes (initial+fix) causes an 
error with our HDMI support

[   17.437684] sof-audio sof-audio: created machine bxt-pcm512x
[   17.585279] bxt-pcm512x bxt-pcm512x: ASoC: failed to init link iDisp1
[   17.585639] bxt-pcm512x bxt-pcm512x: snd_soc_register_card failed -517

Removing your changes restores the functionality

Adding some traces I can see that the the platform name we use doesn't 
seem compatible with your logic. All the Intel boards used a constant 
platform name matching the PCI ID, see e.g. [1], which IIRC is used to 
bind components. Liam, do you recall in more details if this is really 
required?

[1] 
https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/bxt_da7219_max98357a.c#L475

[   18.205812] plb: platform name sof-audio
[   18.206059] plb: cpu_name (null)
[   18.206234] plb: platform name 0000:00:0e.0
[   18.206459] plb: returning -EPROBE_DEFER 1
[   18.206686] bxt-pcm512x bxt-pcm512x: ASoC: failed to init link iDisp1
[   18.207054] bxt-pcm512x bxt-pcm512x: snd_soc_register_card failed -517

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cbafbdd02483..ae731212f82b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1133,11 +1133,15 @@ static int soc_init_dai_link(struct snd_soc_card 
*card,
          * Defer card registration if platform dai component is not 
added to
          * component list.
          */
+       pr_err("plb: platform name %s\n", link->platform->name);
         if (link->platform->of_node || link->platform->name)
                 if (!soc_find_component(link->platform->of_node,
link->platform->name))
-                       return -EPROBE_DEFER;
+                 {
+                         pr_err("plb: returning -EPROBE_DEFER 1\n");
+                         return -EPROBE_DEFER;

+                 }
         /*
          * CPU device may be specified by either name or OF node, but
          * can be left unspecified, and will be matched based on DAI
@@ -1154,9 +1158,14 @@ static int soc_init_dai_link(struct snd_soc_card 
*card,
          * Defer card registration if cpu dai component is not added to
          * component list.
          */
+       pr_err("plb: cpu_name %s\n", link->cpu_name);
         if (link->cpu_of_node || link->cpu_name)
                 if (!soc_find_component(link->cpu_of_node, link->cpu_name))
-                       return -EPROBE_DEFER;
+                 {
+                         pr_err("plb: returning -EPROBE_DEFER 2\n");
+                         return -EPROBE_DEFER;
+
+                 }

         /*
          * At least one of CPU DAI name or CPU device name/node must be

