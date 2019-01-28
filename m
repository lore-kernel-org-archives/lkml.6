Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26810C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A262177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691909;
	bh=MIgTnXGdvwAhlNFEad+tgQmYeP2RKNUoasDWZ1D5/xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPLTtK2IoyaEW8f0A0cOvJSjt0uGdez3pbqwwuUtvVVvOHvqRzKQrXYV8NaLwWRGh
	 Yh01Sn/t18ay7pqAKJtoMKNTqfA9Wi3Foc5hh5vBnkOa7zuyCoOYbviT9bae/r/ayr
	 B1ftc6kV8CmVI9ZKW2FiLKp9H6Fee/cqU2BQkXU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfA1QLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732600AbfA1QLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:11:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C31B2177E;
        Mon, 28 Jan 2019 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691902;
        bh=MIgTnXGdvwAhlNFEad+tgQmYeP2RKNUoasDWZ1D5/xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSPaXK8+jAypxU1RId/XngBneIYDM/Y2f2yiDrGjdl+IF5qyyI2ivw4fVaIIOzGGZ
         fiRQy1oJQnYIfb5BisbhcoDiUjhY+P/5I6A2WRAZjaexT98mgie/yNwn1ZTk7C3tD7
         rvT5BSuCOPQU3SdQeCHBItkUmeBUyWE0VV0vYhc4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cheng Lin <cheng.lin130@zte.com.cn>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 253/258] proc/sysctl: fix return error for proc_doulongvec_minmax()
Date:   Mon, 28 Jan 2019 10:59:19 -0500
Message-Id: <20190128155924.51521-253-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index cc02050fd0c4..32dea29d05a0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2767,6 +2767,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 			bool neg;
 
 			left -= proc_skip_spaces(&p);
+			if (!left)
+				break;
 
 			err = proc_get_long(&p, &left, &val, &neg,
 					     proc_wspace_sep,
-- 
2.19.1

