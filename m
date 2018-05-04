Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeEDQVS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:21:18 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40876 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeEDQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:21:16 -0400
X-Google-Smtp-Source: AB8JxZoCHUAW/80FEKO6D5SzTeXjMWuz7DpV4BEg+c13jeaR9yAqxEZuALsA21D2gqpAibPy8islsKJ3IKlI9+mAGq8=
MIME-Version: 1.0
In-Reply-To: <CAK7LNATV==PWHd2M63X+SMchRoTqtbnnSFSZM1bQnjCRfRrRKg@mail.gmail.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
 <1523595999-27433-2-git-send-email-yamada.masahiro@socionext.com> <CAK7LNATV==PWHd2M63X+SMchRoTqtbnnSFSZM1bQnjCRfRrRKg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 4 May 2018 09:21:14 -0700
X-Google-Sender-Auth: Uvda8aGFdD2oLY_l0gtjl8Fbrko
Message-ID: <CAGXu5jLWGzGERGTVppVn1zXP9kNPURryukeU8Cfy-SwfZpyDSg@mail.gmail.com>
Subject: Re: [PATCH 01/30] gcc-plugins: fix build condition of SANCOV plugin
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 7:21 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Kees,
>
>
> 2018-04-13 14:06 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> Since commit d677a4d60193 ("Makefile: support flag
>> -fsanitizer-coverage=trace-cmp"), you miss to build the SANCOV
>> plugin under some circumstances.
>>
>>   CONFIG_KCOV=y
>>   CONFIG_KCOV_ENABLE_COMPARISONS=y
>>   Your compiler does not support -fsanitize-coverage=trace-pc
>>   Your compiler does not support -fsanitize-coverage=trace-cmp
>>
>> Under this condition, $(CFLAGS_KCOV) is not empty but contains a
>> space, so the following ifeq-conditional is false.
>>
>>     ifeq ($(CFLAGS_KCOV),)
>>
>> Then, scripts/Makefile.gcc-plugins misses to add sancov_plugin.so to
>> gcc-plugin-y while the SANCOV plugin is necessary as an alternative
>> means.
>>
>> Fixes: d677a4d60193 ("Makefile: support flag -fsanitizer-coverage=trace-cmp")
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>
>
> I am planning to queue this up to the fixes branch
> since this is a bug fix.
>
> Do you have any comment on this?

Looks fine to me; thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>
>
>
>
>
>> Changes in v3:
>>   - newly added
>>
>> Changes in v2: None
>>
>>  scripts/Makefile.gcc-plugins | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
>> index b2a95af..7f5c862 100644
>> --- a/scripts/Makefile.gcc-plugins
>> +++ b/scripts/Makefile.gcc-plugins
>> @@ -14,7 +14,7 @@ ifdef CONFIG_GCC_PLUGINS
>>    endif
>>
>>    ifdef CONFIG_GCC_PLUGIN_SANCOV
>> -    ifeq ($(CFLAGS_KCOV),)
>> +    ifeq ($(strip $(CFLAGS_KCOV)),)
>>        # It is needed because of the gcc-plugin.sh and gcc version checks.
>>        gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
>>
>> --
>> 2.7.4
>>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Kees Cook
Pixel Security
