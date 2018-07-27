Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B46C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAD220894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAD220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbeG0MFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:05:43 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52402 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbeG0MFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:05:43 -0400
Received: from [148.252.241.226] (helo=[10.35.4.103])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fj0EN-0004Ke-Ca; Fri, 27 Jul 2018 11:44:19 +0100
Subject: Re: [alsa-devel] [PATCH 0/4] usb-audio: Add UAC3 Power Domains
To:     Takashi Iwai <tiwai@suse.com>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <s5hlga78mmp.wl-tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
From:   Jorge <jorge.sanjuan@codethink.co.uk>
Message-ID: <59bd0814-e41e-667d-62d1-78194e7a8127@codethink.co.uk>
Date:   Fri, 27 Jul 2018 11:44:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5hlga78mmp.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/18 12:56, Takashi Iwai wrote:
> On Thu, 19 Jul 2018 13:22:11 +0200,
> Jorge Sanjuan wrote:
>>
>> This patchset add support for UAC3 Power Domains. This feature
>> of the USB audio class 3 allows the host to notify the device
>> what it is making use of so power comsumption can be optimized.
>>
>> This proposal implements this feature for Power Domains
>> that include an Input/Output Terminal associated to an
>> audio Streaming interface. This is the main usage of this
>> feature according to the spec. For that reason, the logic
>> for the Power Domain state change has been implemented
>> within the ALSA PCMs logic and the suspend/resume callbacks
>> of the usb_driver. The behaviour would be as follows:
>>
>> * Power Domain State D0: A Power Domain will reach this state
>>    only when the audio substream associated to that domain is
>>    being used (i,e. Audio playback/capture is happening).
>> * Power Domain State D1: This is the Idle state where the driver
>>    is going to always want to be in order to reduce power
>>    consumption.
>> * Power Domain State D2: This state is only set when the usb driver
>>    asumes the device is not going to be used anymore and hence, it
>>    wont care about getting any interrupts from the device. This
>>    will only happen when power level is set to "auto" in sysfs
>>    so the usb driver gets suspended when the interfaces are not in use.
>>   
>> NOTE: The way this has been implemented will always try to put the
>> Power Domain in state D1 if the Power Domain exists so there is not a
>> way a user could disable this feature. It may be worth getting a control
>> exposed to userland that enables/disables this feature (?).
> 
> Can it be tied with runtime PM?
> 
> Need to read through your patchset at first...
> 
> 
> thanks,
> 
> Takashi

Hi,

I just realized I accidentally only replied to alsa-devel.. Sorry about 
that.

I think it should be possible to tie up the D1 state changes (low power 
but still interrupt capable) to runtime PM. Changes to D2 are already 
tied to PM in this patchset. Just need to find the way to cleanly access 
`dev->power.runtime_auto` before the driver attempts to set D1 state. We 
could also let the driver only do D2<->D0 changes for now.

I got some kbuild errors due to missing include. Should I re-send this 
patchset or try to go around getting it tied up to runtime PM first?

Regards,

Jorge

> 
> 
>> Power Domains affecting other units independently are required to be
>> bypassed via a Selector Unit first before the host can change the
>> power state. This sceneario is not covered in this patchset.
>>
>> based on next-20180719
>>
>> Jorge Sanjuan (4):
>>    ALSA: usb-audio: Initial Power Domain support
>>    ALSA: usb-audio: AudioStreaming Power Domain parsing
>>    ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks
>>    ALSA: usb-audio: Add UAC3 Power Domains to suspend/resume
>>
>>   include/linux/usb/audio-v3.h |   4 ++
>>   sound/usb/Makefile           |   1 +
>>   sound/usb/card.c             |   9 ++++
>>   sound/usb/card.h             |   2 +
>>   sound/usb/pcm.c              |  64 +++++++++++++++++++++--
>>   sound/usb/pcm.h              |   2 +
>>   sound/usb/power.c            | 117 +++++++++++++++++++++++++++++++++++++++++++
>>   sound/usb/power.h            |  19 +++++++
>>   sound/usb/stream.c           |  70 +++++++++++++++++++++++---
>>   9 files changed, 277 insertions(+), 11 deletions(-)
>>   create mode 100644 sound/usb/power.c
>>
>> -- 
>> 2.11.0
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


