Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8777921841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLRKlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:41:17 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:21328 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLRKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:41:17 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBIAerjA074486;
        Tue, 18 Dec 2018 19:40:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 18 Dec 2018 19:40:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBIAerk3074472
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 18 Dec 2018 19:40:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Dmitry Vyukov <dvyukov@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000051e9c2057d31a563@google.com>
 <20181217072144.GQ2217@ZenIV.linux.org.uk>
 <CACT4Y+Zeyfd693tMa4eTqSWYCBK+55_Lt3tzk2MckFa2KoFGuw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <02027545-b9c3-222b-7f5c-66a11ecadd2d@I-love.SAKURA.ne.jp>
Date:   Tue, 18 Dec 2018 19:40:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Zeyfd693tMa4eTqSWYCBK+55_Lt3tzk2MckFa2KoFGuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/17 19:08, Dmitry Vyukov wrote:
> On Mon, Dec 17, 2018 at 8:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>>>  slab_alloc mm/slab.c:3365 [inline]
>>>  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
>>>  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
>>> ------------[ cut here ]------------
>>> kernel BUG at fs/inode.c:1566!
>>>  d_alloc_anon fs/dcache.c:1698 [inline]
>>>  d_make_root+0x43/0xc0 fs/dcache.c:1885
>>>  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273
>>
>> Huh?  BUG is in iput(), AFAICS, so the stack trace is rather misreported.
> 
> Yes, it's a known problem that kernel is generally incapable of
> producing parsable crash reports. I think Tetsuo is working on a
> solution, but it takes very large amount of discussions and months of
> time.

The solution, CONFIG_PRINTK_FROM option (which will be renamed to CONFIG_PRINTK_CALLER
option tomorrow), just arrived at linux-next-20181218. We can try it...

But currently syzbot cannot boot using linux-next-20181218 due to
"Kernel panic - not syncing: Can't create rootfs" presumably due to changes merged by
"Merge branches 'work.mount', 'work.misc', 'misc.misc' and 'work.iov_iter' into for-next".
I think that we need to examine this "Can't create rootfs" problem, for
the merge window is approaching...

