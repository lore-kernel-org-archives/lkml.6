Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeC1Luf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:50:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45080 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeC1Lua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:50:30 -0400
Date: Wed, 28 Mar 2018 14:48:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] tracing: Uninitialized variable in
 create_tracing_map_fields()
Message-ID: <20180328114815.GC29050@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8845 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=840
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that idx can be used uninitialized when we check if
(idx < 0).  It has to be the first iteration through the loop and the
HIST_FIELD_FL_STACKTRACE bit has to be clear and the HIST_FIELD_FL_VAR
bit has to be set to reach the bug.

Fixes: 30350d65ac56 ("tracing: Add variable support to hist triggers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4f027642ceef..6aceee287d07 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4411,7 +4411,7 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	struct tracing_map *map = hist_data->map;
 	struct ftrace_event_field *field;
 	struct hist_field *hist_field;
-	int i, idx;
+	int i, idx = 0;
 
 	for_each_hist_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
