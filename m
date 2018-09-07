Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA892C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EFB20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EFB20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeIHCZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbeIHCZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93FFDC9A;
        Fri,  7 Sep 2018 21:43:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Snild Dolkow <snild@sony.com>
Subject: [PATCH 3.18 12/29] kthread, tracing: Dont expose half-written comm when creating kthreads
Date:   Fri,  7 Sep 2018 23:10:33 +0200
Message-Id: <20180907210910.439637078@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Snild Dolkow <snild@sony.com>

commit 3e536e222f2930534c252c1cc7ae799c725c5ff9 upstream.

There is a window for racing when printing directly to task->comm,
allowing other threads to see a non-terminated string. The vsnprintf
function fills the buffer, counts the truncated chars, then finally
writes the \0 at the end.

	creator                     other
	vsnprintf:
	  fill (not terminated)
	  count the rest            trace_sched_waking(p):
	  ...                         memcpy(comm, p->comm, TASK_COMM_LEN)
	  write \0

The consequences depend on how 'other' uses the string. In our case,
it was copied into the tracing system's saved cmdlines, a buffer of
adjacent TASK_COMM_LEN-byte buffers (note the 'n' where 0 should be):

	crash-arm64> x/1024s savedcmd->saved_cmdlines | grep 'evenk'
	0xffffffd5b3818640:     "irq/497-pwr_evenkworker/u16:12"

...and a strcpy out of there would cause stack corruption:

	[224761.522292] Kernel panic - not syncing: stack-protector:
	    Kernel stack is corrupted in: ffffff9bf9783c78

	crash-arm64> kbt | grep 'comm\|trace_print_context'
	#6  0xffffff9bf9783c78 in trace_print_context+0x18c(+396)
	      comm (char [16]) =  "irq/497-pwr_even"

	crash-arm64> rd 0xffffffd4d0e17d14 8
	ffffffd4d0e17d14:  2f71726900000000 5f7277702d373934   ....irq/497-pwr_
	ffffffd4d0e17d24:  726f776b6e657665 3a3631752f72656b   evenkworker/u16:
	ffffffd4d0e17d34:  f9780248ff003231 cede60e0ffffff9b   12..H.x......`..
	ffffffd4d0e17d44:  cede60c8ffffffd4 00000fffffffffd4   .....`..........

The workaround in e09e28671 (use strlcpy in __trace_find_cmdline) was
likely needed because of this same bug.

Solved by vsnprintf:ing to a local buffer, then using set_task_comm().
This way, there won't be a window where comm is not terminated.

Link: http://lkml.kernel.org/r/20180726071539.188015-1-snild@sony.com

Cc: stable@vger.kernel.org
Fixes: bc0c38d139ec7 ("ftrace: latency tracer infrastructure")
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Snild Dolkow <snild@sony.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[backported to 3.18 / 4.4 by Snild]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/kthread.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -309,10 +309,16 @@ struct task_struct *kthread_create_on_no
 	task = create->result;
 	if (!IS_ERR(task)) {
 		static const struct sched_param param = { .sched_priority = 0 };
+		char name[TASK_COMM_LEN];
 		va_list args;
 
 		va_start(args, namefmt);
-		vsnprintf(task->comm, sizeof(task->comm), namefmt, args);
+		/*
+		 * task is already visible to other tasks, so updating
+		 * COMM must be protected.
+		 */
+		vsnprintf(name, sizeof(name), namefmt, args);
+		set_task_comm(task, name);
 		va_end(args);
 		/*
 		 * root may have changed our (kthreadd's) priority or CPU mask.


