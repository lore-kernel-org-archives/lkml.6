Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2E53BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEEC208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEEC208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754955AbeFNKfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:35:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:40343 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754772AbeFNKfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:35:14 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5EAY18u013522;
        Thu, 14 Jun 2018 19:34:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 14 Jun 2018 19:34:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5EAXp6x013483
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 14 Jun 2018 19:34:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __sb_start_write
To:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b1b876d9-94e8-fdee-ae12-e05a7467ce5b@i-love.sakura.ne.jp>
Date:   Thu, 14 Jun 2018 19:33:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Zyf2e_K0oRJ5oRj3WYWpf-t=V=RKHYcdqujF3s9PJL_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/11 16:39, Dmitry Vyukov wrote:
> On Mon, Jun 11, 2018 at 9:30 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Sun, Jun 10, 2018 at 11:47:56PM +0900, Tetsuo Handa wrote:
>>
>>> This looks quite strange that nobody is holding percpu_rw_semaphore for
>>> write but everybody is stuck trying to hold it for read. (Since there
>>> is no "X locks held by ..." line without followup "#0:" line, there is
>>> no possibility that somebody is in TASK_RUNNING state while holding
>>> percpu_rw_semaphore for write.)
>>>
>>> I feel that either API has a bug or API usage is wrong.
>>> Any idea for debugging this?
>>
>> Look at percpu_rwsem_release() and usage. The whole fs freezer thing is
>> magic.
> 
> Do you mean that we froze fs? We tried to never-ever issue
> ioctl(FIFREEZE) during fuzzing. Are there other ways to do this?
> 

Dmitry, can you try this patch? If you can get

[   48.080875] ================================================
[   48.083648] WARNING: lock held when returning to user space!
[   48.086384] 4.17.0+ #588 Tainted: G                T
[   48.088890] ------------------------------------------------
[   48.091447] a.out/1243 is leaving the kernel with locks still held!
[   48.093487] 3 locks held by a.out/1243:
[   48.094964]  #0: 00000000148ae74c (sb_writers#8){++++}, at: percpu_down_write+0x1d/0x110
[   48.097622]  #1: 000000001c9e7d4d (sb_pagefaults){++++}, at: percpu_down_write+0x1d/0x110
[   48.100432]  #2: 000000003c3d2e71 (sb_internal){++++}, at: percpu_down_write+0x1d/0x110

with this patch, there is a way to return to userspace with locks held.
If you got possible deadlock warning messages, it will be great.

If you cannot reproduce with this patch, I think we need a git tree to try
this patch. But linux-next.git is not yet re-added to the list of trees to
test and linux.git is not suitable for temporary debug patch...



From 5ba3a5bc6401a937d30a9e3421ac2a29ee99588f Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 14 Jun 2018 16:14:55 +0900
Subject: [PATCH] locking/lockdep: Add config option to allow lockdep splat
 upon ioctl(FIFREEZE) request

syzbot is hitting hung task problems at __sb_start_write() [1]. While hung
tasks at __sb_start_write() suggest that filesystem was frozen, syzbot is
not doing ioctl(FIFREEZE) requests. Therefore, the root cause of hung tasks
is currently unknown. If there are other paths to freeze filesystem and
return to userspace without thawing, syzbot needs to avoid testing such
paths. Therefore, this patch adds a kernel config option which allows
lockdep to splat if syzbot found such paths.

[1] https://syzkaller.appspot.com/bug?id=287aa8708bc940d0ca1645223c53dd4c2d203be6

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 fs/super.c        |  4 ++++
 lib/Kconfig.debug | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 50728d9..eb51268 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1428,10 +1428,12 @@ static void sb_wait_write(struct super_block *sb, int level)
  */
 static void lockdep_sb_freeze_release(struct super_block *sb)
 {
+#ifndef CONFIG_LOCKDEP_REPORT_FSFREEZE_FROM_USERSPACE
 	int level;
 
 	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
 		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
+#endif
 }
 
 /*
@@ -1439,10 +1441,12 @@ static void lockdep_sb_freeze_release(struct super_block *sb)
  */
 static void lockdep_sb_freeze_acquire(struct super_block *sb)
 {
+#ifndef CONFIG_LOCKDEP_REPORT_FSFREEZE_FROM_USERSPACE
 	int level;
 
 	for (level = 0; level < SB_FREEZE_LEVELS; ++level)
 		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
+#endif
 }
 
 static void sb_freeze_unlock(struct super_block *sb)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d543c65..e119d19 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1170,6 +1170,19 @@ config DEBUG_LOCK_ALLOC
 	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
 	 held during task exit.
 
+config LOCKDEP_REPORT_FSFREEZE_FROM_USERSPACE
+       bool "Allow lockdep splat upon ioctl(FIFREEZE) request"
+       depends on PROVE_LOCKING
+       default n
+       help
+	 Freezing filesystems and not thawing shortly will kill the system with
+	 hung tasks. Since ioctl(FIFREEZE) request returns to userspace with
+	 locks held, in order to suppress lockdep splat messages, information
+	 of held locks is cleared without actually releasing locks held. But
+	 doing so might hide possible deadlock bugs. Thus, this option allows
+	 lockdep splat if ioctl(FIFREEZE) is requested, in order to help
+	 finding possible deadlock bugs.
+
 config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
-- 
1.8.3.1
