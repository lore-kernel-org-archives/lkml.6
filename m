Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeBHVBS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:01:18 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:42241 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeBHVBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:01:16 -0500
X-Google-Smtp-Source: AH8x2243ulIBIC9oCjnaIEnX6FoyXChwngH7DTNlPPPH8vBXq5acqhttorC7WkkIPSbTFZ4ntEogUrbJuxuHLil+Tpk=
MIME-Version: 1.0
In-Reply-To: <20180208.151621.581060088482890871.davem@davemloft.net>
References: <20180208014438.GA12186@beast> <20180208.151621.581060088482890871.davem@davemloft.net>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Feb 2018 08:01:12 +1100
X-Google-Sender-Auth: _uIMICAl5dNdIClJDOwPs9noFEU
Message-ID: <CAGXu5jJsmECUtyXBJb60o_Ve3PTUw8pkyaH2=SFHSxHy1vjsmA@mail.gmail.com>
Subject: Re: [PATCH] net: Whitelist the skbuff_head_cache "cb" field
To: David Miller <davem@davemloft.net>
Cc: syzbot <syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Eric Biggers <ebiggers3@gmail.com>, James Morse <james.morse@arm.com>,
        keun-o.park@darkmatter.ae, Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 7:16 AM, David Miller <davem@davemloft.net> wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Wed, 7 Feb 2018 17:44:38 -0800
>
>> Most callers of put_cmsg() use a "sizeof(foo)" for the length argument.
>> Within put_cmsg(), a copy_to_user() call is made with a dynamic size, as a
>> result of the cmsg header calculations. This means that hardened usercopy
>> will examine the copy, even though it was technically a fixed size and
>> should be implicitly whitelisted. All the put_cmsg() calls being built
>> from values in skbuff_head_cache are coming out of the protocol-defined
>> "cb" field, so whitelist this field entirely instead of creating per-use
>> bounce buffers, for which there are concerns about performance.
>>
>> Original report was:
>  ...
>> Reported-by: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com
>> Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> I tried the inlining, it was awful. Splitting put_cmsg() was awful. So,
>> instead, whitelist the "cb" field as the least bad option if bounce
>> buffers are unacceptable. Dave, do you want to take this through net, or
>> should I take it through the usercopy tree?
>
> Thanks Kees, I'll take this through my 'net' tree.

Cool, thanks. And just to be clear, if it's not already obvious, this
patch needs kmem_cache_create_usercopy() which just landed in Linus's
tree last week, in case you've not merged yet.

-Kees

-- 
Kees Cook
Pixel Security
