Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14F5C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4413206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfAFOiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 09:38:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:41165 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfAFOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 09:38:12 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x06Ebqi8023469;
        Sun, 6 Jan 2019 23:37:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Sun, 06 Jan 2019 23:37:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x06EbpfU023437
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 6 Jan 2019 23:37:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: KASAN: stack-out-of-bounds Read in check_stack_object
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+05fc3a636f5ee8830a99@syzkaller.appspotmail.com>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000ae2357057eca1fa5@google.com>
 <CACT4Y+Y+dph0wyKOLffXMPFPsvbviYzfn1nrJJgOL1ngkQLtVw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <40577a65-3947-aec9-3b82-ac71f150e586@I-love.SAKURA.ne.jp>
Date:   Sun, 6 Jan 2019 23:37:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y+dph0wyKOLffXMPFPsvbviYzfn1nrJJgOL1ngkQLtVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/06 22:48, Dmitry Vyukov wrote:
> On Sun, Jan 6, 2019 at 2:31 PM syzbot
> <syzbot+05fc3a636f5ee8830a99@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    3fed6ae4b027 ia64: fix compile without swiotlb
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=161ce1d7400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
>> dashboard link: https://syzkaller.appspot.com/bug?extid=05fc3a636f5ee8830a99
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> userspace arch: i386
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b3769f400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+05fc3a636f5ee8830a99@syzkaller.appspotmail.com
> 
> I suspect this is another incarnation of:
> https://syzkaller.appspot.com/bug?id=4821de869e3d78a255a034bf212a4e009f6125a7
> Any other ideas?



>> CPU: 0 PID: -1455013312 Comm:  Not tainted 4.20.0+ #10

"current->pid < 0" suggests that "struct task_struct" was overwritten.

>> #PF error: [normal kernel read fault]

>> Thread overran stack, or stack corrupted

And "struct task_struct" might be overwritten by stack overrun?

The cause of overrun is unknown, but given that
"fou6: Prevent unbounded recursion in GUE error handler" is not yet
applied to linux.git tree, this might be a dup of that bug.

