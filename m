Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeEUMdb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:33:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750944AbeEUMd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:33:28 -0400
Date: Mon, 21 May 2018 14:34:20 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] Wire compat PERF_EVENT_IOC_QUERY_BPF,
 PERF_EVENT_IOC_MODIFY_ATTRIBUTES
Message-ID: <20180521123420.GA24291@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pointer size is different in compat, and switching in _perf_ioctl
is done using exact ioctl numbers, all new ioctl numbers that use pointer
should be added to perf_compat_ioctl for _IOC_SIZE fixup before passing
to perf_ioctl routine (this shouldn't be needed if semantics of the size
argument of _IO* macros was honored).

* kernel/events/core.c (perf_compat_ioctl): Add
_IOC_NR(PERF_EVENT_IOC_QUERY_BPF) and _IOC_NR(PERF_EVENT_IOC_MODIFY_ATTRIBUTES)
to the switch statement.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67612ce..0a7eee5 100644
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
-- 
2.1.4
