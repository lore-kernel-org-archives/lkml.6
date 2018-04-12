Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeDLJWp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:22:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbeDLJWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:22:44 -0400
Date: Thu, 12 Apr 2018 02:22:11 -0700
From: tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-32e6e967fb36bf77ed99221ae3ce1909f045d8f9@git.kernel.org>
Cc: songliubraving@fb.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, vincent.weaver@maine.edu,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, songliubraving@fb.com,
        mingo@kernel.org, peterz@infradead.org, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <C0B2EFB5-C403-4BDB-9046-C14B3EE66999@fb.com>
References: <C0B2EFB5-C403-4BDB-9046-C14B3EE66999@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Need CAP_SYS_ADMIN to create k/uprobe
 with perf_event_open()
Git-Commit-ID: 32e6e967fb36bf77ed99221ae3ce1909f045d8f9
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

Commit-ID:  32e6e967fb36bf77ed99221ae3ce1909f045d8f9
Gitweb:     https://git.kernel.org/tip/32e6e967fb36bf77ed99221ae3ce1909f045d8f9
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Wed, 11 Apr 2018 18:02:37 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 12 Apr 2018 09:55:50 +0200

perf/core: Need CAP_SYS_ADMIN to create k/uprobe with perf_event_open()

Non-root user cannot create kprobe or uprobe through the text-based
interface (kprobe_events, uprobe_events),so they should not be able
to create probes via perf_event_open() either.

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
Fixes: e12f03d7031a ("perf/core: Implement the 'perf_kprobe' PMU")
Link: http://lkml.kernel.org/r/C0B2EFB5-C403-4BDB-9046-C14B3EE66999@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7af82827373..2d5fe26551f8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8400,6 +8400,10 @@ static int perf_kprobe_event_init(struct perf_event *event)
 
 	if (event->attr.type != perf_kprobe.type)
 		return -ENOENT;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	/*
 	 * no branch sampling for probe events
 	 */
@@ -8437,6 +8441,10 @@ static int perf_uprobe_event_init(struct perf_event *event)
 
 	if (event->attr.type != perf_uprobe.type)
 		return -ENOENT;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	/*
 	 * no branch sampling for probe events
 	 */
