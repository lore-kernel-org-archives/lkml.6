Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeCKA4e (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 19:56:34 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36721 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeCKA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 19:56:32 -0500
X-Google-Smtp-Source: AG47ELvodLVJv+VDKHQIB+w+OKyBXkbmGIafUE7thqAaOm5Ap3fvaFXxFQEn3W8fEfH8C6ZNtK4QJw==
Subject: Re: a Heisenbug tale
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Cc: Leonard Crestez <leonard.crestez@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1520450729.13685.19.camel@nxp.com>
 <c4b2ac3a-9f6f-9985-c7a3-f758c13e7b73@rasmusvillemoes.dk>
 <CAKv+Gu8z2aMeGEi5Jbi+CBpbyMAmxHnZCO+URrVFgb33tddppw@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <24703f21-6125-030d-e2ab-4b91cb5c25f8@rasmusvillemoes.dk>
Date: Sun, 11 Mar 2018 01:56:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8z2aMeGEi5Jbi+CBpbyMAmxHnZCO+URrVFgb33tddppw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-09 10:45, Ard Biesheuvel wrote:
> On 8 March 2018 at 23:19, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>> On 2018-03-07 20:25, Leonard Crestez wrote:
>>> Hello,
>>>

>>
>> What we ended up doing was to explicitly set the mtime of every file in
>> the repo to the same reference time after the git checkout (find ... |
>> xargs touch --date=...). I also wanted to send a patch to change the
>> Makefile to use the filechk mechanism to avoid updating the .S_shipped
>> file when the script produced identical output, but never got around to it.
>>
> 
> I had no idea that _shipped files were causing issues like this, and
> AFAICT, this is not specific to this use case in arch/arm/crypto,
> right?
> 
> Russell, would you mind if we removed the _shipped.S file here and
> just assume that perl is available?
> 

Well, in that case I won't need to write a proper changelog for the
below, but this seems to work. It will of course still give the spurious
build failures when perl is not available and one hits the "files got
checked out at almost but not quite the same time", but it would have
prevented the spurious -dirty bug.


diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 30ef8e291271..f0cec9a92fd8 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -54,13 +54,14 @@ crct10dif-arm-ce-y	:= crct10dif-ce-core.o
crct10dif-ce-glue.o
 crc32-arm-ce-y:= crc32-ce-core.o crc32-ce-glue.o
 chacha20-neon-y := chacha20-neon-core.o chacha20-neon-glue.o

-quiet_cmd_perl = PERL    $@
-      cmd_perl = $(PERL) $(<) > $(@)
+define filechk_perl
+	perl $<
+endef

 $(src)/sha256-core.S_shipped: $(src)/sha256-armv4.pl
-	$(call cmd,perl)
+	$(call filechk,perl)

 $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
-	$(call cmd,perl)
+	$(call filechk,perl)

 .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
