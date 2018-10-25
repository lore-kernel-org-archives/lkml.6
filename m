Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17166C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E652084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8blxREP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E652084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJZDBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:01:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39513 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeJZDBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:01:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id p11-v6so7547439lfc.6;
        Thu, 25 Oct 2018 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a19lCwQzagScv18Hz3RaJqpyLDMg6334U2jBUpLg7Bo=;
        b=F8blxREP8DqAR/JqshNi9fQRZM4BrEs28hBAn58rcNaRchxVTzZmjM0VPh+ShYTV/y
         rH9j10wXQGT1WHCBw3EINA3sSqtlQkaCTCwxZsSkFfFu1o6Nqbk4kz2IRFCym+751VGO
         ls6qEC/u/7vNcl99tZbz9v15OzzyhmPDLGQDts/RnXcZpWaMyQybedxvCrHBH72sbqnE
         mCBC3AqBPIrl+awaAbBmSQsKZ1bCmTLSAeRcj+YIkYy5ekEEmqqqaGUvK02PD6U356am
         lersv0B20uPP9H1UjmSPpAyyY88Zs/xJwAcUXgWo2xESNzU+WOu6GcV9VdadFLWh8okp
         koVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a19lCwQzagScv18Hz3RaJqpyLDMg6334U2jBUpLg7Bo=;
        b=HWQdX/Scxpw/3jnQLbHTxsV+45zk20ATpIZHnB4dP/vATu3RwjEYmIneEO6jL3VHNt
         jFS1yNEqwLbMCeIKW+h/RumOG75vuyr1pjP5LGC3lB53vosK7V+ndJletiCKI+5liOhr
         UNU24uX4WSWXSp0p8HAIzfxHhKmuV2n5EwZNtyJMWg7ivpedDnFO/nRJmZuAfECtPJH+
         xh6ndLc0CCN3bpBUjSwnfrk0hOd4VtBbB3zW4qWAzpVV3R5Vr4B+ER5MMlQh378AUJyN
         Y70LjATJDRbVHqy0pEkKDBAE5evBxM8AuHW+xdIOUncrn3Zj0BjumeQWl6l44kysNo6A
         c9HA==
X-Gm-Message-State: AGRZ1gLPwzP4+N5KRJYOBwa9NDex30Po/6HzXtK537VcSFW+PCHdvEjt
        JwSjcCadIBOqLd4MC7ur4Oo=
X-Google-Smtp-Source: AJdET5cRKTRTAGXHQjhMhvHoE/GBY0faN+bypwaXNKX5g9TQ54wUz+tddpzqcbxceDTRC79KWfUNWg==
X-Received: by 2002:a19:d78c:: with SMTP id q12mr199473lfi.27.1540492045866;
        Thu, 25 Oct 2018 11:27:25 -0700 (PDT)
Received: from [192.168.1.18] (dnt139.neoplus.adsl.tpnet.pl. [83.24.101.139])
        by smtp.gmail.com with ESMTPSA id z10-v6sm904209lfj.50.2018.10.25.11.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:27:25 -0700 (PDT)
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        lee.jones@linaro.org, tony@atomide.com
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com> <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com> <20181024145434.GC9327@bogus>
 <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
Date:   Thu, 25 Oct 2018 20:27:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 08:07 PM, Dan Murphy wrote:
> Rob
> 
> On 10/24/2018 09:54 AM, Rob Herring wrote:
>> On Wed, Oct 24, 2018 at 07:07:57AM -0500, Dan Murphy wrote:
>>> Pavel
>>>
>>> On 10/24/2018 04:04 AM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>> The LM3697 is a single function LED driver. The single function LED
>>>>> driver needs to reside in the LED directory as a dedicated LED driver
>>>>> and not as a MFD device.  The device does have common brightness and ramp
>>>>
>>>> So it is single function LED driver. That does not mean it can not
>>>> share bindings with the rest. Where the bindings live is not imporant.
>>>>
>>>
>>> It can share bindings that are correctly done, not ones that are incomplete and incorrect.
>>>
>>> Where bindings live is important to new Linux kernel developers and product 
>>> developers looking for the proper documentation on the H/W bindings.
>>>
>>>>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>>>>> current LED and general bindings guidelines.
>>>>
>>>> What you forgot to tell us in the changelog:
>>>
>>> I can add this to the changelog.
>>>
>>>>
>>>>> +Optional child properties:
>>>>> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
>>>>> +				the a higher brightness level.
>>>>> +				Range from 2048 us - 117.44 s
>>>>
>>>> The other binding uses "ramp-up-msec". Tell us why you are changing this, or
>>>> better don't change things needlessly.
>>>>
>>>> We don't want to be using "runtime-ramp-up-msec" for one device and
>>>> "ramp-up-msec" for the other.
>>>
>>> This is another example of how the original bindings were incorrect and misleading.
>>>
>>> The LM3697 have 2 ramp implementations that can be used.
>>>
>>> Startup/Shutdown ramp and Runtime Ramp.  Same Ramp rates different registers and
>>> different end user experience.
>>>
>>> So having a single node call ramp-up-msec is misleading and it does not
>>> indicate what the H/W will do.
>>
>> The existing ones aren't documented (present in the example is not 
>> documented). This seems like something that should be common rather than 
>> TI specific. Though it also seems more like something the user would 
>> want to control (i.e. sysfs) rather than fixed in DT.
>>
> 
> Changing the runtime ramping or startup/shutdown ramping could also be done via sysfs.
> I am not dedicated to having it in the DT file I was following prior art.
> 
> Jacek
> 
> Do you have an opinion on this?

This is this problem with the Device Tree's scope of responsibility.
It is defined as a means for "describing the hardware", but often
this rule is abused by the properties that fall into "configuration"
category. E.g. default-state, retain-state-suspended from leds-gpio.txt
or linux-default-trigger from common LED bindings.

In some cases this is justified. The question is whether it is something
that necessarily needs to be configured on driver probing? If not, then
I'd go for sysfs interface.

-- 
Best regards,
Jacek Anaszewski
