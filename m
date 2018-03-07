Return-Path: <anjiandi@codeaurora.org>
X-Google-Smtp-Source: AG47ELstnkbGkgYly+ERreiA5w2FuJSaOOCvjt+T+HYa35YACOFMryjP/9nSNnew7tF40wxwNjbx
ARC-Seal: i=1; a=rsa-sha256; t=1520467176; cv=none;
        d=google.com; s=arc-20160816;
        b=oJJw5CI5g8qoC4k+cdGYM3zRCcu367DedyorGy9iIq3e420bG6Q6gMDTewRGBNrzWO
         ZoNNw5+t/iWroLUbN10RdY+wCG1bqlQlt9jcvh/VXzRQLlOGj5GzzBq8iMLiULBJOYZ0
         8QeuoI0EtOM/xzRIrMXZhGBFWTH7FM6qzlMCQIfo7qj/Pfg3lLvuYH8c1/srixPYuHbw
         XwS5WeFt4joFL1JiiYrTkZCWqsl5Ixh4giqDISuuULAmmNOMcZti6dfwxF75iBW0TGqI
         mnMVr/bP9noYkfk9JJarf8M8QnC2zF2rcJDec48ovNnOitir3e5mmudJXxZHXutqqnTI
         QAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=y8h0Lst9KKB6U5Ndj36B9XHftcs4D10F+a8ncLbHcus=;
        b=OOQodDvqUu5PZOB4YHi935qAundWZ/ZaPZL/e6BR04lN/xcx82qqE4rGhelVh7Zpbv
         OpgxwV/ryZZfA8sAO3M36LXZObHsmsLzhBrpnolUH8aq5WIFheUUAcw60tKHRIbrhSfl
         PQpSJiDfF3JLqEufjGBAZ+Gr8TUIfqHuxEFPQZpVon+pOwjt5OA1Rqx7gwCGkJ7LVHyL
         sXasbR+fm9Q/+hXpncbzOZk+z2hVQGigxeoam3lCKfRxX1UFvhS+FSXIVEbnHYDXfl1f
         uqVXiBZnueisf/glTNK0YjCII7usL8zS9nIHMef+WzHPsbnJJyQRCNy/gFy5KHYyBFn0
         S7jg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IhLpQ7XU;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I1HNeP0b;
       spf=pass (google.com: domain of anjiandi@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=anjiandi@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IhLpQ7XU;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I1HNeP0b;
       spf=pass (google.com: domain of anjiandi@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=anjiandi@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C77F60390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anjiandi@codeaurora.org
Subject: Re: [PATCH] ipmi:ssif: Fix double probe from tryacpi and trydmi
To: minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1520401742-29371-1-git-send-email-anjiandi@codeaurora.org>
 <fa7367db-4199-3dd6-0e51-e991a5fd97fb@acm.org>
From: Jiandi An <anjiandi@codeaurora.org>
Message-ID: <1bc40690-c46f-e7fd-1beb-37e362cd8146@codeaurora.org>
Date: Wed, 7 Mar 2018 17:59:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <fa7367db-4199-3dd6-0e51-e991a5fd97fb@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594256783530173798?=
X-GMAIL-MSGID: =?utf-8?q?1594325390345680579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/07/2018 07:34 AM, Corey Minyard wrote:
> On 03/06/2018 11:49 PM, Jiandi An wrote:
>> IPMI SSIF driver's parameter tryacpi and trydmi both
>> are set to true.  The addition of IPMI DMI driver to
>> create platform device for each IPMI device causes
>> SSIF probe to be done twice on the same SMB I2C address
>> for BMC.  Fix is to not call trydmi if tryacpi is able
>> to find I2C address for BMC from SPMI ACPI table and
>> probe successfully.
> 
> Why are you trying to do this?  Is something bad happening?
> 
> SPMI is not the preferred mechanism for detecting a device,
> the preferred mechanism should be the acpi match table or
> OF, followed by DMI, followed by SPMI.  In fact, it might be
> best to just remove SPMI.
> 
> -corey


On our ARM64 platform, SSIF is the IPMI interface for host to
BMC communication and it is described in ACPI SPMI table including
the I2C address.  The driver would get the SSIF device from
IPI0001 ssif_acpi_match[] and probe.  It worked fine with no issues.

Then it was reported dmidecode does not show the correct SSIF
device information including correct I2C address.  So SSIF device
description is also added in SMBIOS table.  It worked fine with no
issues until this patch.

0944d88 ipmi: Convert DMI handling over to a platform device

We would see error message indicating trydmi via
platform_driver_register fails with -EEXIST during boot.

[    9.385758] ipmi_ssif: probe of dmi-ipmi-ssif.0 failed with error -17

This is because tryacpi ran first and successfully completed
new_ssif_client() (which adds address to ssif_info) and eventually
ssif_probe()

ssif_tryacpi
     spmi_find_bmc()
         try_init_spmi()
             new_ssif_client()

Since both tryacpi and trydmi are set to true as module parameter
with no permission and not exposed to /sys/module/ipmi_ssif/parameters,
it triggers the following path down to dmi_ipmi_probe() and
new_ssif_client() which fails ssif_info_find() finds the address
added to ssif_info already in the ssif_tryacpi path.

ssif_trydmi
     platform_driver_register(&ipmi_driver)
         __platform_driver_register()
             driver_register()
                 bus_add_driver()
                     driver_attach()
                         bus_for_each_dev()
                             __driver_attach()
                                 driver_probe_device()
                                     ssif_platform_probe()
                                         dmi_ipmi_probe()
                                             new_ssif_client()

Are you suggesting to not do tryacpi at all and just rely on
trydmi?

I was looking at the following patch to understand more about
the added ipmi_dmi driver.

9f88145 ipmi: Create a platform device for a DMI-specified IPMI interface

It's creating a platform device for each IPMI device in the DMI
table including SSIF device, for auto-loading IPMI devices from
SMBIOS tables.

Are you suggesting removing SSIF device description from ACPI
SPMI table and remove ssif_tryacpi logic all together?

But the commit description mentions ...

"This also adds the ability to extract the slave address from
the SMBIOS tables, so that when the driver uses ACPI-specified
interfaces, it can still extract the slave address from SMBIOS."

This made me think SSIF driver can still use ACPI-specified
interface.  It made me think it implies SSIF device can be
described in ACPI SPMI table and SMBIOS table.  Both spec
did not say they cannot.

What's your recommended way of fixing this double probing?

Thanks


> 
>> Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
>> ---
>>   drivers/char/ipmi/ipmi_ssif.c | 35 ++++++++++++++++++++++++-----------
>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_ssif.c 
>> b/drivers/char/ipmi/ipmi_ssif.c
>> index 9d3b0fa..5c57363 100644
>> --- a/drivers/char/ipmi/ipmi_ssif.c
>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>> @@ -1981,29 +1981,41 @@ static int try_init_spmi(struct SPMITable *spmi)
>>       return new_ssif_client(myaddr, NULL, 0, 0, SI_SPMI, NULL);
>>   }
>> -static void spmi_find_bmc(void)
>> +static int spmi_find_bmc(void)
>>   {
>>       acpi_status      status;
>>       struct SPMITable *spmi;
>>       int              i;
>> +    int              rc = 0;
>>       if (acpi_disabled)
>> -        return;
>> +        return -EPERM;
>>       if (acpi_failure)
>> -        return;
>> +        return -ENODEV;
>>       for (i = 0; ; i++) {
>>           status = acpi_get_table(ACPI_SIG_SPMI, i+1,
>>                       (struct acpi_table_header **)&spmi);
>> -        if (status != AE_OK)
>> -            return;
>> +        if (status != AE_OK) {
>> +            if (i == 0)
>> +                return -ENODEV;
>> +            else
>> +                return 0;
>> +        }
>> -        try_init_spmi(spmi);
>> +        rc = try_init_spmi(spmi);
>> +        if (rc)
>> +            return rc;
>>       }
>> +
>> +    return 0;
>>   }
>>   #else
>> -static void spmi_find_bmc(void) { }
>> +static int spmi_find_bmc(void)
>> +{
>> +    return -ENODEV;
>> +}
>>   #endif
>>   #ifdef CONFIG_DMI
>> @@ -2104,12 +2116,13 @@ static int init_ipmi_ssif(void)
>>                      addr[i]);
>>       }
>> -    if (ssif_tryacpi)
>> +    if (ssif_tryacpi) {
>>           ssif_i2c_driver.driver.acpi_match_table    =
>>               ACPI_PTR(ssif_acpi_match);
>> -
>> -    if (ssif_tryacpi)
>> -        spmi_find_bmc();
>> +        rv = spmi_find_bmc();
>> +        if (!rv)
>> +            ssif_trydmi = false;
>> +    }
>>       if (ssif_trydmi) {
>>           rv = platform_driver_register(&ipmi_driver);
> 
> 

-- 
Jiandi An
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
