Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40ED9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF69C208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RopdGI7P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R13UFurr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF69C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935478AbeFMTHc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:07:32 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34789 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935062AbeFMTHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:07:31 -0400
Received: by mail-yb0-f194.google.com with SMTP id n23-v6so1321890ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+Wt5LwxQl2eQtnjPGPgsfEAiBBBUXL30r0TUOSVNcDo=;
        b=RopdGI7PtK5dZuIsv8hlGZHANIGpwIdWuJJHWQEZKYzUbF8+LLsVWSTF8oWwC2BhpO
         VHm6Z2XhKH4WRtQedcVj8NDw7gC1h0guAcnpk+ThVWF6WwnqpaC+pQ7PzOVxXS5VEIgS
         nQ+P89VPmg4oOPX+iQQAaauOYRWczCr2k+YxacCgUNjLqIw3ree3ewlPDFkGIxN/OSHT
         pKMLM2/sD+V4DMKICAbVxT8R4r3bgcpQLg5Dy/X5P2Z7bho61XL0fe9HxZeRd+USMvAg
         D+texMuPK91oTUeUWnwjhjy6WDaxIl0+vwLgCkPc7fWhoAjHu9GgoP1v69RfZXapFJG5
         ZHjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+Wt5LwxQl2eQtnjPGPgsfEAiBBBUXL30r0TUOSVNcDo=;
        b=R13UFurr0yPlNNk5D3XesS9zynvb72JCvdijFKT8tda3bH6DI3WwshidfDr/Sf2bpm
         5cIU5amAKD+3vc5yCWkbvx8LQKczKVKeJJ52KWPwNWekwjFO81RDyq0T1qOvbh+ikRHz
         KIFT6EIqKAHZuUc8BmGrOtBB7wjSRO5RZ4g2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+Wt5LwxQl2eQtnjPGPgsfEAiBBBUXL30r0TUOSVNcDo=;
        b=brSK/fgmquS3idiUcwYHUlVZdj3JsHoe3+Tc/ewNbAJcK1dnXhmSEqyYevC5xLq9iD
         c2wC8XXm78INcn4mVF3VbAzsEcxeSmCufak79YzdsXqdYMrOFr2iCIccKQIV8w7i4iLi
         VXAczutAQxRYFldiojv95xvB62xyR+ZuZk4c2ohey85Mg7BF/V7cP/EPzYkgw/fYNkVg
         4W55L7NcE+0MW/qMcVVKk/zrHNxcwPEEnAZjTW0c8S83ME15OZyLuDbuyttjZDlpP+Hp
         rX6UWI7xWeFYy+ZExjS7+aiCJOdMSvXQiN6bHgNBRvQAa6sxjRPm9rY48zErV5WYPC6Q
         dwIA==
X-Gm-Message-State: APt69E2cBMsmLjDsWy1hEq8Zq4EFyda5ze6v5PJnKl53CpTGrUMt3Hn6
        6/gv4Ni/U8krsdQdJKxhq4ioI4/+7O3DtVwHTl06HlppltM=
X-Google-Smtp-Source: ADUXVKJJSAcikGW+kdBRc5LCijydMaZ65Hpl5ST/UHkeq+rUUPNX50JRpciFEvLdTVhWD0woiaJ5450wy8niZIUwL+U=
X-Received: by 2002:a25:be41:: with SMTP id d1-v6mr3045487ybm.309.1528916850391;
 Wed, 13 Jun 2018 12:07:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 12:07:29
 -0700 (PDT)
In-Reply-To: <CA+55aFy9mqnJCr=6JujNvmTjGu-rm0QYrUNkmKODb0ymQU9O8Q@mail.gmail.com>
References: <20180612233552.GA25041@beast> <CA+55aFy9mqnJCr=6JujNvmTjGu-rm0QYrUNkmKODb0ymQU9O8Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Jun 2018 12:07:29 -0700
X-Google-Sender-Auth: YW7npeBzVxmPrCvDcqy_d-DHr9A
Message-ID: <CAGXu5jLw9kMZRkzL_Q7JdyyprntHF6bdVSE_vjyzect3CenDng@mail.gmail.com>
Subject: Re: [GIT PULL] overflow updates (part 2) for v4.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 6:44 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jun 12, 2018 at 4:36 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> - Treewide conversions of allocators to use either 2-factor argument
>>   variant when available, or array_size() and array3_size() as needed (Kees)
>
> Ok, some of this smells just a tad too much of automation, but I've
> done the pull and it's going through my build tests.

Thanks! Yeah, I tried to beat sense into it to avoid REALLY dumb
things that just looked terrible.

> In some of the cases it turns a compile-time constant into a function
> call, ie this just makes for bigger and slower code for no reason
> what-so-ever.
>
> -       ch->tx_array = vzalloc(MIC_DMA_DESC_RX_SIZE * sizeof(*ch->tx_array));
> +       ch->tx_array = vzalloc(array_size(MIC_DMA_DESC_RX_SIZE,
> +                                         sizeof(*ch->tx_array)));
>
> At least in the kzalloc/kcalloc conversion it results in more legible code.

I did try to convince my scripting to avoid the less sane conversions,
but as you saw there were still some that fell through. In the end, I
decided to let it stand since because Rasmus's code is so careful, if
array_size() processes constant expressions, it'll produce a constant
expression, so the machine code result actually isn't worse in these
cases. Using the above example, it's the same as without array_size():

struct dma_async_tx_descriptor is 72 bytes
/* size: 72, cachelines: 2, members: 10 */

MIC_DMA_DESC_RX_SIZE is 131068
#define MIC_DMA_DESC_RX_SIZE (128 * 1024 - 4)

