Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13087C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BC42081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FumLz1E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BC42081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbeKGOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:36:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40837 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeKGOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:36:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so4968164pgp.7;
        Tue, 06 Nov 2018 21:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GbBTsj5GCzZKxzkYvP/0pZ143/RuxDO5XlD/zZeXRYU=;
        b=FumLz1E44lo58cQ21hfFJkqm/mQIh7Ll/N7PlcR/kcs4QtQYiAIfcbWm3WOT6So90G
         wX6kPViMN2+LJfRxG7SOoDCyHxyxv97HpIJh+QaE2hoW7iFgrJrcx4lXdRMYvwZpz/Ba
         hXYOOoYS/cq1D+VDuGAi1VmOoqpcklLyQTz603ppXjSEOcs0fegcJs2Up4rcIIJmW0Gf
         W59rUnEtISqNkWa1llj0K10brE6bfC7hpq9M8WPR+lYlk6g0ildba/C8IrJalJTRdpp0
         bEC71RgsDYToeFF59TUrZ8eKGiJHQHWaJ6qbz5KU1QbXVoSrOOfr+TS3y9nJ5aIMMh25
         EknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GbBTsj5GCzZKxzkYvP/0pZ143/RuxDO5XlD/zZeXRYU=;
        b=lGkqhu7F3Yq3wnkijWtDoIAs7RHcHrO2sK00zRkashPykN3lf2QXl2gRJsT+GApYnS
         LgBpD5d/BTlitu5SujKUTCx9tpqwZqMKFKMnEprB3lIDGEMylPF4wN9XEaceLxsSOsU9
         WTAkAal3fc4W0rccnpXpLq6nN3tsNYO6M+Tbuuu1U1ycq1s+iNmmT/Alk3p/LpysM1+E
         3vSSGrhiRA3OsP/kE0f3JFZVsg2Lzh5oFT/CHm27fmixvQmwN4Ic23UmOl2PpOpvvM1Q
         b69+KZHPRz9QJMxYWY1tkQjwuPt83C2/HtuBSNUvyYrVDR35AHSZKib3StOS8o77LPEq
         8suA==
X-Gm-Message-State: AGRZ1gKtk8TqCrXcOqrO0OkigN70k8Kl1ENUzT44dH0aD4bMjN4If3+y
        NLN7SItQ4Wd4TQLFE0M2A3U=
X-Google-Smtp-Source: AJdET5fYCqKIB8pYYWBUtSmCKkk12WFDDkdu+pRHAlcTagb2OXELj+Wiq8gAkXzInWPASs1L7p8+ng==
X-Received: by 2002:a65:44c6:: with SMTP id g6-v6mr420044pgs.350.1541567280468;
        Tue, 06 Nov 2018 21:08:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s22-v6sm7301006pfi.15.2018.11.06.21.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 21:07:59 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181107040010.27436-1-chris.packham@alliedtelesis.co.nz>
 <20181107040010.27436-2-chris.packham@alliedtelesis.co.nz>
 <64720b73-dddf-783c-a3a4-3f32a748bf5d@roeck-us.net>
 <1ed7434bfded41bfba3b739f58f69102@svr-chch-ex1.atlnz.lc>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <213614fb-1b7a-a06c-6f9f-f3d497750ca6@roeck-us.net>
Date:   Tue, 6 Nov 2018 21:07:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1ed7434bfded41bfba3b739f58f69102@svr-chch-ex1.atlnz.lc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 8:27 PM, Chris Packham wrote:
> On 7/11/18 5:24 PM, Guenter Roeck wrote:
>> On 11/6/18 8:00 PM, Chris Packham wrote:
>>> With the addition of the invert-pwm property the adt7475 needs its own
>>> binding documentation rather being captured under trivial-devices.txt.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>     .../devicetree/bindings/hwmon/adt7475.txt     | 22 +++++++++++++++++++
>>>     .../devicetree/bindings/trivial-devices.txt   |  4 ----
>>>     2 files changed, 22 insertions(+), 4 deletions(-)
>>>     create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Documentation/devicetree/bindings/hwmon/adt7475.txt
>>> new file mode 100644
>>> index 000000000000..79255439e157
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt
>>> @@ -0,0 +1,22 @@
>>> +*ADT7475 hwmon sensor.
>>> +
>>> +Required properties:
>>> +- compatible: One of
>>> +	"adi,adt7473"
>>> +	"adi,adt7475"
>>> +	"adi,adt7476"
>>> +	"adi,adt7490"
>>> +
>>> +- reg: I2C address
>>> +
>>> +optional properties:
>>> +
>>> +- invert-pwm: This configures the PWM to use logic low for 100% duty cycle.
>>> +
>>> +Example:
>>> +
>>> +hwmon@2e {
>>> +	compatible = ;
>>> +	reg = <0x2e>;
>>> +	invert-pwm;
>>
>> If I understand correctly, the flag is set per pwm channel. A single global
>> property seems inappropriate.
> 
> Yes it is per-channel. But I was having a hard time imagining a hardware
> design that would use both inverted and non-inverted at the same time.
> 

People can be inventive. Sometimes too much so.

> Do you have a preference for how the properties should look?
> 
>     invert-pwm[123]?
> 
>     invert-pwm = <0x7>;?
>
Ultimately we'll have to find a generic way of defining devicetree properties for
hardware monitoring devices, not just for pwm but for all sensor types. A sub-node
per channel seems to be the most likely answer, but I think that is a long way off
(and will require lengthy discussions about acceptable properties).

I was looking into pwm DT properties, but they define a set of flags
(PWM_POLARITY_INVERTED, PWM_POLARITY_NORMAL).

The g762 driver uses "pwm_polarity". Underscore - hmm. Other drivers use module
parameters, sysfs attributes (pwmX_invert in asc7621 driver), or platform data
(g762, max6639).

Maybe pwm-polarity = <PWM_POLARITY_NORMAL | PWM_POLARITY_INVERTED> ?
No idea if that makes sense. Or just a boolean pwm-polarity-inverted.

Thinking about it per channel vs. per chip ... other drivers also seem to
use a single property / attribute for the entire chip, so that is fine here
as well. We can always extend it if needed.

Anyway, I am fine with whatever Rob accepts.

Guenter

>>
>> Guenter
>>
>>> +};
>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
>>> index 69c934aec13b..4f29100d6bbf 100644
>>> --- a/Documentation/devicetree/bindings/trivial-devices.txt
>>> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
>>> @@ -14,10 +14,6 @@ ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert an
>>>     ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
>>>     adi,adt7461		+/-1C TDM Extended Temp Range I.C
>>>     adt7461			+/-1C TDM Extended Temp Range I.C
>>> -adi,adt7473		+/-1C TDM Extended Temp Range I.C
>>> -adi,adt7475		+/-1C TDM Extended Temp Range I.C
>>> -adi,adt7476		+/-1C TDM Extended Temp Range I.C
>>> -adi,adt7490		+/-1C TDM Extended Temp Range I.C
>>>     adi,adxl345		Three-Axis Digital Accelerometer
>>>     adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
>>>     ams,iaq-core		AMS iAQ-Core VOC Sensor
>>>
>>
>>
> 
> 

