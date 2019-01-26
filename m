Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C36C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB79021855
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAZB5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:57:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52693 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAZB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:57:04 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0Q1v3dZ074969;
        Sat, 26 Jan 2019 10:57:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Sat, 26 Jan 2019 10:57:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0Q1v3aU074964
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 26 Jan 2019 10:57:03 +0900 (JST)
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <06b4806c-6b53-85a5-84db-fa432ea4ccd0@i-love.sakura.ne.jp>
Date:   Sat, 26 Jan 2019 10:57:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124134646.GA53008@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/24 22:46, Joel Fernandes wrote:
> On Thu, Jan 24, 2019 at 10:52:30AM +0900, Tetsuo Handa wrote:
>> Then, I'm tempted to eliminate shrinker and LRU list (like a draft patch shown
>> below). I think this is not equivalent to current code because this shrinks
>> upon only range_alloc() time and I don't know whether it is OK to temporarily
>> release ashmem_mutex during range_alloc() at "Case #4" of ashmem_pin(), but
>> can't we go this direction? 
> 
> No, the point of the shrinker is to do a lazy free. We cannot free things
> during unpin since it can be pinned again and we need to find that range by
> going through the list. We also cannot get rid of any lists. Since if
> something is re-pinned, we need to find it and find out if it was purged. We
> also need the list for knowing what was unpinned so the shrinker works.
> 
> By the way, all this may be going away quite soon (the whole driver) as I
> said, so just give it a little bit of time.
> 
> I am happy to fix it soon if that's not the case (which I should know soon -
> like a couple of weeks) but I'd like to hold off till then.
> 
>> By the way, why not to check range_alloc() failure before calling range_shrink() ?
> 
> That would be a nice thing to do. Send a patch?

OK. Here is a patch. I chose __GFP_NOFAIL rather than adding error handling,
for small GFP_KERNEL allocation won't fail unless current thread was killed by
the OOM killer or memory allocation fault injection forces it fail, and
range_alloc() will not be called for multiple times from one syscall.

But note that doing GFP_KERNEL allocation with ashmem_mutex held has a risk of
needlessly invoking the OOM killer because "the point of the shrinker is to do
a lazy free" counts on ashmem_mutex not held by GFP_KERNEL allocating thread.
Although other shrinkers likely make forward progress by releasing memory,
technically you should avoid doing GFP_KERNEL allocation with ashmem_mutex held
if shrinker depends on ashmem_mutex not held.



From e1c4a9b53b0bb11a0743a8f861915c043deb616d Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 26 Jan 2019 10:52:39 +0900
Subject: [PATCH] staging: android: ashmem: Don't allow range_alloc() to fail.

ashmem_pin() is calling range_shrink() without checking whether
range_alloc() succeeded. Since memory allocation fault injection might
force range_alloc() to fail while range_alloc() is called for only once
for one ioctl() request, make range_alloc() not to fail.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/staging/android/ashmem.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index d40c1d2..a8070a2 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -171,18 +171,14 @@ static inline void lru_del(struct ashmem_range *range)
  * @end:	   The ending page (inclusive)
  *
  * This function is protected by ashmem_mutex.
- *
- * Return: 0 if successful, or -ENOMEM if there is an error
  */
-static int range_alloc(struct ashmem_area *asma,
-		       struct ashmem_range *prev_range, unsigned int purged,
-		       size_t start, size_t end)
+static void range_alloc(struct ashmem_area *asma,
+			struct ashmem_range *prev_range, unsigned int purged,
+			size_t start, size_t end)
 {
 	struct ashmem_range *range;
 
-	range = kmem_cache_zalloc(ashmem_range_cachep, GFP_KERNEL);
-	if (!range)
-		return -ENOMEM;
+	range = kmem_cache_zalloc(ashmem_range_cachep, GFP_KERNEL | __GFP_NOFAIL);
 
 	range->asma = asma;
 	range->pgstart = start;
@@ -193,8 +189,6 @@ static int range_alloc(struct ashmem_area *asma,
 
 	if (range_on_lru(range))
 		lru_add(range);
-
-	return 0;
 }
 
 /**
@@ -687,7 +681,8 @@ static int ashmem_unpin(struct ashmem_area *asma, size_t pgstart, size_t pgend)
 		}
 	}
 
-	return range_alloc(asma, range, purged, pgstart, pgend);
+	range_alloc(asma, range, purged, pgstart, pgend);
+	return 0;
 }
 
 /*
-- 
1.8.3.1

