Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C5113C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E8E208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E8E208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933421AbeFLMJE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:09:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:55194 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLMJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:09:02 -0400
Received: from [178.197.248.16] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fSi6W-0005cB-La; Tue, 12 Jun 2018 14:08:52 +0200
Subject: Re: WARNING: kmalloc bug in xdp_umem_create
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        penguin-kernel@i-love.sakura.ne.jp
Cc:     dvyukov@google.com,
        syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
References: <00000000000092de58056e3d4b96@google.com>
 <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
 <CAJ+HfNhnmvTHsE7cgi8pROjprsYvCZuzZDmYmpiUx4jqtHboUw@mail.gmail.com>
 <CACT4Y+bfZK6yucoDrXPPW3Tc40RYq61u0Zcb=CKtdao8E+v1cQ@mail.gmail.com>
 <13f6777a-2170-d0cc-1066-1b48a27ec981@i-love.sakura.ne.jp>
 <CAJ+HfNh9pRGcd9EO7BEfPPEdCmP5EDdu_rNgLR7r4oDrcLgvQQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aa02466c-695a-d482-bc5e-ff249536a4ad@iogearbox.net>
Date:   Tue, 12 Jun 2018 14:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAJ+HfNh9pRGcd9EO7BEfPPEdCmP5EDdu_rNgLR7r4oDrcLgvQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24655/Tue Jun 12 06:33:35 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2018 03:03 PM, Björn Töpel wrote:
> Den sön 10 juni 2018 kl 14:53 skrev Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp>:
>> On 2018/06/10 20:52, Dmitry Vyukov wrote:
>>> On Sun, Jun 10, 2018 at 11:31 AM, Björn Töpel <bjorn.topel@gmail.com> wrote:
>>>> Den sön 10 juni 2018 kl 04:53 skrev Tetsuo Handa
>>>> <penguin-kernel@i-love.sakura.ne.jp>:
>>>>> On 2018/06/10 7:47, syzbot wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following crash on:
>>>>>>
>>>>>> HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://git.k..
>>>>>> git tree:       upstream
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1073f68f800000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f04d8d0a2afb789a
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=4abadc5d69117b346506
>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13c9756f800000
>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16366f9f800000
>>>>>>
>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com
>>>>>>
>>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>>> WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70 mm/slab_common.c:996
>>>>>> Kernel panic - not syncing: panic_on_warn set ...
>>>>>
>>>>> syzbot gave up upon kmalloc(), but actually error handling path has
>>>>> NULL pointer dereference bug.
>>>>
>>>> Thanks Tetsuo! This crash has been fixed by Daniel Borkmann in commit
>>>> c09290c56376 ("bpf, xdp: fix crash in xdp_umem_unaccount_pages").
>>>
>>> Let's tell syzbot about this:
>>>
>>> #syz fix: bpf, xdp: fix crash in xdp_umem_unaccount_pages
>>>
>> Excuse me, but that patch fixes NULL pointer dereference which occurs after kmalloc()'s
>> "WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70 mm/slab_common.c:996"
>> message. That is, "Too large memory allocation" itself is not yet fixed.
> 
> The code relies on that the sl{u,a,o}b layer says no, and the
> setsockopt bails out. The warning could be opted out using
> __GFP_NOWARN. Is there another preferred way? Two get_user_pages
> calls, where the first call would set pages to NULL just to fault the
> region? Walk the process' VMAs? Something else?

(Now resolved as well.)

#syz fix: xsk: silence warning on memory allocation failure
