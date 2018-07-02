Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83A9244D9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="khzwqczd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83A9244D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeGBUXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbeGBUWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:22:43 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D93B25A2F;
        Mon,  2 Jul 2018 20:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530562963;
        bh=og6+Kv9zxAyJDBjB6eApjOwRxWYdSYKjGEATo2a3lJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=khzwqczdvu15fbs2vJbW6+nwmW9DS8/uPUOqK0Z4i/RUmCKkPAN+2fz4tbpqRHadv
         FPjJhDbZ4tOnsPEkwSAMhcukEPF2MuvwzqI/bgERKUCIdjuTRccUOQPecohSBnQ/W8
         7ZaHRlD79PbCRWI1sMtZ7Fmp++V/xxzFmdLywI5U=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 5/7] tracing: Move hist trigger key printing into a separate function
Date:   Mon,  2 Jul 2018 15:22:24 -0500
Message-Id: <5410e9310a9ef27996d49c2d313c2d740f570669.1530561352.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1530561352.git.tom.zanussi@linux.intel.com>
References: <cover.1530561352.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1530561352.git.tom.zanussi@linux.intel.com>
References: <cover.1530561352.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Future patches will want to print a histogram key outside a histogram
- add and use hist_trigger_print_key() for that purpose.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f54dc8782d91..9990b6f45430 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4846,10 +4846,10 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 	}
 }
 
-static void
-hist_trigger_entry_print(struct seq_file *m,
-			 struct hist_trigger_data *hist_data, void *key,
-			 struct tracing_map_elt *elt)
+static void hist_trigger_print_key(struct seq_file *m,
+				   struct hist_trigger_data *hist_data,
+				   void *key,
+				   struct tracing_map_elt *elt)
 {
 	struct hist_field *key_field;
 	char str[KSYM_SYMBOL_LEN];
@@ -4925,6 +4925,17 @@ hist_trigger_entry_print(struct seq_file *m,
 		seq_puts(m, " ");
 
 	seq_puts(m, "}");
+}
+
+static void hist_trigger_entry_print(struct seq_file *m,
+				     struct hist_trigger_data *hist_data,
+				     void *key,
+				     struct tracing_map_elt *elt)
+{
+	const char *field_name;
+	unsigned int i;
+
+	hist_trigger_print_key(m, hist_data, key, elt);
 
 	seq_printf(m, " hitcount: %10llu",
 		   tracing_map_read_sum(elt, HITCOUNT_IDX));
-- 
2.14.1

