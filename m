Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86042206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfAIOSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:18:53 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:50058 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbfAIOSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:18:53 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x09EIpRv033111;
        Wed, 9 Jan 2019 23:18:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 09 Jan 2019 23:18:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x09EIkRs032906
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 9 Jan 2019 23:18:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING: locking bug in lock_downgrade
To:     peterz@infradead.org, "mingo@redhat.com" <mingo@redhat.com>
References: <00000000000043ae20057b974f14@google.com>
 <f0acc6af-cdd5-0e46-bca5-2e2a9a4c983e@linux.alibaba.com>
 <69273d51-c129-6b0f-35eb-d98655476ff9@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        syzbot <syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@dominikbrodowski.net, mhocko@suse.com, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        boqun.feng@gmail.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <d61e0a3e-a71e-9e42-7a56-d6fcfc0f6b63@I-love.SAKURA.ne.jp>
Date:   Wed, 9 Jan 2019 23:18:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <69273d51-c129-6b0f-35eb-d98655476ff9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/14 4:46, Waiman Long wrote:
> On 12/12/2018 08:14 PM, Yang Shi wrote:
>> By looking into lockdep code, I'm not sure if lockdep may get confused
>> by such sequence or not?
>>
>>
>> Any hint is appreciated.
>>
>>
>> Regards,
>>
>> Yang 
> 
> The warning was printed because hlock->read was set when doing the
> downgrade_write(). So it is either downgrade_write() was called a second
> time or a read lock was held originally. It is hard to tell what is the
> root cause without a reproducer.
> 
> Cheers,
> Longman
> 

Comparing with output from

        struct rw_semaphore *sem = &current->mm->mmap_sem;

        down_write(sem);
        pr_warn("mmap_sem: count=%ld current=%px, owner=%px\n", atomic_long_read(&sem->count), current, READ_ONCE(sem->owner));
        /* mmap_sem: count=-4294967295 current=ffff88813095ca80, owner=ffff88813095ca80 */
        downgrade_write(sem);
        pr_warn("mmap_sem: count=%ld current=%px, owner=%px\n", atomic_long_read(&sem->count), current, READ_ONCE(sem->owner));
        /* mmap_sem: count=1 current=ffff88813095ca80, owner=ffff88813095ca83 */
        up_read(sem);
        pr_warn("mmap_sem: count=%ld current=%px, owner=%px\n", atomic_long_read(&sem->count), current, READ_ONCE(sem->owner));
        /* mmap_sem: count=0 current=ffff88813095ca80, owner=0000000000000003 */

what we got with debug printk() patch

  https://syzkaller.appspot.com/text?tag=CrashLog&x=169dbb9b400000

  [ 2580.337550][ T3645] mmap_sem: hlock->read=1 count=-4294967295 current=ffff888050e04140, owner=ffff888050e04140
  [ 2580.353526][ T3645] ------------[ cut here ]------------
  [ 2580.367859][ T3645] downgrading a read lock
  [ 2580.367935][ T3645] WARNING: CPU: 1 PID: 3645 at kernel/locking/lockdep.c:3572 lock_downgrade+0x35d/0xbe0
  [ 2580.382206][ T3645] Kernel panic - not syncing: panic_on_warn set ...

  https://syzkaller.appspot.com/text?tag=CrashLog&x=1542da4f400000

  [  386.342585][T16698] mmap_sem: hlock->read=1 count=-4294967295 current=ffff8880512ae180, owner=ffff8880512ae180
  [  386.348586][T16698] ------------[ cut here ]------------
  [  386.357203][T16698] downgrading a read lock
  [  386.357294][T16698] WARNING: CPU: 1 PID: 16698 at kernel/locking/lockdep.c:3572 lock_downgrade+0x35d/0xbe0
  [  386.372148][T16698] Kernel panic - not syncing: panic_on_warn set ...

indicates that lockdep is saying that "current->mm->mmap_sem is held for read"
while "struct rw_semaphore" is saying that "current->mm->mmap_sem is held for write".
Something made lockdep confused. Possibly a lockdep bug.

