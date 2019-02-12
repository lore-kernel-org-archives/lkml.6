Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690C8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B67222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="epCgIyAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfBLUWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:22:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46204 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBLUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:22:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so3296041edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/0RgagH5GJo4IYcAO8aiyUbJM5z/qk+Ey89K8Z8y2C8=;
        b=epCgIyAZPzv6MO7/Lk2xQEeX6jBhfjI6gy5oTbaITA0ZrChhwETVBCOqUxJcrmR9bU
         WR6esomRvA1rr20Rt1QwhUrdSfuVwAf3n97wrS/OzTISHg9LdrFWfvvinvFI8aqiKwax
         iTMZMe/FO5rj03NtXXFroK0YvOOUEt37n/16g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/0RgagH5GJo4IYcAO8aiyUbJM5z/qk+Ey89K8Z8y2C8=;
        b=BmE2fQJkG8CJQ4jSziGJ1jWSwq1q6yGfSceZLvzhnnKifPO4f8z7cmxrHdUprXqdJ7
         wdrCV4vhauE+EIt8sOUzuQBZLiS7YjC9StiyBA2pEVZ10eNG9e+HcOi8XQJRtmXqTFrP
         fn8AilpJ3erDBAwPy2mo09kOIrmz1nYpCvlMvg7BoMWqcYhI2VVQmBiQRT9rMd3Y7//3
         rHg+8HbTL6u2x33TA9HQrJ8lmNofKoiU2kvt+1RulB7HPI82esYopsHMYcWJNZWlWmzU
         aaQXXVYIXLOByL+9QmRDUDjtHGP+Rg1RkfCsVPbE+a0bcyMxLXX0QMTn387yK1R1P0BT
         xPcA==
X-Gm-Message-State: AHQUAuYMfW3vYYKIDr8+6V2APqHJTtAwi/HOIGDd0oBkR2c6W0Fc8RZx
        Ac9cKYL9BI/ZHMAFGeXdALRZqzSdnh5jQojF
X-Google-Smtp-Source: AHgI3IaTN8Qcb6PsNvtncT9dJOJUR9ghjq2uBc4p2f+49mOvT1zbIxYYm39QeVC5RkLNTu/j9SRV8A==
X-Received: by 2002:a50:9156:: with SMTP id f22mr4672560eda.172.1550002961434;
        Tue, 12 Feb 2019 12:22:41 -0800 (PST)
Received: from [192.168.0.189] (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id s17sm3223978ejr.17.2019.02.12.12.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:22:40 -0800 (PST)
Subject: Re: [PATCH v6 5/9] vsprintf: Factor out %pV handler as va_format()
To:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-6-pmladek@suse.com>
 <f308ab312810d538a79c2f54f49edba32c60b561.camel@perches.com>
 <20190212130030.s22aamlnmj2lv7zg@pathway.suse.cz>
 <c65a43b1711dfba3749d7e3022589c7c652e83c4.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <700e118d-4426-cc9c-cae4-1455cc7ebfba@rasmusvillemoes.dk>
Date:   Tue, 12 Feb 2019 21:22:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c65a43b1711dfba3749d7e3022589c7c652e83c4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 18.58, Joe Perches wrote:
> On Tue, 2019-02-12 at 14:00 +0100, Petr Mladek wrote:
>> On Fri 2019-02-08 09:11:17, Joe Perches wrote:
>>> On Fri, 2019-02-08 at 16:23 +0100, Petr Mladek wrote:
>>>> Move the code from the long pointer() function. We are going to improve
>>>> error handling that will make it more complicated.
>>>>
>>>> This patch does not change the existing behavior.
>>>
>>> But doesn't this increase stack use?
>>> %pV is recursive and increasing the stack is undesired
>>> for this use.
>>
>> %pV handler is stack sensitive because the entire vsnprintf()
>> machinery is called recursively. This one extra call does
>> not make it much worse.
> 
> That's an argument?.
> 
> Refactoring is good, but you need to add
> __always_inline here.
> 
> 

No. No no no. Please at least try to send the code through a compiler.
Petr's patch actually makes things uniformly better, since gcc ends up
doing a tail call from pointer().

    2e65:       4c 89 cf                mov    %r9,%rdi
    2e68:       e9 23 05 00 00          jmpq   3390 <va_format>

$ scripts/stackusage -o before.su lib/vsprintf.o
$ cp lib/vsprintf.o lib/vsprintf.o.0
$ # apply patch
$ scripts/stackusage -o after.su lib/vsprintf.o
$ cp lib/vsprintf.o lib/vsprintf.o.1
$ scripts/stackdelta before.su after.su
./lib/vsprintf.c        pointer 40      8       -32
$ grep va_format after.su
after.su:./lib/vsprintf.c:1437     va_format       40      static
# Icing
$ scripts/bloat-o-meter lib/vsprintf.o.0 lib/vsprintf.o.1
add/remove: 1/0 grow/shrink: 0/1 up/down: 77/-186 (-109)
Function                                     old     new   delta
va_format                                      -      77     +77
pointer                                      634     448    -186

Of course, all of this depends very much on compiler version,
architecture (if the calling convention says to pass arguments on stack,
tail calls are a lot harder to come by), CONFIG_STACKPROTECTOR etc.
etc., but nothing suggests that forcing the va_format logic into
pointer() would be a good thing.

Rasmus
