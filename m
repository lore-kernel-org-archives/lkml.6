Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13995ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A244E21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A244E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeJSSl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:41:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53568 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:41:28 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9JAZvw1015713;
        Fri, 19 Oct 2018 19:35:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Fri, 19 Oct 2018 19:35:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9JAZqtu015590
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 19 Oct 2018 19:35:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
References: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
 <20181018042739.GA650@jagdpanzerIV>
 <201810180526.w9I5QvVn032670@www262.sakura.ne.jp>
 <20181018061018.GB650@jagdpanzerIV> <20181018075611.GY18839@dhcp22.suse.cz>
 <20181018081352.GA438@jagdpanzerIV>
 <2c2b2820-e6f8-76c8-c431-18f60845b3ab@i-love.sakura.ne.jp>
 <20181018235427.GA877@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5d472476-7852-f97b-9412-63536dffaa0e@i-love.sakura.ne.jp>
Date:   Fri, 19 Oct 2018 19:35:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018235427.GA877@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/19 8:54, Sergey Senozhatsky wrote:
> On (10/18/18 20:58), Tetsuo Handa wrote:
>>>
>>> A knob might do.
>>> As well as /proc/sys/kernel/printk tweaks, probably. One can even add
>>> echo "a b c d" > /proc/sys/kernel/printk to .bashrc and adjust printk
>>> console levels on login and rollback to old values in .bash_logout
>>> May be.
>>
>> That can work for only single login with root user case.
>> Not everyone logs into console as root user.
> 
> Add sudo ;)

That will not work. ;-) As long as the console loglevel setting is
system wide, we can't allow multiple login sessions.

> 
>> It is pity that we can't send kernel messages to only selected consoles
>> (e.g. all messages are sent to netconsole, but only critical messages are
>> sent to local consoles).
> 
> OK, that's a fair point. There was a patch from FB, which would allow us
> to set a log_level on per-console basis. So the noise goes to heav^W net
> console; only critical stuff goes to the serial console (if I recall it
> correctly). I'm not sure what happened to that patch, it was a while ago.
> I'll try to find that out.

Per a console loglevel setting would help for several environments.
But syzbot environment cannot count on netconsole. We can't expect that
unlimited printk() will become safe.

> 
> [..]
>> That boils down to a "user interaction" problem.
>> Not limiting
>>
>>   "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
>>   "Out of memory and no killable processes...\n"
>>
>> is very annoying.
>>
>> And I really can't understand why Michal thinks "handling this requirement" as
>> "make the code more complex than necessary and squash different things together".
> 
> Michal is trying very hard to address the problem in a reasonable way.

OK. But Michal, do we have a reasonable way which can be applied now instead of
my patch or one of below patches? Just enumerating words like "hackish" or "a mess"
without YOU ACTUALLY PROPOSE PATCHES will bounce back to YOU.

> The problem you are talking about is not MM specific. You can have a
> faulty SCSI device, corrupted FS, and so and on.

"a faulty SCSI device, corrupted FS, and so and on" are reporting problems
which will complete a request. They can use (and are using) ratelimit,
aren't they?

"a memcg OOM with no eligible task" is reporting a problem which cannot
complete a request. But it can use ratelimit as well.

But we have an immediately applicable mitigation for a problem that
already OOM-killed threads are triggering "a memcg OOM with no eligible
task" using one of below patches.



From 0a533d15949eac25f5ce7ce6e53f5830608f08e7 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 19 Oct 2018 15:52:56 +0900
Subject: [PATCH v2] mm, oom: OOM victims do not need to select next OOM victim unless __GFP_NOFAIL.

Since commit 696453e66630ad45 ("mm, oom: task_will_free_mem should skip
oom_reaped tasks") changed to select next OOM victim as soon as
MMF_OOM_SKIP is set, a memcg OOM event from a user process can generate
220+ times (12400+ lines / 730+ KB) of OOM-killer messages with
"Out of memory and no killable processes..." (i.e. no progress) due to
a race window.

This patch completely eliminates such race window by making
out_of_memory() from OOM victims no-op, for OOM victims do not
forever retry (unless __GFP_NOFAIL).

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 mm/oom_kill.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..0e8d20b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1058,6 +1058,9 @@ bool out_of_memory(struct oom_control *oc)
 	if (oom_killer_disabled)
 		return false;
 
+	if (tsk_is_oom_victim(current) && !(oc->gfp_mask & __GFP_NOFAIL))
+		return true;
+
 	if (!is_memcg_oom(oc)) {
 		blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
 		if (freed > 0)
-- 
1.8.3.1



From 4a0e9c9514e1c9c5f90f6247a2c142f622558129 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 19 Oct 2018 16:31:48 +0900
Subject: [PATCH] mm, oom: task_will_free_mem() should ignore MMF_OOM_SKIP.

Since commit 696453e66630ad45 ("mm, oom: task_will_free_mem should skip
oom_reaped tasks") changed to select next OOM victim as soon as
MMF_OOM_SKIP is set, a memcg OOM event from a user process can generate
220+ times (12400+ lines / 730+ KB) of OOM-killer messages with
"Out of memory and no killable processes..." (i.e. no progress) due to
a race window.

But since we added fatal_signal_pending() check to iterations which
can result in a behavior observed in the commit above
(e.g. commit 5abf186a30a89d5b "mm, fs: check for fatal signals in
do_generic_file_read()"), we won't observe such behavior any more.

This patch completely eliminates such race window by removing the
MMF_OOM_SKIP test from task_will_free_mem(), at the risk of falling
into infinite loop when we have to select next OOM victim due to
doing __GFP_NOFAIL allocation requests.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 mm/oom_kill.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..981237c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -800,13 +800,6 @@ static bool task_will_free_mem(struct task_struct *task)
 	if (!__task_will_free_mem(task))
 		return false;
 
-	/*
-	 * This task has already been drained by the oom reaper so there are
-	 * only small chances it will free some more
-	 */
-	if (test_bit(MMF_OOM_SKIP, &mm->flags))
-		return false;
-
 	if (atomic_read(&mm->mm_users) <= 1)
 		return true;
 
-- 
1.8.3.1

