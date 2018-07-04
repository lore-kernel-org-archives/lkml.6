Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF014C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719ED2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719ED2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbeGDJnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:43:11 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:41652 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeGDJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:42:44 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 42E7041AA2; Wed,  4 Jul 2018 11:42:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 3921A41AA1;
        Wed,  4 Jul 2018 11:42:40 +0200 (CEST)
Date:   Wed, 4 Jul 2018 11:42:40 +0200 (CEST)
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
In-Reply-To: <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807041119360.8194@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com> <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 12:09 PM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>>
>>> On Wed, Jul 4, 2018 at 9:37 AM, Nikolaus Voss
>>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>>
>>>> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>>>>
>>>>>
>>>>> On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
>>>>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>>>>
>>>>>>
>>>>>> struct i2c_device_id argument of probe() is not used, so use
>>>>>> probe_new()
>>>>>> instead.
>>>>>>
>>>>>
>>>>> This makes...
>>>>>
>>>>>>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>>>>>
>>>>>
>>>>>
>>>>> ...this table obsolete IIUC. At least that's what I did when switched
>>>>> to ->probe_new() in some drivers.
>>>>>
>>>>> If I'm mistaken (again? :-) ) I would hear from someone to point me
>>>>> how it can be used after a switch.
>>>>
>>>>
>>>>
>>>> It is still used by the i2c-core in i2c_device_match() if DT and ACPI
>>>> matching fails.
>>>
>>>
>>>> And it is used to create the corresponding modaliases for
>>>> driver loading.
>>>
>>>
>>> My question is "How?!"
>>> I don't really see any points to match against it after switching to
>>> ->probe_new().
>>>
>>> Could you point me to the code path in i2c (or OF?) core for that?
>>
>>
>> As written above in i2c-core-base.c: i2c_device_match() ->
>> i2c_match_id(driver->id_table,...
>>
>> This is used for driver matching before probe() or probe_new() of the device
>> driver can be called. probe_new() actually is a function signature change
>> only.
>
> Okay, IIUC we got a match. What should we do with it? The table is not
> used in ->probe_new() (in i2c core), so, you can't say which line
> matched there.

The table is not used by the driver, but is necessary to

a) bind an i2c device declared via i2c_board_info with type field set
    to one of the names of the i2c_device_id table to this driver
b) bind an i2c device declared via DT or ACPI but with no match in of_id/
    acpi_id table but an i2c_device_id table match to this driver (fallback
    matching)
c) create the right modaliases at compile time for this driver to make
    module auto-loading work in case of a) and b)

Niko
