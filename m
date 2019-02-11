Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EB1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36552080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895757;
	bh=9AN8/t67k1Vo7bb8dYquVpBnISjiZbulXm7M2x+kdZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FscY+ucmbcQ1rJOxhxk1fdPyeXZL0KRTeNUqdgNFWS9Iyswd+oRmP7xTrP+j/z+GA
	 YkeWRDsaUZof6z4IQ8LWrXXp9EPjs0Zv50v9ijJZ01stFrclUvveOrxUq0o4rEFNOM
	 XYQdp+OXWEq+R9Q1sC+o96Xv3D1pxQ3fDtj1VJOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbfBKOfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbfBKOfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421EB20844;
        Mon, 11 Feb 2019 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895752;
        bh=9AN8/t67k1Vo7bb8dYquVpBnISjiZbulXm7M2x+kdZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teE128lv+knaeE7k2ezK4uaWyKdraNEPz9VO9CvgxyXpB28nwLr/i5Y3wZkfuPaL9
         vc4lt4Nwt1F+cUeX1+K9fMQPpvo7CGviV+smWSB9uW5iIZwHh370WoGgPYuw1lV498
         VW+7sQY60K0d/W9PUpLEu8IJsNKxxQeThTi5TXm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cheng Lin <cheng.lin130@zte.com.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 284/352] proc/sysctl: fix return error for proc_doulongvec_minmax()
Date:   Mon, 11 Feb 2019 15:18:31 +0100
Message-Id: <20190211141904.998708566@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



