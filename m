Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F1BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B0724012
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B0724012
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeGDNAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:00:08 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:45162 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeGDNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:00:07 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 671B141C94; Wed,  4 Jul 2018 15:00:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 62A1A41C92;
        Wed,  4 Jul 2018 15:00:02 +0200 (CEST)
Date:   Wed, 4 Jul 2018 15:00:02 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
In-Reply-To: <CAHp75VcHDWFpxupECf+tgn7S1esJ6SyPtCXeKG93LDVKRv91mA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807041459110.11004@fox.voss.local>
References: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de> <CAHp75VcHDWFpxupECf+tgn7S1esJ6SyPtCXeKG93LDVKRv91mA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>
> Thanks for the patch, now I completely got it and agree on approach.
> Few comments below.
>
>> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
>> of_device_id table "compatible" strings in DSD, a pointer to the
>
> _DSD
>
>> corresponding DT table entry should be returned instead of a null
>> pointer. An acpi_device_id match still takes precedence.
>
>>  const void *acpi_device_get_match_data(const struct device *dev)
>>  {
>> -       const struct acpi_device_id *match;
>> +       const struct acpi_device_id *acpi_id = NULL;
>> +       const struct of_device_id *of_id = NULL;
>> +       const struct device_driver *drv = dev->driver;
>>
>> -       match = acpi_match_device(dev->driver->acpi_match_table, dev);
>> -       if (!match)
>
>> +       __acpi_match_device(acpi_companion_match(dev), drv->acpi_match_table,
>> +                           drv->of_match_table, &acpi_id, &of_id);
>
> Perhaps,
>
> bool match;
>
> match = __acpi_match_device(..);
> if (!match)
> return NULL;
>
> ...
>> +       if (acpi_id)
>> +               return (const void*)acpi_id->driver_data;
>> +       else if (of_id)
>> +               return (const void*)of_id->data;
>
> Actually (dbesides redundant 'else') there is no difference in which
> order you test these.
> Thus, perhaps
>
> if (of_id)
> return ...of_id...;
>
> return ...acpi_id...;
>
>> -       return (const void *)match->driver_data;
>>  }

Thanks for reviewing and feedback, posted v2...

Niko

