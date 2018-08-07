Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6F4C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB7F21723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB7F21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbeHGNn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:43:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36660 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeHGNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:43:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id k15-v6so6750144edr.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 04:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yu8aOYXf13CyrAxAaAKow3kliySdsRcZ3zh86KB2HyY=;
        b=izPjRRe7Zc5kNTlwNf5RihPizHUfEGysETbsIojluSNN8ur+ndxZUo+gDMlUzEYnCO
         61bCXKXDLlQj+HZ2bRVNQ9FWcqn2QLL5dQFYKbojjhVYP9uGKpFcpE6TgiJX3jrz6Z9B
         gzdGppkpj17TZ9W6BE9O+f6R/M1exfeNiW9gbWnEwv0xSGqCg7W/4OIbBDx3gEQttweC
         C0PeXyCi2iCYMZFzpAsj38d+bAIR3P4kbAteo8LalDEi1aAC3UpmD6UqBz+glyAfQSKo
         GTaHAKKm0uvfDXXsAJvg0/LMKnq7LE41d6wlXyYCRHtWgRH1BRUmmvbYQzboaFkqK05q
         HErQ==
X-Gm-Message-State: AOUpUlEqLBvopWZ0ueGqrmSwFqOTixNER6sx3jVXzOvMhhLyVQWBB8eE
        WB1/FTjeFoTC1DaHzK4tdVUUHQ==
X-Google-Smtp-Source: AAOMgpcU2PXx7azJOCBTN1KNq5JQctG1FBgcuoqkt6eI5eISepnKc0B19IPAPZUH1lTMLaZbmqbs6g==
X-Received: by 2002:a50:8a23:: with SMTP id i32-v6mr22671752edi.49.1533641374520;
        Tue, 07 Aug 2018 04:29:34 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w1-v6sm1637605eda.63.2018.08.07.04.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 04:29:33 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] ACPI / scan: Create platform device for fwnodes
 with multiple i2c devices
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-3-hdegoede@redhat.com>
 <00e16cb09c171b536449b61124473291f2b30d0b.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <13770931-2322-96a3-1667-83c96b25bcfb@redhat.com>
Date:   Tue, 7 Aug 2018 13:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <00e16cb09c171b536449b61124473291f2b30d0b.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-08-18 13:19, Andy Shevchenko wrote:
> On Tue, 2018-08-07 at 10:05 +0200, Hans de Goede wrote:
>> Some devices have multiple I2cSerialBus resources and for things to
>> work
>> an i2c-client must be instantiated for each, each with its own
>> i2c_device_id.
>>
>> Normally we only instantiate an i2c-client for the first resource,
>> using
>> the ACPI HID as id.
>>
>> This commit adds a list of HIDs of devices, which need multiple i2c-
>> clients
>> instantiated from a single fwnode, to
>> acpi_device_enumeration_by_parent and
>> makes acpi_device_enumeration_by_parent return false for these devices
>> so
>> that a platform device will be instantiated.
>>
>> This allows the drivers/platform/x86/i2c-multi-instantiate.c driver,
>> which
>> knows which i2c_device_id to use for each resource, to bind to the
>> fwnode
>> and initiate an i2c-client for each resource.
>>
> 
>> +	/*
>> +	 * These devices have multiple I2cSerialBus resources and an
>> i2c-client
>> +	 * must be instantiated for each, each with its own
>> i2c_device_id.
>> +	 * Normally we only instantiate an i2c-client for the first
>> resource,
>> +	 * using the ACPI HID as id. These special cases are handled by
>> the
>> +	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which
>> knows
>> +	 * which i2c_device_id to use for each resource.
>> +	 */
>> +	static const struct acpi_device_id i2c_multi_instantiate_ids[] =
>> {
>> +		{"BSG1160", 0},
>> +		{"", 0},
>> +	};
> 
> Style nits:
> - can we move it outside of function?

Sure, but there are 2 existing users of an array of acpi_device_id-s
combined with an acpi_match_device_ids() call and both have the array
inside the function, so for consistency it seems better to keep it
where it is.

> - terminator better without comma

Agreed, will fix for v4.

> - is this existing style in the file and / or files in this folder for
> IDs? (I mean unnecessary 0:s and empty string?

It seems that all variants one can come up with are already used inside
this single file.

I agree that less is more, so I will change this to:

         static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
                 {"BSG1160", },
                 {}
         };

For v4.

Regards,

Hans

