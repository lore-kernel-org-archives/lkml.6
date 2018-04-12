Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeDLByr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeDLBym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:54:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BB32183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180412015440.924620680@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 11 Apr 2018 21:54:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 4/5] trace_uprobe: Simplify probes_seq_show()
References: <20180412015359.244491749@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-trace_uprobe-Simplify-probes_seq_show.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Simplify probes_seq_show() function. No change in output
before and after patch.

Link: http://lkml.kernel.org/r/20180315082756.9050-2-ravi.bangoria@linux.vnet.ibm.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index d7d3c9237f64..21604754bb79 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -602,24 +602,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
 	char c = is_ret_probe(tu) ? 'r' : 'p';
 	int i;
 
-	seq_printf(m, "%c:%s/%s", c, tu->tp.call.class->system,
-			trace_event_name(&tu->tp.call));
-	seq_printf(m, " %s:", tu->filename);
-
-	/* Don't print "0x  (null)" when offset is 0 */
-	if (tu->offset) {
-		seq_printf(m, "0x%0*lx", (int)(sizeof(void *) * 2), tu->offset);
-	} else {
-		switch (sizeof(void *)) {
-		case 4:
-			seq_printf(m, "0x00000000");
-			break;
-		case 8:
-		default:
-			seq_printf(m, "0x0000000000000000");
-			break;
-		}
-	}
+	seq_printf(m, "%c:%s/%s %s:0x%0*lx", c, tu->tp.call.class->system,
+			trace_event_name(&tu->tp.call), tu->filename,
+			(int)(sizeof(void *) * 2), tu->offset);
 
 	for (i = 0; i < tu->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
-- 
2.16.3
