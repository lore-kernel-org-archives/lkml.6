Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47441C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03D220843
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03D220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeGJGMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:12:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:35511 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeGJGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:10:53 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6A6AplF020911;
        Tue, 10 Jul 2018 15:10:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Tue, 10 Jul 2018 15:10:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6A6ApWL020907;
        Tue, 10 Jul 2018 15:10:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w6A6Apv4020906;
        Tue, 10 Jul 2018 15:10:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] locking/lockdep: Dump state of =?ISO-2022-JP?B?cGVyY3B1X3J3?=
 =?ISO-2022-JP?B?c2VtIHVwb24gaHVuZyB1cC4=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
MIME-Version: 1.0
Date:   Tue, 10 Jul 2018 15:10:51 +0900
References: <1530945060-7507-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <201807071750.mmO8ZiJo%fengguang.wu@intel.com>
In-Reply-To: <201807071750.mmO8ZiJo%fengguang.wu@intel.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 2642b4a1904259384f2018ea8df03ac49509c57a Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
Date: Tue, 10 Jul 2018 15:01:20 +0900
Subject: [PATCH] locking/rwsem: Convert the other sem->count to 'atomic_long_t'

Since "locking/rwsem: Convert sem->count to 'atomic_long_t'" forgot to
convert "struct rw_semaphore"->count in linux/rwsem-spinlock.h which is
used when CONFIG_RWSEM_GENERIC_SPINLOCK=y, trying to access it in MIPS
architecture causes build error due to type mismatch.

  error: passing argument 1 of 'atomic_long_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
  note: expected 'const atomic_long_t * {aka const struct <anonymous> *}' but argument is of type '__s32 * {aka int *}'

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 8ee62b1870be8e63 ("locking/rwsem: Convert sem->count to 'atomic_long_t'")
Cc: stable <stable@vger.kernel.org> # v4.8+
Cc: Jason Low <jason.low2@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/rwsem-spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rwsem-spinlock.h b/include/linux/rwsem-spinlock.h
index e475683..1164965 100644
--- a/include/linux/rwsem-spinlock.h
+++ b/include/linux/rwsem-spinlock.h
@@ -22,7 +22,7 @@
  * - if wait_list is not empty, then there are processes waiting for the semaphore
  */
 struct rw_semaphore {
-	__s32			count;
+	atomic_long_t		count;
 	raw_spinlock_t		wait_lock;
 	struct list_head	wait_list;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.7.4
