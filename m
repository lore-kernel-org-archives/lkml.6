Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeEBOOR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:14:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:14:14 -0400
Date: Wed, 2 May 2018 07:13:49 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-5b9e886a4af97574ca3ce1147f35545da0e7afc7@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, diego.viola@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, rafael.j.wysocki@intel.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: hpa@zytor.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, mingo@kernel.org, diego.viola@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180430100344.472662715@infradead.org>
References: <20180430100344.472662715@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource: Initialize cs->wd_list
Git-Commit-ID: 5b9e886a4af97574ca3ce1147f35545da0e7afc7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5b9e886a4af97574ca3ce1147f35545da0e7afc7
Gitweb:     https://git.kernel.org/tip/5b9e886a4af97574ca3ce1147f35545da0e7afc7
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 30 Apr 2018 12:00:11 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 2 May 2018 16:10:40 +0200

clocksource: Initialize cs->wd_list

A number of places relies on list_empty(&cs->wd_list), however the
list_head does not get initialized. Do so upon registration, such that
thereafter it is possible to rely on list_empty() correctly reflecting
the list membership status.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Diego Viola <diego.viola@gmail.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: rui.zhang@intel.com
Link: https://lkml.kernel.org/r/20180430100344.472662715@infradead.org

---
 kernel/time/clocksource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c3d2b94723dc..935f39eb8aac 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -332,6 +332,8 @@ static void clocksource_resume_watchdog(void)
 
 static void clocksource_enqueue_watchdog(struct clocksource *cs)
 {
+	INIT_LIST_HEAD(&cs->wd_list);
+
 	if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 		/* cs is a clocksource to be watched. */
 		list_add(&cs->wd_list, &watchdog_list);
