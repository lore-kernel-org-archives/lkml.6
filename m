Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeBHNya (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:54:30 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43401 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeBHNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:54:27 -0500
X-Google-Smtp-Source: AH8x227qnoOwGYVZgWl81CoxGfwA8nRIvydLITPRVjcE6+wKPUIiQNzFIVhmfJeKemr5oj/NZfxSeCD7QUgqSW/5ZzI=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z9+DsDz4F--2X7+ZOdf2G7u9Cf05fcXyjP74+rxLV7Qg@mail.gmail.com>
References: <001a113f2b4c2733040564a73af3@google.com> <CADvbK_dLpUv-TY1LgvPqOVtxmfOBL+Q15vAkmX5M1jbJVP7aRg@mail.gmail.com>
 <CACT4Y+Z9+DsDz4F--2X7+ZOdf2G7u9Cf05fcXyjP74+rxLV7Qg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Feb 2018 21:54:25 +0800
Message-ID: <CADvbK_dQ8pvhECuOGncZ=qS95KrjXLuisODPqhadZc7oy5pE8Q@mail.gmail.com>
Subject: Re: possible deadlock in rtnl_lock (4)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+ddde1c7b7ff7442d7f2d@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>, davem <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>, Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Benc <jbenc@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        mschiffer@universe-factory.net, network dev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Vlad Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 9:25 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Feb 8, 2018 at 10:54 AM, Xin Long <lucien.xin@gmail.com> wrote:
>> On Thu, Feb 8, 2018 at 6:58 AM, syzbot
>> <syzbot+ddde1c7b7ff7442d7f2d@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot hit the following crash on upstream commit
>>> a2e5790d841658485d642196dbb0927303d6c22f (Wed Feb 7 06:15:42 2018 +0000)
>>> Merge branch 'akpm' (patches from Andrew)
>>>
>>> So far this crash happened 632 times on
>>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master.
>>> C reproducer is attached.
>>> syzkaller reproducer is attached.
>>> Raw console output is attached.
>>> compiler: gcc (GCC) 7.1.1 20170620
>>> .config is attached.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+ddde1c7b7ff7442d7f2d@syzkaller.appspotmail.com
>>> It will help syzbot understand when the bug is fixed. See footer for
>>> details.
>>> If you forward the report, please keep this part and the footer.
>>>
>>>
>>> ======================================================
>>> WARNING: possible circular locking dependency detected
>>> 4.15.0+ #301 Not tainted
>>> ------------------------------------------------------
>>> syzkaller233489/4179 is trying to acquire lock:
>>>  (rtnl_mutex){+.+.}, at: [<0000000048e996fd>] rtnl_lock+0x17/0x20
>>> net/core/rtnetlink.c:74
>>>
>>> but task is already holding lock:
>>>  (&xt[i].mutex){+.+.}, at: [<00000000328553a2>]
>>> xt_find_table_lock+0x3e/0x3e0 net/netfilter/x_tables.c:1041
>>>
>>> which lock already depends on the new lock.
>>>
>>>
>>> the existing dependency chain (in reverse order) is:
>>>
>>> -> #2 (&xt[i].mutex){+.+.}:
>>>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>>>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>>>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>>>        xt_find_table_lock+0x3e/0x3e0 net/netfilter/x_tables.c:1041
>>>        xt_request_find_table_lock+0x28/0xc0 net/netfilter/x_tables.c:1088
>>>        get_info+0x154/0x690 net/ipv6/netfilter/ip6_tables.c:989
>>>        do_ipt_get_ctl+0x159/0xac0 net/ipv4/netfilter/ip_tables.c:1699
>>>        nf_sockopt net/netfilter/nf_sockopt.c:104 [inline]
>>>        nf_getsockopt+0x6a/0xc0 net/netfilter/nf_sockopt.c:122
>>>        ip_getsockopt+0x15c/0x220 net/ipv4/ip_sockglue.c:1571
>>>        tcp_getsockopt+0x82/0xd0 net/ipv4/tcp.c:3359
>>>        sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2934
>>>        SYSC_getsockopt net/socket.c:1880 [inline]
>>>        SyS_getsockopt+0x178/0x340 net/socket.c:1862
>>>        do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
>>>        entry_SYSCALL_64_after_hwframe+0x26/0x9b
>>>
>>> -> #1 (sk_lock-AF_INET){+.+.}:
>>>        lock_sock_nested+0xc2/0x110 net/core/sock.c:2777
>>>        lock_sock include/net/sock.h:1463 [inline]
>>>        do_ip_setsockopt.isra.12+0x1d9/0x3210 net/ipv4/ip_sockglue.c:646
>>>        ip_setsockopt+0x3a/0xa0 net/ipv4/ip_sockglue.c:1252
>>>        udp_setsockopt+0x45/0x80 net/ipv4/udp.c:2401
>>>        sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2975
>>>        SYSC_setsockopt net/socket.c:1849 [inline]
>>>        SyS_setsockopt+0x189/0x360 net/socket.c:1828
>>>        do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
>>>        entry_SYSCALL_64_after_hwframe+0x26/0x9b
>>>
>>> -> #0 (rtnl_mutex){+.+.}:
>>>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>>>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>>>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>>>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>>>        rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>>>        unregister_netdevice_notifier+0x91/0x4e0 net/core/dev.c:1673
>>>        clusterip_config_entry_put net/ipv4/netfilter/ipt_CLUSTERIP.c:114
>>> [inline]
>>>        clusterip_tg_destroy+0x389/0x6e0
>>> net/ipv4/netfilter/ipt_CLUSTERIP.c:518
>>>        cleanup_entry+0x218/0x350 net/ipv4/netfilter/ip_tables.c:654
>>>        __do_replace+0x79d/0xa50 net/ipv4/netfilter/ip_tables.c:1089
>>>        do_replace net/ipv4/netfilter/ip_tables.c:1145 [inline]
>>>        do_ipt_set_ctl+0x40f/0x5f0 net/ipv4/netfilter/ip_tables.c:1675
>>>        nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>>>        nf_setsockopt+0x67/0xc0 net/netfilter/nf_sockopt.c:115
>>>        ip_setsockopt+0x97/0xa0 net/ipv4/ip_sockglue.c:1259
>>>        tcp_setsockopt+0x82/0xd0 net/ipv4/tcp.c:2905
>>>        sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2975
>>>        SYSC_setsockopt net/socket.c:1849 [inline]
>>>        SyS_setsockopt+0x189/0x360 net/socket.c:1828
>>>        do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
>>>        entry_SYSCALL_64_after_hwframe+0x26/0x9b
>>>
>>> other info that might help us debug this:
>>>
>>> Chain exists of:
>>>   rtnl_mutex --> sk_lock-AF_INET --> &xt[i].mutex
>>>
>>>  Possible unsafe locking scenario:
>>>
>>>        CPU0                    CPU1
>>>        ----                    ----
>>>   lock(&xt[i].mutex);
>>>                                lock(sk_lock-AF_INET);
>>>                                lock(&xt[i].mutex);
>>>   lock(rtnl_mutex);
>>>
>>>  *** DEADLOCK ***
>>
>> It's probably just a warning.
>
> We are also seeing some "task hung for 120 seconds on rtnl_lock"
> warnings lately. However, they are not preceded by any lockdep
> warnings, which is strange.

Paolo noticed this warning actually could trigger a deadlock,
just need 3 processes, he already posted a fix:
  [PATCH net v2] netfilter: drop outermost socket lock in getsockopt()

Let's see if it would also fix these panicks. Otherwise, I will try to
move this rtnl_lock out of the xt_lock as the below patch.

>
>
>> I'm thinking an improment that moves up xt_table_unlock(t) in __do_replace():
>>
>> +++ b/net/ipv4/netfilter/ip_tables.c
>> @@ -1082,6 +1082,8 @@ static int get_info(struct net *net, void __user *user,
>>             (newinfo->number <= oldinfo->initial_entries))
>>                 module_put(t->me);
>>
>> +       xt_table_unlock(t);
>> +
>>         get_old_counters(oldinfo, counters);
>>
>>         /* Decrease module usage counts and free resource */
>> @@ -1095,7 +1097,6 @@ static int get_info(struct net *net, void __user *user,
>>                 net_warn_ratelimited("iptables: counters copy to user
>> failed while replacing table\n");
>>         }
>>         vfree(counters);
>> -       xt_table_unlock(t);
>>         return ret;
>>
>> It should be safe, as 'oldinfo' doesn't belong to this table anymore there,
>> no need to protect it by xt[i].mutex. It could also avoid this warning.
>> I need to do some testings to confirm this.
>>
>>>
>>> 1 lock held by syzkaller233489/4179:
>>>  #0:  (&xt[i].mutex){+.+.}, at: [<00000000328553a2>]
>>> xt_find_table_lock+0x3e/0x3e0 net/netfilter/x_tables.c:1041
>>>
>>> stack backtrace:
>>> CPU: 1 PID: 4179 Comm: syzkaller233489 Not tainted 4.15.0+ #301
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>  __dump_stack lib/dump_stack.c:17 [inline]
>>>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>>>  print_circular_bug.isra.38+0x2cd/0x2dc kernel/locking/lockdep.c:1223
>>>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>>>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>>>  validate_chain kernel/locking/lockdep.c:2417 [inline]
>>>  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3431
>>>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>>>  __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>>>  __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>>>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>>>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>>>  unregister_netdevice_notifier+0x91/0x4e0 net/core/dev.c:1673
>>>  clusterip_config_entry_put net/ipv4/netfilter/ipt_CLUSTERIP.c:114 [inline]
>>>  clusterip_tg_destroy+0x389/0x6e0 net/ipv4/netfilter/ipt_CLUSTERIP.c:518
>>>  cleanup_entry+0x218/0x350 net/ipv4/netfilter/ip_tables.c:654
>>>  __do_replace+0x79d/0xa50 net/ipv4/netfilter/ip_tables.c:1089
>>>  do_replace net/ipv4/netfilter/ip_tables.c:1145 [inline]
>>>  do_ipt_set_ctl+0x40f/0x5f0 net/ipv4/netfilter/ip_tables.c:1675
>>>  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>>>  nf_setsockopt+0x67/0xc0 net/netfilter/nf_sockopt.c:115
>>>  ip_setsockopt+0x97/0xa0 net/ipv4/ip_sockglue.c:1259
>>>  tcp_setsockopt+0x82/0xd0 net/ipv4/tcp.c:2905
>>>  sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2975
>>>  SYSC_setsockopt net/socket.c:1849 [inline]
>>>  SyS_setsockopt+0x189/0x360 net/socket.c:1828
>>>  do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
>>>  entry_SYSCALL_64_after_hwframe+0x26/0x9b
>>> RIP: 0033:0x44428a
>>> RSP: 002b:00007fff903974a8 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
>>> RAX: ffffffffffffffda RBX: 00000000006cc100 RCX: 000000000044428a
>>> RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
>>> RBP: 00000000006cc100 R08: 00000000000002d8 R09: 0000000000cbe880
>>> R10: 00000000006cc528 R11: 0000000000000206 R12: 0000000000000003
>>> R13: 00000000006cf0a8 R14: 00000000006cf050 R15: 00000000004a322e
>>>
>>>
>>> ---
>>> This bug is generated by a dumb bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for details.
>>> Direct all questions to syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this bug report.
>>> If you forgot to add the Reported-by tag, once the fix for this bug is
>>> merged
>>> into any tree, please reply to this email with:
>>> #syz fix: exact-commit-title
>>> If you want to test a patch for this bug, please reply with:
>>> #syz test: git://repo/address.git branch
>>> and provide the patch inline or as an attachment.
>>> To mark this as a duplicate of another syzbot report, please reply with:
>>> #syz dup: exact-subject-of-another-report
>>> If it's a one-off invalid bug report, please reply with:
>>> #syz invalid
>>> Note: if the crash happens again, it will cause creation of a new bug
>>> report.
>>> Note: all commands must start from beginning of the line in the email body.
