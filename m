Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934561AbeCMQCh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:02:37 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:44931 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932425AbeCMQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:02:34 -0400
X-Google-Smtp-Source: AG47ELux8YIW8PYwrbr3NeFLf05zEEZTfMWmK3t3YyU2ulTiJkSh6x8HWEH7+u88J0NiXLKgob9lgnFxIlkqZgUu7/U=
MIME-Version: 1.0
In-Reply-To: <0ab7c9f6-e677-3bc9-df05-9895870a3c32@rasmusvillemoes.dk>
References: <20180313132155.203220-1-arnd@arndb.de> <0ab7c9f6-e677-3bc9-df05-9895870a3c32@rasmusvillemoes.dk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Mar 2018 17:02:32 +0100
X-Google-Sender-Auth: djcNs0Es21ztUb9N2D8IUp82qsU
Message-ID: <CAK8P3a2mkLfkmEgg7GbeS=QkXvzjt86fNiUuuHGa54HyULkMng@mail.gmail.com>
Subject: Re: [PATCH] test_rhashtable: avoid gcc-8 -Wformat-overflow warning
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Blakey <paulb@mellanox.com>, Martin Sebor <msebor@gcc.gnu.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        Tom Herbert <tom@quantonium.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 3:41 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 2018-03-13 14:21, Arnd Bergmann wrote:
>> gcc-8 warns about a code pattern that is used in the newly added
>> test_rhashtable code:
>>
>> lib/test_rhashtable.c: In function 'print_ht':
>> lib/test_rhashtable.c:511:21: error: '
>> bucket[' directive writing 8 bytes into a region of size between 1 and 512 [-Werror=format-overflow=]
>>     sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
>>                      ^~~~~~~~~
>> lib/test_rhashtable.c:511:4: note: 'sprintf' output between 15 and 536 bytes into a destination of size 512
>>     sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> The problem here is using the same fixed-length buffer as input and output
>> of snprintf(), which for an unbounded loop has an actual potential to
>> overflow the buffer. The '512' byte length was apparently chosen to
>> be "long enough" to prevent that in practice, but without any specific
>> guarantees of being the smallest safe size.
>
> well, 1024 would certainly be enough, because the result is anyway
> passed to printk() which formats into a buffer of that size, so anything
> more would certainly just be thrown away...

I was only worried about overflowing the stack here, not about the
output making sense ;-)

>> I can see three possible ways to avoid this warning:
>>
>> - rewrite the code to use pointer arithmetic to forward the buffer,
>>   rather than copying the buffer itself. This is a more conventional
>>   use of sprintf(), and it avoids the warning, but is not any more
>>   safe than the original code.
>> - Rewrite the function in a safe way that avoids both the potential
>>   overflow and the warning.
>> - Ask the gcc developers to not warn for this pattern if we consider
>>   the warning to be inappropriate.
>>
>> This patch implements the first of the above, as an illustration of
>> the problem, and the simplest workaround.
>
> If you use scnprintf() and forward the printed length you can get rid of
> the potential buffer overrun:
>
> len = 0;
> ...
> len += scnprintf(buf + len, sizeof(buf) - len, fmt, args...)
>
> scnprintf has the property that if you pass in a positive value, you get
> back something that is strictly less, so with the above pattern, we
> might eventually have sizeof(buf)-len==1, so all subsequent scnprintfs
> return 0, but we never overflow the buffer. The effect is thus the same
> as if you had done all the formatting with a single snprintf() call.

Right, that was my second proposal above. Using scnprintf(),
that's probably easier than I first thought.

> FWIW, I sent an RFC [1] two years ago trying to get rid of all
> snprintf(buf, ..., "%s...", buf, ...), because I think it's too fragile
> (it obviously breaks horribly if anything precedes the %s with buf as
> its argument), but others disagreed and said that the kernel's
> vsnprintf() instead should be documented to support that special case of
> overlapping src and dst. I don't really recall what happened with the
> patches, perhaps some got applied, but if not, maybe gcc-8 will now warn
> about those places.
>
> [1]
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1096481.html

It looks useful, but not all seem to have landed. I think you
are referring to Andrew's feedback in
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1097554.html
here as the concern about whether it did the right thing, but I'm not
actually sure what his reply meant.

In the case of the analog_name() function that Andrew commented on,
Dmitry later fixed the overflow in a different way in commit
10ca4c0a622a ("Input: fix potential overflows in driver/input/joystick").

>> +                     buffp += sprintf(buffp, "[[");
>>                       do {
>>                               pos = &list->rhead;
>>                               list = rht_dereference(list->next, ht);
>>                               p = rht_obj(ht, pos);
>>
>> -                             sprintf(buff, "%s val %d (tid=%d)%s", buff, p->value.id, p->value.tid,
>> +                             buffp += sprintf(buffp, "val %d (tid=%d)%s", p->value.id, p->value.tid,
>>                                       list? ", " : " ");
>
> this removes a space before val, not sure that was intended?

It was not, I'll fix it up. Thanks for taking a closer look!

     Arnd
