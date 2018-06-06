Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE636606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeFFMzn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:55:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:9650 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeFFMzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:55:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="55204285"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH V4 1/3] kallsyms: Simplify update_iter_mod()
Date: Wed,  6 Jun 2018 15:54:09 +0300
Message-Id: <1528289651-4113-2-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic in update_iter_mod() is overcomplicated and gets worse every time
another get_ksymbol_* function is added.

In preparation for adding another get_ksymbol_* function, simplify logic in
update_iter_mod().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
---
 kernel/kallsyms.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a23e21ada81b..aa31aa07f2ef 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -506,27 +506,24 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	}
 }
 
+/*
+ * The end position (last + 1) of each additional kallsyms section is recorded
+ * in iter->pos_..._end as each section is added, and so can be used to
+ * determine which get_ksymbol_...() function to call next.
+ */
 static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
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
