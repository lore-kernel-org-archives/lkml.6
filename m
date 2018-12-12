Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE4AC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124432086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UDDoqQC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124432086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeLLCZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:25:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42432 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeLLCZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:25:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so7567060pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RmKCG2vjvx5pkCe9XrXlTLfU5SXj6SQnQr7mWTh5qIk=;
        b=UDDoqQC0tKdh07XAH/wc/oczJV9lXxNYH0JUAZZy7imigLmFgOvN1YM0O6n6fidX1Y
         qPbuz+wDscLLdXuY70JDUAUFVzEkDpx3pir/97FDEN3SDHcNZiJBLhWZjlPH2XwTFHWQ
         5j+mVYOlLMSE5WV/5PubqOyRT4FDwv2vEe2T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RmKCG2vjvx5pkCe9XrXlTLfU5SXj6SQnQr7mWTh5qIk=;
        b=EgIo+zL5xCyHEzsW8VxMhDcNEqej/Te0G4kmkvMKR6GRBxd7062X+SgWmsZAdecNEi
         3+eVefvSuEsQs0FzGVKz147Do05iPKB1KEh2zQ2ngE6ln9kROzH2EDbQfjkejgBUpCVI
         TX5qKLc5X9Tw2jxHR27gn/bavktAT4T/tuay0QdczP4nYUdJ/Ji2iQPrNqouESO+ad4B
         ACyaWtdHE9o5PyHJnDN+p27z6IqdktieNeIDKi9ITUHrEmarNZty9tnb97AeoejFV30x
         RBfGksJw7ilEZsA6Y43n8RtNmMuyUYbFIqh9B361XvFQk/FTxKhPrnb7gPG/6LUbiJN4
         /VYA==
X-Gm-Message-State: AA+aEWZbyaNzQhEb5n+6KcsJMX4mYCITHrni9EM689FYWwjvT4nlfL6j
        s46FSqwCb+r+R6ugHpiJMLSSrQ==
X-Google-Smtp-Source: AFSGD/WpyCSuFGEOyVUamaVe/Z0BcOIKbnIRI8aztIgbE8MgL5TLu7SSs2c+6AbBERBqgxQFVQlPLQ==
X-Received: by 2002:a63:85c6:: with SMTP id u189mr16105154pgd.156.1544581515165;
        Tue, 11 Dec 2018 18:25:15 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id f6sm27334649pfg.188.2018.12.11.18.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 18:25:14 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: RFC [PATCH 1/1] locking/lockdep: Fix nest lock warning on unlock
Date:   Tue, 11 Dec 2018 18:25:06 -0800
Message-Id: <20181212022506.171936-2-dbasehore@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181212022506.171936-1-dbasehore@chromium.org>
References: <20181212022506.171936-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __lock_acquire checks that the nest lock is held passed
in as an argument. The issue with this is that __lock_acquire is used
for internal bookkeeping on lock_release. This produces a false
positive lockdep warning on unlock. Since you explicitly don't need to
hold the nest lock on unlock, this is an issue.

This fixes the problem by only checking the nest lock on the actual
lock acquire step.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 kernel/locking/lockdep.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1efada2dd9dd..2e7297ee6596 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3155,15 +3155,15 @@ EXPORT_SYMBOL_GPL(lockdep_init_map);
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 
-static int
-print_lock_nested_lock_not_held(struct task_struct *curr,
-				struct held_lock *hlock,
+static void
+print_lock_nested_lock_not_held(struct lockdep_map *lock,
+				struct lockdep_map *nest_lock,
 				unsigned long ip)
 {
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("==================================\n");
@@ -3171,22 +3171,21 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 	print_kernel_ident();
 	pr_warn("----------------------------------\n");
 
-	pr_warn("%s/%d is trying to lock:\n", curr->comm, task_pid_nr(curr));
-	print_lock(hlock);
+	pr_warn("%s/%d is trying to lock:\n", current->comm,
+			task_pid_nr(current));
+	pr_warn("%s\n", lock->name);
 
 	pr_warn("\nbut this task is not holding:\n");
-	pr_warn("%s\n", hlock->nest_lock->name);
+	pr_warn("%s\n", nest_lock->name);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
 
 	pr_warn("\nother info that might help us debug this:\n");
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(current);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -3335,9 +3334,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	}
 	chain_key = iterate_chain_key(chain_key, class_idx);
 
-	if (nest_lock && !__lock_is_held(nest_lock, -1))
-		return print_lock_nested_lock_not_held(curr, hlock, ip);
-
 	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
 		return 0;
 
@@ -3843,6 +3839,9 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
+	if (nest_lock && !__lock_is_held(nest_lock, -1))
+		print_lock_nested_lock_not_held(lock, nest_lock, ip);
+
 	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 }
-- 
2.20.0.rc2.403.gdbc3b29805-goog

