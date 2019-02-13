Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB8DC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B7A222D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550081893;
	bh=Q9EG9INJbgHL44XCt+Hwf2ZuuQE9NnkacYyhD79YEuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=jTD05mOb+PgKfE4s5wF/oIMPv9TPRI8iB8y9FRbz59No166VtvbhUr1rtJSMPS4ry
	 3LJXhMqykXm3MTXXAVf2ofC+xVSN47iv5lpOxlWE5W6LywKwxYQ7xc/Wj+YAbkCyfG
	 0ujto6lZmsg7Z+NkNm1n7goeeN0Zfvni1VbZnv6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393695AbfBMSSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbfBMSSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:18:07 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3E8222C9;
        Wed, 13 Feb 2019 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550081886;
        bh=Q9EG9INJbgHL44XCt+Hwf2ZuuQE9NnkacYyhD79YEuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CccEVmMCSD/nqPhI0OLzJvhzrbsHoTwW5CaKdV1Wy0xpIRpMHx6vNwOhzaSpPWkmy
         ypAWTbMsQQn3HvYrW3AYwDH3xCjJ2a45QHHcgt5anWn2KFStHl/l5YMIfz48IzBbSA
         3BRMV/3FGgLdLUtjwR5IWchtqYwYfYFATN09vxLc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 2/5] tracing: Save the last hist command's associated event name
Date:   Wed, 13 Feb 2019 12:17:53 -0600
Message-Id: <8a38aaa21424c23f225c8d2b1e77f0c0a07f7ffd.1550074795.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

In preparation for making use of the new trace error log, save the
subsystem and event name associated with the last hist command - it
will be passed as the location param in the event_log_err() calls.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4064e355878c..3e8addebc7be 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -536,15 +536,34 @@ static struct track_data *track_data_alloc(unsigned int key_len,
 	return data;
 }
 
-static char last_hist_cmd[MAX_FILTER_STR_VAL];
+static char last_cmd[MAX_FILTER_STR_VAL];
+static char last_cmd_loc[MAX_FILTER_STR_VAL];
+
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
-static void last_cmd_set(char *str)
+static void last_cmd_set(struct trace_event_file *file, char *str)
 {
+	const char *system = NULL, *name = NULL;
+	struct trace_event_call *call;
+
 	if (!str)
 		return;
 
-	strncpy(last_hist_cmd, str, MAX_FILTER_STR_VAL - 1);
+	strncpy(last_cmd, str, MAX_FILTER_STR_VAL - 1);
+
+	if (file) {
+		call = file->event_call;
+
+		system = call->class->system;
+		if (system) {
+			name = trace_event_name(call);
+			if (!name)
+				system = NULL;
+		}
+	}
+
+	if (system)
+		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, "hist:%s:%s", system, name);
 }
 
 static void hist_err(char *str, char *var)
@@ -584,6 +603,8 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
 static void hist_err_clear(void)
 {
 	hist_err_str[0] = '\0';
+	last_cmd[0] = '\0';
+	last_cmd_loc[0] = '\0';
 }
 
 static bool have_hist_err(void)
@@ -5440,8 +5461,8 @@ static int hist_show(struct seq_file *m, void *v)
 	}
 
 	if (have_hist_err()) {
-		seq_printf(m, "\nERROR: %s\n", hist_err_str);
-		seq_printf(m, "  Last command: %s\n", last_hist_cmd);
+		seq_printf(m, "\n%s: error: \n", hist_err_str);
+		seq_printf(m, "  Last command: %s\n", last_cmd);
 	}
 
  out_unlock:
@@ -6045,8 +6066,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	lockdep_assert_held(&event_mutex);
 
 	if (glob && strlen(glob)) {
-		last_cmd_set(param);
 		hist_err_clear();
+		last_cmd_set(file, param);
 	}
 
 	if (!param)
-- 
2.14.1

