Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeDUHuq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:50:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeDUHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:50:43 -0400
Date: Sat, 21 Apr 2018 00:49:58 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bfb3d7b8b906b66551424d7636182126e1d134c8@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        peterz@infradead.org, jolsa@kernel.org, andi@firstfloor.org,
        namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, andi@firstfloor.org,
        mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, peterz@infradead.org
In-Reply-To: <20180415092352.12403-3-jolsa@kernel.org>
References: <20180415092352.12403-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf: Remove superfluous allocation error check
Git-Commit-ID: bfb3d7b8b906b66551424d7636182126e1d134c8
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

Commit-ID:  bfb3d7b8b906b66551424d7636182126e1d134c8
Gitweb:     https://git.kernel.org/tip/bfb3d7b8b906b66551424d7636182126e1d134c8
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 15 Apr 2018 11:23:52 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 17 Apr 2018 09:47:40 -0300

perf: Remove superfluous allocation error check

If the get_callchain_buffers fails to allocate the buffer it will
decrease the nr_callchain_events right away.

There's no point of checking the allocation error for
nr_callchain_events > 1. Removing that check.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: syzkaller-bugs@googlegroups.com
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/20180415092352.12403-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/callchain.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 73cc26e321de..c187aa3df3c8 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -131,14 +131,8 @@ int get_callchain_buffers(int event_max_stack)
 		goto exit;
 	}
 
-	if (count > 1) {
-		/* If the allocation failed, give up */
-		if (!callchain_cpus_entries)
-			err = -ENOMEM;
-		goto exit;
-	}
-
-	err = alloc_callchain_buffers();
+	if (count == 1)
+		err = alloc_callchain_buffers();
 exit:
 	if (err)
 		atomic_dec(&nr_callchain_events);
