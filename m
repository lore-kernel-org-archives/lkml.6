Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756139AbeDZMu2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:50:28 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35620 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755542AbeDZMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:50:25 -0400
X-Google-Smtp-Source: AB8JxZpGNgkqn2zIUGXOXk/WDm2HK+SIS7S3L1Zp3ERJUgggliWbBmBXu06G2/kRlJycHIm1b6KI/WvwOD+7XShuzks=
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJ0xy-0UByd8UzSUyc9iwgytH7EYE2JPDXFTe-1PFG3+A@mail.gmail.com>
References: <7809a25514e8f7f72a276d19414346b2e4100945.1524570852.git.baolin.wang@linaro.org>
 <201804261703.caDB8Qo5%fengguang.wu@intel.com> <CAMz4kuJ0xy-0UByd8UzSUyc9iwgytH7EYE2JPDXFTe-1PFG3+A@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 Apr 2018 14:50:23 +0200
X-Google-Sender-Auth: hIUfgFkveZAM8AW458x-E4HA2YI
Message-ID: <CAK8P3a3qhR9rWhgewzOWXVLFY2yhp=Nbvj7-ThRrX+i55VGMpA@mail.gmail.com>
Subject: Re: [PATCH 4/8] ALSA: Avoid using timespec for struct snd_pcm_status
To: Baolin Wang <baolin.wang@linaro.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Ingo Molnar <mingo@kernel.org>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com,
        Vinod Koul <vinod.koul@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        subhransu.s.prusty@intel.com, Bhumika Goyal <bhumirks@gmail.com>,
        gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>,
        hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Fabian Frederick <fabf@skynet.be>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:53 PM, Baolin Wang <baolin.wang@linaro.org> wrote:

>>
>>    971
>>    972  static int snd_pcm_status_user32(struct snd_pcm_substream *substream,
>>    973                                   struct snd_pcm_status32 __user * _status,
>>    974                                   bool ext)
>>    975  {
>>    976          struct snd_pcm_status64 status64;
>>    977          struct snd_pcm_status32 status32;
>>    978          int res;
>>    979
>>    980          memset(&status64, 0, sizeof(status64));
>>    981          memset(&status32, 0, sizeof(status32));
>>    982          /*
>>    983           * with extension, parameters are read/write,
>>    984           * get audio_tstamp_data from user,
>>    985           * ignore rest of status structure
>>    986           */
>>    987          if (ext && get_user(status64.audio_tstamp_data,
>>    988                              (u32 __user *)(&_status->audio_tstamp_data)))
>>    989                  return -EFAULT;
>>    990          res = snd_pcm_status64(substream, &status64);
>>    991          if (res < 0)
>>    992                  return res;
>>    993
>>    994          status32 = (struct snd_pcm_status32) {
>>  > 995                  .state = status64.state,
>>    996                  .trigger_tstamp_sec = status64.trigger_tstamp_sec,
>>    997                  .trigger_tstamp_nsec = status64.trigger_tstamp_nsec,
>>    998                  .tstamp_sec = status64.tstamp_sec,
>>    999                  .tstamp_nsec = status64.tstamp_nsec,
>>   1000                  .appl_ptr = status64.appl_ptr,
>>   1001                  .hw_ptr = status64.hw_ptr,
>>   1002                  .delay = status64.delay,
>>   1003                  .avail = status64.avail,
>>   1004                  .avail_max = status64.avail_max,
>>   1005                  .overrange = status64.overrange,
>>> 1006                  .suspended_state = status64.suspended_state,
>
> I am not sure for the warning here, we should change 'snd_pcm_state_t'
> to 's32' for struct snd_pcm_status64?
>
> typedef int __bitwise snd_pcm_state_t;

The problem is that snd_pcm_status32 uses 'u32' here instead of snd_pcm_state_t,
and the __bitwise annotation makes the two types incompatible. This is a
preexisting problem, the warning mail just appeared because you moved that
code to a different file.

If you want to avoid that warning, either use a type case with '__force',
or change the snd_pcm_status32 structure to also use snd_pcm_state_t.

That would be a useful change, but it should be separate from your
other changes since it's an unrelated problem.

      Arnd
