Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D63ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8DA2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8DA2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbeISSXy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:23:54 -0400
Received: from vie01a-dmta-pe05-2.mx.upcmail.net ([84.116.36.12]:13238 "EHLO
        vie01a-dmta-pe05-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731235AbeISSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:23:54 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1g2brn-0000bT-Jg
        for linux-kernel@vger.kernel.org; Wed, 19 Sep 2018 14:46:03 +0200
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id dQlw1y01E4XbgXZ01QlznR; Wed, 19 Sep 2018 14:46:00 +0200
X-SourceIP: 37.228.204.209
Received: from [192.168.2.4] (brady.scss.tcd.ie [134.226.35.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id 789014E607;
        Wed, 19 Sep 2018 13:45:56 +0100 (IST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint
From:   Mike Brady <mikebrady@eircom.net>
In-Reply-To: <8866e22a-6cd7-d32d-92e5-9a4e60206d2f@i2se.com>
Date:   Wed, 19 Sep 2018 13:47:46 +0100
Cc:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <77C9E357-8B01-4CF1-ADA2-899D3E4D2085@eircom.net>
References: <20180904155858.8001-1-tiwai@suse.de>
 <20180904155858.8001-18-tiwai@suse.de>
 <4c5f9aed-8fbe-fe22-0c8d-097d8915805c@i2se.com>
 <s5h4lelu84e.wl-tiwai@suse.de>
 <8866e22a-6cd7-d32d-92e5-9a4e60206d2f@i2se.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan. Thanks for this.

> On 19 Sep 2018, at 13:41, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi,
> 
> [add Phil and Mike]
> 
> Am 19.09.2018 um 11:52 schrieb Takashi Iwai:
>> On Wed, 19 Sep 2018 11:42:22 +0200,
>> Stefan Wahren wrote:
>>> Hi Takashi,
>>> 
>>> Am 04.09.2018 um 17:58 schrieb Takashi Iwai:
>>>> It seems that the resolution of vc04 callback is in 10 msec; i.e. the
>>>> minimal period size is also 10 msec.
>>>> 
>>>> This patch adds the corresponding hw constraint.
>>>> 
>>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>>> ---
>>>> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 5 +++++
>>>> 1 file changed, 5 insertions(+)
>>>> 
>>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>> index 9659c25b9f9d..6d89db6e14e4 100644
>>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>>> @@ -145,6 +145,11 @@ static int snd_bcm2835_playback_open_generic(
>>>> 				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>>>> 				   16);
>>>> 
>>>> +	/* position update is in 10ms order */
>>>> +	snd_pcm_hw_constraint_minmax(runtime,
>>>> +				     SNDRV_PCM_HW_PARAM_PERIOD_TIME,
>>>> +				     10 * 1000, UINT_MAX);
>>>> +
>>>> 	chip->alsa_stream[idx] = alsa_stream;
>>>> 
>>>> 	chip->opened |= (1 << idx);
>>> in the Foundation Kernel (Downstream) there is a patch to interpolate
>>> the audio delay. So my questions is, does your patch above makes the
>>> following patch obsolete?
>> Through a quick glance, no, my patch is orthogonal to this.
>> 
>> My patch adds a PCM hw constraint so that the period size won't go
>> below 10ms, while the downstream patch provides the additional delay
>> value that is calculated from the system clock.
> 
> thanks for your explanation. So your patch must be reverted with
> implementation of interpolate audio delay.
> 
>> 
>>> [PATCH] bcm2835: interpolate audio delay
>>> 
>>> It appears the GPU only sends us a message all 10ms to update
>>> the playback progress. Other than this, the playback position
>>> (what SNDRV_PCM_IOCTL_DELAY will return) is not updated at all.
>>> Userspace will see jitter up to 10ms in the audio position.
>>> 
>>> Make this a bit nicer for userspace by interpolating the
>>> position using the CPU clock.
>>> 
>>> I'm not sure if setting snd_pcm_runtime.delay is the right
>>> approach for this. Or if there is maybe an already existing
>>> mechanism for position interpolation in the ALSA core.
>> That's OK, as long as the computation is accurate enough (at least not
>> exceed the actual position) and is light-weight.
>> 
>>> I only set SNDRV_PCM_INFO_BATCH because this appears to remove
>>> at least one situation snd_pcm_runtime.delay is used, so I have
>>> to worry less in which place I have to update this field, or
>>> how it interacts with the rest of ALSA.
>> Actually, this SNDRV_PCM_INFO_BATCH addition should be a separate
>> patch.  It has nothing to do with the runtime->delay calculation.
>> (And, this "one situation" is likely called PulseAudio :)
>> 
>>> In the future, it might be nice to use VC_AUDIO_MSG_TYPE_LATENCY.
>>> One problem is that it requires sending a videocore message, and
>>> waiting for a reply, which could make the implementation much
>>> harder due to locking and synchronization requirements.
>> This can be now easy with my patch series.  By switching to non-atomic
>> operation, we can issue the vc04 command inside the pointer callback,
>> too.
> 
> I think we should try to implement this later.
> 
> @Mike: Do you want to write a patch series which upstream "interpolate
> audio delay" and addresses Takashi's comments?
> 
> I would help you, in case you have questions about setup a Raspberry Pi
> with Mainline kernel or patch submission.

Yeah, sure. I might need some of the handholding alright. Can you point me at any documentation please?
Regards
Mike

> 
> Regards
> Stefan
> 
>> 
>> 
>> thanks,
>> 
>> Takashi
> 
> 

