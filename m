Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D3C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8E02087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8E02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJIUrL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:47:11 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:19125 "EHLO
        vie01a-dmta-pe06-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbeJIUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:47:10 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1g9s5S-0004WW-DG
        for linux-kernel@vger.kernel.org; Tue, 09 Oct 2018 15:30:10 +0200
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id lRW01y0174XbgXZ01RW2ov; Tue, 09 Oct 2018 15:30:03 +0200
X-SourceIP: 37.228.204.209
Received: from [192.168.50.181] (apu.aillwee.com [192.168.50.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id 421B54E607;
        Tue,  9 Oct 2018 14:30:00 +0100 (IST)
Subject: Re: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint
 [Resend in plain text...]
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain;
        charset=utf-8
From:   Mike Brady <mikebrady@eircom.net>
In-Reply-To: <s5hworhs559.wl-tiwai@suse.de>
Date:   Tue, 9 Oct 2018 14:18:15 +0100
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <828AF61F-4F6F-44C3-B463-7FE4EB8974F1@eircom.net>
References: <20180904155858.8001-1-tiwai@suse.de>
 <20180904155858.8001-18-tiwai@suse.de>
 <4c5f9aed-8fbe-fe22-0c8d-097d8915805c@i2se.com>
 <s5h4lelu84e.wl-tiwai@suse.de>
 <8866e22a-6cd7-d32d-92e5-9a4e60206d2f@i2se.com>
 <s5hworhs559.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there. Apologies for the delay. The issue here is not the 10ms period constrain -- it’s the possible addition of code to interpolate the playback position between GPU-driven updates. The intention is to give userland a jitter-free view of the playback position.

> On 19 Sep 2018, at 19:39, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Wed, 19 Sep 2018 14:41:28 +0200,
> Stefan Wahren wrote:
>> 
>> Hi,
>> 
>> [add Phil and Mike]
>> 
>> Am 19.09.2018 um 11:52 schrieb Takashi Iwai:
>>> On Wed, 19 Sep 2018 11:42:22 +0200,
>>> Stefan Wahren wrote:
>>>> Hi Takashi,
>>>> 
>>>> Am 04.09.2018 um 17:58 schrieb Takashi Iwai:
>>>>> It seems that the resolution of vc04 callback is in 10 msec; i.e. the
>>>>> minimal period size is also 10 msec.
>>>>> 
>>>>> This patch adds the corresponding hw constraint.
>>>>> 
>>>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>>>> ---
>>>>> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 5 +++++
>>>>> 1 file changed, 5 insertions(+)
>>>>> 
>>>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>>> index 9659c25b9f9d..6d89db6e14e4 100644
>>>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>>> @@ -145,6 +145,11 @@ static int snd_bcm2835_playback_open_generic(
>>>>> 				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>>>>> 				   16);
>>>>> 
>>>>> +	/* position update is in 10ms order */
>>>>> +	snd_pcm_hw_constraint_minmax(runtime,
>>>>> +				     SNDRV_PCM_HW_PARAM_PERIOD_TIME,
>>>>> +				     10 * 1000, UINT_MAX);
>>>>> +
>>>>> 	chip->alsa_stream[idx] = alsa_stream;
>>>>> 
>>>>> 	chip->opened |= (1 << idx);
>>>> in the Foundation Kernel (Downstream) there is a patch to interpolate
>>>> the audio delay. So my questions is, does your patch above makes the
>>>> following patch obsolete?
>>> Through a quick glance, no, my patch is orthogonal to this.
>>> 
>>> My patch adds a PCM hw constraint so that the period size won't go
>>> below 10ms, while the downstream patch provides the additional delay
>>> value that is calculated from the system clock.
>> 
>> thanks for your explanation. So your patch must be reverted with
>> implementation of interpolate audio delay.
> 
> No, no.
> Both can be applied as is.  They have *nothing to do* with each
> other.

Agreed. The patches address different issues.

> [PATCH] bcm2835: interpolate audio delay
>>>> 
>>>> It appears the GPU only sends us a message all 10ms to update
>>>> the playback progress. Other than this, the playback position
>>>> (what SNDRV_PCM_IOCTL_DELAY will return) is not updated at all.
>>>> Userspace will see jitter up to 10ms in the audio position.
>>>> 
>>>> Make this a bit nicer for userspace by interpolating the
>>>> position using the CPU clock.
>>>> 
>>>> I'm not sure if setting snd_pcm_runtime.delay is the right
>>>> approach for this. Or if there is maybe an already existing
>>>> mechanism for position interpolation in the ALSA core.
>>> That's OK, as long as the computation is accurate enough (at least not
>>> exceed the actual position) and is light-weight.
>>> 
>>>> I only set SNDRV_PCM_INFO_BATCH because this appears to remove
>>>> at least one situation snd_pcm_runtime.delay is used, so I have
>>>> to worry less in which place I have to update this field, or
>>>> how it interacts with the rest of ALSA.
>>> Actually, this SNDRV_PCM_INFO_BATCH addition should be a separate
>>> patch.  It has nothing to do with the runtime->delay calculation.
>>> (And, this "one situation" is likely called PulseAudio :)
>>> 
>>>> In the future, it might be nice to use VC_AUDIO_MSG_TYPE_LATENCY.
>>>> One problem is that it requires sending a videocore message, and
>>>> waiting for a reply, which could make the implementation much
>>>> harder due to locking and synchronization requirements.
>>> This can be now easy with my patch series.  By switching to non-atomic
>>> operation, we can issue the vc04 command inside the pointer callback,
>>> too.
>> 
>> I think we should try to implement this later.
>> 
>> @Mike: Do you want to write a patch series which upstream "interpolate
>> audio delay" and addresses Takashi's comments?
>> 
>> I would help you, in case you have questions about setup a Raspberry Pi
>> with Mainline kernel or patch submission.
> 
> Well, the question is who really wants this.  The value given by that
> patch is nothing but some estimation and might be even incorrect.
> 
> PulseAudio won't need it any longer when you set the BATCH flag.
> Then it'll switch from tsched mode to the old mode, and the delay
> value would be almost irrelevant.

Well, two answers. First, Shairport Sync (https://github.com/mikebrady/shairport-sync) needs it — whenever a packet of audio frames is about to be added to the output queue (at approximately 7.9 millisecond intervals), the delay is checked to try to maintain sync to within a few milliseconds. The BCM2835 audio device is the only one I have yet come across with so much jitter. Whatever other drivers do, the delay they report doesn’t suffer from anything like this level of jitter.

The second answer is that the veracity of the ALSA documentation depends on it — any application using the ALSA system for synchronisation will rely on this being an accurate reflection of the situation. AFAIK there is really no workaround it if the application is confined to “safe” ALSA (http://0pointer.de/blog/projects/guide-to-sound-apis).

On LMKL.org, Takashi wrote:

> Date	Wed, 19 Sep 2018 11:52:33 +0200
> From	Takashi Iwai <>
> Subject	Re: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint

> [snip]

> That's OK, as long as the computation is accurate enough (at least not
> exceed the actual position) and is light-weight.

> [snip]

The overhead is small -- an extra ktime_get() every time a GPU message
is sent -- and another call and a few calculations whenever the delay
is sought from userland.

At 48,000 frames per second, i.e. approximately 20 microseconds per frame, it would take a clock inaccuracy of roughly
20 microseconds in 10 milliseconds -- 2,000 parts per million — to result in an inaccurate estimate.
Crystal or resonator-based clocks typically have an inaccuracy of 10s to 100s of parts per million.

Finally, to see the effect of the absence and presence of this interpolation, please have a look at this: https://github.com/raspberrypi/firmware/issues/1026#issuecomment-415746016, where a downstream version of this fix was being discussed.

Best wishes
Mike Brady



