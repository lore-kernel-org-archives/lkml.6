Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39631C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ECB20684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzuAlfgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ECB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbeI1PCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:02:43 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54310 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbeI1PCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:02:42 -0400
Received: by mail-it1-f193.google.com with SMTP id f14-v6so1656121ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w4iKj5QPJanX0rheArNvcHU6trq225AGValxwhsvPqk=;
        b=YzuAlfgha6qbYkYzhZ7aj3Kze8d+4zXPTWVYofN/xCQ4GOgxG0PCtOo6ODnGhURmVD
         9MmbzXz5R78Bpnw5a4VZKlBJFQBGBTtfNoy/+OHigT3EqZVCelQQe5uFO386CSOgM94/
         GzeAQe8cExtA7lKBWzFvV6TEFKAwJ/rxlWraWOwzeynt7V6EA4tZvqPPKWkd8Nf1T9cm
         ClmpOJB16EsPLXYuwLcyRx2nTGN0xmAMVVt6s9zDpDqOFDCFwWHF/pNJVOQaD4ywDFH6
         jvqXlJCg+LFqxqk/Rrm570rxJPkJfyZ9L0p8Ln8x7+tYwW0HA0ieJ7/9kATz5bQaKInh
         MO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w4iKj5QPJanX0rheArNvcHU6trq225AGValxwhsvPqk=;
        b=HywOJZvkZXE0oiJwxp6+k2d8SxKXseY/dG7/p7RLlY+7pRcRYY8nb/U5/BU8j5FH4t
         8xgjp+FuOVp+t1GKPLgrByaRAZZ08XaSfGL3YaTbLcs+xQl/30Uf3w+KGnK3BZT4zERD
         eIMiiT/HK+yMsnlpO3ljsiSTJ8/1JJCYWXMiFF949QfnoN0KB2Z9g/Dqw2rQ4UtF/YAc
         18R5nS1cypTGHtFKFNS0aKbtiIQwO9KsqRX31pO/de9d5FhJJpk9Ml6sV8/1xHR9U8Pi
         2566h7BmQNouTMHIImXRnge57qn5mZd0xisObiF38sTTnGb7Dn+QwooyxPQN0QoMrF/B
         ggPw==
X-Gm-Message-State: ABuFfohDG98708QOmrds7oMOEcYGf1moAjEnVLe80S9WGBa2tw6rRPNi
        z+dgNFWi/vBvpnqLJf4UPinxXWeEHiZ36A7AnDwkRA==
X-Google-Smtp-Source: ACcGV63wJZcpo0/QwQE4sEUp1jjmfTNqRxScFip6Wr2mkqrD3Q6VB8IA5f3shyhQ7HM3Npjowc6gZNrSHIahlBxo1zc=
X-Received: by 2002:a24:e187:: with SMTP id n129-v6mr829430ith.47.1538124001516;
 Fri, 28 Sep 2018 01:40:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 01:39:40
 -0700 (PDT)
In-Reply-To: <CACT4Y+YAbon-m=N-UcEVfGj8DxgRAySQz7qLYQWFxQZqv+3JhA@mail.gmail.com>
References: <000000000000a7487d0576c18693@google.com> <CACT4Y+YAbon-m=N-UcEVfGj8DxgRAySQz7qLYQWFxQZqv+3JhA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 28 Sep 2018 10:39:40 +0200
Message-ID: <CACT4Y+ZP3bFBZ7Omjn7e78ibfCNAFriMpmPut5P38Ex_aGcJHQ@mail.gmail.com>
Subject: Re: KASAN: global-out-of-bounds Read in __aa_lookupn_ns
To:     syzbot <syzbot+71b6643475f707f93fdc@syzkaller.appspotmail.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:06 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 26, 2018 at 9:54 AM, syzbot
> <syzbot+71b6643475f707f93fdc@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    02214bfc89c7 Merge tag 'media/v4.19-2' of git://git.kernel..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1456f8a1400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=71b6643475f707f93fdc
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>
> Again misattributed to net. This misattribution should now be fixed by:
> https://github.com/google/syzkaller/commit/db716d6653d073b0abfb51186cd4ac2d5418c9c6
> Adding security/apparmor/policy_ns.c maintainers explicitly.

