Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9C1CBC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DB520869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1yiHRBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DB520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933741AbeFKRyl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932647AbeFKRyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:54:39 -0400
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com [209.85.223.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFC3208B1;
        Mon, 11 Jun 2018 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739679;
        bh=2TzgZey581hTt3zu4wrjplG0yy0ADveDkPVQzG6HT+w=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=T1yiHRByV33Zs8/x0TKjHwFKyKY0ozXmglIBTEFcITAXRvIGCmWtAIhd7xPr0WwR6
         kVLSY/62dSIKCoVp9V+IifphjAktJay6rbNt/HNgXE8uWhtywcCx4bcYnJMNNKD3iU
         SnX23bBf6Cu+4hCxfsLeq9NyrU57fpmiLn2ewOZ8=
Received: by mail-io0-f182.google.com with SMTP id d185-v6so24929535ioe.0;
        Mon, 11 Jun 2018 10:54:38 -0700 (PDT)
X-Gm-Message-State: APt69E17uzRLd1ucld30wIpI24SW1iWusO1ulF1zEiPmnSh7hvWBfFEx
        FpOfcrEjGhbiFaEw6eaSOaqJahXduO2nVu2gVA==
X-Google-Smtp-Source: ADUXVKKORGo4SPVpBMEHNmKeKvE6jC/QcGQlyk88vNIIFd6Q7gTCGVjniCpXQA77Nb3IB55ict5LsUeM3zd/wGL8MpQ=
X-Received: by 2002:a5e:9407:: with SMTP id q7-v6mr186551ioj.268.1528739678311;
 Mon, 11 Jun 2018 10:54:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 10:54:17
 -0700 (PDT)
In-Reply-To: <4F0D6729-AE77-47D4-9765-FBC44181D4DE@holtmann.org>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com> <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
 <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
 <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com> <4F0D6729-AE77-47D4-9765-FBC44181D4DE@holtmann.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Jun 2018 11:54:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL2StWgA9gkL9i3o85-C3TNixBLmbTXzFQW8bts4phJqQ@mail.gmail.com>
Message-ID: <CAL_JsqL2StWgA9gkL9i3o85-C3TNixBLmbTXzFQW8bts4phJqQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Artiom Vaskov <velemas@gmail.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 9:47 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Rob,
>
>>>>> Added support to automatically configure the SCO packet routing at th=
e
>>>>> device setup. The SCO packets are used with the HSP / HFP profiles, b=
ut in
>>>>> some devices (ex. CYW43438) they are routed to a PCM output by defaul=
t. This
>>>>> change allows sending the vendor specific HCI command to configure th=
e SCO
>>>>> routing. The parameters of the command are loaded from the device tre=
e.
>>>>
>>>> Please wrap your commit msg.
>>>
>>>
>>> Sure.
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
>>>>> ---
>>>>> .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>>>>
>>>> Please split bindings to separate patch.
>>>
>>>
>>> Ok, I will split this in two.
>>>>
>>>>
>>>>
>>>>
>>>>> drivers/bluetooth/hci_bcm.c                   | 72 ++++++++++++++++++=
+
>>>>> 2 files changed, 79 insertions(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>> index 4194ff7e..aea3a094 100644
>>>>> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>> @@ -21,6 +21,12 @@ Optional properties:
>>>>>  - clocks: clock specifier if external clock provided to the controll=
er
>>>>>  - clock-names: should be "extclk"
>>>>>
>>>>> + SCO routing parameters:
>>>>> + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
>>>>> + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
>>>>> + - pcm-frame-type: 0 (short), 1 (long)
>>>>> + - pcm-sync-mode: 0 (slave), 1 (master)
>>>>> + - pcm-clock-mode: 0 (slave), 1 (master)
>>>>
>>>> Are these Broadcom specific? Properties need either vendor prefix or
>>>> to be documented in a common location. I think these look like the
>>>> latter.
>>>
>>>
>>> These will be used as parameters of a vendor specific (Broadcom/Cypress=
)
>>> command configuring the SCO packet routing. See the Write_SCO_PCM_Int_P=
aram
>>> command from: http://www.cypress.com/file/298311/download.
>>
>> The DT should just describe how the h/w is hooked-up. What the s/w has
>> to do based on that is the driver's problem which is certainly
>> vendor/chip specific, but that is all irrelevant to the binding.
>>
>>> What would be the property names with a Broadcom / Cypress vendor prefi=
x?
>>>
>>>    brcm,sco-routing
>>>    brcm,pcm-interface-rate
>>>    brcm,pcm-frame-type
>>>    brcm,pcm-sync-mode
>>>    brcm,pcm-clock-mode
>>>
>>> ?
>>
>> Yes.
>
> we can do this. However all pcm-* are optional if you switch the HCI tran=
sport. And sco-routing should default to HCI if that is not present. Meanin=
g a driver should actively trying to change this. Nevertheless, it would be=
 good if a driver reads the current settings.
>
> In theory we could make sco-routing generic, but so many vendors have dif=
ferent modes, that we better keep this vendor specific.

Even if vendor specific, the properties for not HCI transport case are
still incomplete IMO.

By modes, you mean PCM vs. I2S and all the flavors of timings you can
have within those or something else? For the former, that's often
going to be a process of solving what each end support and if that
doesn't work, then IIRC we already have properties for setting
modes/timing. All the same issues exist with audio codecs and this is
really not any different.

Rob
