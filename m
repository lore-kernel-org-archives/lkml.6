Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeDFNDu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752688AbeDFNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5EC21838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130113.056305093@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 09/18] tracing: Make sure variable string fields are NULL-terminated
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0009-tracing-Make-sure-variable-string-fields-are-NULL-te.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

The strncpy() currently being used for variable string fields can
result in a lack of termination if the string length is equal to the
field size.  Use the safer strscpy() instead, which will guarantee
termination.

Link: http://lkml.kernel.org/r/fb97c1e518fb358c12a4057d7445ba2c46956cd7.1522256721.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6114939f065a..15ea11c29a51 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -669,7 +669,7 @@ static notrace void trace_event_raw_event_synth(void *__data,
 			char *str_val = (char *)(long)var_ref_vals[var_ref_idx + i];
 			char *str_field = (char *)&entry->fields[n_u64];
 
-			strncpy(str_field, str_val, STR_VAR_LEN_MAX);
+			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
 			entry->fields[n_u64] = var_ref_vals[var_ref_idx + i];
@@ -3091,7 +3091,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 			char *str = elt_data->field_var_str[j++];
 			char *val_str = (char *)(uintptr_t)var_val;
 
-			strncpy(str, val_str, STR_VAR_LEN_MAX);
+			strscpy(str, val_str, STR_VAR_LEN_MAX);
 			var_val = (u64)(uintptr_t)str;
 		}
 		tracing_map_set_var(elt, var_idx, var_val);
-- 
2.15.1
