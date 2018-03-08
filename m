Return-Path: <tcminyard@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520518238; cv=none;
        d=google.com; s=arc-20160816;
        b=lLlgyqU5yo+uzERv9cWWcdtApnByo/de5JsNgrzni/JG9bXO2qs242grvJ/D90MC0g
         AGEYJBP7bYPpakH0SKqwBxagpZyl2OxhOTT2atUU672Uq5x1Zjqt7fiJ4dTmlCxeqCBM
         Ga7eFWJBQlJ3vAv83A+1DaQUGxUiu9p4nNfWe1tNiXXMAxAMV4UO3oOQwiRfWwgJ314i
         TvMr7+1rtE4sMu90rNC6+X1ki8IWvhf9RtIx/3SlUvmTNBcF0kitZfgLqNj4JLqLKmed
         9CHoM1TUYy7pPfMaAqOujz6Dp66lrQ7NGWlKQ9ArFbGso4RXe8bHzkfsm4omQWoby9Vp
         Xezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :sender:dkim-signature:arc-authentication-results;
        bh=cCGIpwcc3l3yzS4r0y0GjaTm5aSYTv/cTG4d1TGpr0o=;
        b=swZ7bEd9IzHLqhE/TrZNe4ae/fiv1U7wq7e4sImTlIyaro5nJbcQyDnOpvVQ6aNuj4
         kU+iZpcEHAsWbyn2YXYv20ibaaMpEk6MtNmVqIuePFk1Cf57IyouZd7TKimK4rEEbu/f
         Mfn0Jx/ahVeWyucsAH2C1GLrefQcDq6BSNM0wvpNw/vnWEO2QfJF1BJdWIs/s6oayAQ5
         0TlNAI22vJo1uaNi63P2Vp77wGG1yt4dt2PsVNLwhujo1VFNRNfXZH8e5gqb1FBlOIOS
         ZyAmavVBsx4qR0dohK2Mcv6UWYvh2qyzm1gli0Iq8vdNOa2WJpk24Q+yTEAuf1hNncyg
         FVIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JAP5ZmG8;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JAP5ZmG8;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
X-Google-Smtp-Source: AG47ELuEMFNZSrJFJs4FvANTTrJKHPihNYK27zH87K5YPrUuvkqAtAHBFJnbQHgTyhauujB4OFB5dQ==
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi:ssif: Fix double probe from tryacpi and trydmi
To: Jiandi An <anjiandi@codeaurora.org>, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1520401742-29371-1-git-send-email-anjiandi@codeaurora.org>
 <fa7367db-4199-3dd6-0e51-e991a5fd97fb@acm.org>
 <1bc40690-c46f-e7fd-1beb-37e362cd8146@codeaurora.org>
From: Corey Minyard <minyard@acm.org>
Message-ID: <7814a839-a718-7437-3f69-8b4f090ccbcf@acm.org>
Date: Thu, 8 Mar 2018 08:10:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1bc40690-c46f-e7fd-1beb-37e362cd8146@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594256783530173798?=
X-GMAIL-MSGID: =?utf-8?q?1594378932408017206?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 05:59 PM, Jiandi An wrote:
>
>
> On 03/07/2018 07:34 AM, Corey Minyard wrote:
>> On 03/06/2018 11:49 PM, Jiandi An wrote:
>>> IPMI SSIF driver's parameter tryacpi and trydmi both
>>> are set to true.  The addition of IPMI DMI driver to
>>> create platform device for each IPMI device causes
>>> SSIF probe to be done twice on the same SMB I2C address
>>> for BMC.  Fix is to not call trydmi if tryacpi is able
>>> to find I2C address for BMC from SPMI ACPI table and
>>> probe successfully.
>>
>> Why are you trying to do this?  Is something bad happening?
>>
>> SPMI is not the preferred mechanism for detecting a device,
>> the preferred mechanism should be the acpi match table or
>> OF, followed by DMI, followed by SPMI.  In fact, it might be
>> best to just remove SPMI.
>>
>> -corey
>
>
> On our ARM64 platform, SSIF is the IPMI interface for host to
> BMC communication and it is described in ACPI SPMI table including
> the I2C address.  The driver would get the SSIF device from
> IPI0001 ssif_acpi_match[] and probe.  It worked fine with no issues.
>
> Then it was reported dmidecode does not show the correct SSIF
> device information including correct I2C address.  So SSIF device
> description is also added in SMBIOS table.  It worked fine with no
> issues until this patch.
>
> 0944d88 ipmi: Convert DMI handling over to a platform device
>
> We would see error message indicating trydmi via
> platform_driver_register fails with -EEXIST during boot.
>
> [    9.385758] ipmi_ssif: probe of dmi-ipmi-ssif.0 failed with error -17
>
> This is because tryacpi ran first and successfully completed
> new_ssif_client() (which adds address to ssif_info) and eventually
> ssif_probe()
>
> ssif_tryacpi
>     spmi_find_bmc()
>         try_init_spmi()
>             new_ssif_client()
>
> Since both tryacpi and trydmi are set to true as module parameter
> with no permission and not exposed to /sys/module/ipmi_ssif/parameters,
> it triggers the following path down to dmi_ipmi_probe() and
> new_ssif_client() which fails ssif_info_find() finds the address
> added to ssif_info already in the ssif_tryacpi path.
>
> ssif_trydmi
>     platform_driver_register(&ipmi_driver)
>         __platform_driver_register()
>             driver_register()
>                 bus_add_driver()
>                     driver_attach()
>                         bus_for_each_dev()
>                             __driver_attach()
>                                 driver_probe_device()
>                                     ssif_platform_probe()
>                                         dmi_ipmi_probe()
>                                             new_ssif_client()
>
> Are you suggesting to not do tryacpi at all and just rely on
> trydmi?

