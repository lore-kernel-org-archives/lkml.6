Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD15C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFBB20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFBB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbeGSIlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:41:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36660 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbeGSIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:41:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so6387534eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 00:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b9VjlscrCR2ATnojEVIGSnc6yw6RpSXWB2tnT6FGkLE=;
        b=HWlxXkhR2IonHAP6omgoDWuFUO8e3BvSzGB9+VT0NKmt0czrPbFB/gmwtXijoDLRA6
         Z4mQXBWwhO2mMFqlSXLtqUTIUAhdD0jbI2Pe5yOcK2FG/HbLPT3/xhlwc0OfjjEhmmNd
         kfYUYK0ZjiG9ZCG1PuvSU93zEvbxkpmwerc4J+HAunShUq9WPcO9B2wLFSMr1xOoVH0/
         Yb9YVClanV3YvGxBfOzeOGhyg/ewx7I/eT5GFoQ5nJykAuavKimqWPK2XXtleewP4mjJ
         V+lF+5qNIxCu7x0RXO0SXUkgYSZSAMOrBNOH+K+rsvEHx0Ydz8jVb+2KcROShcsrD2pb
         qcqg==
X-Gm-Message-State: AOUpUlGEXdVbjzEdPDaDfLuSDnIQiiay7Bn2EEAoCFr6/fr5f9sY2UsO
        sho4+X9kRlol0cUwAMDy1ng=
X-Google-Smtp-Source: AAOMgpetvMPAU8s+WNe4IR0EpIPw/820b0AoI//H+zzGoMjlL+NrgtShYVL0YvjBXC2Nxd9eZeXCuw==
X-Received: by 2002:a50:c211:: with SMTP id n17-v6mr10357985edf.11.1531987168100;
        Thu, 19 Jul 2018 00:59:28 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d7-v6sm2191798edi.79.2018.07.19.00.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 00:59:26 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, oom: remove oom_lock from oom_reaper
Date:   Thu, 19 Jul 2018 09:59:22 +0200
Message-Id: <20180719075922.13784-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

oom_reaper used to rely on the oom_lock since e2fe14564d33 ("oom_reaper:
close race with exiting task"). We do not really need the lock anymore
though. 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run
concurrently") has removed serialization with the exit path based on the
mm reference count and so we do not really rely on the oom_lock anymore.

Tetsuo was arguing that at least MMF_OOM_SKIP should be set under the
lock to prevent from races when the page allocator didn't manage to get
the freed (reaped) memory in __alloc_pages_may_oom but it sees the flag
later on and move on to another victim. Although this is possible in
principle let's wait for it to actually happen in real life before we
make the locking more complex again.

Therefore remove the oom_lock for oom_reaper paths (both exit_mmap and
oom_reap_task_mm). The reaper serializes with exit_mmap by mmap_sem +
MMF_OOM_SKIP flag. There is no synchronization with out_of_memory path
now.

Suggested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/mmap.c     |  2 --
 mm/oom_kill.c | 29 ++++-------------------------
 2 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fc41c0543d7f..4642964f7741 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3073,9 +3073,7 @@ void exit_mmap(struct mm_struct *mm)
 		 * which clears VM_LOCKED, otherwise the oom reaper cannot
 		 * reliably test it.
 		 */
-		mutex_lock(&oom_lock);
 		__oom_reap_task_mm(mm);
-		mutex_unlock(&oom_lock);
 
 		set_bit(MMF_OOM_SKIP, &mm->flags);
 		down_write(&mm->mmap_sem);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 32e6f7becb40..c74bf0bd8010 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -529,28 +529,9 @@ void __oom_reap_task_mm(struct mm_struct *mm)
 
 static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 {
-	bool ret = true;
-
-	/*
-	 * We have to make sure to not race with the victim exit path
-	 * and cause premature new oom victim selection:
-	 * oom_reap_task_mm		exit_mm
-	 *   mmget_not_zero
-	 *				  mmput
-	 *				    atomic_dec_and_test
-	 *				  exit_oom_victim
-	 *				[...]
-	 *				out_of_memory
-	 *				  select_bad_process
-	 *				    # no TIF_MEMDIE task selects new victim
-	 *  unmap_page_range # frees some memory
-	 */
-	mutex_lock(&oom_lock);
-
 	if (!down_read_trylock(&mm->mmap_sem)) {
-		ret = false;
 		trace_skip_task_reaping(tsk->pid);
-		goto unlock_oom;
+		return false;
 	}
 
 	/*
@@ -562,7 +543,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	if (mm_has_blockable_invalidate_notifiers(mm)) {
 		up_read(&mm->mmap_sem);
 		schedule_timeout_idle(HZ);
-		goto unlock_oom;
+		return true;
 	}
 
 	/*
@@ -574,7 +555,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
 		up_read(&mm->mmap_sem);
 		trace_skip_task_reaping(tsk->pid);
-		goto unlock_oom;
+		return true;
 	}
 
 	trace_start_task_reaping(tsk->pid);
@@ -589,9 +570,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	up_read(&mm->mmap_sem);
 
 	trace_finish_task_reaping(tsk->pid);
-unlock_oom:
-	mutex_unlock(&oom_lock);
-	return ret;
+	return true;
 }
 
 #define MAX_OOM_REAP_RETRIES 10
-- 
2.18.0

