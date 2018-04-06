Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDFNBP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752561AbeDFNBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92D6217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130111.738213668@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 01/18] tracing: Fix a potential NULL dereference
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0001-tracing-Fix-a-potential-NULL-dereference.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

We forgot to set the error code on this path so we return ERR_PTR(0)
which is NULL.  It results in a NULL dereference in the caller.

Link: http://lkml.kernel.org/r/20180323113735.GC28518@mwanda

Fixes: 100719dcef44 ("tracing: Add simple expression support to hist triggers")
Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4f027642ceef..a02bc09d765a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2776,6 +2776,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		expr->fn = hist_field_plus;
 		break;
 	default:
+		ret = -EINVAL;
 		goto free;
 	}
 
-- 
2.15.1
