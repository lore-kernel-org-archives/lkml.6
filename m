Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeCUC3O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbeCUCV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C707D217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022124.592540646@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>
Subject: [for-next][PATCH 10/46] tracing: Break out hist trigger assignment parsing
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0010-tracing-Break-out-hist-trigger-assignment-parsing.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

This will make it easier to add variables, and makes the parsing code
cleaner regardless.

Link: http://lkml.kernel.org/r/e574b3291bbe15e35a4dfc87e5395aa715701c98.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 72 ++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 37f5acefdc6c..e4368bb7ba30 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -251,6 +251,51 @@ static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
 	kfree(attrs);
 }
 
+static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
+{
+	int ret = 0;
+
+	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
+	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
+		attrs->keys_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->keys_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
+		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
+		 (strncmp(str, "values=", strlen("values=")) == 0)) {
+		attrs->vals_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->vals_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (strncmp(str, "sort=", strlen("sort=")) == 0) {
+		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->sort_key_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (strncmp(str, "name=", strlen("name=")) == 0) {
+		attrs->name = kstrdup(str, GFP_KERNEL);
+		if (!attrs->name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
+		int map_bits = parse_map_size(str);
+
+		if (map_bits < 0) {
+			ret = map_bits;
+			goto out;
+		}
+		attrs->map_bits = map_bits;
+	} else
+		ret = -EINVAL;
+ out:
+	return ret;
+}
+
 static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 {
 	struct hist_trigger_attrs *attrs;
@@ -263,33 +308,18 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 	while (trigger_str) {
 		char *str = strsep(&trigger_str, ":");
 
-		if ((strncmp(str, "key=", strlen("key=")) == 0) ||
-		    (strncmp(str, "keys=", strlen("keys=")) == 0))
-			attrs->keys_str = kstrdup(str, GFP_KERNEL);
-		else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
-			 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
-			 (strncmp(str, "values=", strlen("values=")) == 0))
-			attrs->vals_str = kstrdup(str, GFP_KERNEL);
-		else if (strncmp(str, "sort=", strlen("sort=")) == 0)
-			attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
-		else if (strncmp(str, "name=", strlen("name=")) == 0)
-			attrs->name = kstrdup(str, GFP_KERNEL);
-		else if (strcmp(str, "pause") == 0)
+		if (strchr(str, '=')) {
+			ret = parse_assignment(str, attrs);
+			if (ret)
+				goto free;
+		} else if (strcmp(str, "pause") == 0)
 			attrs->pause = true;
 		else if ((strcmp(str, "cont") == 0) ||
 			 (strcmp(str, "continue") == 0))
 			attrs->cont = true;
 		else if (strcmp(str, "clear") == 0)
 			attrs->clear = true;
-		else if (strncmp(str, "size=", strlen("size=")) == 0) {
-			int map_bits = parse_map_size(str);
-
-			if (map_bits < 0) {
-				ret = map_bits;
-				goto free;
-			}
-			attrs->map_bits = map_bits;
-		} else {
+		else {
 			ret = -EINVAL;
 			goto free;
 		}
-- 
2.15.1
