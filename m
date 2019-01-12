Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84523C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526B32084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GzV8/jQ3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QbQylNkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfALGHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 01:07:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfALGHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 01:07:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 84B8E6089D; Sat, 12 Jan 2019 06:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547273240;
        bh=mBw7DLl4jJD0mClvSjX9nQGoB/UmCQJClyXsdkodJ5k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=GzV8/jQ3zw2VWMrbfXDzZ+mGnpp8WlynjP/yCCwnwczJ41HjOv09zfmrIq16IAJwm
         L5PZMg88YTrCOB+zb2kVo9rzYl2Dzxi2JmLj8dwN+7WyLxCcjm33JCGR19iOZL/wFl
         gChKqlvz5fNydQpvsRNDpjBBrlm7nsQekual879s=
Received: from [192.168.100.15] (unknown [183.83.161.15])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89609601B4;
        Sat, 12 Jan 2019 06:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547273239;
        bh=mBw7DLl4jJD0mClvSjX9nQGoB/UmCQJClyXsdkodJ5k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=QbQylNkW0L1r5Ki/GFxB0lcBNA6cr+HILBmTXr445A5qeEd30mWLeqjPEaF1YfOS0
         5eCqaTWOdHZ+dC4iKEWwgQkUBEyZNWXL1MrMv6+KfgjpIztSv7fucUQMUoyvgougxr
         KzHGKcVbFVHS559SnFCarzmodkmANts0VBYnlm6s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89609601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Message-ID: <5C39840A.7040005@codeaurora.org>
Date:   Sat, 12 Jan 2019 11:37:06 +0530
From:   Rohit kumar <rohitkr@codeaurora.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org,
        Ajit Pandey <ajitp@codeaurora.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org> <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com> <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
In-Reply-To: <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 190111-4, 01/11/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/2019 3:19 AM, Pierre-Louis Bossart wrote:
>
>> Thanks for the overnight fix. This update fixes the issue on my 
>> Skylake XPS13 test device (blind testing since I don't understand 
>> what the code does).
>>
>> Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> I need to take this back, this set of changes (initial+fix) causes an 
> error with our HDMI support
>
> [   17.437684] sof-audio sof-audio: created machine bxt-pcm512x
> [   17.585279] bxt-pcm512x bxt-pcm512x: ASoC: failed to init link iDisp1
> [   17.585639] bxt-pcm512x bxt-pcm512x: snd_soc_register_card failed -517
>
> Removing your changes restores the functionality
>
Looks like we should revert generic implementation for defering probe 
and move to call from machine driver as done in v1.
https://lore.kernel.org/patchwork/patch/1027560/
https://lore.kernel.org/patchwork/patch/1027561/

@Mark, Do you have suggestion to refine current patch?
> Adding some traces I can see that the the platform name we use doesn't 
> seem compatible with your logic. All the Intel boards used a constant 
> platform name matching the PCI ID, see e.g. [1], which IIRC is used to 
> bind components. Liam, do you recall in more details if this is really 
> required?
>
> [1] 
> https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/bxt_da7219_max98357a.c#L475
I think if it does not set platform name as 0000:00:0e.0, it should take 
snd-soc-dummy as platform name
and that might fix the issue.
snd-soc-dummy does have component associated with it.
https://elixir.bootlin.com/linux/latest/source/sound/soc/soc-utils.c#L281
>
> [   18.205812] plb: platform name sof-audio
> [   18.206059] plb: cpu_name (null)
> [   18.206234] plb: platform name 0000:00:0e.0
> [   18.206459] plb: returning -EPROBE_DEFER 1
> [   18.206686] bxt-pcm512x bxt-pcm512x: ASoC: failed to init link iDisp1
> [   18.207054] bxt-pcm512x bxt-pcm512x: snd_soc_register_card failed -517
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index cbafbdd02483..ae731212f82b 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1133,11 +1133,15 @@ static int soc_init_dai_link(struct 
> snd_soc_card *card,
>          * Defer card registration if platform dai component is not 
> added to
>          * component list.
>          */
> +       pr_err("plb: platform name %s\n", link->platform->name);
>         if (link->platform->of_node || link->platform->name)
>                 if (!soc_find_component(link->platform->of_node,
> link->platform->name))
> -                       return -EPROBE_DEFER;
> +                 {
> +                         pr_err("plb: returning -EPROBE_DEFER 1\n");
> +                         return -EPROBE_DEFER;
>
> +                 }
>         /*
>          * CPU device may be specified by either name or OF node, but
>          * can be left unspecified, and will be matched based on DAI
> @@ -1154,9 +1158,14 @@ static int soc_init_dai_link(struct 
> snd_soc_card *card,
>          * Defer card registration if cpu dai component is not added to
>          * component list.
>          */
> +       pr_err("plb: cpu_name %s\n", link->cpu_name);
>         if (link->cpu_of_node || link->cpu_name)
>                 if (!soc_find_component(link->cpu_of_node, 
> link->cpu_name))
> -                       return -EPROBE_DEFER;
> +                 {
> +                         pr_err("plb: returning -EPROBE_DEFER 2\n");
> +                         return -EPROBE_DEFER;
> +
> +                 }
>
>         /*
>          * At least one of CPU DAI name or CPU device name/node must be
>

Thanks,
Rohit
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

