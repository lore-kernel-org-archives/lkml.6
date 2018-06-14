Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 14A75C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3B1208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG9IK9WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3B1208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964910AbeFNRqP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964854AbeFNRqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:46:11 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB90208E1;
        Thu, 14 Jun 2018 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528998371;
        bh=og6+Kv9zxAyJDBjB6eApjOwRxWYdSYKjGEATo2a3lJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=mG9IK9WMahXEi1GgWqwzTFefQyTX94++4GamxyKZ0br6A0ZGjlqqSPhMV8i3/rI7G
         nPQmJ0EDbWLNpOImlNB8FtNFwI8tQL12gh6AlWL4iPzDVveRbhakqEfumiMszIZgYW
         6fS/gYjWNPzMF+eObmdFZ4oS437e5v76T+St/AII=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 5/7] tracing: Move hist trigger key printing into a separate function
Date:   Thu, 14 Jun 2018 12:45:14 -0500
Message-Id: <e4f73c329cc693ad65d79c44eee0b2708529f82a.1528986926.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1528986925.git.tom.zanussi@linux.intel.com>
References: <cover.1528986925.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1528986925.git.tom.zanussi@linux.intel.com>
References: <cover.1528986925.git.tom.zanussi@linux.intel.com>
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

