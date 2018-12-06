Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D50C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1191520989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1191520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeLFHdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:33:31 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:54562 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbeLFHd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:33:28 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E2F7E7F0D8B42B9CAE03;
        Thu,  6 Dec 2018 15:33:25 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB67XMik013184;
        Thu, 6 Dec 2018 15:33:22 +0800 (GMT-8)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120615334773-15085957 ;
          Thu, 6 Dec 2018 15:33:47 +0800 
From:   Cheng Lin <cheng.lin130@zte.com.cn>
To:     mcgrof@kernel.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Cheng Lin <cheng.lin130@zte.com.cn>
Subject: [PATCH] proc/sysctl: fix return error for proc_doulongvec_minmax
Date:   Thu, 6 Dec 2018 15:36:15 +0800
Message-Id: <1544081775-15720-1-git-send-email-cheng.lin130@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-06 15:33:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-06 15:33:11,
        Serialize complete at 2018-12-06 15:33:11
X-MAIL: mse01.zte.com.cn wB67XMik013184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the number of input parameters is less than the total
parameters, an EINVAL error will be returned.

e.g.
We use proc_doulongvec_minmax to pass up to two parameters
with kern_table.

{
	.procname       = "monitor_signals",
	.data           = &monitor_sigs,
	.maxlen         = 2*sizeof(unsigned long),
	.mode           = 0644,
	.proc_handler   = proc_doulongvec_minmax,
},

Reproduce:
When passing two parameters, it's work normal. But passing
only one parameter, an error "Invalid argument"(EINVAL) is
returned.

[root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
[root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
1       2
[root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
-bash: echo: write error: Invalid argument
[root@cl150 ~]# echo $?
1
[root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
3       2
[root@cl150 ~]#

The following is the result after apply this patch. No error
is returned when the number of input parameters is less than
the total parameters.

[root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
[root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
1       2
[root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
[root@cl150 ~]# echo $?
0
[root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
3       2
[root@cl150 ~]#

There are three processing functions dealing with digital parameters,
__do_proc_dointvec/__do_proc_douintvec/__do_proc_doulongvec_minmax.

This patch deals with __do_proc_doulongvec_minmax, just as
__do_proc_dointvec does, adding a check for parameters 'left'. In
__do_proc_douintvec, its code implementation explicitly does not
support multiple inputs.

static int __do_proc_douintvec(...){
         ...
         /*
          * Arrays are not supported, keep this simple. *Do not* add
          * support for them.
          */
         if (vleft != 1) {
                 *lenp = 0;
                 return -EINVAL;
         }
         ...
}

So, just __do_proc_doulongvec_minmax has the problem. And most use of
proc_doulongvec_minmax/proc_doulongvec_ms_jiffies_minmax just have one
parameter.

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
---
 kernel/sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5fc724e..9ee261f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2779,6 +2779,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 			bool neg;
 
 			left -= proc_skip_spaces(&p);
+			if (!left)
+				break;
 
 			err = proc_get_long(&p, &left, &val, &neg,
 					     proc_wspace_sep,
-- 
1.8.3.1

