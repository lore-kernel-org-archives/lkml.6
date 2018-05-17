Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeEQJXa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:23:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:6649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbeEQJX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:23:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="41683533"
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
Subject: [PATCH V2 01/20] kallsyms: Simplify update_iter_mod()
Date: Thu, 17 May 2018 12:21:49 +0300
Message-Id: <1526548928-20790-2-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic in update_iter_mod() is overcomplicated and gets worse every time
another get_ksymbol_* function is added.

In preparation for adding another get_ksymbol_* function, simplify logic in
update_iter_mod().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/kallsyms.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a23e21ada81b..eda4b0222dab 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -510,23 +510,15 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 {
 	iter->pos = pos;
 
-	if (iter->pos_ftrace_mod_end > 0 &&
-	    iter->pos_ftrace_mod_end < iter->pos)
-		return get_ksymbol_bpf(iter);
-
-	if (iter->pos_mod_end > 0 &&
-	    iter->pos_mod_end < iter->pos) {
-		if (!get_ksymbol_ftrace_mod(iter))
-			return get_ksymbol_bpf(iter);
+	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
+	    get_ksymbol_mod(iter))
 		return 1;
-	}
 
-	if (!get_ksymbol_mod(iter)) {
-		if (!get_ksymbol_ftrace_mod(iter))
-			return get_ksymbol_bpf(iter);
-	}
+	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > pos) &&
+	    get_ksymbol_ftrace_mod(iter))
+		return 1;
 
-	return 1;
+	return get_ksymbol_bpf(iter);
 }
 
 /* Returns false if pos at or past end of file. */
-- 
1.9.1
