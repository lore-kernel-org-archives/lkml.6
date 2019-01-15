Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42A8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B563920866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbfAOTfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:35:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:22878 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731673AbfAOTfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:35:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 11:35:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; 
   d="scan'208";a="108496456"
Received: from sdjohn-mobl.amr.corp.intel.com (HELO [10.254.105.1]) ([10.254.105.1])
  by orsmga006.jf.intel.com with ESMTP; 15 Jan 2019 11:35:07 -0800
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
Message-ID: <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
Date:   Tue, 15 Jan 2019 13:35:07 -0600
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

Beyond the fact that the platform_name seems to be totally useless, 
additional tests show that the patch ('ASoC: soc-core: defer card probe 
until all component is added to list') adds a new restriction which 
contradicts existing error checks.

None of the Intel machine drivers set the dailink "cpu_name" field but 
use the "cpu_dai_name" field instead. This was perfectly legit as 
documented by the code at the end of soc_init_dai_link()

     /*
      * At least one of CPU DAI name or CPU device name/node must be
      * specified
      */
     if (!link->cpu_dai_name &&
         !(link->cpu_name || link->cpu_of_node)) {
         dev_err(card->dev,
             "ASoC: Neither cpu_dai_name nor cpu_name/of_node are set 
for %s\n",
             link->name);
         return -EINVAL;
     }

The code contributed by Qualcomm only checks for cpu_name, which 
prevents the init from completing.

So if we want to be consistent, the new code should be something like:

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b680c673c553..2791da9417f8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1154,7 +1154,7 @@ static int soc_init_dai_link(struct snd_soc_card 
*card,
          * Defer card registartion if cpu dai component is not added to
          * component list.
          */
-       if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+       if (!link->cpu_dai_name && 
!soc_find_component(link->cpu_of_node, link->cpu_name))
                 return -EPROBE_DEFER;

         /*

or try to call soc_find_component with both cpu_name or cpu_dai_name, if 
this makes sense?
