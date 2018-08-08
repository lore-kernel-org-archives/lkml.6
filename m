Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC01CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B69A21990
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B69A21990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeHHRQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:16:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39121 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:16:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so2295389wre.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 07:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9vhfNAgdj5W8QZ1VKpMcCJdWyXP5EC18tA1bq4tqvEY=;
        b=MKpq0Hq8/1vIrn/xf6Hfgke9haWhKChTEfmXfH6taCSQmk30strOmamLiHgwhq/m+h
         WTCDsa+5CceHmSqAia14HW14yh/HCK4OFZKli0kR7cb/qJ9xz28RaKTlxBqpaexn8pKL
         MuKgVqiGeHxQ0bm23fLmuWgBw/cyvPxtvUT5Ktyv8W102/40zhCm49zMrmiJuM4HDQqW
         y/B6Nnn3ZXlvv3kKNsJDfYdhd7IkzCL5dlWAMffOYbZd6yGKi0MW1lh3HKCVHT/unWC9
         7vL4+mEcwOE+m6ikNVKkNLUJ5YS0zMuWLo+tA0td+cHra+5TfY7bN568DWnDkB6z1khj
         7J2Q==
X-Gm-Message-State: AOUpUlEeNnsX5etFxy1zE9wzIgMa+fPI/7TYOdCoeIZOEuXUMqntA2+n
        NUg0ssDNzYTLpuzsDVgISWKEpA==
X-Google-Smtp-Source: AA+uWPyd2cro7DytL+XLKJiaF9nRfhQCloT2YFgvoHQmDJzHFmO3ynwUCLjD8GUzVkfjSOu1mj/s2w==
X-Received: by 2002:adf:ae5a:: with SMTP id u26-v6mr2005466wrd.246.1533740214551;
        Wed, 08 Aug 2018 07:56:54 -0700 (PDT)
Received: from dhcp-44-202.space.revspace.nl (53547DC9.cm-6-5b.dynamic.ziggo.nl. [83.84.125.201])
        by smtp.gmail.com with ESMTPSA id y184-v6sm5390921wmg.17.2018.08.08.07.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 07:56:53 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
References: <20180808083006.31919-1-hdegoede@redhat.com>
 <20180808083006.31919-5-hdegoede@redhat.com>
 <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e7a065f8-7ded-c5f8-4d9c-abf27fc248b4@redhat.com>
