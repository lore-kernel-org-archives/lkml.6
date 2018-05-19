Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeESLsf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:48:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeESLsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:48:32 -0400
Date: Sat, 19 May 2018 04:48:10 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-19422a9f2a3be7f3a046285ffae4cbb571aa853a@git.kernel.org>
Cc: joro@8bytes.org, ak@linux.intel.com, mingo@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        adrian.hunter@intel.com, acme@redhat.com, dave.hansen@linux.intel.com,
        luto@kernel.org
Reply-To: jolsa@kernel.org, ak@linux.intel.com, mingo@kernel.org,
        joro@8bytes.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org
In-Reply-To: <1526548928-20790-7-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-7-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix kernel_start for PTI on x86
Git-Commit-ID: 19422a9f2a3be7f3a046285ffae4cbb571aa853a
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

Commit-ID:  19422a9f2a3be7f3a046285ffae4cbb571aa853a
Gitweb:     https://git.kernel.org/tip/19422a9f2a3be7f3a046285ffae4cbb571aa853a
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 17 May 2018 12:21:54 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 19 May 2018 06:42:51 -0300

perf tools: Fix kernel_start for PTI on x86

Opickn x86_64, PTI entry trampolines are less than the start of kernel text,
but still above 2^63. So leave kernel_start = 1ULL << 63 for x86_64.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526548928-20790-7-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 107bae7676b1..e011a7160380 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2321,7 +2321,12 @@ int machine__get_kernel_start(struct machine *machine)
 	machine->kernel_start = 1ULL << 63;
 	if (map) {
 		err = map__load(map);
-		if (!err)
+		/*
+		 * On x86_64, PTI entry trampolines are less than the
+		 * start of kernel text, but still above 2^63. So leave
+		 * kernel_start = 1ULL << 63 for x86_64.
+		 */
+		if (!err && !machine__is(machine, "x86_64"))
 			machine->kernel_start = map->start;
 	}
 	return err;
