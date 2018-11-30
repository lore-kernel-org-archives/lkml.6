Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8047EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525352146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525352146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeK3X21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:28:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59276 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeK3X21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:28:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4F9CD27D961
Subject: Re: [PATCH v2 1/2] power: supply: add input voltage limit property.
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com,
        bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
 <20181123232203.GA3852@amd>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
Date:   Fri, 30 Nov 2018 13:19:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181123232203.GA3852@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thanks for the feedback.

On 24/11/18 0:22, Pavel Machek wrote:
> Hi!
> 
>> We have a problem with USBPD chargers which under certain conditions
>> can result in system overheating if the voltage provided by the USBPD
>> port is too high. While the preferred means to control this would be
>> through devicetree or ACPI settings, this is not always possible, and
>> we need to have a means to set a voltage limit.
>>
>> This patch exposes a new property, similar to input current limit, to
>> re-configure the maximum voltage from the external supply at runtime
>> based on system-level knowledge or user input.
> 
> First, this should really be handled by dt / ACPI. If it is broken,
> that's a hardware bug, and we can do DMI-based blacklists in kernel.
> 

I think that handle this via dt / ACPI is not possible for our use case. It can
be a hardware bug or a hardware/user constrain, let me try to explain better
with an example.

On Pixel C's devices, userspace uses this to set a USB input limit of 5V when
the screen is on for thermal reasons, but those go away when the screen is
off/system is sleeping, so we allow 9V and 12V levels when sleeping.

> How are you supposed to fsck a system, for example?
> 

hmm, I'm not sure I get the question, sorry, could you rephrase?

>> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
>> +Date:		Nov 2018
>> +Contact:	linux-pm@vger.kernel.org
>> +Description:
>> +		Details the incoming VBUS voltage limit currently set in the
>> +		supply. Normally this is configured based on the type of
>> +		connection made.
> 
> "Details"?
> 
> Who can write to this value and when? What is the limit? If USB
> charger is plugged in, should it show 5.0V (because that's nominal on
> the USB) or 5.25V (because that is the real limit)?
> 

The voltages here refer to the Typical or Nominal values defined by the USB
specification for a Fixed power supply (or Fixed PDO). 5.0V, 5.25V, 4.75V,
5.5V... all of those are considered "5V" according to the USB specifications.

At the 5V level (defined in the USB PD specification as vSafe5V), a nominal
power source is allowed to have a voltage between 4.75V and 5.50V (5V -5%/
+10%). For simplicity, we refer to this range as 5V, the typical value.
For all higher voltage levels other than vSafe5V, MIN voltage is PDO Voltage *
0.95, and MAX voltage is PDO Voltage * 1.05, where PDO Voltage is the Typical
value (9V, 12V, 15V, 20V). [1]

> Who can write to this and when. And what happens on write? What
> happens if I write value that charger can't provide there?
> 
> Does it set the voltage power supply should produce? Or maximal it can
> choose to produce?
> 

This defines a maximal voltage. If you write a value it can't provide,
it should go down to the next lowest level, and barring that, 5V is
always allowed.

That makes me think that maybe I should also improve the implementation.

> This really needs better documentation.

Ack, I'll send a next version improving that.

Make sense to you?

Thanks
 Enric

[1] USB PD Specification revision 2.0, Version 1.3, Table 7-22

> 
> 								Pavel
> 