Date:   Wed, 8 Aug 2018 16:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/08/2018 11:08 AM, Andy Shevchenko wrote:
> On Wed, Aug 8, 2018 at 11:30 AM, Hans de Goede <hdegoede@redhat.com> wrote:
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
> 
> Thanks for an update! My comments below.
> 
>> +struct i2c_inst_data {
>> +       const char *type;
>> +       int irq_idx;
>> +};
> 
>> +struct i2c_multi_inst_data {
> 
>> +       int no_clients;
> 
> Name a bit confusing. What about num_clients?

no is often used as abbreviation for "number of" so this is a quite
normal naming scheme. But if you really want me to I can do a v5
renaming this to num_clients.

> 
>> +       struct i2c_client *clients[0];
>> +};
>> +
>> +static int i2c_multi_inst_probe(struct platform_device *pdev)
>> +{
>> +       struct i2c_multi_inst_data *multi;
>> +       const struct acpi_device_id *match;
>> +       const struct i2c_inst_data *inst_data;
>> +       struct i2c_board_info board_info = {};
>> +       struct device *dev = &pdev->dev;
>> +       struct acpi_device *adev;
>> +       char name[32];
>> +       int i, ret;
>> +
>> +       match = acpi_match_device(dev->driver->acpi_match_table, dev);
>> +       if (!match) {
>> +               dev_err(dev, "Error ACPI match data is missing\n");
>> +               return -ENODEV;
>> +       }
>> +       inst_data = (const struct i2c_inst_data *)match->driver_data;
>> +
>> +       adev = ACPI_COMPANION(dev);
>> +
> 
>> +       /* Count number of clients to instantiate */
>> +       for (i = 0; inst_data[i].type; i++) {}
>> +
>> +       multi = devm_kmalloc(dev,
>> +                       offsetof(struct i2c_multi_inst_data, clients[i]),
>> +                       GFP_KERNEL);
>> +       if (!multi)
>> +               return -ENOMEM;
> 
> Here I see the following:
>   - it's kinda unusual use of offsetof()

There are actually plenty of places doing this, this is the normal way
to get the size of a struct which ends with a variable sized array.

I would prefer to keep this as is.

, perhaps i*sizeof() + sizeof()
> would be more understandable
>   - there is no guard against i == 0

i depends on the driver_data, defining a driver_data
where i == 0 is silly, still if this happens nothing bad
will happen, so I see no need for a check for this.

> 
> To solve both, it might be like
> 
> struct i2c_multi_inst_data {
>         int num_clients;
>         struct i2c_client *clients;
> };
> 
> ...
> multi = devm_kmalloc(sizeof(*multi), GFP_KERNEL);
> if (!multi)
>   return -ENOMEM;
> 
> multi->clients = devm_kcalloc(i, sizeof(*multi->clients), GFP_KERNEL);
> if (ZERO_PTR_OR_NULL(multi->clients))
>   return -ENOMEM;
> 
> But I would like to hear your (other's) opinion(s).

Nack for this option, this just makes the code more
complicated and uses allocs instead of 1 for no good
reason IMHO.

Regards,

Hans


> 
>> +
>> +       multi->no_clients = i;
>> +
>> +       for (i = 0; i < multi->no_clients; i++) {
>> +               memset(&board_info, 0, sizeof(board_info));
>> +               strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
>> +               snprintf(name, sizeof(name), "%s-%s", match->id,
>> +                        inst_data[i].type);
>> +               board_info.dev_name = name;
>> +               board_info.irq = 0;
> 
>> +               if (inst_data[i].irq_idx != -1) {
> 
>> = 0 sounds more robust
> 
>> +                       ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
>> +                       if (ret < 0) {
> 
>> +                               dev_err(dev, "Error requesting irq at index %d: %d\n",
>> +                                       inst_data[i].irq_idx, ret);
> 
> irq -> IRQ in the message.
> 
>> +                               goto error;
>> +                       }
>> +                       board_info.irq = ret;
>> +               }
>> +               multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>> +               if (!multi->clients[i]) {
>> +                       dev_err(dev, "Error creating i2c-client, idx %d\n", i);
>> +                       ret = -ENODEV;
>> +                       goto error;
>> +               }
>> +       }
>> +
>> +       platform_set_drvdata(pdev, multi);
>> +       return 0;
>> +
>> +error:
> 
>> +       while (--i >= 0)
> 
> It can be simple
> 
> while (i--)
> 
>> +               i2c_unregister_device(multi->clients[i]);
>> +
>> +       return ret;
>> +}
>> +
>> +static int i2c_multi_inst_remove(struct platform_device *pdev)
>> +{
>> +       struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
>> +       int i;
>> +
>> +       for (i = 0; i < multi->no_clients; i++)
>> +               i2c_unregister_device(multi->clients[i]);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct i2c_inst_data bsg1160_data[]  = {
>> +       { "bmc150_accel", 0 },
>> +       { "bmc150_magn", -1 },
>> +       { "bmg160", -1 },
>> +       {}
>> +};
>> +
>> +/*
>> + * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>> + * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>> + */
>> +static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>> +       { "BSG1160", (unsigned long)bsg1160_data },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
>> +
>> +static struct platform_driver i2c_multi_inst_driver = {
>> +       .driver = {
>> +               .name = "I2C multi instantiate pseudo device driver",
> 
>> +               .acpi_match_table = ACPI_PTR(i2c_multi_inst_acpi_ids),
> 
> We don't need ACPI_PTR for the driver which depends on ACPI.
> In the general case we have an inconsistency with variable definition
> (might be unused).
> 
>> +       },
>> +       .probe = i2c_multi_inst_probe,
>> +       .remove = i2c_multi_inst_remove,
>> +};
>> +module_platform_driver(i2c_multi_inst_driver);
>> +
>> +MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
>> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.18.0
>>
> 
> 
> 
