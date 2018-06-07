Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SsqGJQBqGVtWOQAAmS7hNA
	; Thu, 07 Jun 2018 17:23:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C0A08608BA; Thu,  7 Jun 2018 17:23:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3E844605A2;
	Thu,  7 Jun 2018 17:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E844605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933571AbeFGRXN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:23:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932591AbeFGRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:23:12 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57HKlrH018065
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 10:23:11 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jf896056m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:23:11 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.20) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Jun
 2018 10:23:10 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)  id
 51FC07605DB; Thu,  7 Jun 2018 10:23:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To: "David S . Miller" <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <mcgrof@kernel.org>,
        <netdev@vger.kernel.org>, <dvyukov@google.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH net-next] umh: fix race condition
Date: Thu, 7 Jun 2018 10:23:10 -0700
Message-ID: <20180607172310.3121039-1-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan reported use-after-free:
BUG: KASAN: use-after-free in call_usermodehelper_exec_work+0x2d3/0x310 kernel/umh.c:195
Write of size 4 at addr ffff8801d9202370 by task kworker/u4:2/50
Workqueue: events_unbound call_usermodehelper_exec_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
 __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
 call_usermodehelper_exec_work+0x2d3/0x310 kernel/umh.c:195
 process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
 worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
 kthread+0x345/0x410 kernel/kthread.c:240
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

The reason is that 'sub_info' cannot be accessed out of parent task
context, since it will be freed by the child.
Instead remember the pid in the child task.

Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")
Reported-by: syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/umh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index 30db93fd7e39..c449858946af 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -99,6 +99,7 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
+	sub_info->pid = task_pid_nr(current);
 	if (sub_info->file)
 		retval = do_execve_file(sub_info->file,
 					sub_info->argv, sub_info->envp);
@@ -191,8 +192,6 @@ static void call_usermodehelper_exec_work(struct work_struct *work)
 		if (pid < 0) {
 			sub_info->retval = pid;
 			umh_complete(sub_info);
-		} else {
-			sub_info->pid = pid;
 		}
 	}
 }
-- 
2.9.5
