Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1DBC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE62A206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE62A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeIFK4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:56:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:37763 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeIFK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:56:32 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w866McQj056474;
        Thu, 6 Sep 2018 15:22:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Thu, 06 Sep 2018 15:22:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w866McqY056470;
        Thu, 6 Sep 2018 15:22:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w866MchB056469;
        Thu, 6 Sep 2018 15:22:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201809060622.w866MchB056469@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] =?ISO-2022-JP?B?bW0scGFnZV9hbGxvYzogUEZfV1FfV09SS0VSIHRocmVh?=
 =?ISO-2022-JP?B?ZHMgbXVzdCBzbGVlcCBhdCBzaG91bGRfcmVjbGFpbV9yZXRyeSgpLg==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Date:   Thu, 06 Sep 2018 15:22:38 +0900
References: <201809060100.w86100i6060716@www262.sakura.ne.jp> <20180906055742.GL14951@dhcp22.suse.cz>
In-Reply-To: <20180906055742.GL14951@dhcp22.suse.cz>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko wrote:
> > I assert that we should fix af5679fbc669f31f.
> 
> If you can come up with reasonable patch which doesn't complicate the
> code and it is a clear win for both this particular workload as well as
> others then why not.

Why can't we do "at least MMF_OOM_SKIP should be set under the lock to
prevent from races" ?

diff --git a/mm/mmap.c b/mm/mmap.c
index 5f2b2b1..e096bb8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3065,7 +3065,9 @@ void exit_mmap(struct mm_struct *mm)
 		 */
 		(void)__oom_reap_task_mm(mm);
 
+		mutex_lock(&oom_lock);
 		set_bit(MMF_OOM_SKIP, &mm->flags);
+		mutex_unlock(&oom_lock);
 		down_write(&mm->mmap_sem);
 		up_write(&mm->mmap_sem);
 	}
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..b2a94c1 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -606,7 +606,9 @@ static void oom_reap_task(struct task_struct *tsk)
 	 * Hide this mm from OOM killer because it has been either reaped or
 	 * somebody can't call up_write(mmap_sem).
 	 */
+	mutex_lock(&oom_lock);
 	set_bit(MMF_OOM_SKIP, &mm->flags);
+	mutex_unlock(&oom_lock);		
 
 	/* Drop a reference taken by wake_oom_reaper */
 	put_task_struct(tsk);
