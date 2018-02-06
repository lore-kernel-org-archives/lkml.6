Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeBFL4c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:56:32 -0500
Received: from terminus.zytor.com ([65.50.211.136]:41935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:56:24 -0500
Date: Tue, 6 Feb 2018 03:52:32 -0800
From: tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-65074d43fc77bcae32776724b7fa2696923c78e4@git.kernel.org>
Cc: ast@kernel.org, rostedt@goodmis.org, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com, peterz@infradead.org, namhyung@kernel.org, yhs@fb.com,
        kernel-team@fb.com, jolsa@redhat.com, davem@davemloft.net,
        daniel@iogearbox.net, tglx@linutronix.de,
        torvalds@linux-foundation.org, jbacik@fb.com
Reply-To: daniel@iogearbox.net, tglx@linutronix.de,
        torvalds@linux-foundation.org, jbacik@fb.com, peterz@infradead.org,
        acme@redhat.com, namhyung@kernel.org, kernel-team@fb.com, yhs@fb.com,
        jolsa@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, ast@kernel.org, rostedt@goodmis.org,
        songliubraving@fb.com
In-Reply-To: <20171206224518.3598254-4-songliubraving@fb.com>
References: <20171206224518.3598254-4-songliubraving@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Prepare perf_event.h for new types:
 'perf_kprobe' and 'perf_uprobe'
Git-Commit-ID: 65074d43fc77bcae32776724b7fa2696923c78e4
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

Commit-ID:  65074d43fc77bcae32776724b7fa2696923c78e4
Gitweb:     https://git.kernel.org/tip/65074d43fc77bcae32776724b7fa2696923c78e4
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Wed, 6 Dec 2017 14:45:13 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:18:04 +0100

perf/core: Prepare perf_event.h for new types: 'perf_kprobe' and 'perf_uprobe'

Two new perf types, perf_kprobe and perf_uprobe, will be added to allow
creating [k,u]probe with perf_event_open. These [k,u]probe are associated
with the file decriptor created by perf_event_open(), thus are easy to
clean when the file descriptor is destroyed.

kprobe_func and uprobe_path are added to union config1 for pointers to
function name for kprobe or binary path for uprobe.

kprobe_addr and probe_offset are added to union config2 for kernel
address (when kprobe_func is NULL), or [k,u]probe offset.

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yonghong Song <yhs@fb.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: <daniel@iogearbox.net>
Cc: <davem@davemloft.net>
Cc: <kernel-team@fb.com>
Cc: <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20171206224518.3598254-4-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/uapi/linux/perf_event.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c77c9a2..5d49cfc 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -380,10 +380,14 @@ struct perf_event_attr {
 	__u32			bp_type;
 	union {
 		__u64		bp_addr;
+		__u64		kprobe_func; /* for perf_kprobe */
+		__u64		uprobe_path; /* for perf_uprobe */
 		__u64		config1; /* extension of config */
 	};
 	union {
 		__u64		bp_len;
+		__u64		kprobe_addr; /* when kprobe_func == NULL */
+		__u64		probe_offset; /* for perf_[k,u]probe */
 		__u64		config2; /* extension of config1 */
 	};
 	__u64	branch_sample_type; /* enum perf_branch_sample_type */
