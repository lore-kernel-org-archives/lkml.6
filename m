Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DDEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2913D21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2913D21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJQRGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:06:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeJQRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:06:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9H9AxU0277789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 02:10:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9H9Axok277786;
        Wed, 17 Oct 2018 02:10:59 -0700
Date:   Wed, 17 Oct 2018 02:10:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Mc Guire <tipbot@zytor.com>
Message-ID: <tip-11e13696a08e838ba48c72404c2b3f41429b5b20@git.kernel.org>
Cc:     hofrat@osadl.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hofrat@osadl.org
In-Reply-To: <1539697539-24055-1-git-send-email-hofrat@osadl.org>
References: <1539697539-24055-1-git-send-email-hofrat@osadl.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/completions/Documentation: Add
 recommendation for dynamic and ONSTACK completions
Git-Commit-ID: 11e13696a08e838ba48c72404c2b3f41429b5b20
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  11e13696a08e838ba48c72404c2b3f41429b5b20
Gitweb:     https://git.kernel.org/tip/11e13696a08e838ba48c72404c2b3f41429b5b20
Author:     Nicholas Mc Guire <hofrat@osadl.org>
AuthorDate: Tue, 16 Oct 2018 15:45:39 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 17 Oct 2018 08:30:10 +0200

sched/completions/Documentation: Add recommendation for dynamic and ONSTACK completions

To prevent dynamic completion objects from being de-allocated while still
in use, add a recommendation to embed them in long lived data structures.

Also add a note for the on-stack case that emphasizes the dangers of
the limited scope, and recommends dynamic allocation if scope limitations
are not clearly understood.

[ mingo: Minor touch-ups of the text, expanded it a bit to make the
         warnings Nicholas added more prominent. ]

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: john.garry@huawei.com
Link: http://lkml.kernel.org/r/1539697539-24055-1-git-send-email-hofrat@osadl.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/scheduler/completion.txt | 42 +++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/completion.txt b/Documentation/scheduler/completion.txt
index 91a11a668354..2dbff579f957 100644
--- a/Documentation/scheduler/completion.txt
+++ b/Documentation/scheduler/completion.txt
@@ -70,8 +70,18 @@ Good, intuitive naming (as always) helps code readability. Naming a completion
 Initializing completions:
 -------------------------
 
-Initialization of dynamically allocated completion objects, often embedded in
-other structures, is done via a call to init_completion():
+Dynamically allocated completion objects should preferably be embedded in data
+structures that are assured to be alive for the life-time of the function/driver,
+to prevent races with asynchronous complete() calls from occurring.
+
+Particular care should be taken when using the _timeout() or _killable()/_interruptible()
+variants of wait_for_completion(), as it must be assured that memory de-allocation
+does not happen until all related activities (complete() or reinit_completion())
+have taken place, even if these wait functions return prematurely due to a timeout
+or a signal triggering.
+
+Initializing of dynamically allocated completion objects is done via a call to
+init_completion():
 
 	init_completion(&dynamic_object->done);
 
@@ -99,16 +109,32 @@ Note that in this case the completion is boot time (or module load time)
 initialized to 'not done' and doesn't require an init_completion() call.
 
 When a completion is declared as a local variable within a function,
-then the initialization should always use:
+then the initialization should always use DECLARE_COMPLETION_ONSTACK()
+explicitly, not just to make lockdep happy, but also to make it clear
+that limited scope had been considered and is intentional:
 
 	DECLARE_COMPLETION_ONSTACK(setup_done)
 
-A simple DECLARE_COMPLETION() on the stack makes lockdep unhappy.
-
 Note that when using completion objects as local variables you must be
-aware of the short life time of the function stack: the function must
-not return to a calling context until all activities (such as waiting
-threads) have ceased and the completion is ... completely unused.
+acutely aware of the short life time of the function stack: the function
+must not return to a calling context until all activities (such as waiting
+threads) have ceased and the completion object is completely unused.
+
+To emphasise this again: in particular when using some of the waiting API variants
+with more complex outcomes, such as the timeout or signalling (_timeout(),
+_killable() and _interruptible()) variants, the wait might complete
+prematurely while the object might still be in use by another thread - and a return
+from the wait_on_completion*() caller function will deallocate the function
+stack and cause subtle data corruption if a complete() is done in some
+other thread. Simple testing might not trigger these kinds of races.
+
+If unsure, use dynamically allocated completion objects, preferably embedded
+in some other long lived object that has a boringly long life time which
+exceeds the life time of any helper threads using the completion object,
+or has a lock or other synchronization mechanism to make sure complete()
+is not called on a freed object.
+
+A naive DECLARE_COMPLETION() on the stack triggers a lockdep warning.
 
 Waiting for completions:
 ------------------------
