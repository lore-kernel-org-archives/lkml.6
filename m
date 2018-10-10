Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF38C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E912087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E912087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJJVly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:41:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:16238 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeJJVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:41:54 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9AEJTjF055365;
        Wed, 10 Oct 2018 23:19:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Wed, 10 Oct 2018 23:19:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9AEJNiC055313
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Oct 2018 23:19:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in shmem_fault
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        hannes@cmpxchg.org, akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, yang.s@alibaba-inc.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz>
 <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <127c73bd-2c7b-6ef0-3c6d-5e01d43bdf5b@i-love.sakura.ne.jp>
Date:   Wed, 10 Oct 2018 23:19:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010113500.GH5873@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/10 20:35, Michal Hocko wrote:
>>>> What should we do if memcg-OOM found no killable task because the allocating task
>>>> was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires 
>>>> (which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
>>>> OOM header when no eligible victim left") because syzbot was terminating the test
>>>> upon WARN(1) removed by that commit) is not a good behavior.
>>>
>>> We definitely want to inform about ineligible oom victim. We might
>>> consider some rate limiting for the memcg state but that is a valuable
>>> information to see under normal situation (when you do not have floods
>>> of these situations).
>>>
>>
>> But if the caller cannot be noticed by SIGKILL from the OOM killer,
>> allowing the caller to trigger the OOM killer again and again (until
>> global OOM killer triggers) is bad.
> 
> There is simply no other option. Well, except for failing the charge
> which has been considered and refused because it could trigger
> unexpected error paths and that breaking the isolation on rare cases
> when of the misconfiguration is acceptable. We can reconsider that
> but you should bring really good arguments on the table. I was very
> successful doing that.
> 

By the way, how do we avoid this flooding? Something like this?

 include/linux/sched.h |  1 +
 mm/oom_kill.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57..58eff50 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -723,6 +723,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			in_user_fault:1;
+	unsigned			memcg_oom_no_eligible_warned:1;
 #ifdef CONFIG_MEMCG_KMEM
 	unsigned			memcg_kmem_skip_account:1;
 #endif
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..ff0fa65 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1106,6 +1106,13 @@ bool out_of_memory(struct oom_control *oc)
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
+#ifdef CONFIG_MEMCG
+		if (is_memcg_oom(oc)) {
+			if (current->memcg_oom_no_eligible_warned)
+				return false;
+			current->memcg_oom_no_eligible_warned = 1;
+		}
+#endif
 		dump_header(oc, NULL);
 		pr_warn("Out of memory and no killable processes...\n");
 		/*
@@ -1115,6 +1122,10 @@ bool out_of_memory(struct oom_control *oc)
 		 */
 		if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
 			panic("System is deadlocked on memory\n");
+#ifdef CONFIG_MEMCG
+	} else if (is_memcg_oom(oc)) {
+		current->memcg_oom_no_eligible_warned = 0;
+#endif
 	}
 	if (oc->chosen && oc->chosen != (void *)-1UL)
 		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
-- 
1.8.3.1
