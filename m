Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9B3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25D2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VDaHIoFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F25D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeKCFR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:17:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43025 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKCFR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:17:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so2737053eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dXd8m3rLrHnKrxjdIe3JtajFAtElzHNtyH2pD/GSHpg=;
        b=VDaHIoFd5gKwpfkMSy7pTKW4ifhDsGImJssSqDgE8MwJ2Z8QtbBNuPIsgL+TrzkboU
         /fFInf6X6E2qJ87RulpbezzvxJoGRrfIImT6T4DHENs6pNfgL+IF61aF+aqMRW2iKhiS
         b5sSAPwEQ8BIkJG+pk6Irm/sKzlHawftGKuCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dXd8m3rLrHnKrxjdIe3JtajFAtElzHNtyH2pD/GSHpg=;
        b=IjNZhBtwv3zRZR4lJlCIDWpDl0UH3DbUTlRPfDUOFsxih/Jfp0REv7+1xvh5FuiwII
         8D11G5z5Rn0mVItnLS0TOdRTJhlQT9Jtxfsgptl+bTRCOi1uVnnLZ4/p1M06azcRui6h
         udapu3X2wXj17BHMOiADMFqhN2B1PGFFZEbICy5vbRmzt/kB+E9Ud5hGN/Anxqrs0J3U
         Jm+6C7ZJFFdMqEqnmqjMvVCJkN4VegvqIwUnHhHjvSFaTwjHUmPn1GN4uZBYhIbzG7mM
         2jnhehTpcikpaf/NM2IMsfmwmIOGZWYr1FGHRzqxKZhfPcNXJpiWRMrEvZQeW04b3PzT
         wiqg==
X-Gm-Message-State: AGRZ1gK8yctG9jm+G728cFh9MAU/SYYZlK8MYDsvlFoZ1/I//3hfdMv7
        v2s4uWrhUy2oUxlw6stLEpvNsPDIY+6ErA==
X-Google-Smtp-Source: AJdET5cRNZEhjr1mWV7rEnHbKKDkTz/EoX/KBdfiJcyCQYuk+8IVCk68c5W3Ss98ADQeTNnI24kxZQ==
X-Received: by 2002:a50:8144:: with SMTP id 62-v6mr9593110edc.204.1541189363753;
        Fri, 02 Nov 2018 13:09:23 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id r26-v6sm110796edq.22.2018.11.02.13.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:09:22 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] runtime format string checking
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
 <CAGXu5j+eGQ3oo_1qSwW-BEVSK=vcLmNLWH8E7fPiawobo=_fbQ@mail.gmail.com>
 <63e10688-5207-e8a4-dac2-d6c6094fbcc2@rasmusvillemoes.dk>
 <CAGXu5jL6RCL=WvCBJQytw=KnN74dp=1gd5wO-fO3i8tjAT=pvw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <22cb7c93-1160-b181-5702-1d7bfcee5b18@rasmusvillemoes.dk>
Date:   Fri, 2 Nov 2018 21:09:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL6RCL=WvCBJQytw=KnN74dp=1gd5wO-fO3i8tjAT=pvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[trimming cc list]

On 2018-11-01 23:57, Kees Cook wrote:
> On Thu, Nov 1, 2018 at 3:06 PM, Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> referring to an anonymous object in .rodata; one gets code gen like
>>
>> +:      31 c0                   xor    %eax,%eax
>> +:      48 b8 61 63 70 69 2d    movabs $0x7570632d69706361,%rax # "acpi-cpu"
>> +:      63 70 75
>> +:      c7 44 24 0b 66 72 65    movl   $0x71657266,0xb(%rsp) # "freq"
>> +:      71
>> +:      c6 44 24 0f 00          movb   $0x0,0xf(%rsp) "\0"
>> +:      48 89 44 24 03          mov    %rax,0x3(%rsp)
> 
> Oh that is nasty. Ugh. I hate the "const but not really ha ha" optimizations. :(
> 
>> It's not the-end-of-the-world-horrible, but it's better avoided,
>> especially for patches that are not supposed to change anything. And
>> longer strings would of course produce even more gunk like the above.
>> A better fix which also silences -Wformat-security is to declare the
>> variable itself const, i.e.
>>
>> const char *const drv = "acpi-cpufreq".
> 
> Yes, that would be much better. Seems like we could do a really easy
> Coccinelle script to fix all of those?
> 
> @@
> identifier VAR;
> expression STRING;
> @@
> 
> - const char VAR[]
> + const char * const VAR
>   = STRING;
> 
> yields:
>  517 files changed, 890 insertions(+), 891 deletions(-)
> 
> Worth doing at the end of -rc2?

That's a bit too naive. At the very least, you must exclude static
stuff, i.e. restrict to actual auto variables. Otherwise you're making
things worse (a "static const char []" just occupies some space in
.rodata, a "static const char * const" occupies the same space for the
anonymous literal, plus space for a pointer). Furthermore, you must
ensure that nobody does sizeof() on VAR. With a trivial extension of
your script to exclude the "static const char" places, I get

 97 files changed, 151 insertions(+), 151 deletions(-)

but that includes a number of places at file level where VAR actually
has external linkage. Which is most likely not intentional, but those
places would need different fixes. Actually, a lot of them are of the
'version = "1.2 (Feb 3 1995)"' kind which are utterly useless, so should
simply be removed (possibly left in a comment).

There's not a whole lot of difference between

const char *const foo = "read";

and

static const char foo[] = "read";

The former allows the linker to share "read" with other identical
literals (or reuse the tail of "thread"), but the actual strings in
these cases are likely to be unique and not suffixes of others. The
latter is probably more readable (at least it's more common), and in
some cases one can slap on an __initconst, making the memory footprint
go away entirely. And when sizeof() is used,

So I think it's better to take the above 151 cases and do them in small
batches.

>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/format-security&id=b7dcfc8f48caaafcc423e5793f7ef61b9bb5c458
>>> This one covers cases where the pointer is pointing to a const string,
>>> so really there's no sense in injecting the "%s", but I was collecting
>>> them to make real ones stand out.
>>
>> I don't agree. [...]
> 
> Okay, then I'll forward this to akpm maybe?

Yes, if all they do is replace f(..., s) by f(..., "%s", s) that should
never hurt. Maybe check if there's a ..._puts() variant that can be used
instead, e.g. seq_puts().

Rasmus
