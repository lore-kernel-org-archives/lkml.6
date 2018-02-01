Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeBAQJh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:09:37 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:46820 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeBAQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:09:36 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: airlied@linux.ie, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180125152117.qikemrwl7f35ssjg@flea.lan>
 <d79602b9-8e04-8250-fd7f-f52b8e16c575@micronovasrl.com>
 <20180126145608.5s6c6ltpvrko7iyv@flea.lan>
 <18ec71dc-a785-a771-76d4-176d95032c97@micronovasrl.com>
 <e3a8682c-7524-ee99-8d4f-c492709e6e49@micronovasrl.com>
 <20180201101411.d23efsjt7jdyi4zh@flea.lan>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <51323c6d-ba50-f09e-fcd7-d9b18d03673a@micronovasrl.com>
Date: Thu, 1 Feb 2018 17:09:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180201101411.d23efsjt7jdyi4zh@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/02/2018 11:14, Maxime Ripard ha scritto:
> On Sat, Jan 27, 2018 at 11:07:09PM +0100, Giulio Benetti wrote:
>>>>>> I don't really know what the polarity of D0 would be just by
>>>>>> judging at that capture, but we would have noticed if the colors
>>>>>> were inverted for quite some time now.
>>>>>
>>>>> D0-D23 are correct.
>>>>>
>>>>> With that capture, I mean to show you instead dclk is inverted, as
>>>>> dclk samples D0 on falling edge.
>>>>
>>>> Ah right, DCLK being the first channel?
>>>
>>> Yes, sorry I didn't place a label on channels
>>>
>>>>
>>>>> So 0 is NEGEDGE and 1 is POSEDGE(1/3 of clock phase).
>>>>> 1/3 clock phase seems enough to me to be considered POSEDGE,
>>>>> 2/3 instead risks to go too much to the right of D0(even if it
>>>>> could work).
>>>>
>>>> Do you have captures with both settings?
>>>
>>> Not now, but asap I'm going to take.
>>
>> Here we are:
>> 1/3 phase: https://pasteboard.co/H4VehON.png
>> 2/3 phase: https://pasteboard.co/H4Veq8a.png
>>
>> Yellow: D0
>> Blue: DCLK
>>
>> As you can see:
>> 1/3 phase has DCLK rising edge almost in the middle of D0
>> 2/3 phase has DCLK rising edge that comes too late
>>
>> I would go for "1/3 phase" for Rising edge and "normal phase" for
>> Falling edge.
>>
>> What do you think?
> 
> It seems fair. This need a whole lot of comments though :)

Yes, then, do I proceed resubmitting both corrected patches with 
corrected commit logs?

> 
>>>> That it's going to be a nightmare... We've advertised since the very
>>>> beginning something, and we're about to break it. I'm not sure we want
>>>> to do that.
>>>
>>> I can take care about that.
>>> But I also think that a lot of displays work because they use only
>>> DE-mode, almost ignoring HSync and VSync signals(HV-mode).
>>>
>>> In any case I have to produce these patches because of my company's
>>> board based on A20 and A33, and modify defconfig according to it.
>>> The only technical nightmare I see is to produce a commit for every
>>> defconfig to be modified and copy-paste che commit-log substituing board
>>> name(1-2 days of work).
>>> Problem is testing, but we're speaking about something that probably was
>>> badly working, but you couldn't see it on display.
>>> So I think this is only an improvement at the end.
>>>
>>> I'm sorry I've taken bad news.
>>> Drink 1 glass of Spritz to go over! :)
>>
>> IMHO I think that we have only to take care about displays that don't have
>> DE signal.
>>
>> If DE signal exists, then displays are driven through DE only for back and
>> front porch as I know, and on most displays I've used, Hsync and VSync are
>> ignored.
>> DE is used not only for Data Enable, but also for sync the very beginning of
>> frame, the rest of syncing is done by pause between every line sent.
>> This is should be why nobody noticed it before,
>> I think almost every display is used in DE mode only.
>> So, if we fix bug for HSync and VSync, risk should be very low.
>> Indeed, everybody or almost, use sync:3 because display ignore those 2
>> signals (HSync and VSYnc) in favour of DE.
>> And I don't know how many people checked with oscilloscope signals after
>> getting display working in a few.
> 
> I know I did, but I apparently didn't pay attention to that and was
> more focused on getting the timings right :)
> 
> But clearly this is a separate discussion that needs to be held on the
> U-Boot ML.

Ok, so I'd create a patch regarding HSync and VSync polarity and send it 
to uboot ML.

> 
> Maxime
> 


-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
