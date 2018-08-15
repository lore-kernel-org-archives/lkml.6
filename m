Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1630C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5426208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyRKE2Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5426208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbeHOSBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbeHOSBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:01:18 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1146214AB;
        Wed, 15 Aug 2018 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345725;
        bh=hhUCw/6m/9JrSMVI9Hlk+i1w6PgbwxxedNPfk3bswd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HyRKE2QjrL0yinVtCu8TjBxLaUimpGmtus3djdEXcBX348eJUCssisTYYAXQyr+kE
         nNtErcLjI6nLWT1F505m9eXsykc/1ntmYvxNLUl9P5kbafNvPGnSN/2cv1SXRJttV3
         uXyCxvgwM/TGsbTXeMLuO5Yv4NxI/9PZBDvH4NiQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/35] kallsyms: Simplify update_iter_mod()
Date:   Wed, 15 Aug 2018 12:06:09 -0300
Message-Id: <20180815150611.32080-34-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The logic in update_iter_mod() is overcomplicated and gets worse every
time another get_ksymbol_* function is added.

In preparation for adding another get_ksymbol_* function, simplify logic
in update_iter_mod().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: (ftrace changes only) Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1528289651-4113-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

