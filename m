Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D0C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5722177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfA2KoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:44:09 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:37089 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfA2KoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:44:09 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0TAi6Pr059092;
        Tue, 29 Jan 2019 19:44:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Tue, 29 Jan 2019 19:44:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0TAi59p059088
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 29 Jan 2019 19:44:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in __do_page_fault
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Todd Kjos <tkjos@google.com>,
        syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com,
        ak@linux.intel.com, Johannes Weiner <hannes@cmpxchg.org>,
        jack@suse.cz, jrdr.linux@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <201901230201.x0N214eq043832@www262.sakura.ne.jp>
 <20190123155751.GA168927@google.com>
 <201901240152.x0O1qUUU069046@www262.sakura.ne.jp>
 <20190124134646.GA53008@google.com>
 <d736c8f5-eba1-2da8-000f-4b2a80ad74ff@i-love.sakura.ne.jp>
 <20190128164502.GA260885@google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <17f26aab-4a25-dba9-7d39-40df80d1eadb@i-love.sakura.ne.jp>
Date:   Tue, 29 Jan 2019 19:44:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128164502.GA260885@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/29 1:45, Joel Fernandes wrote:
>>  		freed += range_size(range);
>> +		mutex_unlock(&ashmem_mutex);
>> +		f->f_op->fallocate(f,
>> +				   FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>> +				   start, end - start);
>> +		fput(f);
>> +		if (atomic_dec_and_test(&ashmem_shrink_inflight))
>> +			wake_up_all(&ashmem_shrink_wait);
>> +		mutex_lock(&ashmem_mutex);
> 
> Let us replace mutex_lock with mutex_trylock, as done before the loop? Here
> is there is an opportunity to not block other ashmem operations. Otherwise
> LGTM. Also, CC stable.

If shrinker succeeded to grab ashmem_mutex using mutex_trylock(), it is
guaranteed that that thread is not inside

  mutex_lock(&ashmem_mutex);
  kmalloc(GFP_KERNEL);
  mutex_unlock(&ashmem_mutex);

block. Therefore, I think that it is safe to use mutex_lock() here.

Nonetheless, although syzbot did not find other dependency, I can update this
patch to use mutex_trylock() if you worry about not-yet-discovered dependency.



From fd850fecd248951ad1ad26b37ec5bf84afe41cbb Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 29 Jan 2019 10:56:47 +0900
Subject: [PATCH v2] staging: android: ashmem: Don't call fallocate() with ashmem_mutex held.

syzbot is hitting lockdep warnings [1][2][3]. This patch tries to fix
the warning by eliminating ashmem_shrink_scan() => {shmem|vfs}_fallocate()
sequence.

[1] https://syzkaller.appspot.com/bug?id=87c399f6fa6955006080b24142e2ce7680295ad4
[2] https://syzkaller.appspot.com/bug?id=7ebea492de7521048355fc84210220e1038a7908
[3] https://syzkaller.appspot.com/bug?id=e02419c12131c24e2a957ea050c2ab6dcbbc3270

Reported-by: syzbot <syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: stable@vger.kernel.org
---
 drivers/staging/android/ashmem.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 90a8a9f1ac7d..ade8438a827a 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -75,6 +75,9 @@ struct ashmem_range {
 /* LRU list of unpinned pages, protected by ashmem_mutex */
 static LIST_HEAD(ashmem_lru_list);
 
+static atomic_t ashmem_shrink_inflight = ATOMIC_INIT(0);
+static DECLARE_WAIT_QUEUE_HEAD(ashmem_shrink_wait);
+
 /*
  * long lru_count - The count of pages on our LRU list.
  *
@@ -438,7 +441,6 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 static unsigned long
 ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct ashmem_range *range, *next;
 	unsigned long freed = 0;
 
 	/* We might recurse into filesystem code, so bail out if necessary */
@@ -448,21 +450,33 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	if (!mutex_trylock(&ashmem_mutex))
 		return -1;
 
-	list_for_each_entry_safe(range, next, &ashmem_lru_list, lru) {
+	while (!list_empty(&ashmem_lru_list)) {
+		struct ashmem_range *range =
+			list_first_entry(&ashmem_lru_list, typeof(*range), lru);
 		loff_t start = range->pgstart * PAGE_SIZE;
 		loff_t end = (range->pgend + 1) * PAGE_SIZE;
+		struct file *f = range->asma->file;
 
-		range->asma->file->f_op->fallocate(range->asma->file,
-				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				start, end - start);
+		get_file(f);
+		atomic_inc(&ashmem_shrink_inflight);
 		range->purged = ASHMEM_WAS_PURGED;
 		lru_del(range);
 
 		freed += range_size(range);
+		mutex_unlock(&ashmem_mutex);
+		f->f_op->fallocate(f,
+				   FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				   start, end - start);
+		fput(f);
+		if (atomic_dec_and_test(&ashmem_shrink_inflight))
+			wake_up_all(&ashmem_shrink_wait);
+		if (!mutex_trylock(&ashmem_mutex))
+			goto out;
 		if (--sc->nr_to_scan <= 0)
 			break;
 	}
 	mutex_unlock(&ashmem_mutex);
+out:
 	return freed;
 }
 
@@ -713,6 +727,7 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
 		return -EFAULT;
 
 	mutex_lock(&ashmem_mutex);
+	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
 
 	if (!asma->file)
 		goto out_unlock;
-- 
2.17.1


