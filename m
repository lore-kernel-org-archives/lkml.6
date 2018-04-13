Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeDMSzU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 14:55:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750839AbeDMSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 14:55:19 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig102.frc2.facebook.com
To: <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <vincent.weaver@maine.edu>,
        Song Liu <songliubraving@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Smtp-Origin-Cluster: frc2c02
Subject: [PATCH] trace_kprobe: Remove warning message "Could not insert probe at..."
Date: Fri, 13 Apr 2018 11:55:13 -0700
Message-ID: <20180413185513.3626052-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning message is not very helpful, as the return value should
already show information about the error. Also, this message will
flush dmesg if the user space do something silly in a loop, like:

    for x in {0..5}
    do
        echo p:xx xx+$x >> /sys/kernel/debug/tracing/kprobe_events
    done

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/trace/trace_kprobe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1cd3fb4..02aed76 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -512,8 +512,6 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (ret == 0)
 		tk->tp.flags |= TP_FLAG_REGISTERED;
 	else {
-		pr_warn("Could not insert probe at %s+%lu: %d\n",
-			trace_kprobe_symbol(tk), trace_kprobe_offset(tk), ret);
 		if (ret == -ENOENT && trace_kprobe_is_on_module(tk)) {
 			pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
 			ret = 0;
-- 
2.9.5
