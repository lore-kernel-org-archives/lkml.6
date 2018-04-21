Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeDUHtz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:49:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeDUHtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:49:53 -0400
Date: Sat, 21 Apr 2018 00:48:58 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-78b562fbfa2cf0a9fcb23c3154756b690f4905c1@git.kernel.org>
Cc: mingo@kernel.org, eranian@google.com, namhyung@kernel.org,
        acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        andi@firstfloor.org, hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, eranian@google.com, namhyung@kernel.org,
        acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        andi@firstfloor.org
In-Reply-To: <20180415092352.12403-1-jolsa@kernel.org>
References: <20180415092352.12403-1-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf: Return proper values for user stack errors
Git-Commit-ID: 78b562fbfa2cf0a9fcb23c3154756b690f4905c1
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

Commit-ID:  78b562fbfa2cf0a9fcb23c3154756b690f4905c1
Gitweb:     https://git.kernel.org/tip/78b562fbfa2cf0a9fcb23c3154756b690f4905c1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 15 Apr 2018 11:23:50 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 17 Apr 2018 09:47:39 -0300

perf: Return proper values for user stack errors

Return immediately when we find issue in the user stack checks. The
error value could get overwritten by following check for
PERF_SAMPLE_REGS_INTR.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: syzkaller-bugs@googlegroups.com
Cc: x86@kernel.org
Fixes: 60e2364e60e8 ("perf: Add ability to sample machine state on interrupt")
Link: http://lkml.kernel.org/r/20180415092352.12403-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1bae80aaabfb..67612ce359ad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10209,9 +10209,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		 * __u16 sample size limit.
 		 */
 		if (attr->sample_stack_user >= USHRT_MAX)
-			ret = -EINVAL;
+			return -EINVAL;
 		else if (!IS_ALIGNED(attr->sample_stack_user, sizeof(u64)))
-			ret = -EINVAL;
+			return -EINVAL;
 	}
 
 	if (!attr->sample_max_stack)
