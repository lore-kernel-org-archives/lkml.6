Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDCSPu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:15:50 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36857 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeDCSPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:15:48 -0400
X-Google-Smtp-Source: AIpwx4/HwrjzwGzRiNCDq18Kt6OEc+3ib2WST714rtrxrdMy4qgA9r5DoYIdjBJqFaDxqG6PtKMkgA==
Subject: Re: [alsa-devel] [PATCH v3 0/2] ASoC: topology: Improve parsing
 hw_configs
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
References: <20180327205632.3677-1-k.marinushkin@gmail.com>
 <17f0767a-2dea-92dd-a88e-a3f3e670d0d2@gmail.com>
 <461bbabf-7c36-1361-8f66-5abbe3c7f4d8@linux.intel.com>
 <ee6ba140-fa5c-78e9-47bc-125b1aca7672@gmail.com>
 <260f1850-37f2-fffa-fb33-4b5ff823ba0b@linux.intel.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <21dd211e-2b93-b5af-0606-726432e40795@gmail.com>
Date: Tue, 3 Apr 2018 20:16:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <260f1850-37f2-fffa-fb33-4b5ff823ba0b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/18 19:21, Pierre-Louis Bossart wrote:
>
>
> On 04/03/2018 12:15 AM, Kirill Marinushkin wrote:
>> On 04/03/18 02:57, Pierre-Louis Bossart wrote:
>>>
>>> On 04/02/2018 04:17 PM, Kirill Marinushkin wrote:
>>>> Hello Pierre-Louis,
>>>>
>>>> I explicitly clarified with Takashi: to have this patch series merged, we
>>>> need a
>>>> tag "Reviewed-by" from you.
>>> I am fine with the changes, but maybe while we are at it, we should clarify
>>> what mclk_direction means?
>> That's a good idea to have it solved within this patch series.
>>
>>>      __u8 mclk_direction;    /* 0 for input, 1 for output */
>>>
>>> This is really awful and might benefit for additional clarity using
>>> codec-centric conventions.
>>>
>> I agree that having a clear naming will avoid confusion for future usage.
>> I see from the code, that this variable is ignored. So we have no technical
>> restriction on how to interpret this.
>> I suggest to do similar to what we did for bclk_master:
>>
>> /* DAI mclk_direction */
>> #define SND_SOC_TPLG_MCLK_CO        0 /* for codec, mclk is output */
>> #define SND_SOC_TPLG_MCLK_CI          1 /* for codec, mclk is input */
>>
>>> We also had a discussion internally and can't figure out why the strings are
>>> different from the fields in the structure, I feel it'd be simpler to align
>>> config and code to avoid issues but keep existing notation for backwards
>>> compatibility, e.g.
>>>
>>> if (strcmp(id, "mclk_freq") == 0) || strcmp(id, "mclk_rate") == 0) {
>>>          if (snd_config_get_string(n, &val) < 0)
>>>                  return -EINVAL;
>>>
>>>              hw_cfg->mclk_rate = atoi(val);
>>>              continue;
>>> }
>> I agree with this. I will also do the same (keeping backwards-compatibility)
>> for:
>>
>> "format" => "fmt"
>> "bclk" => "bclk_master"
>> "bclk_freq" => "bclk_rate"
>> "bclk_invert" => "invert_bclk"
>> "fsync" => "fsync_master"
>> "fsync_invert" => "invert_fsync"
>> "fsync_freq" => "fsync_rate"
>> "mclk_freq" => "mclk_rate"
>> "mclk" => "mclk_direction"
>> "pm_gate_clocks" => "clock_gated"
>>
>> If you agree with both proposals, I will add patches to this patch series, and
>> re-send as patch v4.
>> Or can we handle it in a better way?
> A v4 is fine with me.
>
> These topology definitions appear in hindsight quite problematic, there are
> missing definitions and capabilities, e.g we have the ability to 'gate the
> clock' but without knowing which clock, and we have no ability to force the
> mclk/bclk/fsync on (be it on demand from a codec driver or on startup as a
> system requirement). And there is no real extension capability with a protocol
> version. The net effect is that people will have to create custom tokens and
> parsing for things that should be common...
>

Yes, definitions which you mentioned really can become a problem.
But, I see from the header that topology files support versioning:

~~~~
#define SND_SOC_TPLG_ABI_VERSION    0x5    /* current version */
~~~~

So, in future such problems can be solved by incrementing the version, if no
backwards capabilities are available.




Before I continue with the patch v4, I want to clarify with you, so that we
avoid the misunderstanding:

* in the existing 4 patches, I will add a tag
  "Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>"
* in the new 2 patches, which we recently discussed, I will add a tag
  "Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>"

Do you agree with that?

Best Regards,
Kirill

> Thanks
> -Pierre
