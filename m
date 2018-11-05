Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE2CC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD7C2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD7C2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbeKFCWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:22:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:13575 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387458AbeKFCWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:22:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 09:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="93821049"
Received: from patelp1x-mobl3.amr.corp.intel.com (HELO [10.252.130.246]) ([10.252.130.246])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Nov 2018 09:01:39 -0800
Subject: Re: [alsa-devel] [PATCH] fix the kernel panic due to wrong use the
 dev memory API
To:     "He, Bo" <bo.he@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>,
        "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Kesapragada, Pardha Saradhi" <pardha.saradhi.kesapragada@intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "guruprasadx.pawse@intel.com" <guruprasadx.pawse@intel.com>,
        "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>,
        "Prakash, Divya1" <divya1.prakash@intel.com>,
        "Diwakar, Praveen" <praveen.diwakar@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f2e3ffeb-12bd-d60e-e96a-8fa00a17844f@linux.intel.com>
Date:   Mon, 5 Nov 2018 11:01:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/5/18 2:29 AM, He, Bo wrote:
> skl->dais is allocated with devm_kcalloc, can't free with
> the krealloc. Memory allocated with devm API is automatically freed
> on driver detach, Like all other devres resources.
>
> Refer to drivers/base/devres.c devm_kmalloc for more details.

What code are you looking at?

I see this in the Mark's tree

int skl_platform_register(struct device *dev)
{
     int ret;
     struct snd_soc_dai_driver *dais;
     int num_dais = ARRAY_SIZE(skl_platform_dai);
     struct hdac_bus *bus = dev_get_drvdata(dev);
     struct skl *skl = bus_to_skl(bus);

     INIT_LIST_HEAD(&skl->ppl_list);
     INIT_LIST_HEAD(&skl->bind_list);

     skl->dais = kmemdup(skl_platform_dai, sizeof(skl_platform_dai),
                 GFP_KERNEL);
     if (!skl->dais) {
         ret = -ENOMEM;
         goto err;
     }

     if (!skl->use_tplg_pcm) {
         dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
                 sizeof(skl_platform_dai), GFP_KERNEL);


No trace of devm as you mention it? I checked the Chrome tree as well 
and it's not there.

What am I missing?


>
> Signed-off-by: he, bo <bo.he@intel.com>
> ---
>   sound/soc/intel/skylake/skl-pcm.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index 823e391..928d314 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -1438,7 +1438,8 @@ int skl_platform_register(struct device *dev)
>   	}
>   
>   	if (!skl->use_tplg_pcm) {
> -		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
> +		devm_kfree(dev, skl->dais);
> +		dais = devm_kcalloc(dev, skl->dais, sizeof(skl_fe_dai) +
>   				sizeof(skl_platform_dai), GFP_KERNEL);
>   		if (!dais) {
>   			ret = -ENOMEM;
> @@ -1472,7 +1473,5 @@ int skl_platform_unregister(struct device *dev)
>   		}
>   	}
>   
> -	kfree(skl->dais);
> -
>   	return 0;
>   }
