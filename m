Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F63C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCA72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZnZyWQMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCA72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeLJKhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:37:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46553 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeLJKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:36:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so8995733edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEsctnSJl6ojJTv9Gu+kKqy9VNezjsl3TRV+ARV/mkc=;
        b=ZnZyWQMH6WIayzR/QKbBPP6+0b9sXHlAARJt64WBv2Unoue68evGiPArqIPwCa/XLM
         7p0ILYs2uj3fACNC8YILBa+TPUR2csiYsBl0GkHkJapOJlF8MCR3+Y+/Zh8S4grK4BOt
         384VE9HqGSj3KwckvLatg1ved/XePWOFAfv40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEsctnSJl6ojJTv9Gu+kKqy9VNezjsl3TRV+ARV/mkc=;
        b=mtpU4U44goXDj6m65H5dVSd6yor+XrKcrS0kxrXweA8OqHEYSEUr94dNMHoScmuJMJ
         0Av9OeiWN1YNW90S1lXDw5+pd32v5oSwWYVVQOZtijjJ1ggYnDgMMe1f+LBq3jCTjHO/
         jfXS4++pjxCDkIPxdShaOG3tatqRBjtE/NlXJSNT72YZSCU3jwq+9GXJydhQ+UhIDMBv
         2ktZ/d/Zp5Okm8LGrrIjUX1MoJijaH2Ar/UG1Givzw9AbJLmdZdxwnjsKgdFPJu22AEA
         T+DfZOePXbBZZUh7Gh9ztjwUHsdLD0RhreBHsZQ3O1O4ZESBefuSQNe/LYBIOk8hHFfi
         OoMQ==
X-Gm-Message-State: AA+aEWZEMqTiCpO49KNZwF76fwmhrE3hhusQJtg3bG2o1vdKfJxvAwpV
        9VHVY7IpzyASQ2xiLwvSpsWxUA==
X-Google-Smtp-Source: AFSGD/Uk9Y35fLYH2MG6TLt5GU2n4GMlNtntTdbUScLCDF73rMg9GXcbK7pjTLciIvgEi+Dvmd7bgA==
X-Received: by 2002:a17:906:55a:: with SMTP id k26-v6mr9502822eja.218.1544438210804;
        Mon, 10 Dec 2018 02:36:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q50sm3223862edd.66.2018.12.10.02.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 02:36:50 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 2/4] kernel.h: Add non_block_start/end()
Date:   Mon, 10 Dec 2018 11:36:39 +0100
Message-Id: <20181210103641.31259-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some special cases we must not block, but there's not a
spinlock, preempt-off, irqs-off or similar critical section already
that arms the might_sleep() debug checks. Add a non_block_start/end()
pair to annotate these.

This will be used in the oom paths of mmu-notifiers, where blocking is
not allowed to make sure there's forward progress.

Suggested by Michal Hocko.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/kernel.h | 10 +++++++++-
 include/linux/sched.h  |  4 ++++
 kernel/sched/core.c    |  6 +++---
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..c2cf31515b3d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -251,7 +251,9 @@ extern int _cond_resched(void);
  * might_sleep - annotation for functions that can sleep
  *
  * this macro will print a stack trace if it is executed in an atomic
- * context (spinlock, irq-handler, ...).
+ * context (spinlock, irq-handler, ...). Additional sections where blocking is
+ * not allowed can be annotated with non_block_start() and non_block_end()
+ * pairs.
  *
  * This is a useful debugging help to be able to catch problems early and not
  * be bitten later when the calling function happens to sleep when it is not
@@ -260,6 +262,10 @@ extern int _cond_resched(void);
 # define might_sleep() \
 	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
 # define sched_annotate_sleep()	(current->task_state_change = 0)
+# define non_block_start() \
+	do { current->non_block_count++; } while (0)
+# define non_block_end() \
+	do { WARN_ON(current->non_block_count-- == 0); } while (0)
 #else
   static inline void ___might_sleep(const char *file, int line,
 				   int preempt_offset) { }
@@ -267,6 +273,8 @@ extern int _cond_resched(void);
 				   int preempt_offset) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define sched_annotate_sleep() do { } while (0)
+# define non_block_start() do { } while (0)
+# define non_block_end() do { } while (0)
 #endif
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ecffd4e37453..41249dbf8f27 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -916,6 +916,10 @@ struct task_struct {
 	struct mutex_waiter		*blocked_on;
 #endif
 
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+	int				non_block_count;
+#endif
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned int			irq_events;
 	unsigned long			hardirq_enable_ip;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6fedf3a98581..969d7a71f30c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6113,7 +6113,7 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 	rcu_sleep_check();
 
 	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
-	     !is_idle_task(current)) ||
+	     !is_idle_task(current) && !current->non_block_count) ||
 	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
 	    oops_in_progress)
 		return;
@@ -6129,8 +6129,8 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 		"BUG: sleeping function called from invalid context at %s:%d\n",
 			file, line);
 	printk(KERN_ERR
-		"in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
-			in_atomic(), irqs_disabled(),
+		"in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
+			in_atomic(), irqs_disabled(), current->non_block_count,
 			current->pid, current->comm);
 
 	if (task_stack_end_corrupted(current))
-- 
2.20.0.rc1

