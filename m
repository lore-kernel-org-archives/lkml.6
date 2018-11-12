Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B97C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439E322419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juos8+dN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439E322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeKMB4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:56:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39207 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMB4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:56:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so6552906lfh.6;
        Mon, 12 Nov 2018 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OGpDVYZZ33etyb6iQsfc/st4tQbzCM1IdvbraAxu2po=;
        b=juos8+dNkapcwNW/AFpmwEEL1UAjZ/jBUKhUFC2FelJZsDhw2pq7zhxJMT3FkXUTZn
         j3bbi9AOomjIEqDrcoivlw+WJDm9QjDOtA4dcZ5XehL6OyJDidY6qegXgxb1mHe2N2tq
         ToigtyS764S5nyKotFtX9xZtD4AOvAD2Ovg5ubS88810MaSjWFusmwD4fYG9vtUPcWQC
         dvrCtN9ro21XlE25YZRodtbi4rHvywJyOXlv7ON5ihmoPhUkZ5oDRiwvShPh1An6L4oG
         blVapnai/dOIzk1PMx+1kyHCjoTsU2lHfcrUxmmUxuwkskimis9gtpgrMAp4lDU45UZc
         nP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OGpDVYZZ33etyb6iQsfc/st4tQbzCM1IdvbraAxu2po=;
        b=OuRwJVvu+841nuq8tsvHMT9Uy3ltXcTZDmBsjobo3oqqsE6YgAmogOLV+8nml2Tr/o
         /Ju1uGGRQHG19jkKSYAppTot2uDp08a6VLJysMkiNjxM7gvncI6syqUkUZicbI00NvK5
         +9iyLuMj+32graN3m4cAxAcYs0OtnoRuEus0M6ithlIX4NvCB8ThpukeE/rX5GItpKQ1
         RpwJF5DZBgqpfFUuS+COeOk7kZ8JCt1yK1VhZxuQEU2Jr5fwuNt6KTQl7HMOdqkyx6XR
         l17t0fR4Zbov9drGVv5XEbtliLDZLD0VNDxYEvIcyzPLM3VgzxiJznPvkH6y3zbgzTq1
         UfAw==
X-Gm-Message-State: AGRZ1gLQYgPKLMNu5HYDBV9yiScbIgug/CB9ybKGyAmIxPuZpLgFdUV0
        b86IgKkEDv0G46z0YhDDnqY=
X-Google-Smtp-Source: AJdET5cJj07HepOorg31ewpMw8wP22Y7wS1Zxb0HvgogJCE3DtFk8qkZNKbqid9YUJWmQfy1PRXXpQ==
X-Received: by 2002:a19:280f:: with SMTP id o15mr968396lfo.0.1542038562978;
        Mon, 12 Nov 2018 08:02:42 -0800 (PST)
Received: from [192.168.1.18] (bgt69.neoplus.adsl.tpnet.pl. [83.28.83.69])
        by smtp.gmail.com with ESMTPSA id h21sm3135442lfk.41.2018.11.12.08.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:02:42 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <bdd18dc6-0dee-5957-81d4-39254c7ad74d@gmail.com>
 <be4e75ed-746e-ed55-0bbe-0fd710bd4162@gmail.com>
 <12fb34ec-7175-1ac4-a96e-e1d5d424c9eb@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <d1ef315d-1216-7e63-f24f-5c6fee8793be@gmail.com>
Date:   Mon, 12 Nov 2018 17:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12fb34ec-7175-1ac4-a96e-e1d5d424c9eb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vesa,

