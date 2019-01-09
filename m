Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB2DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF8721783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GwcYdXst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfAIKw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:52:59 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3912 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbfAIKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:52:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c35d27c0000>; Wed, 09 Jan 2019 02:52:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Jan 2019 02:52:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Jan 2019 02:52:56 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 9 Jan
 2019 10:52:54 +0000
Subject: Re: [PATCH] ASoC: core: Fix deferral of machine drivers
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Matthias Reichl <hias@horus.com>
References: <1546968494-22993-1-git-send-email-jonathanh@nvidia.com>
 <87imyy382r.wl-kuninori.morimoto.gx@renesas.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ea0f24dd-901c-5937-bb0b-b4eba4cbcbcd@nvidia.com>
Date:   Wed, 9 Jan 2019 10:52:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87imyy382r.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547031164; bh=dAmxDhh7Q8FzJXKbAU4ucWRj3zWeVxD8NORT/Z4W3dE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GwcYdXstfxmhAh90suhb8T8+n1ral0naNOuVzdrk2ZNHjgiE+W4PsG9T5GOX9xWUX
         Tey7I6kVzgbN96JKCk+bM7MajXq2MYRhkHjot5KNho6zhw3p7luFj0pGSBJPVjLWUV
         C0DoiFdAlSpYsRcyAB12zKiqBOvGMeUjrkK4iLiGK0IxvKPi6cZSpSS+rW6bLOX6pG
         uhGeARvdIwJngmngutFI9GUMRHEerJAu2+oyVzbbnrc6Unl3ybfK3S/xn8lCBFuHCT
         VN+6q8XaGwiECl8K158jnwMeLSOL9sHuIDMjD9ZASFgBztXW1EUFOOBlZ45L00YmPs
         fRqhi/pwZgbFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/2019 02:09, Kuninori Morimoto wrote:
> 
> Hi Jon
> 
>> Commit daecf46ee0e5 ("ASoC: soc-core: use snd_soc_dai_link_component for
>> platform") added a new member to the snd_soc_dai_link structure for
>> storing a pointer for a platform link component. The pointer for this
>> platform link component was allocated, if not already populated by the
>> machine driver, using devm_kzalloc() such that the memory would be
>> automatically freed on error or removal of the soundcard. However, this
>> introduced a new problem, because if the probing of the soundcard is
>> deferred, then although the memory allocated for the platform link
>> component is freed, if the snd_soc_dai_link structure is declared
>> statically by the machine driver, then the pointer in the DAI link
>> structure will never be clearer. This means that when the soundcard is
>> probed again, memory for the platform link component will not be
>> allocated again because the address of the pointer was not cleared
>> and this causes sound core to access memory that is no longer valid.
>>
>> In most cases this causes the following error condition to be triggered
>> and causes probing the soundcard to fail.
>>
>>  tegra-snd-sgtl5000 sound: ASoC: Both platform name/of_node are set for
>>   sgtl5000
>>
>> Unfortunately, because this platform link component is allocated before
>> the DAI links are added to the soundcard, there is no easy way to clear
>> this pointer on teardown if an error occurs.
>>
>> The pointer for this platform link component was added for future
>> proofing and communalising the structures for storing various data.
>> Although a machine driver maybe used by more than one platform and so
>> this platform data may vary from platform to platform, there is only
>> ever a single instance for a given platform. Therefore, rather than
>> dynamically allocate the platform link component structure, make it a
>> static member of the snd_soc_dai_link to fix the problem.
>>
>> It should be noted that if the platform_name of platform_of_node members
>> of the snd_soc_dai_link structure are populated, these will always be
>> used regardless of if the new platform.name or platform.of_node members
>> are populated.
>>
>> Fixes: daecf46ee0e5 ("ASoC: soc-core: use snd_soc_dai_link_component for platform")
>>
>> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
> 
> Thank you for your patch.
> The reason why it is allocating memory is it is for glue Legacy vs Modern style.
> This means, this allocation style will be removed if ALSA SoC become modern style.
> The missing part so far is CPU.
> Only CPU is not yet supporting snd_soc_dai_link_component style.
> If all CPU/Codec/Platform supports snd_soc_dai_link_component style,
> all driver can switch to it, and then, all will be static style.
> Currently, simple card series is only(?) using this style.
> 
> The reason why platform is using pointer style is that
> someone (not me ;P) will support multi platform style in the future.

Can you elaborate a bit more, I still not not understand what you mean
here by 'support multi-platform style' and why this is needed in the future?

Furthermore, even if the CPU is not supporting the
snd_soc_dai_link_component, I don't understand why this prevents us from
making this change now other than it is not consistent.

Jon

-- 
nvpublic