131068 * 72 = 0x8ffee0

vzalloc(array_size(MIC_DMA_DESC_RX_SIZE, sizeof(*ch->tx_array)))

ffffffff815e87d0:   bf e0 fe 8f 00      mov    $0x8ffee0,%edi
ffffffff815e87d5:   e8 c6 4b be ff      callq  <vzalloc>

The same is true for each of these all-constants forms, with each
resolving to the same machine code in my tests:

kmalloc(16 * PAGE_SIZE, GFP_KERNEL)
kmalloc_array(16, PAGE_SIZE, GFP_KERNEL)
kmalloc(array_size(16, PAGE_SIZE), GFP_KERNEL)

16 * 4096 = 0x10000

ffffffff8179810e:   ba 04 00 00 00          mov    $0x4,%edx
ffffffff81798113:   be c0 00 60 00          mov    $0x6000c0,%esi
ffffffff81798118:   bf 00 00 01 00          mov    $0x10000,%edi
ffffffff8179811d:   e8 6e b0 a1 ff          callq  <kmalloc_order_trace>

Obviously, it gets more interesting once there is an actual variable in play:

kmalloc(var * PAGE_SIZE, GFP_KERNEL) does no overflow checking, as
expected, and is what I wanted to eliminate from the kernel:

ffffffff8179810e:   48 63 3d 93 f4 14 01    movslq 0x114f493(%rip),%rdi
ffffffff81798115:   be c0 00 60 00          mov    $0x6000c0,%esi
ffffffff8179811a:   48 c1 e7 0c             shl    $0xc,%rdi
ffffffff8179811e:   e8 1d af a4 ff          callq  <__kmalloc>

kmalloc_array(var, PAGE_SIZE, GFP_KERNEL) has its builtin overflow
checking and returns NULL:

ffffffff8179810e:   48 63 05 93 f4 14 01    movslq 0x114f493(%rip),%rax
ffffffff81798115:   bf 00 10 00 00          mov    $0x1000,%edi
ffffffff8179811a:   48 f7 e7                mul    %rdi
ffffffff8179811d:   48 89 c7                mov    %rax,%rdi
ffffffff81798120:   70 18                   jo     ffffffff8179813a
ffffffff81798122:   be c0 00 60 00          mov    $0x6000c0,%esi
ffffffff81798127:   e8 14 af a4 ff          callq  <__kmalloc>
ffffffff8179812c:   48 89 05 ad ea fd 01    mov    %rax,0x1fdeaad(%rip)
ffffffff81798133:   48 83 c4 08             add    $0x8,%rsp
ffffffff81798137:   5b                      pop    %rbx
ffffffff81798138:   5d                      pop    %rbp
ffffffff81798139:   c3                      retq
ffffffff8179813a:   31 c0                   xor    %eax,%eax
ffffffff8179813c:   eb ee                   jmp    ffffffff8179812c

kmalloc(array_size(var, PAGE_SIZE), GFP_KERNEL), (not that this form
should be used, but just to illustrate) performs the saturation
instead of the NULL return:

ffffffff8179810e:   48 63 05 93 f4 14 01    movslq 0x114f493(%rip),%rax
ffffffff81798115:   bf 00 10 00 00          mov    $0x1000,%edi
ffffffff8179811a:   48 f7 e7                mul    %rdi
ffffffff8179811d:   48 89 c7                mov    %rax,%rdi
ffffffff81798120:   70 18                   jo     ffffffff8179813a
ffffffff81798122:   be c0 00 60 00          mov    $0x6000c0,%esi
ffffffff81798127:   e8 14 af a4 ff          callq  <__kmalloc>
ffffffff8179812c:   48 89 05 ad ea fd 01    mov    %rax,0x1fdeaad(%rip)
ffffffff81798133:   48 83 c4 08             add    $0x8,%rsp
ffffffff81798137:   5b                      pop    %rbx
ffffffff81798138:   5d                      pop    %rbp
ffffffff81798139:   c3                      retq
ffffffff8179813a:   ba 34 00 00 00          mov    $0x34,%edx
ffffffff8179813f:   be c0 00 60 00          mov    $0x6000c0,%esi
ffffffff81798144:   48 83 cf ff             or     $0xffffffffffffffff,%rdi
ffffffff81798148:   e8 43 b0 a1 ff          callq  <kmalloc_order_trace>
ffffffff8179814d:   eb dd                   jmp    ffffffff8179812c

> To make up for it, there's some conversions *away* from nonsensical expressions:
>
> -       hc_name = kzalloc(sizeof(char) * (HSMMC_NAME_LEN + 1), GFP_KERNEL);
> +       hc_name = kzalloc(HSMMC_NAME_LEN + 1, GFP_KERNEL);

Yeah, I tried to catch these and some other masked cases. Coccinelle
didn't seem to have a consistent isomorphism for (sizeof(thing)) vs
sizeof(thing), so I also tried to drop redundant parens.

> but I _really_ think you were way too eager to move to array_size()
> even when it made no sense what-so-ever.
>
> But at least with the kcalloc()/kmalloc_array() conversions now
> preferred, those crazy cases are now a minority rather than "most of
> the patch makes code worse".

Net improvement was my goal, yes! :)

> I am *not* looking forward to the conflicts this causes, but maybe it
> won't be too bad. Fingers crossed.

Hopefully it shouldn't be too bad, but that's why I tried to perform
the conversion as late in -rc1 as possible, etc.

Thanks again for the pull! I'll keep my eyes out for new cases that
need conversion. Hopefully we can enhance checkpatch to yell more
loudly too. :)

-Kees

-- 
Kees Cook
Pixel Security
