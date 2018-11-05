Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2729FECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DA82082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wGdGuI7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DA82082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeKESYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKESYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:24:01 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B894D20862;
        Mon,  5 Nov 2018 09:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541408720;
        bh=aRftkZl0b6OKtR28FUy2km529pcMGr1YorisXBFAbdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGdGuI7fEI6CMq2a5mMy4BWA+2oMFaSUROnc3fWkpSxeJgQ9BvdRQg0Zi2CA+tAzv
         pjryAeROA7B12WPzhB8zsdoF6cu9Tjm1Wr+W13xxncV9qbtzBUTxCZzZoGiDQZkmeG
         ZzuAfp6nuFybn9N4UmOLo2xfFvwpF+8MWo3qusow=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 11/12] tracing: Add generic event-name based remove event method
Date:   Mon,  5 Nov 2018 18:04:57 +0900
Message-Id: <154140869774.17322.8887303560398645347.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154140838606.17322.15294184388075458777.stgit@devbox>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic method to remove event from dynamic event
list. This is same as other system under ftrace. You
just need to pass the event name with '!', e.g.

  # echo p:new_grp/new_event _do_fork > dynamic_events

This creates an event, and

  # echo '!p:new_grp/new_event _do_fork' > dynamic_events

Or,

  # echo '!p:new_grp/new_event' > dynamic_events

will remove new_grp/new_event event.

Note that this doesn't check the event prefix (e.g. "p:")
strictly, because the "group/event" name must be unique.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
  - Instead of checking the given entire line strictly,
    simply checking the event and group name.
---
 kernel/trace/trace_dynevent.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index f17a887abb66..dd1f43588d70 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -37,10 +37,17 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 	char *system = NULL, *event, *p;
 	int ret = -ENOENT;
 
-	if (argv[0][1] != ':')
-		return -EINVAL;
+	if (argv[0][0] == '-') {
+		if (argv[0][1] != ':')
+			return -EINVAL;
+		event = &argv[0][2];
+	} else {
+		event = strchr(argv[0], ':');
+		if (!event)
+			return -EINVAL;
+		event++;
+	}
 
-	event = &argv[0][2];
 	p = strchr(event, '/');
 	if (p) {
 		system = event;
@@ -69,7 +76,7 @@ static int create_dyn_event(int argc, char **argv)
 	struct dyn_event_operations *ops;
 	int ret;
 
-	if (argv[0][0] == '-')
+	if (argv[0][0] == '-' || argv[0][0] == '!')
 		return dyn_event_release(argc, argv, NULL);
 
 	mutex_lock(&dyn_event_ops_mutex);

