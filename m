Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC111C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A759214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A759214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbeKLGQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50824 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730606AbeKLFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000l6-F5; Sun, 11 Nov 2018 19:58:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001mv-IZ; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Snild Dolkow" <snild@sony.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.673358820@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 298/366] kthread, tracing: Don't expose half-written
 comm when creating kthreads
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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

Fixes: bc0c38d139ec7 ("ftrace: latency tracer infrastructure")
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Snild Dolkow <snild@sony.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/kthread.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -309,10 +309,16 @@ struct task_struct *kthread_create_on_no
 	if (!IS_ERR(task)) {
 		static const struct sched_param param = { .sched_priority = 0 };
 		va_list args;
+		char name[TASK_COMM_LEN];
 
+		/*
+		 * task is already visible to other tasks, so updating
+		 * COMM must be protected.
+		 */
 		va_start(args, namefmt);
-		vsnprintf(task->comm, sizeof(task->comm), namefmt, args);
+		vsnprintf(name, sizeof(name), namefmt, args);
 		va_end(args);
+		set_task_comm(task, name);
 		/*
 		 * root may have changed our (kthreadd's) priority or CPU mask.
 		 * The kernel thread should not inherit these properties.

