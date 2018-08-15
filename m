Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61164C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D6521528
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D6521528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeHOVmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:42:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9227 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeHOVmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:42:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b7475800000>; Wed, 15 Aug 2018 11:48:32 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Aug 2018 11:48:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Aug 2018 11:48:40 -0700
Received: from [10.2.166.219] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 15 Aug
 2018 18:48:48 +0000
Subject: Re: [RFC PATCH] ASoC: core: Optimise suspend/resume of DAPM widgets
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <1533301025-19980-1-git-send-email-jonathanh@nvidia.com>
 <20180803163605.GD6591@sirena.org.uk>
 <7ba86328-5bb6-5280-df6f-9937173fb2ab@nvidia.com>
 <20180814144004.GD5810@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e1bc40ec-de7e-2b77-d7f6-ec6b3066aeec@nvidia.com>
Date:   Wed, 15 Aug 2018 19:48:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814144004.GD5810@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/08/18 15:40, Mark Brown wrote:
> On Mon, Aug 13, 2018 at 07:19:16PM +0100, Jon Hunter wrote:
>>
>> I had taken some ftrace graphs but there was not one thing that really
>> stood out. Looking again it seems that each call to
>> async_schedule_domain() can take tens of uS and so it there are a lot of
>> DAPM widgets (100+) this can take some time. I will dig into it a bit
>> further.
> 
> We don't call that per widget, we call that per context.  We might have
> a lot of contexts but it's definitely not number of widgets level.
> Perhaps what we need there is something which remembers if we actually
> changed anything in each context and/or there's relevant operations and
> then doesn't do this if not, we're working on the basis that these
> operations are fairly cheap.

Yes I see that now. 
 
>>> One thing that it occurs to me might help is to start the suspend
>>> process by powering down all the input and output widgets that aren't
>>> ignoring suspend in one operation, that should hopefully have the effect
>>> of ensuring that most of the system that's going to get powered down
>>> does so on the first pass through.
> 
>> If the async_schedule_domain() calls are the problem, then it may not
>> help as we call that for all dapms apart from the card->dapm.
> 
> No, we actually need to run the operations on all contexts - they can
> all do things if they want to.  We just want them all to run in parallel
> so if we are doing things like waiting for capacitors to charge we don't
> do it in series.

So I did a bit more digging and this time on Tegra124 Jetson-TK1 (which
is supported in the mainline). On Jetson-TK1 I see that
dapm_power_widgets is called 4 times on entering suspend and each call
then calls the dapm_pre/post_sequence_async() functions 3 times.
Interestingly, at least for Jetson-TK1, it appears that the calls to
dapm_pre/post_sequence_async() do not actually change the bias state
because the dapm contexts are already in the desired state. Please
note that at this time audio is not active and so that is probably why.

Anyway, I was interested in the overhead added of calling
async_schedule_domain() to schedule the dapm_pre/post_sequence_async()
function calls if there is nothing to be done. This is what I see ...

Times for function dapm_power_widgets() are (us):
	Min 23, Ave 190, Max 434, Count 39

Where 'Count' is the number of times that dapm_power_widgets() has
been called (both during boot and through a few suspend iterations).

So then I made the following change to avoid scheduling the function
calls unnecessarily (which I think should be fine) ...

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5ed90ea69a24..ff66a6834531 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1955,7 +1955,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
        dapm_pre_sequence_async(&card->dapm, 0);
        /* Run other bias changes in parallel */
        list_for_each_entry(d, &card->dapm_list, list) {
-               if (d != &card->dapm)
+               if (d != &card->dapm && d->bias_level != d->target_bias_level)
                        async_schedule_domain(dapm_pre_sequence_async, d,
                                                &async_domain);
        }
@@ -1979,7 +1979,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 
        /* Run all the bias changes in parallel */
        list_for_each_entry(d, &card->dapm_list, list) {
-               if (d != &card->dapm)
+               if (d != &card->dapm && d->bias_level != d->target_bias_level)
                        async_schedule_domain(dapm_post_sequence_async, d,
                                                &async_domain);
        }

And with the above change I now see ...

Times for function dapm_power_widgets() are (us):
	Min 4, Ave 16, Max 82, Count 39

Please note that I am just using ktime_get() to log the time on entry
and exit from dapm_power_widgets() and so yes the time may not be
purely the time take to execute this function if we are preempted,
but I am measuring in the same way in both cases and so it does seem
to show some improvement.

Let me know your thoughts.

Cheers
Jon

-- 
nvpublic
