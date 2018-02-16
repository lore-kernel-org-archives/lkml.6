Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758011AbeBPOqE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:46:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53943 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbeBPOqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:46:00 -0500
X-Google-Smtp-Source: AH8x227hh+OnlFy4bgmXS5Ml1nOWY+Guamx74TK4+ii53vAF9wwDs3nibSxr23ObWpe4+7wmw2goDQ==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: libata: disable LPM for Crucial BX100 SSD drives
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <dce01c88-b1dc-dc9c-4073-3b407633d012@redhat.com>
Date: Fri, 16 Feb 2018 22:45:50 +0800
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CBB5390E-5AEC-45AE-9DDE-5CCA7F50655E@canonical.com>
References: <20180215190023.25575-1-kai.heng.feng@canonical.com>
 <dce01c88-b1dc-dc9c-4073-3b407633d012@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 16 Feb 2018, at 6:34 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
> Hi,
> 
> On 15-02-18 20:00, Kai-Heng Feng wrote:
>> After Laptop Mode Tools starts to use min_power for LPM, a user found
>> out Crucial BX100 SSD can't get mounted.
>> Crucial BX100 SSD drives don't work well with min_power. This also
>> happens to med_power_with_dipm.
>> So let's disable LPM for Crucial BX100 SSD drives.
> 
> First of all thank you for your patch for this.
> 
> Compared to a similar patch which I just submitted for MX100 device
> 2 things stand out:
> 
> 1) The entry my patch adds needed to be above the queued TRIM
> entries because there is a more generic entry matching the SSD
> below, it might be good to group all entries together there.

Sure. I’ll rebase mine on top of yours.
Also the model name “CT500BX100SSD1” doesn’t contain “Micron”, so it
should not match to other quirks...

> 
> 2) Your reporter has a 500GB model and as mentioned in my
> patch I've noticed that all reporters (there are multiple
> for my model) all have the 500GB version, so I think we should
> restrict this to the 500GB version for now ?

My guess is that all of them use the same firmware/controller.
But you are right, for now we should just match this specific
model.

> 
> I also noticed that your reporter reports a firmware
> version of "MU02" and so does mine, where as the
> "queued TRIM" blacklist entries all check for a version
> of "MU01", could it be that the non 500GB and 500GB
> versions have different firmware ?  What about the queued
> trim quirks, do we maybe also need that for the MU02 version?

I don’t see this SSD model on other Launchpad bugs, so I don’t
have the answer.

The user doesn’t report any TRIM issue (yet), so I guess LPM quirk
alone is good for now. We can also match MU02 to be even more
restrictive.

Kai-Heng

> 
> Regards,
> 
> Hans
> 
> 
> 
>> BugLink: https://bugs.launchpad.net/bugs/1726930
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/ata/libata-core.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 3c09122bf038..577cf820eed4 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4592,6 +4592,14 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>  +	/*
>> +	 * Crucial BX100 SSD has broken min_power and med_power_with_dipm
>> +	 * support.
>> +	 *
>> +	 * https://bugs.launchpad.net/bugs/1726930
>> +	 */
>> +	{ "CT*BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
>> +
>>  	/* End Marker */
>>  	{ }
>>  };
