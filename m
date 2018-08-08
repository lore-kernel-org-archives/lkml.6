Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD4C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2386D216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2386D216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHHK0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:26:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40256 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727288AbeHHK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:26:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so811497edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 01:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLxYrziqHk0IAfhaegsqLo1N1wObSPL4KTSn03Iv4UY=;
        b=DnPdnUmwgUI2Q0P3Hnr7AbcqyBSgWtEPj8F0GQ8UVa73IZWQyLwrT06iZOT4M09BKD
         Hb9pAh7zxPiN+2BsiEsOqNNqcIh2qCaYTEwg/SEYoU8HX9FEkfooVmpY2d01SwnQhtQY
         5to3yHCGt0Ji2W9JDrTzxqeRX+ucYyZ68u4XHOeMvpB3EF4ydViMzLIv3zQ8IcnULT8p
         ECHjzVEV23P6GfoLzZcgwpbSR/8eNzDCZge6aD54Cj49C2s17f7G0aK5KoAbKkg0UFs2
         nNhsS77Azw00sIEXeSwkIJhNkWIGp6oUEuECClZmnrfvOBGrYkzm66afex14cMzx/e5d
         k5nQ==
X-Gm-Message-State: AOUpUlEZ8SbugWD9qmsxyYQdzhu2tKPciQx+oSjrw96GKUBu3Mkhl/6j
        hOrxmd6nZYwsKculCzttF0TDUA==
X-Google-Smtp-Source: AA+uWPzd1DGFN9gtVH4tMjvmmGtnT6SnhQ3TtxO8U1Iglvnb9jBWXemg+5yXAzwMd+5dqpfkgVOJfg==
X-Received: by 2002:a50:8607:: with SMTP id o7-v6mr2012849edo.243.1533715685369;
        Wed, 08 Aug 2018 01:08:05 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1375201edo.44.2018.08.08.01.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 01:08:04 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
To:     John Garry <john.garry@huawei.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c@vger.kernel.org
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-5-hdegoede@redhat.com>
 <7e68276c-2211-85d3-3e1f-2bc4b2d9f7d5@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <594d2c14-6f93-98cb-100d-9cc307d1cee4@redhat.com>
Date:   Wed, 8 Aug 2018 10:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7e68276c-2211-85d3-3e1f-2bc4b2d9f7d5@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-08-18 14:46, John Garry wrote:
> On 07/08/2018 09:05, Hans de Goede wrote:
>> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
>> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
>> i2c-device.
>>
>> But in some rare cases the manufacturer has decided to describe multiple
>> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>>
>> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
>> code to support this corner-case.
>>
>> This commit introduces a new i2c-multi-instantiate driver which fixes this
>> in a different way. This new driver can be built as a module which will
>> only loaded on affected systems.
>>
>> This driver will instantiate a new i2c-client per I2cSerialBus resource,
>> using the driver_data from the acpi_device_id it is binding to to tell it
>> which chip-type (and optional irq-resource) to use when instantiating.
>>
>> Note this driver depends on a platform device being instantiated for the
>> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
>> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  MAINTAINERS                                  |   6 +
>>  drivers/platform/x86/Kconfig                 |  11 ++
>>  drivers/platform/x86/Makefile                |   1 +
>>  drivers/platform/x86/i2c-multi-instantiate.c | 131 +++++++++++++++++++
>>  4 files changed, 149 insertions(+)
>>  create mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9b377508f24f..09e16d76cab7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6657,6 +6657,12 @@ F:    drivers/i2c/i2c-mux.c
>>  F:    drivers/i2c/muxes/
>>  F:    include/linux/i2c-mux.h
>>
>> +I2C MULTI INSTANTIATE DRIVER
>> +M:    Hans de Goede <hdegoede@redhat.com>
>> +L:    linux-i2c@vger.kernel.org
>> +S:    Maintained
>> +F:    drivers/drivers/platform/x86/i2c-multi-instantiate.c
> 
> This path looks incorrect
> 
>> +
>>  I2C MV64XXX MARVELL AND ALLWINNER DRIVER
>>  M:    Gregory CLEMENT <gregory.clement@bootlin.com>
>>  L:    linux-i2c@vger.kernel.org
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 85a93453237c..8256629f58f7 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1219,6 +1219,17 @@ config INTEL_CHTDC_TI_PWRBTN
>>        To compile this driver as a module, choose M here: the module
>>        will be called intel_chtdc_ti_pwrbtn.
>>
>> +config I2C_MULTI_INSTANTIATE
>> +    tristate "I2C multi instantiate pseudo device driver"
>> +    depends on I2C && ACPI
>> +    help
>> +      Some ACPI bases systems list multiple i2c-devices in a single ACPI
> 
> I guess that this should be "Some ACPI-based systems"

Thanks, both fixed for v4 of the patchset.

Regards,

Hans


> 
>> +      firmware-node. This driver will instantiate separate i2c-clients
>> +      for each device in the firmware-node.
>> +
>> +      To compile this driver as a module, choose M here: the module
>> +      will be called i2c-multi-instantiate.
>> +
> 
> Thanks,
> John
> 
