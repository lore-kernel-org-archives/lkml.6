Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeCTLQP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:16:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeCTLQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:16:09 -0400
Date: Tue, 20 Mar 2018 04:15:36 -0700
From: tip-bot for Dan Carpenter <tipbot@zytor.com>
Message-ID: <tip-e5ea9b54a055619160bbfe527ebb7d7191823d66@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, acme@redhat.com, eranian@google.com,
        kan.liang@linux.intel.com, vincent.weaver@maine.edu,
        torvalds@linux-foundation.org, mingo@kernel.org, bigeasy@linutronix.de,
        jolsa@redhat.com
Reply-To: jolsa@redhat.com, mingo@kernel.org, bigeasy@linutronix.de,
        vincent.weaver@maine.edu, torvalds@linux-foundation.org,
        eranian@google.com, kan.liang@linux.intel.com, tglx@linutronix.de,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, hpa@zytor.com,
        peterz@infradead.org
In-Reply-To: <20180317115216.GB4035@mwanda>
References: <20180317115216.GB4035@mwanda>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Don't accidentally clear high
 bits in bdw_limit_period()
Git-Commit-ID: e5ea9b54a055619160bbfe527ebb7d7191823d66
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

Commit-ID:  e5ea9b54a055619160bbfe527ebb7d7191823d66
Gitweb:     https://git.kernel.org/tip/e5ea9b54a055619160bbfe527ebb7d7191823d66
Author:     Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate: Sat, 17 Mar 2018 14:52:16 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:53:31 +0100

perf/x86/intel: Don't accidentally clear high bits in bdw_limit_period()

We intended to clear the lowest 6 bits but because of a type bug we
clear the high 32 bits as well.  Andi says that periods are rarely more
than U32_MAX so this bug probably doesn't have a huge runtime impact.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 294fe0f52a44 ("perf/x86/intel: Add INST_RETIRED.ALL workarounds")
Link: http://lkml.kernel.org/r/20180317115216.GB4035@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 56457cb73448..9b18a227fff7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3194,7 +3194,7 @@ static unsigned bdw_limit_period(struct perf_event *event, unsigned left)
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
 		if (left < 128)
 			left = 128;
-		left &= ~0x3fu;
+		left &= ~0x3fULL;
 	}
 	return left;
 }
