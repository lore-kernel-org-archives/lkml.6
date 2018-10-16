Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340BC20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340BC20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeJPVmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:42:40 -0400
Received: from www.osadl.org ([62.245.132.105]:55869 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbeJPVmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:42:40 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w9GDlrKt030159;
        Tue, 16 Oct 2018 15:47:53 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     mingo@kernel.org
Cc:     john.garry@huawei.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] sched/completions/Documentation: add recommendation for dynamic and ONSTACK completion
Date:   Tue, 16 Oct 2018 15:45:39 +0200
Message-Id: <1539697539-24055-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 To prevent dynamic completion objects from being de-allocated while still
in use a recommendation to embed them in long lived data structs is added.
Further a note for the on-stack case is added that emphasizes the limited
scope and recommending dynamic allocation if scope limitations are not
clearly understood.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch is aginast 4.19-rc8 -tip (Oct 16 2018)

 Documentation/scheduler/completion.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/completion.txt b/Documentation/scheduler/completion.txt
index 91a11a6..6e8b0d1 100644
--- a/Documentation/scheduler/completion.txt
+++ b/Documentation/scheduler/completion.txt
@@ -70,8 +70,13 @@ Good, intuitive naming (as always) helps code readability. Naming a completion
 Initializing completions:
 -------------------------
 
-Initialization of dynamically allocated completion objects, often embedded in
-other structures, is done via a call to init_completion():
+Dynamically allocated completion objects should preferably be embedded in data
+structures that are assured for the life-time of the function/driver to prevent
+a race with async complete() calls from occurring - notably for the timeout or
+killable variants of wait_for_completion() it must be assured that de-allocation
+does not happen until all related activities (complete() or reinit_completion())
+have taken place. Initializing of dynamically allocated completion objects is done
+via a call to init_completion():
 
 	init_completion(&dynamic_object->done);
 
@@ -99,7 +104,9 @@ Note that in this case the completion is boot time (or module load time)
 initialized to 'not done' and doesn't require an init_completion() call.
 
 When a completion is declared as a local variable within a function,
-then the initialization should always use:
+then the initialization should always use DECLARE_COMPLETION_ONSTACK()
+explicitly to make it clear that limited scope had been considered and
+is intentional - if unsure use dynamically allocated completion objects.
 
 	DECLARE_COMPLETION_ONSTACK(setup_done)
 
-- 
2.1.4

