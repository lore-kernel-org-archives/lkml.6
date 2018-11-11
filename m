Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB3AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F142148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F142148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeKLD5y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:57:54 -0500
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:19461 "EHLO
        vie01a-dmta-pe08-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729274AbeKLD5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:57:54 -0500
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gLuA3-000560-0q
        for linux-kernel@vger.kernel.org; Sun, 11 Nov 2018 19:08:39 +0100
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id Lu9ugW3DGkosQLuA0gnFqW; Sun, 11 Nov 2018 19:08:38 +0100
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=IkcTkHD0fZMA:10 a=JHtHm7312UAA:10 a=qbuszIz_fLx8hrSXDfwA:9 a=QEXdDO2ut3YA:10
Received: from [192.168.50.181] (apu.aillwee.com [192.168.50.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id E19C34E607;
        Sun, 11 Nov 2018 18:08:29 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
From:   Mike Brady <mikebrady@eircom.net>
In-Reply-To: <s5hsh0dx59n.wl-tiwai@suse.de>
Date:   Sun, 11 Nov 2018 18:08:29 +0000
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, f.fainelli@gmail.com,
        julia.lawall@lip6.fr,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        Kirill Marinushkin <k.marinushkin@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
 <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
 <C35AD288-063F-4197-A758-450CBB3B1184@eircom.net>
 <s5hsh0f1p30.wl-tiwai@suse.de>
 <6AF69E32-029E-478F-9BFA-6262316364A9@eircom.net>
 <s5hsh0dx59n.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.101.1)
X-CMAE-Envelope: MS4wfD0XS3u5tIjktnqG3YDorYrOEvLygECwo38eIkrthi+mBFVqH6ZFEwXkMLL1ZRghBJsBiAnOrTxyYjv0HsWDbXtFav9Vzg3iJn33qjds+HyutOYp8I0y
 5SuxjrGdgSsIRQeCxAOk46g8hJOemjrzkXx98g6G3UxDdfFUJ0H+oQg6jk7isIJ7VKcj3ngsxsg6SAPcI6nGVi/vv+tLwNzpCUs/7glBInMSslV9jgABhy45
 TyZv4o3wMMSb7NwDll2E0rf4EY6u2pyaWkF4+CE2QpyUhPTvJhoOeNVRkTRxFfZT5eXyz0JUh1IHIUsMpS0eybrdyQSlIjpzg8kiAD3IAQIqAWqW21mu3+b6
 HEPyLMAiRSLMOcxswCL3mr6XfJ5tlutCIUnbZl2YvHT4AmBwMv4ZLXW97r/eJ+p0ne5f6MfvfhYBajJXCgn9QrdNvPg22cm+WiOeF3oQvPciwzJr+49CUGu+
 Yh8C+2/aIO/weZo9b2J9MJ51xZQfZu/i2EOmYaaEJbjmDsXm+DfdgXvRDiM8oZRf5YPQU3CfsbMUZERxlGXgzjPcXt7l8FLTQnmfBZhsEi4m9AFLHW6c4f72
 SzJXVK/LXJcTYtjQCcQ/9HCwUqbcjP1r+NtLe4kVtOd7iLh/K3MglrVP6Yu7l5x1o20=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 6 Nov 2018, at 21:31, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Tue, 06 Nov 2018 22:05:11 +0100,
> Mike Brady wrote:
>> 
>> 
>>> On 5 Nov 2018, at 16:11, Takashi Iwai <tiwai@suse.de> wrote:
>>> 
>>> On Mon, 05 Nov 2018 16:57:07 +0100,
>>> Mike Brady wrote:
>>>> 
>>>>> One another thing I'd like to point out is that the value given in the
>>>>> patch is nothing but an estimated position, optimistically calculated
>>>>> via the system timer.  Mike and I had already discussion in another
>>>>> thread, and another possible option would be to provide the proper
>>>>> timestamp-vs-hwptr pair, instead of updating the timestamp always at
>>>>> the status read.
>>>> 
>>>> Agreed — that would give the caller the information needed to do the
>>>> interpolation for themselves if desired.
>>> 
>>> And now I wonder whether the problem is still present with the latest
>>> code.  There was a (kind of) regression in this regard when we
>>> introduced the fine-grained hardware timestamping, but it should have
>>> been addressed by the commit 20e3f985bb875fea4f86b04eba4b6cc29bfd6b71
>>>   ALSA: pcm: update tstamp only if audio_tstamp changed
>>> 
>>> Could you double-check whether the tstamp field gets still updated
>>> even if no hwptr (and delay) is changed?
>> 
>> Yes, this could be a bit problematic. The function update_audio_tstamp in pcm_lib.c could include the interpolated delay in the calculation of audio_tstamp, and hence
>> could trigger the update of tstamp.
> 
> Well, my question is about the current driver as-is.
> It has no runtime->delay, so far, hence audio_tstamp is calculated
> only from the hwptr position.  As the corresponding tstamp gets
> updated only when the audio_tstamp (i.e. hwptr) is updated, the driver
> should provide the consistent pair of audio_tstamp (i.e. hwptr) vs
> tstamp.

Fair enough — I had been thinking about the situation with the patch in place.

>> Another issue, as I see it, is that the the audio_tstamp value would depend on whether, and when, a snd_pcm_delay() call (which recalculates the interpolation and puts it into the delay field) was made immediately prior to it. By zeroing the delay when a GPU interrupt occurs, you could be certain that the interpolated delay would be less than or equal to the true delay, but this doesn’t seem very satisfactory — you have neither the timestamp of the last update nor the correctly interpolated timestamp. 
> 
> No, audio_stamp field is updated at snd_pcm_period_elapsed() call as
> well as tstamp field.

That's great.

> Basically the driver provides three things: hwptr, tstamp and
> audio_tstamp.  For the default configuration (like bcm audio does),
> audio_tstamp is calculated from hwptr, so it can be seen as the hwptr
> represented in timespec.  OTOH, tstamp is the actual system time that
> is updated only when audio_tstamp changes -- which means tstamp gets
> updated *only* at snd_pcm_period_elapsed() call on bcm audio.
> 
> And, my point is that you should be able to interpolate the actual
> position in user-space side based on these information; it doesn't
> have to be done in the kernel at all.

That is true, of course. The problem is that the snd_pcm_delay() call is so inaccurate though.

>> Sadly, therefore, I’m now of the view that this approach to interpolating the delay between GPU interrupts is not really viable. Would that be your view?

> Actually there were some bugs in the past that the tstamp was updated
> at each snd_pcm_status(), but it should have been fixed in the recent
> kernels.  That's why I asked to re-check the current status.

Yes, as far as I can see, that's fixed. 

In further testing, however, I noticed that the audio_frames calculation in update_audio_tstamp() in pcm_lib.c didn't include the delay,
so now it does if the delay field is negative, which it is "naturally" in this case. With that change, the delay reported by snd_pcm_delay() and
calculated as you referred to above are consistent.

So, overall, I am happier that this approach is at least viable. But two issues remain, in my view:
First, is it "a good idea"?
Second, the delay field is now being used as a delay if its positive and an interpolation if it's negative. It works, but would it be better to have an extra "interpolation" field?

I'll post the updated patch shortly.

Thanks,
Mike

