Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755304AbeDTOdQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754968AbeDTOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED592183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, syzkaller-bugs@googlegroups.com,
        x86@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/17] perf: Return proper values for user stack errors
Date: Fri, 20 Apr 2018 11:32:16 -0300
Message-Id: <20180420143227.16030-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.3
