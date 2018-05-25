Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966293AbeEYJyn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:54:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52595 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965252AbeEYJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:28 -0400
Date: Fri, 25 May 2018 02:50:07 -0700
From: tip-bot for Eugene Syromiatnikov <tipbot@zytor.com>
Message-ID: <tip-82489c5fe5f99ca95f708fecae9f2c8aa99398bb@git.kernel.org>
Cc: peterz@infradead.org, acme@redhat.com, esyr@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, hpa@zytor.com,
        vincent.weaver@maine.edu, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, acme@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Reply-To: hpa@zytor.com, vincent.weaver@maine.edu, mingo@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, torvalds@linux-foundation.org,
        jolsa@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, esyr@redhat.com,
        acme@redhat.com, eranian@google.com
In-Reply-To: <20180521123420.GA24291@asgard.redhat.com>
References: <20180521123420.GA24291@asgard.redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Wire up compat PERF_EVENT_IOC_QUERY_BPF,
 PERF_EVENT_IOC_MODIFY_ATTRIBUTES
Git-Commit-ID: 82489c5fe5f99ca95f708fecae9f2c8aa99398bb
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

Commit-ID:  82489c5fe5f99ca95f708fecae9f2c8aa99398bb
Gitweb:     https://git.kernel.org/tip/82489c5fe5f99ca95f708fecae9f2c8aa99398bb
Author:     Eugene Syromiatnikov <esyr@redhat.com>
AuthorDate: Mon, 21 May 2018 14:34:20 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:11:11 +0200

perf/core: Wire up compat PERF_EVENT_IOC_QUERY_BPF, PERF_EVENT_IOC_MODIFY_ATTRIBUTES

Since pointer size is different in compat, and switching in _perf_ioctl
is done using exact ioctl numbers, all new ioctl numbers that use pointer
should be added to perf_compat_ioctl for _IOC_SIZE fixup before passing
to perf_ioctl routine (this shouldn't be needed if semantics of the size
argument of _IO* macros was honored).

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20180521123420.GA24291@asgard.redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 24dea13a27ed..08f5e1b42b43 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5120,6 +5120,8 @@ static long perf_compat_ioctl(struct file *file, unsigned int cmd,
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(PERF_EVENT_IOC_SET_FILTER):
 	case _IOC_NR(PERF_EVENT_IOC_ID):
+	case _IOC_NR(PERF_EVENT_IOC_QUERY_BPF):
+	case _IOC_NR(PERF_EVENT_IOC_MODIFY_ATTRIBUTES):
 		/* Fix up pointer size (usually 4 -> 8 in 32-on-64-bit case */
 		if (_IOC_SIZE(cmd) == sizeof(compat_uptr_t)) {
 			cmd &= ~IOCSIZE_MASK;
