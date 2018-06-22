Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11209C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70B523C1C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a07IDHhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70B523C1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934224AbeFVBfE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:35:04 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33061 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934042AbeFVBfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:35:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so5031718wro.0;
        Thu, 21 Jun 2018 18:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z9WdIwsQQqSoR1DSIKFcwKJcczbg37LVTH/HmIp2few=;
        b=a07IDHhsNAvwguMuXuyScuyhMAHaixN/JV1SsWjsYcFdyHX5XDVoRei/NoKk2Xh1Um
         uhKQdP1ytpkSNvghKtTYuaykXfvI17jKhDz/06JWg+IfU4kd8OFNwfvKiklVknmpQUnm
         5bLS7svjoTfNvJ7vv7Lx3JNVk+thrt/LyYGecmhxDhUvTls4HQFW0QAQCWJEi6/vpOAo
         lMXzpVzezv4eZyLGgL2IpfRu2zUj7BDsU+70lFsh09ZpHIxE2J/eR7PB4/ZZly8req6Q
         Slmj+teUVVFNu4Y+HSfrNGsljkrVqfw/r65Oln39eExedpD+0/RoXCXH8RAa1Pri810L
         H9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z9WdIwsQQqSoR1DSIKFcwKJcczbg37LVTH/HmIp2few=;
        b=qewHIisHb1P6A73zu14+oWT4xZSWdxv5TACDOZef5ZNkrLXULI7zgEZxPs5xShcUbM
         QZk9tTnrCeqmiEZqqhfdIXSYcYI7BwHzyokXv4BKVXOsNRqkYyyb55prtw+4bdU2lVty
         Ka/j2xTlf9EAeXV7MTEW2K8d5yP8+9qKSxUSqDA6zA//vN8EExBudJAKgEEHJGFwC6RL
         U/GLbPjClVIwtUIa93uDyBTsVfJgd1/umOjDCA2gKBMKoIUGg5nbC9ARC/niHcZq4Mv/
         IxmIf4iy5r8tk+iH8vHMxBZOlHzaOQGD8krmZQ5dMNJdis3nn4nhQLcJoBcYFbXk71GC
         11Eg==
X-Gm-Message-State: APt69E0esICf6tBr75qS3wjZkO6X1+yhUn4M0I36SbjTBCEHwz1dtIWG
        weTWGkxmiyLz0SrtF5lYtv0r9NA8INq+y1u8wI8=
X-Google-Smtp-Source: ADUXVKLKPzMW+kfOc4oIZt3s2yNv7FOVNlbfjtXNTH7LSGNaxcbWJLvzbSSdVbVOMtMuZnecNkuZwk+O6QbsPLAd2Ig=
X-Received: by 2002:adf:f391:: with SMTP id m17-v6mr22726388wro.279.1529631301697;
 Thu, 21 Jun 2018 18:35:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a288:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 18:34:21
 -0700 (PDT)
In-Reply-To: <55337e35-a4f7-e543-6384-e1f523d3f463@posteo.de>
References: <d3cdb3fef8434663c95b7b2f799c5ee4446a5231.1528397238.git.leonard.crestez@nxp.com>
 <55337e35-a4f7-e543-6384-e1f523d3f463@posteo.de>
From:   harinath Nampally <harinath922@gmail.com>
Date:   Thu, 21 Jun 2018 21:34:21 -0400
Message-ID: <CAAGUq_ppBDi0N-SrjKpZvhhfA0tay32gTLBtmXwMb=n4_rUjxQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mma8452: Fix ignoring MMA8452_INT_DRDY
To:     Martin Kepplinger <martink@posteo.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-07 20:52, Leonard Crestez wrote:
> Interrupts are ignored if no event bit is set in the status status
> register and this breaks the buffer interface. No data is shown when
> running "iio_generic_buffer -n mma8451 -a" and interrupt counts go
> crazy.
>
> Fix by not returning IRQ_NONE if DRDY is set.
>
> Fixes: 605f72de137a ("iio: accel: mma8452: improvements to handle
> multiple events")
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Thanks for catching it. Looks good to me.
Acked-by: Harinath Nampally <harinath922@gmail.com>

Thanks,
Harinath


On Wed, Jun 20, 2018 at 5:15 AM, Martin Kepplinger <martink@posteo.de> wrote:
> On 2018-06-07 20:52, Leonard Crestez wrote:
>> Interrupts are ignored if no event bit is set in the status status
>> register and this breaks the buffer interface. No data is shown when
>> running "iio_generic_buffer -n mma8451 -a" and interrupt counts go
>> crazy.
>>
>> Fix by not returning IRQ_NONE if DRDY is set.
>>
>> Fixes: 605f72de137a ("iio: accel: mma8452: improvements to handle
>> multiple events")
>>
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>
> At least this does no harm to events. So if this solves your problem:
>
> Acked-by: Martin Kepplinger <martink@posteo.de>
>
> thanks,
>
>                             martin
>
>>
>> ---
>>  drivers/iio/accel/mma8452.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Perhaps this whole early-exit check could be dropped? It is not clear
>> how it helps.
>>
>> If for some models we want to ignore unsupported events then maybe this
>> should be checked for each individual bit. Instead of
>>
>> if (src & MMA8452_INT_FF_MT) {
>>
>> Check for:
>>
>> if ((src & MMA8452_INT_FF_MT) && (data->chip_info->enabled_events & MMA8452_INT_FF_MT))
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 7a2da7f9d4dc..5485b35fe553 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -1032,11 +1032,11 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>>
>>       src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>>       if (src < 0)
>>               return IRQ_NONE;
>>
>> -     if (!(src & data->chip_info->enabled_events))
>> +     if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
>>               return IRQ_NONE;
>>
>>       if (src & MMA8452_INT_DRDY) {
>>               iio_trigger_poll_chained(indio_dev->trig);
>>               ret = IRQ_HANDLED;
>>
>
