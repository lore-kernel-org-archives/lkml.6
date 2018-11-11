Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5462C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FA421707
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FA421707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeKLGQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50870 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730392AbeKLFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:27 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000oP-HE; Sun, 11 Nov 2018 19:58:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001mp-Fp; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "kbuild test robot" <lkp@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.968655180@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 297/366] tracing: Quiet gcc warning about maybe
 unused link variable
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

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 2519c1bbe38d7acacc9aacba303ca6f97482ed53 upstream.

Commit 57ea2a34adf4 ("tracing/kprobes: Fix trace_probe flags on
enable_trace_kprobe() failure") added an if statement that depends on another
if statement that gcc doesn't see will initialize the "link" variable and
gives the warning:

 "warning: 'link' may be used uninitialized in this function"

It is really a false positive, but to quiet the warning, and also to make
sure that it never actually is used uninitialized, initialize the "link"
variable to NULL and add an if (!WARN_ON_ONCE(!link)) where the compiler
thinks it could be used uninitialized.

Fixes: 57ea2a34adf4 ("tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_kprobe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -361,7 +361,7 @@ static struct trace_kprobe *find_trace_k
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct ftrace_event_file *file)
 {
-	struct event_file_link *link;
+	struct event_file_link *link = NULL;
 	int ret = 0;
 
 	if (file) {
@@ -387,7 +387,9 @@ enable_trace_kprobe(struct trace_kprobe
 
 	if (ret) {
 		if (file) {
-			list_del_rcu(&link->list);
+			/* Notice the if is true on not WARN() */
+			if (!WARN_ON_ONCE(!link))
+				list_del_rcu(&link->list);
 			kfree(link);
 			tk->tp.flags &= ~TP_FLAG_TRACE;
 		} else {

