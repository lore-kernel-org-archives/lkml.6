Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519125078; cv=none;
        d=google.com; s=arc-20160816;
        b=dE7jha3JY9y/ojMEPXYIXtoaKUkaPX/1gFjjCzfDVftUOLZluyThSIidiwQbmr9fmG
         MD9euXYCnyCcQXdyhSi5NWpHgW6WZJBvRnD60FB3sEv/LfLJUey4BFm8QDUjAAMpH+tS
         B9aNTsIoSTefpb+41JKVqz7WM3q6VnjoMOZr3SEdScVnuIOT6ikFLEoNDJwW0FAOVECz
         aSb2XTaOB7LEeLbcG8Bx7+oV2PsAiqrRhg79mpmmvPAJqEJdGC4D/n94l6j3poM2JVX1
         oBPE6mOpE0iB6mt8O25aLpt3zA67M+ez6TUyUoYPGZqLr0K6oZtUVGzSIKlbYyX0J7sA
         p9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=4HsG+Z/fFjFXj6SlQV9dfwwdRGv4Us+h337/yIzFU9E=;
        b=D6fgGT2qy9uDZEVAAJTlTJET1MZW7KT3oCaccrQaIhNQASPb+Gv7A/Kmd1U36k9X9M
         7lO0Vadr+G6hjyHecHOIOoSLblasvpGbyrOvuOQew1BCphCKSIkHpyf2mfvhB0wa4IX5
         SnO9T0UYsyfDSPujKSUrvW0VN0PASHtrudeBQq68MXhaaVgfe2RCZO3o48rIcQolaihy
         TBCSjDoGL35SXnLKeLmlaEUrURvUY/5rVTdhfH9PBjG5J33zfqn3YzD1YgFx7R6R1g0A
         VsfbdAWA/pj2gIHoa5rjcPXGTjgqAuHhVcacgqUEm9ekHOXKM8Lds0dGbCRvapbSIO23
         +9Og==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QnZJQCDZ;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QnZJQCDZ;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x2263G6Ls/hzfg36wweWSK6rh8CvABEvtgX8uIJKfUp+3g+QWs2tBo/c14aeGwgDLaTuSjFhdbrGA00tuVPJSTGY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK7LNAQVSVtXzWXjLRAQXynSvHHbiF1xYLhjLBwPfFOpnX_NRA@mail.gmail.com>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-4-arnd@arndb.de>
 <CAK7LNAQVSVtXzWXjLRAQXynSvHHbiF1xYLhjLBwPfFOpnX_NRA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Feb 2018 12:11:17 +0100
X-Google-Sender-Auth: WrU1XHv0V1fRmG2DWGhuG5RIIjI
Message-ID: <CAK8P3a2WYKQPJ_y9O_HpgbwN9-b9isKkYJH4niLA02MD2uH+2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kconfig: add a default allrandom.config
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	"Yann E . MORIN" <yann.morin.1998@free.fr>, Michal Marek <mmarek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595421999203989?=
X-GMAIL-MSGID: =?utf-8?q?1592918097988675840?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:16 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> Building randconfig kernels frequently leads to build errors from
>> drivers that have additional build dependencies, or that we don't
>> want to build for compile-testing for some other reason.
>
> Can you fix the former case?

I'm sure it can be done with runtime detection of the tools, not sure if that's
a good idea. What we would need here is

CONFIG_WANXL_BUILD_FIRMWARE: needs to check for as68k and ld68k
CONFIG_AIC79XX_BUILD_FIRMWARE: needs flex, bison and berkeley db.
        I have all those but it still failed to build for me.
STANDALONE now (after the removal of sound/oss) only controls
      ACPI_CUSTOM_DSDT_FILE, we could remove STANDALONE now
      I think, it doesn't actually get in the way of anything. For the stable
      kernels, I'd still need to deal with CONFIG_STANDALONE for the oss
      drivers.

My feeling right now is that we're better off making both STANDALONE
and PREVENT_FIRMWARE_BUILD depend on !COMPILE_TEST,
and then find a way to force that.

>> We already have a couple of compile-time options that can deal with this
>> problem, but the complete set is not documented well.  We also have a
>> method to override some options during 'make randconfig' and a couple
>> of other make targets. However, we don't yet combine those two.
>
>
> From this statement,
>
> kernel/configs/compile_test.config
>
> would make more sense?

My original thought was that the allrandom.config file name is already
documented and I just wanted a more consistent behavior, not come
up with something new.

>> This adds a new allrandom.config file to turn on CONFIG_COMPILE_TEST,
>> CONFIG_STANDALONE and CONFIG_PREVENT_FIRMWARE_BUILD for all randconfig
>> builds. This in turn disables some other options that we already try
>> to avoid in 'allmodconfig' builds and that make no sense in a general
>> randconfig build.
>>
>> Building with 'make randconfig KCONFIG_ALLCONFIG=1' should now always
>
>
> Can you type 'make randconfig compile_test.config', instead?
>
> (Or 'make allmodconfig compile_test.config' for full-build test)
>
>
> The merge_config has a little bit different logic
> from KCONFIG_ALLCONFIG=1, but I guess it leads to the almost same result.

I suspect that one difference in a randconfig kernel is that all options that
depend on CONFIG_COMPILE_TEST have a 50% lower chance of getting
enabled that way, but eventually they will get enabled.

      Arnd
