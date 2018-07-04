Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9256C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D5924732
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D5924732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933366AbeGDGiD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:38:03 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:38978 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753518AbeGDGiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:38:01 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 0BAEC41C92; Wed,  4 Jul 2018 08:37:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 04ED841C91;
        Wed,  4 Jul 2018 08:37:57 +0200 (CEST)
Date:   Wed, 4 Jul 2018 08:37:56 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
In-Reply-To: <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807040728490.6169@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> struct i2c_device_id argument of probe() is not used, so use probe_new()
>> instead.
>>
>
> This makes...
>
>>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>
> ...this table obsolete IIUC. At least that's what I did when switched
> to ->probe_new() in some drivers.
>
> If I'm mistaken (again? :-) ) I would hear from someone to point me
> how it can be used after a switch.

It is still used by the i2c-core in i2c_device_match() if DT and ACPI 
matching fails. And it is used to create the corresponding modaliases for 
driver loading. So it is necessary for non-DT/ non-ACPI systems and used 
for fallback matching if no match is found in of_device_ids.

>
>>
>> -static int st_accel_i2c_probe(struct i2c_client *client,
>> -                                               const struct i2c_device_id *id)
>> +static int st_accel_i2c_probe(struct i2c_client *client)
>>  {
>>         struct iio_dev *indio_dev;
>>         struct st_sensor_data *adata;
>> @@ -182,7 +181,7 @@ static struct i2c_driver st_accel_driver = {
>>                 .of_match_table = of_match_ptr(st_accel_of_match),
>>                 .acpi_match_table = ACPI_PTR(st_accel_acpi_match),
>>         },
>> -       .probe = st_accel_i2c_probe,
>> +       .probe_new = st_accel_i2c_probe,
>>         .remove = st_accel_i2c_remove,
>>         .id_table = st_accel_id_table,
>>  };
>> --
>> 2.17.1
>>
>
>
>
>

