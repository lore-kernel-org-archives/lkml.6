Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B223224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU/53N/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B223224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbeKMGGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:06:25 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40053 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMGGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:06:24 -0500
Received: by mail-ed1-f42.google.com with SMTP id d3so7854292edx.7;
        Mon, 12 Nov 2018 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xU8J2F2zBaN0j+XnjETUs+1pKeb65Q4acGoxUbM7zkQ=;
        b=EU/53N/PJwQ2KvfbdcXv2KfAJwGINVnEH3iVWLE9UbCzXvCGChHrmjRdnZX6AUU46x
         PtuLCj2cD3Lxv/K79csw1X+gHfZgniWWryU42OnGne3DHL1MTjeCupnQWmCEHKZ/QH2B
         DgdvxFhKDnHVEt0th7Fh/cuiREFeF/CREx4IAMuZCxmlVr72uJEhBIH44T1qIq8a6FgL
         fcWpnlmA6G/otAG3MYbiJ+wIVeI+rpmgzOkcq/NQSz/OysxlFSsK6/oX9bo1VIHHEL8c
         nCVhXQv8S/8/Ii1hvHDhuBx0Ux72rhqazYpOS9ajb15EyJqEMOlVbA1nVqssS9k8rnQO
         e+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xU8J2F2zBaN0j+XnjETUs+1pKeb65Q4acGoxUbM7zkQ=;
        b=tzWMsNdRNAqGrQCODJxAslj5iZwZLqLHngNkNEcUx4Y94l3rrgbXG5CUTzPgocLIvG
         uOfBS26aLT9RZ+mc4t+V6T8gGhELItvQVrHlGeLsJI4ZVLig82ZXV9rjERO3aSaKYsb0
         tNkgiIM20b/+3D7SedMF98+9gdOMwWb7NfNE1pyfR8oEk/g7frrogvix95nlLgsAyStu
         YHkfyyFb+O7ORZsSbt4YnTtXnP5UnQGPaszMSxSIseHymQSnvuO6e45q6G9OdSyeTqqa
         qOdTCZJTMWGUysXR2vyTpLGabfKqwhKbRNfl0hp8dTDdCSzBHRXqt0cdN8lYaU/KO+Po
         Gynw==
X-Gm-Message-State: AGRZ1gJgQd4wm5ETWpZr0Z+7gkArsu7V4IAPpo+LbOhAH2P46yR0IWOa
        L4RZRAe4fV1o+/6f7tmrRrU=
X-Google-Smtp-Source: AJdET5fQmZxECumddbowXhTy391NQUHpf+OJKHUolUPyjB9fS+mGPi+ga7iR5Fi/FrUZ5PF6j5M2ow==
X-Received: by 2002:a50:ad0b:: with SMTP id y11mr9672328edc.113.1542053495781;
        Mon, 12 Nov 2018 12:11:35 -0800 (PST)
Received: from [192.168.1.18] (bgt69.neoplus.adsl.tpnet.pl. [83.28.83.69])
        by smtp.gmail.com with ESMTPSA id gz20-v6sm1234373ejb.56.2018.11.12.12.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:11:35 -0800 (PST)
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd> <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd> <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <20181112103513.GB5695@amd> <662c02ba-455b-e2bf-a5e2-ae3933161894@gmail.com>
 <20181112190554.GA13959@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <b167cfc1-e392-eec6-6455-5983dc1c7212@gmail.com>
Date:   Mon, 12 Nov 2018 21:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181112190554.GA13959@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 08:05 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> My system looks like this:
>>>>>
>>>>> input16::capslock    tpacpi::bay_active    tpacpi::standby
>>>>> input16::numlock     tpacpi::dock_active   tpacpi::thinklight
>>>>> input16::scrolllock  tpacpi::dock_batt	      tpacpi::thinkvantage
>>>>> input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
>>>>> input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
>>>>> input5::scrolllock   tpacpi:green:batt	      tpacpi::unknown_led3
> 
>>> But it is not just for backwards compatibility. See my examples above,
>>> it is needed to tell which device the LED is asociated with, and it is
>>> absolutely required for USB devices (for example).
>>
>> For USB devices there is already ledtrig-usbport available, which
>> provides sysfs interface for defining and reading the usb ports,
>> the status of which the LED indicates. Since the USB devices can be
>> attached/removed dynamically, it would be impossible to reflect
>> the associations in the LED class device name.
> 
> I'm not talking USB activity. I'm talking USB devices with LEDs on
> them, like for example keyboards.
> 
> Please take a look at example above. input16::numlock ;
> input5::numlock . You absolutely need device part.

It would be redundant since there is "device" symbolic link
created in given LED class device sysfs directory, pointing to the
corresponding input device directory, like in case of my USB keyboard:

#/sys/class/leds/input5::scrolllock$ ls -l
total 0
-rw-r--r-- 1 root root 4096 Nov 12 20:22 brightness
lrwxrwxrwx 1 root root    0 Nov 12 20:22 device -> ../../input5
-r--r--r-- 1 root root 4096 Nov 12 20:22 max_brightness
drwxr-xr-x 2 root root    0 Nov 12 20:22 power
lrwxrwxrwx 1 root root    0 Nov 12 20:04 subsystem ->
../../../../../../../../../../../class/leds
-rw-r--r-- 1 root root 4096 Nov 12 20:22 trigger


>>> And even for "embedded" stuff like routers, we want eth0:green:link,
>>> eth0:yellow:activity and not some kind of hack.
>>
>> eth0 is not something you can be certain of at the stage of defining DT
>> node.
> 
> In the common case DT is used for, yes, you can, because whole system
> is in one box.

Only when all kernel modules are built-in.

> (And really DT does not matter. We are talking kernel <-> user
> interface here).

OK, I was fixed on the devicename understood as LED controller name.


>>> Ideally, colors would come from fixed list, functions would come from
>>> fixed list, and device part would come from name used elsewhere in the
>>> kernel.
>>>
>>> (And yes, it probably means we should have something in device tree to
>>> link LED to its device. device = "name" would be good start...)
>>
>> Why would you need such link?
> 
> Because userspace needs that information?
> 
> Say you have raid array, with "error" leds for each drive (your list
> already contains "hdderr"). Now userland detects problem with hdparm
> on /dev/sdi. It would like to turn on corresponding LED.
> 
> How do you propose we do that?

Similarly as in case of USB keyboard.

-- 
Best regards,
Jacek Anaszewski
