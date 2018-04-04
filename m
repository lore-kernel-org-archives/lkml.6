Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeDDTAm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:00:42 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:40555 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDDTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:00:37 -0400
X-Google-Smtp-Source: AIpwx4+tjded2WpZeyMounFWwep6RJGJ07GrFlnJGzvJD+F1S3Cxm+tv1uG5OUr4k2EUAcL8c5flWA/QBDLE+45hb4I=
MIME-Version: 1.0
In-Reply-To: <CAM_iQpV89LRuJovA840T0pUQYXkZvecezLmg6=Hp0PxfziOxUQ@mail.gmail.com>
References: <0000000000003584570568da18dd@google.com> <06c79d3f-3f28-7f1e-9431-66c18149c9e6@virtuozzo.com>
 <CACT4Y+Zb4Y1=H8Vtd1d+ULKu-P3ftud=SgFqSAfu9SE6Lu3LMA@mail.gmail.com>
 <0eb5ed24-012a-89c9-bac9-796a0276221a@virtuozzo.com> <CAM_iQpV89LRuJovA840T0pUQYXkZvecezLmg6=Hp0PxfziOxUQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 4 Apr 2018 21:00:16 +0200
Message-ID: <CACT4Y+aRqG8i1WUKAF925aqN9Nrg43YE1AjGzzLC5hZs4ZawDw@mail.gmail.com>
Subject: Re: possible deadlock in skb_queue_tail
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, Ingo Molnar <mingo@kernel.org>,
        syzbot <syzbot+6b495100f17ca8554ab9@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        David Windsor <dwindsor@gmail.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthew Dawson <matthew@mjdsystems.ca>,
        Mateusz Jurczyk <mjurczyk@google.com>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        xemul@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 7:08 AM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Tue, Apr 3, 2018 at 4:42 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> On 03.04.2018 14:25, Dmitry Vyukov wrote:
>>> On Tue, Apr 3, 2018 at 11:50 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>> sk_diag_dump_icons() dumps only sockets in TCP_LISTEN state.
>>>> TCP_LISTEN state may be assigned in only place in net/unix/af_unix.c:
>>>> it's unix_listen(). The function is applied to stream and seqpacket
>>>> socket types.
>>>>
>>>> It can't be stream because of the second stack, and seqpacket also can't,
>>>> as I don't think it's possible for gcc to inline unix_seqpacket_sendmsg()
>>>> in the way, we don't see it in the stack.
>>>>
>>>> So, this is looks like false positive result for me.
>>>>
>>>> Kirill
>>>
>>> Do you mean that these &(&u->lock)->rlock/1 referenced in 2 stacks are
>>> always different?
>>
>> In these 2 particular stacks they have to be different.
>
> So actually my patch could fix this false positive? I thought it couldn't.
> https://patchwork.ozlabs.org/patch/894342/

You know better!
If you suspect it can fix this report, and nobody has better
proposals, then we can just mark this as being fixed with your commit
and then see if it triggers again with your commit or not.
