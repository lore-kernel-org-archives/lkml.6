Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE2EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1162A206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1162A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeIFS1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:27:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeIFS1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:27:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DppP3312089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:51:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DppAv312086;
        Thu, 6 Sep 2018 06:51:51 -0700
Date:   Thu, 6 Sep 2018 06:51:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Neeraj Upadhyay <tipbot@zytor.com>
Message-ID: <tip-f8b7530aa0a1def79c93101216b5b17cf408a70a@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infraded.org, mingo@kernel.org, neeraju@codeaurora.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, peterz@infraded.org,
          neeraju@codeaurora.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <1536126727-11629-1-git-send-email-neeraju@codeaurora.org>
References: <1536126727-11629-1-git-send-email-neeraju@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] cpu/hotplug: Adjust misplaced smb() in
 cpuhp_thread_fun()
Git-Commit-ID: f8b7530aa0a1def79c93101216b5b17cf408a70a
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

Commit-ID:  f8b7530aa0a1def79c93101216b5b17cf408a70a
Gitweb:     https://git.kernel.org/tip/f8b7530aa0a1def79c93101216b5b17cf408a70a
Author:     Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate: Wed, 5 Sep 2018 11:22:07 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 6 Sep 2018 15:21:37 +0200

cpu/hotplug: Adjust misplaced smb() in cpuhp_thread_fun()

The smp_mb() in cpuhp_thread_fun() is misplaced. It needs to be after the
load of st->should_run to prevent reordering of the later load/stores
w.r.t. the load of st->should_run.

Fixes: 4dddfb5faa61 ("smp/hotplug: Rewrite AP state machine core")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infraded.org>
Cc: josh@joshtriplett.org
Cc: peterz@infradead.org
Cc: jiangshanlai@gmail.com
Cc: dzickus@redhat.com
Cc: brendan.jackman@arm.com
Cc: malat@debian.org
Cc: mojha@codeaurora.org
Cc: sramana@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1536126727-11629-1-git-send-email-neeraju@codeaurora.org

---
 kernel/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aa7fe85ad62e..eb4041f78073 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -607,15 +607,15 @@ static void cpuhp_thread_fun(unsigned int cpu)
 	bool bringup = st->bringup;
 	enum cpuhp_state state;
 
+	if (WARN_ON_ONCE(!st->should_run))
+		return;
+
 	/*
 	 * ACQUIRE for the cpuhp_should_run() load of ->should_run. Ensures
 	 * that if we see ->should_run we also see the rest of the state.
 	 */
 	smp_mb();
 
-	if (WARN_ON_ONCE(!st->should_run))
-		return;
-
 	cpuhp_lock_acquire(bringup);
 
 	if (st->single) {
