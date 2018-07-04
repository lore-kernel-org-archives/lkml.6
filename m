Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E90C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5CA20841
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5CA20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934704AbeGDLq2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:46:28 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:43936 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932758AbeGDLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:46:24 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 1E57441B00; Wed,  4 Jul 2018 13:46:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 19FB941AFB;
        Wed,  4 Jul 2018 13:46:19 +0200 (CEST)
Date:   Wed, 4 Jul 2018 13:46:19 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Javier Martinez Canillas <javier@dowhile0.org>
cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
In-Reply-To: <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com> <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com> <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
> Hi Nikolaus,
>
> On Wed, Jul 4, 2018 at 1:15 PM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
>
> [snip]
>
>>> I think Nikolaus is correct, assuming that the driver can be used on
>>> legacy
>>> platforms that register the I2C devices using board files / platform data.
>>> In that case you still need a I2C device ID table for (a) and (c) as he
>>> said.
>>>
>>> I don't buy on (b) though, that's a bug in my opinion. If you register an
>>> I2C
>>> device via DT then you must have a OF device ID entry that matches the
>>> device
>>> and the same for ACPI. You can't rely on the I2C device table to do the
>>> match.
>>
>>
>> Ok, in my opinion it is an elegant way of not bloating the driver when no
>> explicit handling (e.g. reading DT properties) is needed. Just adding an
>> of_device_id doesn't change any driver functionality then but only maps to
>> an already existing i2c_table_id.
>>
>
> I disagree, in the case of OF for example a compatible string is
> composed of both a vendor a device, the complete tuple is what should
> be matched.
>
> But with the fallback, only the device portion would be used so both
> <foo,bar> and <baz,bar> will match against the i2c device with id
> "bar". It may or may not be correct but the vendor portion is very
> important to disambiguate.

Disambiguation via DT implies there is already a name collision in i2c 
modalias name space, so adding an of_id would work around this collision 
for DT enumeration. I2c_board_info driver binding would still be broken. 
The right fix would be to remove the name collision.

>>>
>>> I would also remove the struct i2c_device_id .driver_data fields from the
>>> I2C
>>> device ID table, since are not used and just makes reading the code
>>> confusing
>>> (only the struct i2c_device_id .name is used as far as I can see).
>>
>>
>> Valid point, thanks. I will change that.
>>
>>>
>>>> Javier, just a summary of the above. Nikolaus switched one driver to
>>>> use ->probe_new() hook and left i2c ID table at the same time.
>>>> My understanding that this table is not anymore in use.
>>>>
>>>> But I have to admit I didn't see entire picture of this. Can you shed a
>>>> light?
>>>>
>>>
>>> So to shed some light, in the past even {OF,ACPI}-only drivers needed an
>>> I2C ID
>>> table because: 1) the .probe callback had a struct i2c_device_id *
>>> parameter
>>> and 2) the I2C core always reported a modalias of the form i2c:<foo> even
>>> for
>>> devices registered via OF.
>>
>>
>> It could have been a null pointer and device driver binding (and
>> auto-loading) done just via driver.name.
>>
>
> I'm not sure I understood this comment.

What I was trying to say is that if the i2c_device_id table information 
was not needed (i.d. only one single id), even the old probe() could be 
used without defining an i2c_device_id table, the i2c_device_id* argument 
to probe() being a nullptr.

Niko
