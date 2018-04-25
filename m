Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeDYUIK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:08:10 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:47248 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeDYUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:08:08 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
 <20180424084137.7xfwji2gcibxavvt@flea>
 <03a02abb-e95c-b4ec-748f-907c0af67969@micronovasrl.com>
 <20180425184016.xktppxw7egddr7li@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <42feccc9-1d09-9ff2-3ccc-1dea63bacfb6@micronovasrl.com>
Date: Wed, 25 Apr 2018 22:08:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425184016.xktppxw7egddr7li@flea>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Il 25/04/2018 20:40, Maxime Ripard ha scritto:
> Hi Giulio,
> 
> On Tue, Apr 24, 2018 at 08:31:44PM +0200, Giulio Benetti wrote:
>> LiNova1 is not a board with various headers to connect other peripherals
>> such display, pcap etc.
>> It's an HMI that I would consider the same as a Tablet, because it has a
>> plastic enclosure also.
>>
>> So I would like to understand how to manage it in the best way.
>> Try to consider LiNova1 as a Tablet series, with following list:
>> LiNova1 4.3" ctp
>> LiNova1 7" ctp
>> LiNova1 10.1" ctp
>> LiNova1 4.3" rtp
>> LiNova1 7" rtp
>> LiNova1 10.1" rtp
>>
>> Every of those has a slightly different BOM, so they are 6 different
>> boards with a common base(uP, ram). And same pcb.
> 
> So the LiNova1 is exactly the same in all these setups, the only
> difference is that it has a connector that you connect a different
> display / touchscreen to?
> 
> If so, that's definitely a case for device tree overlays.

Yes it is that way. So I proceed with dt overlays.

> 
>> So I don't know if submit only the common base and provide
>> separately on our github DT-overlays, or provide as many dts patches
>> as the HMI number with a base dtsi.
> 
> That's really up to you, but the overlays will make this much simpler
> to handle precisely because it will reduce the amount of combinations
> you have.
> 
> You can even reduce it in your case to 5 of them, 3 for each panel and
> 2 for each touchscreen.

Ah, that's right! Good idea, more "encapsulation".

> 
>> Basically Micronova provides entire system without the capability to hack
>> hardware adding shields of various type.
>>
>> There are also other 2 LiNova:
>> LiNova2 and LiNova3
> 
> Which SoCs are these boards based on?

A20 on all three. They are slightly between each other.
Some RS485 more, 1 USB more etc.

> 
>> So I understand that this could lead to 18 different dts files and 3
>> dtsi files.
> 
> Yeah, I'd really like to keep this under control :)

:)

> 
>> But with Tablet it should be the same way.  For sure people would be
>> more interested on famous tablets instead of our HMI.
>>
>> In the case I need to use dt-overlays, you mean .dto files with
>> fragments inside loaded by u-boot or runtime, right?
> 
> You don't have to handcode the fragments anymore with the new syntax,
> and U-Boot makes it really trivial to use if you use the FIT image
> format to have multiple overlays bundled in the same image. You can
> choose to apply them dynamically, for example based on an EEPROM or
> some other metric to see which combination you have.

Ah, this is interesting. I'm going to experiment with that.

> 
>>>>>> +&usb_otg {
>>>>>> +	dr_mode = "otg";
>>>>>
>>>>> You're saying that this is a USB-A connector? Then it's not OTG since
>>>>> it doesn't have an ID pin, this is an host.
>>>>
>>>> Right, with a special overlay I will activate Usb Device for RNDIS,
>>>> so modified as host
>>>
>>> That doesn't really make much sense. The USB OTG is wired only using a
>>> daughter board?
>>
>> My fault, I've meant "peripheral" in one case and "host" in another case.
>> Usually "host".
>> Are there problem with this?
>> There is no daughter board.
> 
> If you have an ID pin and the ability to control VBUS, then you don't
> need to change the device tree, it's done automatically at runtime by
> Linux.

Unfortanetely I don't have ID pin and a common mosfet to control VBUS.
"peripheral" mode should be used only in debug mode,
so right dt-overlay can be written to sd-card by ourself or some of our 
customers.

Thank you very much for all clarifications!

Giulio.

> 
> Maxime
> 
