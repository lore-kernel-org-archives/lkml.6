Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeBFSgN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:36:13 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41525 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753125AbeBFSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:36:04 -0500
X-Google-Smtp-Source: AH8x226FRipwg7lYNkH5lWu3J9Lc3wAgBv/XDJItpB9EucA451wkl9W+0mvn2Y96TURMyda54eVwRtGlA2gtLh5rLC8=
MIME-Version: 1.0
In-Reply-To: <20180206.111949.1986970583522698316.davem@davemloft.net>
References: <20180202102749.GA34019@beast> <20180205.100347.176614123780866781.davem@davemloft.net>
 <CAGXu5j+VnhgXFajjxR7HJkN=Z6r3Kfw-+Gg2x37AacOD6C+Wdg@mail.gmail.com> <20180206.111949.1986970583522698316.davem@davemloft.net>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Feb 2018 05:36:02 +1100
X-Google-Sender-Auth: t4P7c9rdpOctH2lPbIbj5EPGvr0
Message-ID: <CAGXu5j+JnJKQocO4LxshbPZ0HPO+sQ71D+iCtCJN1YJzKn2G0g@mail.gmail.com>
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

On Wed, Feb 7, 2018 at 3:19 AM, David Miller <davem@davemloft.net> wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Tue, 6 Feb 2018 04:31:50 +1100
>
>> On Tue, Feb 6, 2018 at 2:03 AM, David Miller <davem@davemloft.net> wrote:
>>> From: Kees Cook <keescook@chromium.org>
>>> Date: Fri, 2 Feb 2018 02:27:49 -0800
>>>
>>>> @@ -343,6 +343,14 @@ struct ucred {
>>>>
>>>>  extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
>>>>  extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
>>>> +/*
>>>> + * Provide a bounce buffer for copying cmsg data to userspace when the
>>>> + * target memory isn't already whitelisted for hardened usercopy.
>>>> + */
>>>> +#define put_cmsg_whitelist(_msg, _level, _type, _ptr) ({             \
>>>> +             typeof(*(_ptr)) _val = *(_ptr);                         \
>>>> +             put_cmsg(_msg, _level, _type, sizeof(_val), &_val);     \
>>>> +     })
>>>
>>> I understand what you are trying to achieve, but it's at a real cost
>>> here.  Some of these objects are structures, for example the struct
>>> sock_extended_err is 16 bytes.
>>
>> It didn't look like put_cmsg() was on a fast path, so it seemed like a
>> bounce buffer was the best solution here (and it's not without
>> precedent).
>
> For some things like timestamps it can be important.

Making put_cmsg() inline would help quite a bit with tracking the
builtin_const-ness, and that could speed things up a little bit too.
Would you be opposed to inlining?

-Kees

-- 
Kees Cook
Pixel Security
