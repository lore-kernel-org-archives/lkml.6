Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3261AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ADB208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ADB208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbeG0Qba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:31:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:7391 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbeG0Qba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:31:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 08:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,409,1526367600"; 
   d="scan'208";a="75087217"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2018 08:09:10 -0700
Received: from stedia-mobl.amr.corp.intel.com (unknown [10.254.75.253])
        by linux.intel.com (Postfix) with ESMTP id 0E1AC58037D;
        Fri, 27 Jul 2018 08:09:08 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
Date:   Fri, 27 Jul 2018 10:09:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/18 5:13 AM, Akshu Agrawal wrote:
> There are cases where a pointer function populates
> runtime->delay, such as:
> ./sound/pci/hda/hda_controller.c
> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c
> 
> Also, in some cases cpu dai used is generic and the pcm
> driver needs to set delay.
> 
> This delay was getting lost and was overwritten by delays
> from codec or cpu dai delay function if exposed.

Humm, yes the runtime->delay set in the .pointer function would be lost 
without this change, but the delay would still be provided in the 
followup call to .delay.
With your change, the same delay will be accounted for twice?

> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>   sound/soc/soc-pcm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 98be04b..b1a2bc2 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>   	snd_pcm_sframes_t codec_delay = 0;
>   	int i;
>   
> +	/* clearing the previous delay */
> +	runtime->delay = 0;
> +
>   	for_each_rtdcom(rtd, rtdcom) {
>   		component = rtdcom->component;
>   
> @@ -1203,7 +1206,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>   	}
>   	delay += codec_delay;
>   
> -	runtime->delay = delay;
> +	runtime->delay += delay;
>   
>   	return offset;
>   }
> 