On 11/10/2018 06:19 PM, Vesa Jääskeläinen wrote:
> Hi Jacek,
> 
> On 09/11/2018 22.42, Jacek Anaszewski wrote:
>> Hi Vesa,
>>
>> On 11/09/2018 09:32 AM, Vesa Jääskeläinen wrote:
>>> On 07/11/2018 0.07, Jacek Anaszewski wrote:
>>>> Introduce dedicated properties for conveying information about
>>>> LED function and color. Mark old "label" property as deprecated.
>>>>
>>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>>> Cc: Baolin Wang <baolin.wang@linaro.org>
>>>> Cc: Daniel Mack <daniel@zonque.org>
>>>> Cc: Dan Murphy <dmurphy@ti.com>
>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>>>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>>> Cc: Simon Shields <simon@lineageos.org>
>>>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/leds/common.txt | 52
>>>> +++++++++++++++++++----
>>>>    1 file changed, 44 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/common.txt
>>>> b/Documentation/devicetree/bindings/leds/common.txt
>>>> index aa13998..3efc826 100644
>>>> --- a/Documentation/devicetree/bindings/leds/common.txt
>>>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>>>> @@ -10,14 +10,20 @@ can influence the way of the LED device
>>>> initialization, the LED components
>>>>    have to be tightly coupled with the LED device binding. They are
>>>> represented
>>>>    by child nodes of the parent LED device binding.
>>>>    +
>>>>    Optional properties for child nodes:
>>>>    - led-sources : List of device current outputs the LED is connected
>>>> to. The
>>>>            outputs are identified by the numbers that must be defined
>>>>            in the LED device binding documentation.
>>>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed
>>>> definitions
>>>> +        from the header include/dt-bindings/leds/functions.h.
>>>> +        If there is no matching LED_FUNCTION available, add a new one.
>>>> +- color : Color of the LED.
>>>
>>> We have had for years out-of-tree patch for multi color gpio led driver
>>> which extends this concept with multiple colors. Then in sysfs there has
>>> been possibility to control the color and otherwise use blinking or
>>> other features.
>>>
>>> Our need is multi color status led of the device which includes
>>> different kind of blinkings and colors on different situations.
>>>
>>> Current in-tree gpio led driver just wasn't atomic enough and a bit
>>> clumsy interface for handling this.
>>>
>>> Now that this is being looked at could we come up with solution that we
>>> could define multiple colors for one led in device tree and then we
>>> could work on getting the driver upstreamed?
>>>
>>> What we did was generally:
>>>
>>> leds-multi {
>>>      compatible = "gpio-multi-leds";
>>>
>>>      status {
>>>          gpios = <...>;
>>>          linux,default-trigger = "none";
>>>          deafult-state = "keep";
>>>
>>>          color-red {
>>>              pin-mask = <0x01>;
>>>          };
>>>
>>>          color-green {
>>>              pin-mask = <0x02>;
>>>          };
>>>
>>>          color-orange {
>>>              pin-mask = <0x03>;
>>>          };
>>>      };
>>> };
>>>
>>
>> Device Tree node implementation doesn't actually say too much
>> about the sysfs interface you came up with, which is most vital
>> in this case.
> 
> In our case it is very simple. There is "color" named sysfs node under
> gpio instance.
> 
> It creates own led instance for each children in this case it is named
> as "status" and then uses properties under it to define operation.
> 
> Currently we do have fixed list of color names in driver to require
> "standardized" names but that could be easily changed to be dynamic.
> 
> Driver registers all GPIOs defined in "gpios" under the instance.
> 
> So one can say:
> 
> echo "orange" > color
> 
> This setting goes to the driver, it figures out logical name "orange"
> and the configure all listed GPIO's to its "pin-mask" state. Polarity of
> the GPIO's is configured in GPIO definition so this is more or less turn
> this particular pin to activate state.
> 
> So in this case it changes led's color to orange and still lets one to
> use standard led triggers. Eg. set periodic blinking or so.
> 
> If one cat's "color" it lists all available colors for user and shows
> which one is active.
> 
> When brightness is configured as zero the all registered go to off state
> and when non-zero then it goes to state what ever is configured with
> "color" sysfs entry.
> 
>> Support for RGB LEDs, or other variations of LED synchronization
>> have been approached several times, but without satisfying result
>> so far.
>>
>> Generally the problem boils down to the issue of how triggers
>> should handle multiple synchronized LED class devices in a backwards
>> compatible way with monochrome LEDs.
>>
>> At some point the HSV [0] approach was proposed, but there was a problem
>> with getting uniform colors across devices. Especially white.
>> Certainly a calibration mechanism would be required.
>>
>> [0] https://lkml.org/lkml/2017/8/30/423
> 
> We do not usually use PWM controlled leds so our calibration has been HW
> engineer tuning the resistors for the leds to get acceptable color for
> different colors variations.
> 
> If one wants to have fixed colors for such device then one could use
> this similar method to define them or/and free form interface to enter
> RGB values there. Thou with PWM RGB leds you probably want to have more
> animation there which probably would require some additional support code.
> 
> One way to do atomic PWM RGB color change with sysfs could be:
> 
> echo "21 223 242" > color
> 
> or
> 
> echo "21 223 242" > rgb
> 
> or:
> 
> echo "r:21 g:232 b:242" > color (or something similar)
> 
> and if there is know registered name then just write it to "color" which
> would pick registered color rgb values to led instances rgb value.
> 
> Now for PWM RGB led one could use "brightness" and "rgb" value to
> calculate actual color with some color space formula (like hsv in [0]).
> 
> Doing white with RGB LED is a bit hard so usually you want to get RGBW
> LED (or RGBAW LED) if "real" white is something that is needed. This
> could then be "rgbw" entry and "color" to pick from fixed set.
> 
> These presets in device tree for "color" could be considered one way of
> doing calibration for particular hardware.
> 
> So in device tree for RGB PWM led it could be like:
> 
> color-orange {
>     rgb = <249 197 9>
> }
> 
> color-warm-white {
>     rgb = <255 253 249>
> }
> 
> How would that sound like?

Thank you for the description of your approach.

Predefined DT color definitions make an interesting option. Nonetheless,
your design assumes that for RGB LEDs max_brightness would have to be
always 1.

While it would solve the issue, it wouldn't allow to benefit from
the whole potential of RGB LEDs - think of having adjustable "color
brightness" (like in HSV color model).

How abut allowing for providing an array of color intensity/brightness
levels per each color? In the simplest case there could be a single
level per color, but it should be possible to provide up to 255 levels.

-- 
Best regards,
Jacek Anaszewski
