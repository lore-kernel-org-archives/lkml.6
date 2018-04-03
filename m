Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754466AbeDCFPD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 01:15:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51030 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbeDCFPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 01:15:02 -0400
X-Google-Smtp-Source: AIpwx49nmbDJRKgp4A9ySqVN9giKRe/A9ZYCdOGd2NeWwPtT82oGdVNzEWBOQLlHuurGpAx1v0ynpg==
Subject: Re: [PATCH v3 0/2] ASoC: topology: Improve parsing hw_configs
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>, Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180327205632.3677-1-k.marinushkin@gmail.com>
 <17f0767a-2dea-92dd-a88e-a3f3e670d0d2@gmail.com>
 <461bbabf-7c36-1361-8f66-5abbe3c7f4d8@linux.intel.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <ee6ba140-fa5c-78e9-47bc-125b1aca7672@gmail.com>
Date: Tue, 3 Apr 2018 07:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <461bbabf-7c36-1361-8f66-5abbe3c7f4d8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/18 02:57, Pierre-Louis Bossart wrote:
>
>
> On 04/02/2018 04:17 PM, Kirill Marinushkin wrote:
>> Hello Pierre-Louis,
>>
>> I explicitly clarified with Takashi: to have this patch series merged, we need a
>> tag "Reviewed-by" from you.
> I am fine with the changes, but maybe while we are at it, we should clarify
> what mclk_direction means?

That's a good idea to have it solved within this patch series.

>
>     __u8 mclk_direction;    /* 0 for input, 1 for output */
>
> This is really awful and might benefit for additional clarity using
> codec-centric conventions.
>

I agree that having a clear naming will avoid confusion for future usage.
I see from the code, that this variable is ignored. So we have no technical
restriction on how to interpret this.
I suggest to do similar to what we did for bclk_master:

/* DAI mclk_direction */
#define SND_SOC_TPLG_MCLK_CO        0 /* for codec, mclk is output */
#define SND_SOC_TPLG_MCLK_CI          1 /* for codec, mclk is input */

> We also had a discussion internally and can't figure out why the strings are
> different from the fields in the structure, I feel it'd be simpler to align
> config and code to avoid issues but keep existing notation for backwards
> compatibility, e.g.
>
> if (strcmp(id, "mclk_freq") == 0) || strcmp(id, "mclk_rate") == 0) {
>         if (snd_config_get_string(n, &val) < 0)
>                 return -EINVAL;
>
>             hw_cfg->mclk_rate = atoi(val);
>             continue;
> }

I agree with this. I will also do the same (keeping backwards-compatibility) for:

"format" => "fmt"
"bclk" => "bclk_master"
"bclk_freq" => "bclk_rate"
"bclk_invert" => "invert_bclk"
"fsync" => "fsync_master"
"fsync_invert" => "invert_fsync"
"fsync_freq" => "fsync_rate"
"mclk_freq" => "mclk_rate"
"mclk" => "mclk_direction"
"pm_gate_clocks" => "clock_gated"

If you agree with both proposals, I will add patches to this patch series, and
re-send as patch v4.
Or can we handle it in a better way?

>>
>> Patches [2] and [5]:
>> You already tested them. May I put a tag "Reviewed-by" with your name into them?
>>
>> Patches [3] and [6]:
>> Those are new for you; I added them to this patch series, because they are
>> logically similar to [2] and [5].
>> Could you please review these patches?
>>
>> Best Regards,
>> Kirill
>>
>> [1] [PATCH v3 0/2] ASoC: topology: Improve parsing hw_configs
>> [2] [PATCH v3 1/2] ASoC: topology: Fix bclk and fsync inversion in
>> set_link_hw_format()
>> [3] [PATCH v3 2/2] ASoC: topology: Add missing clock gating parameter when
>> parsing hw_configs
>> [4] [PATCH, alsa-lib, v3 0/2] alsa-lib: ASoC: topology: Improve parsing
>> hw_configs
>> [5] [PATCH, alsa-lib, v3 1/2] ASoC: topology: Fix bclk and fsync inversion in
>> set_link_hw_format()
>> [6] [PATCH, alsa-lib, v3 2/2] ASoC: topology: Add missing clock gating
>> parameter when parsing hw_configs
>>
>>
>> On 03/27/18 22:56, Kirill Marinushkin wrote:
>>> Hello Jaroslav, Takashi, Mark,
>>>
>>> This patch series is a resend of [1] and [2], rebased on top of the latest
>>> head. It was logical to resend them together.
>>>
>>> It includes 2 patches for linux + 2 patches for alsa-lib.
>>>
>>> Please have a look.
>>>
>>> Best Regards,
>>> Kirill
>>>
>>> [1] https://patchwork.kernel.org/patch/10250485/
>>> [2] https://patchwork.kernel.org/patch/10230611/
>>>
>>> Kirill Marinushkin (2):
>>>    ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
>>>    ASoC: topology: Add missing clock gating parameter when parsing
>>>      hw_configs
>>>
>>>   include/uapi/sound/asoc.h | 23 ++++++++++++++++++++---
>>>   sound/soc/soc-topology.c  | 19 ++++++++++++++-----
>>>   2 files changed, 34 insertions(+), 8 deletions(-)
>>>
>
