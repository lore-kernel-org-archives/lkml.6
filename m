Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C150420700
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfAKPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:44:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:19251 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731856AbfAKPoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:44:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 07:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="290802073"
Received: from dnorris1-mobl1.amr.corp.intel.com (HELO [10.254.187.45]) ([10.254.187.45])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2019 07:44:04 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
To:     Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, asishb@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org
Cc:     Ajit Pandey <ajitp@codeaurora.org>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
Date:   Fri, 11 Jan 2019 09:44:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/11/19 2:14 AM, Rohit kumar wrote:
> From: Ajit Pandey <ajitp@codeaurora.org>
>
> soc_find_component() may lead to null pointer exception if both
> arguments i.e of_node and name is NULL. Add NULL check before
> calling soc_find_component(). Also fix some typos.

Thanks for the overnight fix. This update fixes the issue on my Skylake 
XPS13 test device (blind testing since I don't understand what the code 
does).

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>
> Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/soc-core.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 0934b36..df05fb8 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1131,11 +1131,13 @@ static int soc_init_dai_link(struct snd_soc_card *card,
>   	}
>   
>   	/*
> -	 * Defer card registartion if platform dai component is not added to
> +	 * Defer card registration if platform dai component is not added to
>   	 * component list.
>   	 */
> -	if (!soc_find_component(link->platform->of_node, link->platform->name))
> -		return -EPROBE_DEFER;
> +	if (link->platform->of_node || link->platform->name)
> +		if (!soc_find_component(link->platform->of_node,
> +					link->platform->name))
> +			return -EPROBE_DEFER;
>   
>   	/*
>   	 * CPU device may be specified by either name or OF node, but
> @@ -1150,11 +1152,12 @@ static int soc_init_dai_link(struct snd_soc_card *card,
>   	}
>   
>   	/*
> -	 * Defer card registartion if cpu dai component is not added to
> +	 * Defer card registration if cpu dai component is not added to
>   	 * component list.
>   	 */
> -	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
> -		return -EPROBE_DEFER;
> +	if (link->cpu_of_node || link->cpu_name)
> +		if (!soc_find_component(link->cpu_of_node, link->cpu_name))
> +			return -EPROBE_DEFER;
>   
>   	/*
>   	 * At least one of CPU DAI name or CPU device name/node must be
