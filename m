Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D752171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeLZR5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:57:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:14321 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbeLZR5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:57:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 09:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,401,1539673200"; 
   d="scan'208";a="305182563"
Received: from vle-mobl.amr.corp.intel.com (HELO [10.254.191.139]) ([10.254.191.139])
  by fmsmga006.fm.intel.com with ESMTP; 26 Dec 2018 09:57:47 -0800
Subject: Re: [PATCH] sound: atom: fix a missing check of
 snd_pcm_lib_malloc_pages
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20181226022950.71824-1-kjlu@umn.edu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a684ebcb-7b7a-d5b5-8770-f87db0c5a480@linux.intel.com>
Date:   Wed, 26 Dec 2018 11:57:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181226022950.71824-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/25/18 8:29 PM, Kangjie Lu wrote:
> snd_pcm_lib_malloc_pages() may fail, so let's check its status and
> return its error code upstream.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index afc559866095..91a2436ce952 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -399,7 +399,13 @@ static int sst_media_hw_params(struct snd_pcm_substream *substream,
>   				struct snd_pcm_hw_params *params,
>   				struct snd_soc_dai *dai)
>   {
> -	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
> +	int ret;
> +
> +	ret =
> +		snd_pcm_lib_malloc_pages(substream,
> +				params_buffer_bytes(params));
> +	if (ret)
> +		return ret;
>   	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
>   	return 0;
>   }
