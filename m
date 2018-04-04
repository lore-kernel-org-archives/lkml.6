Return-Path: <kernel-hardening-return-12851-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/TdA4OBZY9ffLb2upQb9tGKwyVnjfk0BG32Z3byABPnZ8e8PZ9wOPWXgCOMf0XFcrAbaoT
ARC-Seal: i=1; a=rsa-sha256; t=1522866723; cv=none;
        d=google.com; s=arc-20160816;
        b=JTEnB27SV6nDs/j8IOY2otPqe3IhBaFSj2yrOThXcmqTdnGkpwc94RjD1FD2PFHqDE
         hG4Qy7SlPLR14eHY4B2Kaw9PuLnTA2LNe1MrkF8LH4A+K/uweMV/x8fhWzFx61uvLAV9
         9KeS5Q+9oJI3Ru15uZSicue/sYist+t+h7/54N2/tNflXR85zGneAMucAfNfmqsgCdLL
         yH4skwpFBXh/PmMAmagb2xtyZ2BJBWuKXUEyTztdZuogD427/A4uq8117GBl654xXvXZ
         LXiD2Sd8cRhVjsMupymc42IGxf54vZYp3eE9ZTlkwkK2elceCdw2eUZUodcMw9kssuAR
         MiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=vpoRiENI9SfFPVdel6/XYsgsUfH2NBNOOe7jF53InkA=;
        b=OsQAhkZ+LS8pRZtgsv+9noF8xXpDCDhueov/3iyQ9mtpz4X34DsDkhUi7TKtSrYnPS
         6BbXRjq6ly6u56pBZ8RHAYnp41ReiFsWgglvU8kF9i5cnaxnuwRIluhxa9bhhHLWpugt
         0UrhCKVOlWFnd+4qCN5ykqRiGGe+r14mxKMJLwxc5GBhWQQA7U4h59dhAYrUl9fUxoku
         Yt3NxHyFy3q7cYyd+fEpCw9u/Z5VSO3vn/XdwZY6rG02fesKeUkDggSZuuAn3ZLtH/eG
         UMTkJmuAhj0cVPewtIRkQxP/uAfAXXH9gug7lvrNftsm10pMK1xWDSzotgSDRY1LiWCH
         uGlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12851-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12851-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12851-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12851-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCHv3] gpio: Remove VLA from gpiolib
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Kees Cook <keescook@chromium.org>, Lukas Wunner <lukas@wunner.de>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kernel-hardening@lists.openwall.com,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20180328181809.24505-1-labbott@redhat.com>
 <CAHp75VdZOiJgzt3nhdeqwTXC=jsbndLWOV3eF_XmgFU-eHjYSg@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <2c191bd2-9df5-ecc1-1bf3-5ad19bea9138@redhat.com>
Date: Wed, 4 Apr 2018 11:31:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdZOiJgzt3nhdeqwTXC=jsbndLWOV3eF_XmgFU-eHjYSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596206473991489239?=
X-GMAIL-MSGID: =?utf-8?q?1596841496926668988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/30/2018 07:33 AM, Andy Shevchenko wrote:
> On Wed, Mar 28, 2018 at 9:18 PM, Laura Abbott <labbott@redhat.com> wrote:
>> The new challenge is to remove VLAs from the kernel
>> (see https://lkml.org/lkml/2018/3/7/621) to eventually
>> turn on -Wvla.
>>
>> Using a kmalloc array is the easy way to fix this but kmalloc is still
>> more expensive than stack allocation. Introduce a fast path with a
>> fixed size stack array to cover most chip with gpios below some fixed
>> amount. The slow path dynamically allocates an array to cover those
>> chips with a large number of gpios.
> 
>> +               ret = gpiod_set_array_value_complex(false,
>>                                                true,
>>                                                lh->numdescs,
>>                                                lh->descs,
>>                                                vals);
>> +               if (ret)
>> +                       return ret;
>> +
>>                  return 0;
> 
> Can't we
> 
> return gpiod_set_array_value_complex(); ?
> 
> 

Yeah I'll clean that up for v4.

>> +                       slowpath = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
>> +                                          sizeof(*slowpath),
>> +                                          can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> 
> 
>> +                       if (slowpath)
>> +                               kfree(slowpath);
> 
>> +               if (slowpath)
>> +                       kfree(slowpath);
> 
> Since slowpath is a pointer, conditionals above are redundant.
> 
>> +                       slowpath = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
>> +                                          sizeof(*slowpath),
>> +                                          can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> 
>> +               if (slowpath)
>> +                       kfree(slowpath);
> 
> Ditto.
> 

This was caught by a coccinelle script via 0-day but I think the request
was to not do it. I'll add a comment explaining why we are going against
style.

Thanks,
Laura
