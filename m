Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeBIRx3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:53:29 -0500
Received: from gateway23.websitewelcome.com ([192.185.48.104]:29533 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752261AbeBIRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:53:19 -0500
Date: Fri, 9 Feb 2018 11:53:16 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] tracing: Use swap macro in update_max_tr
Message-ID: <20180209175316.GA18720@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1ekCrO-000dNN-2e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:34036
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the swap macro and remove unnecessary variable _buf_.
This makes the code easier to read and maintain. Also, reduces the
stack usage.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/trace/trace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5660853..6dcd740 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1351,8 +1351,6 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 void
 update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 {
-	struct ring_buffer *buf;
-
 	if (tr->stop_count)
 		return;
 
@@ -1366,9 +1364,7 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	arch_spin_lock(&tr->max_lock);
 
-	buf = tr->trace_buffer.buffer;
-	tr->trace_buffer.buffer = tr->max_buffer.buffer;
-	tr->max_buffer.buffer = buf;
+	swap(tr->trace_buffer.buffer, tr->max_buffer.buffer);
 
 	__update_max_tr(tr, tsk, cpu);
 	arch_spin_unlock(&tr->max_lock);
-- 
2.7.4
