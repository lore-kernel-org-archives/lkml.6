Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48BDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887B5204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887B5204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbeGKLSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:18:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:31809 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbeGKLSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:18:18 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6BBDDDT031165;
        Wed, 11 Jul 2018 20:13:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Wed, 11 Jul 2018 20:13:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6BBDCsS031115
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 11 Jul 2018 20:13:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in __sb_start_write
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000283c37056b4a81a5@google.com>
 <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
 <20180611073038.GK12217@hirez.programming.kicks-ass.net>
 <CACT4Y+Zyf2e_K0oRJ5oRj3WYWpf-t=V=RKHYcdqujF3s9PJL_w@mail.gmail.com>
 <b1b876d9-94e8-fdee-ae12-e05a7467ce5b@i-love.sakura.ne.jp>
 <CACT4Y+ZaUanRCWtq4nFhFVxfDCX=2e6JCW-qkX7vp++QvijWBw@mail.gmail.com>
 <dd849e4f-a30f-e508-d4e9-0f3c6d11c89a@i-love.sakura.ne.jp>
 <f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <51f1de87-3fbe-48f6-0297-9717d9919772@I-love.SAKURA.ne.jp>
Date:   Wed, 11 Jul 2018 20:13:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/19 20:10, Tetsuo Handa wrote:
> On 2018/06/16 4:40, Tetsuo Handa wrote:
>> Hmm, there might be other locations calling percpu_rwsem_release() ?
> 
> There are other locations calling percpu_rwsem_release(), but quite few.
> 
> include/linux/fs.h:1494:#define __sb_writers_release(sb, lev)   \
> include/linux/fs.h-1495-        percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
> 
> fs/btrfs/transaction.c:1821:            __sb_writers_release(fs_info->sb, SB_FREEZE_FS);
> fs/aio.c:1566:                  __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> fs/xfs/xfs_aops.c:211:  __sb_writers_release(ioend->io_inode->i_sb, SB_FREEZE_FS);
> 
> 
> 
> I'd like to check what atomic_long_read(&sem->rw_sem.count) says
> when hung task is reported.
> 

syzbot reproduced this problem with the patch applied.

percpu_rw_semaphore(00000000082ac9da)
  ->rw_sem.count=0xfffffffe00000001
  ->rss.gp_state=2
  ->rss.gp_count=1
  ->rss.cb_state=0
  ->rss.gp_type=1
  ->readers_block=1
  ->read_count=0
  ->list_empty(rw_sem.wait_list)=0
  ->writer.task=          (null)

The output says that percpu_down_read() was blocked because
somebody has called percpu_down_write().

  DEFINE_STATIC_PERCPU_RWSEM(sem);
  percpu_down_write(&sem);
  percpu_down_read(&sem);
  percpu_up_read(&sem);
  percpu_up_write(&sem);

The next step is to find who is calling percpu_down_write(). How do we want to do this?
We don't want to annoy normal linux-next.git testers. Below one?

---
 include/linux/percpu-rwsem.h | 4 ++++
 lib/Kconfig.debug            | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 79b99d6..26e87c3 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -130,7 +130,9 @@ extern int __percpu_init_rwsem(struct percpu_rw_semaphore *,
 static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
+#ifndef CONFIG_DEBUG_AID_FOR_SYZBOT
 	lock_release(&sem->rw_sem.dep_map, 1, ip);
+#endif
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
 		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
@@ -140,7 +142,9 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
+#ifndef CONFIG_DEBUG_AID_FOR_SYZBOT
 	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
+#endif
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
 		sem->rw_sem.owner = current;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c731ff9..f0d02e8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1181,6 +1181,12 @@ config DEBUG_LOCK_ALLOC
 	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
 	 held during task exit.
 
+config DEBUG_AID_FOR_SYZBOT
+       bool "Additional debug options for syzbot"
+       default n
+       help
+	 This option is intended for testing by syzbot.
+
 config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
-- 

Hmm, given that neither xfs nor btrfs is used, is it aio code?
