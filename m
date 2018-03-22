Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeCVCXG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:23:06 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44733 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeCVCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:23:03 -0400
X-Google-Smtp-Source: AG47ELuP46XBfJgZmkg57WgNnCl2oHnXtpCqD+6/FGfuqnQTfMJAlAYR+RsjGiJDELzF5YKJb+AsM+kO0kbTBFtKvWQ=
MIME-Version: 1.0
In-Reply-To: <20180321140422.GA10700@amd>
References: <7ff55372818461feed4b0550d5f88edce2cc7d41.1521631678.git.baolin.wang@linaro.org>
 <20180321140422.GA10700@amd>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 22 Mar 2018 10:23:02 +0800
Message-ID: <CAMz4kuK+w0GUyXOw8_35sxyxNix8Os5JPgiyaGNTFcWuzvn_nw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / PM: Use register_reboot_notifier() instead of pm_power_off_prepare
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, Len Brown <lenb@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 21 March 2018 at 22:04, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2018-03-21 19:30:16, Baolin Wang wrote:
>> We can register one notifier through register_reboot_notifier() function to
>> prepare to power off the system, then we can remove the 'pm_power_off_prepare'
>> hook in following patch.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Note: Please help to review carefully, since I have no platform to test
>> this conversion.
>>
>> I saw there is another reboot notifier in this driver, I am not sure the
>> orders between them. I can change the priority of notifier to keep their
>> orders if it is necessary.
>
> I don't understand why this is good idea... and you should really test
> it. I'm sure you can find PC or notebook somewhere...

I want to test it, but I have no opensource board with x86
architecture. But I will try to find one or ask other guys to help to
test it. Thanks for your comments.

>>  drivers/acpi/sleep.c |   22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index 46cde091..b3de894 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -1229,14 +1229,24 @@ static void acpi_sleep_hibernate_setup(void)
>>  static inline void acpi_sleep_hibernate_setup(void) {}
>>  #endif /* !CONFIG_HIBERNATION */
>>
>> -static void acpi_power_off_prepare(void)
>> +static int acpi_reboot_notify(struct notifier_block *this, unsigned long code,
>> +                           void *x)
>>  {
>> -     /* Prepare to power off the system */
>> -     acpi_sleep_prepare(ACPI_STATE_S5);
>> -     acpi_disable_all_gpes();
>> -     acpi_os_wait_events_complete();
>> +     if (code == SYSTEM_POWER_OFF) {
>> +             /* Prepare to power off the system */
>> +             acpi_sleep_prepare(ACPI_STATE_S5);
>> +             acpi_disable_all_gpes();
>> +             acpi_os_wait_events_complete();
>> +     }
>> +
>> +     return NOTIFY_DONE;
>>  }
>>
>> +static struct notifier_block acpi_reboot_notifier = {
>> +     .notifier_call  = acpi_reboot_notify,
>> +     .priority       = 0,
>> +};
>> +
>>  static void acpi_power_off(void)
>>  {
>>       /* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
>> @@ -1261,7 +1271,7 @@ int __init acpi_sleep_init(void)
>>
>>       if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
>>               sleep_states[ACPI_STATE_S5] = 1;
>> -             pm_power_off_prepare = acpi_power_off_prepare;
>> +             register_reboot_notifier(&acpi_reboot_notifier);
>>               pm_power_off = acpi_power_off;
>>       } else {
>>               acpi_no_s5 = true;
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Baolin.wang
Best Regards
