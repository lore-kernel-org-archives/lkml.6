Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15027C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B1D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeLaISK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:18:10 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:32316 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeLaISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:18:09 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBV8HNlj008160;
        Mon, 31 Dec 2018 17:17:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Mon, 31 Dec 2018 17:17:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBV8HIbh008118
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 31 Dec 2018 17:17:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: rcu detected stall in ndisc_alloc_skb
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-MM <linux-mm@kvack.org>
References: <0000000000007beca9057e4c8c14@google.com>
 <CACT4Y+Yx4BJw=F_PMx9a8AjPKzEwhzLnzt9K-dgkBoNkKQj2+g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <ef2508c9-d069-2143-09a6-a90b9ef12568@I-love.SAKURA.ne.jp>
Date:   Mon, 31 Dec 2018 17:17:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Yx4BJw=F_PMx9a8AjPKzEwhzLnzt9K-dgkBoNkKQj2+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/31 16:49, Dmitry Vyukov wrote:
> On Mon, Dec 31, 2018 at 8:42 AM syzbot
> <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    ef4ab8447aa2 selftests: bpf: install script with_addr.sh
>> git tree:       bpf-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14a28b6e400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e7e2279c0020d5f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=ea7d9cb314b4ab49a18a
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com
> 
> Since this involves OOMs and looks like a one-off induced memory corruption:
> 
> #syz dup: kernel panic: corrupted stack end in wb_workfn
> 

Why?

RCU stall in this case is likely to be latency caused by flooding of printk().
