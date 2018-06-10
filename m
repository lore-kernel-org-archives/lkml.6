Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MvCgMlAfHVsDVwAAmS7hNA
	; Sun, 10 Jun 2018 12:53:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5229E607E7; Sun, 10 Jun 2018 12:53:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CA39D605A5;
	Sun, 10 Jun 2018 12:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA39D605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbeFJMx3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:53:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57958 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbeFJMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:53:28 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5ACrC9a094886;
        Sun, 10 Jun 2018 21:53:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Sun, 10 Jun 2018 21:53:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5ACr6AJ094853
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 10 Jun 2018 21:53:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING: kmalloc bug in xdp_umem_create
To: Dmitry Vyukov <dvyukov@google.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000092de58056e3d4b96@google.com>
 <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
 <CAJ+HfNhnmvTHsE7cgi8pROjprsYvCZuzZDmYmpiUx4jqtHboUw@mail.gmail.com>
 <CACT4Y+bfZK6yucoDrXPPW3Tc40RYq61u0Zcb=CKtdao8E+v1cQ@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <13f6777a-2170-d0cc-1066-1b48a27ec981@i-love.sakura.ne.jp>
Date: Sun, 10 Jun 2018 21:53:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bfZK6yucoDrXPPW3Tc40RYq61u0Zcb=CKtdao8E+v1cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/10 20:52, Dmitry Vyukov wrote:
> On Sun, Jun 10, 2018 at 11:31 AM, Björn Töpel <bjorn.topel@gmail.com> wrote:
>> Den sön 10 juni 2018 kl 04:53 skrev Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp>:
>>>
>>> On 2018/06/10 7:47, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://git.k..
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1073f68f800000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f04d8d0a2afb789a
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=4abadc5d69117b346506
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13c9756f800000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16366f9f800000
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com
>>>>
>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>> WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70 mm/slab_common.c:996
>>>> Kernel panic - not syncing: panic_on_warn set ...
>>>
>>> syzbot gave up upon kmalloc(), but actually error handling path has
>>> NULL pointer dereference bug.
>>>
>>
>> Thanks Tetsuo! This crash has been fixed by Daniel Borkmann in commit
>> c09290c56376 ("bpf, xdp: fix crash in xdp_umem_unaccount_pages").
> 
> Let's tell syzbot about this:
> 
> #syz fix: bpf, xdp: fix crash in xdp_umem_unaccount_pages
> 
> 
Excuse me, but that patch fixes NULL pointer dereference which occurs after kmalloc()'s
"WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70 mm/slab_common.c:996"
message. That is, "Too large memory allocation" itself is not yet fixed.