Basically, yes.  SPMI is really designed for early detection of interfaces
before ACPI proper comes up.  You should have the IPMI device in your
ACPI tree.

My inclination is to remove SPMI support from the IPMI driver.

-corey

>
> I was looking at the following patch to understand more about
> the added ipmi_dmi driver.
>
> 9f88145 ipmi: Create a platform device for a DMI-specified IPMI interface
>
> It's creating a platform device for each IPMI device in the DMI
> table including SSIF device, for auto-loading IPMI devices from
> SMBIOS tables.
>
> Are you suggesting removing SSIF device description from ACPI
> SPMI table and remove ssif_tryacpi logic all together?
>
> But the commit description mentions ...
>
> "This also adds the ability to extract the slave address from
> the SMBIOS tables, so that when the driver uses ACPI-specified
> interfaces, it can still extract the slave address from SMBIOS."
>
> This made me think SSIF driver can still use ACPI-specified
> interface.  It made me think it implies SSIF device can be
> described in ACPI SPMI table and SMBIOS table.  Both spec
> did not say they cannot.
>
> What's your recommended way of fixing this double probing?
>
> Thanks
>
>
>>
>>> Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
>>> ---
>>>   drivers/char/ipmi/ipmi_ssif.c | 35 
>>> ++++++++++++++++++++++++-----------
>>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/char/ipmi/ipmi_ssif.c 
>>> b/drivers/char/ipmi/ipmi_ssif.c
>>> index 9d3b0fa..5c57363 100644
>>> --- a/drivers/char/ipmi/ipmi_ssif.c
>>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>>> @@ -1981,29 +1981,41 @@ static int try_init_spmi(struct SPMITable 
>>> *spmi)
>>>       return new_ssif_client(myaddr, NULL, 0, 0, SI_SPMI, NULL);
>>>   }
>>> -static void spmi_find_bmc(void)
>>> +static int spmi_find_bmc(void)
>>>   {
>>>       acpi_status      status;
>>>       struct SPMITable *spmi;
>>>       int              i;
>>> +    int              rc = 0;
>>>       if (acpi_disabled)
>>> -        return;
>>> +        return -EPERM;
>>>       if (acpi_failure)
>>> -        return;
>>> +        return -ENODEV;
>>>       for (i = 0; ; i++) {
>>>           status = acpi_get_table(ACPI_SIG_SPMI, i+1,
>>>                       (struct acpi_table_header **)&spmi);
>>> -        if (status != AE_OK)
>>> -            return;
>>> +        if (status != AE_OK) {
>>> +            if (i == 0)
>>> +                return -ENODEV;
>>> +            else
>>> +                return 0;
>>> +        }
>>> -        try_init_spmi(spmi);
>>> +        rc = try_init_spmi(spmi);
>>> +        if (rc)
>>> +            return rc;
>>>       }
>>> +
>>> +    return 0;
>>>   }
>>>   #else
>>> -static void spmi_find_bmc(void) { }
>>> +static int spmi_find_bmc(void)
>>> +{
>>> +    return -ENODEV;
>>> +}
>>>   #endif
>>>   #ifdef CONFIG_DMI
>>> @@ -2104,12 +2116,13 @@ static int init_ipmi_ssif(void)
>>>                      addr[i]);
>>>       }
>>> -    if (ssif_tryacpi)
>>> +    if (ssif_tryacpi) {
>>>           ssif_i2c_driver.driver.acpi_match_table    =
>>>               ACPI_PTR(ssif_acpi_match);
>>> -
>>> -    if (ssif_tryacpi)
>>> -        spmi_find_bmc();
>>> +        rv = spmi_find_bmc();
>>> +        if (!rv)
>>> +            ssif_trydmi = false;
>>> +    }
>>>       if (ssif_trydmi) {
>>>           rv = platform_driver_register(&ipmi_driver);
>>
>>
>
