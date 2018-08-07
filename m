Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0A3C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193C2216FE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193C2216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbeHGMzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:55:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47091 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeHGMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:55:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id o8-v6so6660797edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 03:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Y47WEmUsZ1vQX33J2mEgnmGzQ/3vq5YSq8W41lYCPw=;
        b=Q2KNLolMFjCvIUSu9s4MFVJ5vHMzEtupRFXQe57solphuA6I0Sg+VsXoP42LtNXbqL
         YiNKzf3EhVeYeEdEd7U0wKAsPNUsfIIS+IsoHLT7BUpnaSeTzIaRKoTA9Yg9tADBGm6x
         FH+ezUjll/4JvYfILI2enWQbRc3OrJmupPX06XIY278HuPEcVFPgVB+JUtBicmu6gL/S
         YPKiTx/1Mx0Q1lavB9yzpAzVfcOeVfHxyoNYtRtYlf0pw42OQOAOltREkF2KRldNSMDC
         tqtSnV2OVqOx8n44mNilXwloRAJbDkM/O533SIHMhORGJ4xXtksK22peEwLCFfsH+6Sc
         TmYQ==
X-Gm-Message-State: AOUpUlEbEKWq4LOHsOZeaGvVQoQXXWExIdVFLk/q1idvsjIwrvS5DqYW
        xbA0/UJRKRH6s2Owi4QJWd0Syg==
X-Google-Smtp-Source: AAOMgpc5Br8+JhS2IvGHJqm7mdg7blEnA9WdZupRMQPDN3u2xJuX6Cg3OM6cYzHcICjd7TuOhY4xXg==
X-Received: by 2002:a50:b2c6:: with SMTP id p64-v6mr21852448edd.293.1533638488190;
        Tue, 07 Aug 2018 03:41:28 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b58-v6sm1136472ede.37.2018.08.07.03.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 03:41:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] ACPI / scan: Fix acpi_is_indirect_io_slave()
 always returning false
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
        linux-i2c@vger.kernel.org, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dann Frazier <dann.frazier@canonical.com>,
        Linuxarm <linuxarm@huawei.com>
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-2-hdegoede@redhat.com>
 <03dae627-a888-317a-ed43-6c374b1b54eb@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7d0cb757-a1a1-27bd-170c-87f602d5c22c@redhat.com>
Date:   Tue, 7 Aug 2018 12:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <03dae627-a888-317a-ed43-6c374b1b54eb@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-08-18 12:05, John Garry wrote:
> On 07/08/2018 09:05, Hans de Goede wrote:
>> Since commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to
>> initialize ACPI_TYPE_DEVICE devs") the status field of normal acpi_devices
>> gets set to 0 by acpi_bus_type_and_status() and filled with its actual
>> value later when acpi_add_single_object() calls acpi_bus_get_status().
>>
>> This means that status is 0 when acpi_device_enumeration_by_parent()
>> gets called which makes the acpi_match_device_ids() call in
>> acpi_is_indirect_io_slave() always return -ENOENT.
> 
> For for the (child) device the status may be zero, but how about the parent device (which is what we care about)? As I see, we would have set the parent device status present field at this stage.

Ah I did not notice you were calling acpi_match_device_ids() on the parents.
Yes I think you are right. This commit is still a necessary part of the
series, but it needs a completely new commit message no longer
referencing acpi_is_indirect_io_slave().

I will submit a v4 of this patch-set with new commit message for this patch.

Regards,

Hans






> 
> Thanks,
> John
> 
>>
>> This commit fixes this by making acpi_bus_type_and_status() set status to
>> ACPI_STA_DEFAULT until acpi_add_single_object() calls acpi_bus_get_status()
>>
>> Fixes: dfda4492322e ("ACPI / scan: Do not enumerate Indirect IO host children")
>> Cc: stable@vger.kernel.org
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Dann Frazier <dann.frazier@canonical.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/scan.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 970dd87d347c..6799d00dd790 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1612,7 +1612,8 @@ static int acpi_add_single_object(struct acpi_device **child,
>>       * Note this must be done before the get power-/wakeup_dev-flags calls.
>>       */
>>      if (type == ACPI_BUS_TYPE_DEVICE)
>> -        acpi_bus_get_status(device);
>> +        if (acpi_bus_get_status(device) < 0)
>> +            acpi_set_device_status(device, 0);
>>
>>      acpi_bus_get_power_flags(device);
>>      acpi_bus_get_wakeup_device_flags(device);
>> @@ -1690,7 +1691,7 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
>>           * acpi_add_single_object updates this once we've an acpi_device
>>           * so that acpi_bus_get_status' quirk handling can be used.
>>           */
>> -        *sta = 0;
>> +        *sta = ACPI_STA_DEFAULT;
>>          break;
>>      case ACPI_TYPE_PROCESSOR:
>>          *type = ACPI_BUS_TYPE_PROCESSOR;
>>
> 
> 
