Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeBERcP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:32:15 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37588 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbeBERbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:31:52 -0500
X-Google-Smtp-Source: AH8x227mgEgSepplgT00TBL4sESuErUiLyRqe5QHNH8PCVOFy3bcMmwdNBZqvna6OfsWW97UZZWGmWE2+maM+aDW22g=
MIME-Version: 1.0
In-Reply-To: <20180205.100347.176614123780866781.davem@davemloft.net>
References: <20180202102749.GA34019@beast> <20180205.100347.176614123780866781.davem@davemloft.net>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Feb 2018 04:31:50 +1100
X-Google-Sender-Auth: 9snrJ7jSE66bfgJaItOvCPRaePI
Message-ID: <CAGXu5j+VnhgXFajjxR7HJkN=Z6r3Kfw-+Gg2x37AacOD6C+Wdg@mail.gmail.com>
Subject: Re: [PATCH v2] socket: Provide put_cmsg_whitelist() for constant size copies
To: David Miller <davem@davemloft.net>
Cc: syzbot <syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Eric Biggers <ebiggers3@gmail.com>, James Morse <james.morse@arm.com>,
        keun-o.park@darkmatter.ae, Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 2:03 AM, David Miller <davem@davemloft.net> wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Fri, 2 Feb 2018 02:27:49 -0800
>
>> @@ -343,6 +343,14 @@ struct ucred {
>>
>>  extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
>>  extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
>> +/*
>> + * Provide a bounce buffer for copying cmsg data to userspace when the
>> + * target memory isn't already whitelisted for hardened usercopy.
>> + */
>> +#define put_cmsg_whitelist(_msg, _level, _type, _ptr) ({             \
>> +             typeof(*(_ptr)) _val = *(_ptr);                         \
>> +             put_cmsg(_msg, _level, _type, sizeof(_val), &_val);     \
>> +     })
>
> I understand what you are trying to achieve, but it's at a real cost
> here.  Some of these objects are structures, for example the struct
> sock_extended_err is 16 bytes.

It didn't look like put_cmsg() was on a fast path, so it seemed like a
bounce buffer was the best solution here (and it's not without
precedent).

> And now we're going to copy it twice, once into the on-stack copy,
> and then once again into the CMSG blob.
>
> Please find a way to make hardened user copy happy without adding
> new overhead.

Another idea would be breaking put_cmsg() up into a macro with helper
functions, rearrange the arguments to avoid the math, and leaving the
copy_to_user() inline to see the const-ness, but that seemed way
uglier to me.

I'll think about it some more, but I think having put_cmsg_whitelist()
called only in a few places is reasonable here.

-Kees

-- 
Kees Cook
Pixel Security
