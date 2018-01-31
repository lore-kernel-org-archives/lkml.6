Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeAaE1P convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 23:27:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeAaE1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 23:27:13 -0500
X-Google-Smtp-Source: AH8x226aeLHPx9syUQxQSiGrS5q1meNvzjOdGX49uzqiVZux0U9wGHirnDSfVz+d5pekrs5v48p3gw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] ACPI: Parse entire table as a term_list for Dell XPS 9570
 and Precision M5530
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED5396EE01A@ORSMSX110.amr.corp.intel.com>
Date: Wed, 31 Jan 2018 12:27:05 +0800
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Moore, Robert" <robert.moore@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F7055E4B-0765-45C2-8290-16204EA85B77@canonical.com>
References: <20180130060744.19049-1-kai.heng.feng@canonical.com>
 <CAHp75VdPQuEwNOOakvZpC1gzWB9p5yx+CHUjRgMDZ9ZDvxGckQ@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED5396EE01A@ORSMSX110.amr.corp.intel.com>
To: "Schmauss, Erik" <erik.schmauss@intel.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 31 Jan 2018, at 2:37 AM, Schmauss, Erik <erik.schmauss@intel.com> wrote:
> 
> Hi,
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>> Sent: Tuesday, January 30, 2018 10:18 AM
>> To: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; ACPI
>> Devel Maling List <linux-acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
>> kernel@vger.kernel.org>; Mario Limonciello <mario.limonciello@dell.com>
>> Subject: Re: [PATCH] ACPI: Parse entire table as a term_list for Dell XPS 9570 and
>> Precision M5530
>> 
>> On Tue, Jan 30, 2018 at 8:07 AM, Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>>> The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work out
>>> of box.
>>> 
>>> The touchpad relies on its _INI method to update its _HID value from
>>> XXXX0000 to SYNA2393.
>>> Also, the _STA relies on value of I2CN to report correct status.
>>> 
>>> Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
>>> correctly set up, and _INI can get run. The ACPI table in this machine
>>> is designed to get parsed this way.
> 
> I thought I would give everyone an update: we are getting close to finishing patches to enable this term list parsing by default as well as a few other fixes with forward referencing of package elements. Once we have established that these patches are stable, we will get rid of acpi_gbl_parse_table_as_term_list. So this quirk may not be needed in the near future…

I am aware it will land into mainline soon, the target version is v4.17 IIRC.
Since the laptops in question are going to hit the market soon,
we want to support it sooner rather then later.

Also, as Mario pointed out, backport is a big factor here.
v4.14 is the current LTS kernel, v4.15 will be used in Ubuntu 18.04,
both of them will have lots of users.
So being able to backport to v4.14 and v4.15 is quite important.

Kai-Heng

> 
> Erik
>>> 
>>> Also, change the quirk table to a more generic name.
>> 
>>> +static int set_gbl_term_list(const struct dmi_system_id *id) {
>>> +       pr_notice("%s detected - parse the entire table as a term_list\n",
>>> +                 id->ident);
>>> +       acpi_gbl_parse_table_as_term_list = 1;
>>> +       return 0;
>>> +}
>>> #endif
>> 
>> The above should be outside of another #ifdef. Basically after the above #endif.
>> 
>>> #else
>> 
>>> #endif
>> 
>>> @@ -1005,7 +1034,7 @@ void __init acpi_early_init(void)
>> 
>>>         * If the machine falls into the DMI check table,
>>>         * DSDT will be copied to memory
>>>         */
>> 
>> It might make sense to adjust comment above that it's about quirks in general.
>> And, if needed, move current content to actual DMI group of records.
>> 
>>> -       dmi_check_system(dsdt_dmi_table);
>>> +       dmi_check_system(acpi_quirks_dmi_table);
>> 
>> --
>> With Best Regards,
>> Andy Shevchenko
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the body of
>> a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