This is the same as "KASAN: stack-out-of-bounds Read in __aa_lookupn_ns":
https://syzkaller.appspot.com/bug?id=f0d603856d8b3cc9b8e09228f2f548c18ef907ac
right?

>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+71b6643475f707f93fdc@syzkaller.appspotmail.com
>>
>>  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3038
>>  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
>>  __do_sys_setsockopt net/socket.c:1913 [inline]
>>  __se_sys_setsockopt net/socket.c:1910 [inline]
>>  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>> ==================================================================
>> BUG: KASAN: global-out-of-bounds in memcmp+0xe3/0x160 lib/string.c:861
>> Read of size 1 at addr ffffffff88000008 by task syz-executor0/10914
>>
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x457579
>> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f4c14533c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
>> RAX: ffffffffffffffda RBX: 00007f4c14533c90 RCX: 0000000000457579
>> RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
>> RBP: 000000000072bf00 R08: 0000000000000004 R09: 0000000000000000
>> R10: 0000000020000080 R11: 0000000000000246 R12: 00007f4c145346d4
>> R13: 00000000004c3ed9 R14: 00000000004d6260 R15: 0000000000000004
>> CPU: 0 PID: 10914 Comm: syz-executor0 Not tainted 4.19.0-rc5+ #252
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>  print_address_description.cold.8+0x58/0x1ff mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>>  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
>>  memcmp+0xe3/0x160 lib/string.c:861
>>  strnstr+0x4b/0x70 lib/string.c:934
>>  __aa_lookupn_ns+0xc1/0x570 security/apparmor/policy_ns.c:209
>>  aa_lookupn_ns+0x88/0x1e0 security/apparmor/policy_ns.c:240
>>  aa_fqlookupn_profile+0x1b9/0x1010 security/apparmor/policy.c:468
>>  fqlookupn_profile+0x80/0xc0 security/apparmor/label.c:1844
>>  aa_label_strn_parse+0xa3a/0x1230 security/apparmor/label.c:1908
>>  aa_label_parse+0x42/0x50 security/apparmor/label.c:1943
>>  aa_change_profile+0x513/0x3510 security/apparmor/domain.c:1362
>>  apparmor_setprocattr+0xa8b/0x1150 security/apparmor/lsm.c:656
>>  security_setprocattr+0x66/0xc0 security/security.c:1298
>>  proc_pid_attr_write+0x301/0x540 fs/proc/base.c:2555
>>  __vfs_write+0x119/0x9f0 fs/read_write.c:485
>>  vfs_write+0x1fc/0x560 fs/read_write.c:549
>>  ksys_write+0x101/0x260 fs/read_write.c:598
>>  __do_sys_write fs/read_write.c:610 [inline]
>>  __se_sys_write fs/read_write.c:607 [inline]
>>  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x457579
>> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f5a92ec2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
>> RDX: 000000000000002c RSI: 00000000200000c0 RDI: 0000000000000004
>> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5a92ec36d4
>> R13: 00000000004c5454 R14: 00000000004d8c78 R15: 00000000ffffffff
>>
>> CPU: 1 PID: 10921 Comm: syz-executor3 Not tainted 4.19.0-rc5+ #252
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> The buggy address belongs to the variable:
>>  __start_rodata+0x8/0x1000
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>
>> Memory state around the buggy address:
>>  ffffffff87ffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  ffffffff87ffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  fail_dump lib/fault-inject.c:51 [inline]
>>  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
>>>
>>> ffffffff88000000: 00 fa fa fa fa fa fa fa 00 01 fa fa fa fa fa fa
>>
>>                       ^
>>  ffffffff88000080: 00 00 00 07 fa fa fa fa 00 04 fa fa fa fa fa fa
>>  ffffffff88000100: 05 fa fa fa fa fa fa fa 00 00 00 00 05 fa fa fa
>> ==================================================================
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
