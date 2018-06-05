Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeFEJgx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:36:53 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37942 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeFEJgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:36:52 -0400
X-Google-Smtp-Source: ADUXVKJjur4rmrphE5gDvKKwHhFGaMXRy8us+buWwmL/ZbfgS7XUE72lj6fIKgpjFVnmVolRNkTt4y8iX3cKqpNieg0=
MIME-Version: 1.0
In-Reply-To: <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com>
References: <0000000000006e4595056dd23c16@google.com> <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
 <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 5 Jun 2018 11:36:30 +0200
Message-ID: <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
Subject: Re: INFO: task hung in ip6gre_exit_batch_net
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: syzbot <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Xin Long <lucien.xin@gmail.com>,
        mschiffer@universe-factory.net, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:03 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> Hi, Dmirty!
>
> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>
>> Another hang on rtnl lock:
>>
>> #syz dup: INFO: task hung in netdev_run_todo
>>
>> May be related to "unregister_netdevice: waiting for DEV to become free":
>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9

netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
be something different.


>> Any other explanations for massive hangs on rtnl lock for minutes?
>
> To exclude the situation, when a task exists with rtnl_mutex held:
>
> would the pr_warn() from print_held_locks_bug() be included in the console output
> if they appear?

Yes, everything containing "WARNING:" is detected as bug.
