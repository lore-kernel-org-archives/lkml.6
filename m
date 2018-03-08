Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeCHRTB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:19:01 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41196 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeCHRTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:19:00 -0500
X-Google-Smtp-Source: AG47ELvFc9Ndty4ajyIi3HiyetIx7RsTv5Aj2EtXsAl/LSiXXbAU6GvhW1vIvdU5DoBSbrj/Ise4v8kUcdLm55Qn3ZI=
MIME-Version: 1.0
In-Reply-To: <20180307165126.do5ecbm7ne2llmhb@dell>
References: <20180226150739.13457-1-andrew.smirnov@gmail.com> <20180307165126.do5ecbm7ne2llmhb@dell>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 8 Mar 2018 09:18:58 -0800
Message-ID: <CAHQ1cqFBxkd3h4X9v5CQVv+Byz1qeSz5FmvjL42ARt1R2xvc1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: rave-sp: Add code to print firmware versions
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 8:51 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 26 Feb 2018, Andrey Smirnov wrote:
>
>> Add code that would query and print out bootloader and application
>> firmware version info.
>>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: cphealy@gmail.com
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>
>> Lee:
>>
>> The reason 'part_number_firmware' and 'part_number_firmware' are a
>> part of struct rave_sp is because there exists another patch on top of
>> this one that exposes those fields via sysfs. The latter patch is not
>> currently being upstreamed (might be in the future), so if keeping
>> this arrangement is too ugly, let me know, and I'll get rid of those
>> fields in 'rave_sp'.
>
> That's okay.
>
>>  drivers/mfd/rave-sp.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
>> index c8173de5653a..9e4c83ff2aec 100644
>> --- a/drivers/mfd/rave-sp.c
>> +++ b/drivers/mfd/rave-sp.c
>> @@ -160,6 +160,8 @@ struct rave_sp_variant {
>>   * @variant:                 Device variant specific information
>>   * @event_notifier_list:     Input event notification chain
>>   *
>> + * @part_number_firmware:    Firmware version
>> + * @part_number_bootloader:  Bootloader version
>>   */
>>  struct rave_sp {
>>       struct serdev_device *serdev;
>> @@ -171,8 +173,42 @@ struct rave_sp {
>>
>>       const struct rave_sp_variant *variant;
>>       struct blocking_notifier_head event_notifier_list;
>> +
>> +     const char *part_number_firmware;
>> +     const char *part_number_bootloader;
>>  };
>>
>> +struct rave_sp_version {
>> +     u8     hardware;
>> +     __le16 major;
>> +     u8     minor;
>> +     u8     letter[2];
>> +} __packed;
>> +
>> +struct rave_sp_status {
>> +     struct rave_sp_version bootloader_version;
>> +     struct rave_sp_version firmware_version;
>> +     u16 rdu_eeprom_flag;
>> +     u16 dds_eeprom_flag;
>> +     u8  pic_flag;
>> +     u8  orientation;
>> +     u32 etc;
>> +     s16 temp[2];
>> +     u8  backlight_current[3];
>> +     u8  dip_switch;
>> +     u8  host_interrupt;
>> +     u16 voltage_28;
>> +     u8  i2c_device_status;
>> +     u8  power_status;
>> +     u8  general_status;
>> +#define RAVE_SP_STATUS_GS_FIRMWARE_MODE      BIT(1)
>
> I'm more concerned with the seemingly unused #define shoved in the
> middle of a struct definition -- which I am not a fan of.
>
> Better to introduce it when you start using it and outside of the
> struct definition please.
>
> The remainder of the patch looks okay.

OK, will fix in v2.

Thanks,
Andrey Smirnov
