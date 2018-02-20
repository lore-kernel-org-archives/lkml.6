Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeBTIwZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:52:25 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45144 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeBTIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:52:24 -0500
X-Google-Smtp-Source: AH8x224l7Oko+c3+aRNJLfLisNtFVUlLs6cGWtoqy5u4PSP0HTQ9hlLtgMvD6MVecTSd6o4PQoHpgblnC6gCx+8b5R8=
MIME-Version: 1.0
In-Reply-To: <CAP_ceTzdA6TgO4H2CCa4rJOjQvLL4tfFD8DnCZeJp67rWiSrdg@mail.gmail.com>
References: <20180219224043.21383-1-enric.balletbo@collabora.com> <CAP_ceTzdA6TgO4H2CCa4rJOjQvLL4tfFD8DnCZeJp67rWiSrdg@mail.gmail.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 20 Feb 2018 09:52:22 +0100
Message-ID: <CAFqH_53KekHzh_WGBN8WVFexb3DRCpu-pW4ffv3U0U7NUe99nw@mail.gmail.com>
Subject: Re: [PATCH 2/6] mfd: cros_ec: free IRQ automatically
To: Vincent Palatin <vpalatin@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

2018-02-20 9:00 GMT+01:00 Vincent Palatin <vpalatin@chromium.org>:
> On Mon, Feb 19, 2018 at 11:40 PM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> From: Vincent Palatin <vpalatin@chromium.org>
>>
>> Free the IRQ we might have requested when removing the cros_ec device,
>> so we can unload and reload the driver properly.
>>
>> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>  drivers/mfd/cros_ec.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index 74780f2964a1..d1a4fbee9380 100644
>> --- a/drivers/mfd/cros_ec.c
>> +++ b/drivers/mfd/cros_ec.c
>> @@ -119,9 +119,9 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>         }
>>
>>         if (ec_dev->irq) {
>> -               err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
>> -                                          IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> -                                          "chromeos-ec", ec_dev);
>> +               err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
>> +                               ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> +                               "chromeos-ec", ec_dev);
>>                 if (err) {
>>                         dev_err(dev, "Failed to request IRQ %d: %d",
>>                                 ec_dev->irq, err);
>> @@ -135,7 +135,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>                 dev_err(dev,
>>                         "Failed to register Embedded Controller subdevice %d\n",
>>                         err);
>> -               goto fail_mfd;
>> +               return err;
>>         }
>>
>>         if (ec_dev->max_passthru) {
>> @@ -153,7 +153,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>                         dev_err(dev,
>>                                 "Failed to register Power Delivery subdevice %d\n",
>>                                 err);
>> -                       goto fail_mfd;
>> +                       return err;
>>                 }
>>         }
>>
>> @@ -162,7 +162,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>                 if (err) {
>>                         mfd_remove_devices(dev);
>>                         dev_err(dev, "Failed to register sub-devices\n");
>> -                       goto fail_mfd;
>> +                       return err;
>>                 }
>>         }
>>
>> @@ -180,11 +180,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>         cros_ec_acpi_install_gpe_handler(dev);
>>
>>         return 0;
>> -
>> -fail_mfd:
>> -       if (ec_dev->irq)
>> -               free_irq(ec_dev->irq, ec_dev);
>> -       return err;
>>  }
>>  EXPORT_SYMBOL(cros_ec_register);
>
>
> You need to remove the "free_irq(ec_dev->irq, ec_dev);" in cros_ec_remove() too.
> as done there:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/866858/15/drivers/mfd/cros_ec.c
>
> it was missing originally but was added by: 'f58b14e6632a mfd:
> cros_ec: Free IRQ on exit'
>

Many thanks to catch this. I'll wait a bit more for if I receive more
feedback on the other patches and send a second version of this
patchset.

Regards,
  Enric

>
>>
>> --
>> 2.16.1
>>
