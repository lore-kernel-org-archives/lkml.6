Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeEQJXz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:23:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:6649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752121AbeEQJXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:23:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="41683580"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH V2 06/20] perf tools: Fix kernel_start for PTI on x86
Date: Thu, 17 May 2018 12:21:54 +0300
Message-Id: <1526548928-20790-7-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, PTI entry trampolines are less than the start of kernel text,
but still above 2^63. So leave kernel_start = 1ULL << 63 for x86_64.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dcdf78ddc470..4281a9b65aba 100644
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
-- 
1.9.1
