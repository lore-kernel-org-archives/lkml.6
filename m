Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D64BCC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3D1208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3D1208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934211AbeFKSTJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:19:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43264 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933452AbeFKSTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:19:07 -0400
Received: from marcel-macpro.fritz.box (p5B3D24B5.dip0.t-ipconnect.de [91.61.36.181])
        by mail.holtmann.org (Postfix) with ESMTPSA id CD0B7CF18A;
        Mon, 11 Jun 2018 20:25:47 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL_JsqL2StWgA9gkL9i3o85-C3TNixBLmbTXzFQW8bts4phJqQ@mail.gmail.com>
Date:   Mon, 11 Jun 2018 20:19:04 +0200
Cc:     =?utf-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Artiom Vaskov <velemas@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D56466C0-2312-4F0E-AB00-66EF4BEECB1A@holtmann.org>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com>
 <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
 <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
 <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
 <4F0D6729-AE77-47D4-9765-FBC44181D4DE@holtmann.org>
 <CAL_JsqL2StWgA9gkL9i3o85-C3TNixBLmbTXzFQW8bts4phJqQ@mail.gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>>>>>> Added support to automatically configure the SCO packet routing at the
>>>>>> device setup. The SCO packets are used with the HSP / HFP profiles, but in
>>>>>> some devices (ex. CYW43438) they are routed to a PCM output by default. This
>>>>>> change allows sending the vendor specific HCI command to configure the SCO
>>>>>> routing. The parameters of the command are loaded from the device tree.
>>>>> 
>>>>> Please wrap your commit msg.
>>>> 
>>>> 
>>>> Sure.
>>>>> 
>>>>> 
>>>>>> 
>>>>>> Signed-off-by: Attila Tőkés <attitokes@gmail.com>
>>>>>> ---
>>>>>> .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>>>>> 
>>>>> Please split bindings to separate patch.
>>>> 
>>>> 
>>>> Ok, I will split this in two.
>>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>>> drivers/bluetooth/hci_bcm.c                   | 72 +++++++++++++++++++
>>>>>> 2 files changed, 79 insertions(+)
>>>>>> 
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>> index 4194ff7e..aea3a094 100644
>>>>>> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>> @@ -21,6 +21,12 @@ Optional properties:
>>>>>> - clocks: clock specifier if external clock provided to the controller
>>>>>> - clock-names: should be "extclk"
>>>>>> 
>>>>>> + SCO routing parameters:
>>>>>> + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
>>>>>> + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
>>>>>> + - pcm-frame-type: 0 (short), 1 (long)
>>>>>> + - pcm-sync-mode: 0 (slave), 1 (master)
>>>>>> + - pcm-clock-mode: 0 (slave), 1 (master)
>>>>> 
>>>>> Are these Broadcom specific? Properties need either vendor prefix or
>>>>> to be documented in a common location. I think these look like the
>>>>> latter.
>>>> 
>>>> 
>>>> These will be used as parameters of a vendor specific (Broadcom/Cypress)
>>>> command configuring the SCO packet routing. See the Write_SCO_PCM_Int_Param
>>>> command from: http://www.cypress.com/file/298311/download.
>>> 
>>> The DT should just describe how the h/w is hooked-up. What the s/w has
>>> to do based on that is the driver's problem which is certainly
>>> vendor/chip specific, but that is all irrelevant to the binding.
>>> 
>>>> What would be the property names with a Broadcom / Cypress vendor prefix?
>>>> 
>>>>   brcm,sco-routing
>>>>   brcm,pcm-interface-rate
>>>>   brcm,pcm-frame-type
>>>>   brcm,pcm-sync-mode
>>>>   brcm,pcm-clock-mode
>>>> 
>>>> ?
>>> 
>>> Yes.
>> 
>> we can do this. However all pcm-* are optional if you switch the HCI transport. And sco-routing should default to HCI if that is not present. Meaning a driver should actively trying to change this. Nevertheless, it would be good if a driver reads the current settings.
>> 
>> In theory we could make sco-routing generic, but so many vendors have different modes, that we better keep this vendor specific.
> 
> Even if vendor specific, the properties for not HCI transport case are
> still incomplete IMO.
> 
> By modes, you mean PCM vs. I2S and all the flavors of timings you can
> have within those or something else? For the former, that's often
> going to be a process of solving what each end support and if that
> doesn't work, then IIRC we already have properties for setting
> modes/timing. All the same issues exist with audio codecs and this is
> really not any different.

this is what Broadcom uses to configure their PCM transport. So I think for now, we make them brcm, specific and see how that goes. We can always generalize them later if enough chip manufactures provide support for it.

Regards

Marcel

