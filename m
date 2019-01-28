Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C5FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D4B21848
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691141;
	bh=s2x/FYN5aQedI+KecYS8T2oUkEHMmL5lhOFIvumWMcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CYTlNqM4DubuagBfhdbs7WYDxAM8cr5v4HmIQ8PJswGVpylWkr72dMv94tGvIALUZ
	 edLXrrsY9mRnzP4GuUzz5DeJW95x4Z/yuEElnKclEe3k8NkzuTPn7FDpxCNBAjFquk
	 cgzubjVT1S+f+wr2ZI3zrqRAB0F1EfsJ1CxBVui8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfA1P67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfA1P6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C2A2082E;
        Mon, 28 Jan 2019 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691134;
        bh=s2x/FYN5aQedI+KecYS8T2oUkEHMmL5lhOFIvumWMcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqFuhHFn/B5+8j/fKMXv0xVzPRuK3XvKyBDR/AQ76eZdXJXJwfUIRmRwhWBULxXTg
         ZnKstKs7eJKv/SfcQZrZ20hE/BuITwSz8TrkAExEtBkh+N/llmAn8NW/zJlx+GlIdn
         1vqtYS/FSNGoEQuvsAPA4M5w/iGNa2JZ9lueRweI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cheng Lin <cheng.lin130@zte.com.cn>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 298/304] proc/sysctl: fix return error for proc_doulongvec_minmax()
Date:   Mon, 28 Jan 2019 10:43:35 -0500
Message-Id: <20190128154341.47195-298-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Lin <cheng.lin130@zte.com.cn>

[ Upstream commit 09be178400829dddc1189b50a7888495dd26aa84 ]

If the number of input parameters is less than the total parameters, an
EINVAL error will be returned.

For example, we use proc_doulongvec_minmax to pass up to two parameters
with kern_table:

{
	.procname       = "monitor_signals",
	.data           = &monitor_sigs,
	.maxlen         = 2*sizeof(unsigned long),
	.mode           = 0644,
	.proc_handler   = proc_doulongvec_minmax,
},

Reproduce:

When passing two parameters, it's work normal.  But passing only one
parameter, an error "Invalid argument"(EINVAL) is returned.

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

The following is the result after apply this patch.  No error is
returned when the number of input parameters is less than the total
parameters.

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
__do_proc_dointvec does, adding a check for parameters 'left'.  In
__do_proc_douintvec, its code implementation explicitly does not support
multiple inputs.

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

So, just __do_proc_doulongvec_minmax has the problem.  And most use of
proc_doulongvec_minmax/proc_doulongvec_ms_jiffies_minmax just have one
parameter.

Link: http://lkml.kernel.org/r/1544081775-15720-1-git-send-email-cheng.lin130@zte.com.cn
Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5fc724e4e454..9ee261fce89e 100644
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
2.19.1

