Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F076820645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F076820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJNXLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35753 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727170AbeJNXLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0004cW-Ln; Sun, 14 Oct 2018 16:30:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000TQ-Si; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Omar Sandoval" <osandov@fb.com>, "Kenny Yu" <kennyyu@fb.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.640202943@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 231/366] uprobe: Find last occurrence of ':' when
 parsing uprobe PATH:OFFSET
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kenny Yu <kennyyu@fb.com>

commit 6496bb72bf20c1c7e4d6be44dfa663163e709116 upstream.

Previously, `create_trace_uprobe` found the *first* occurence
of the ':' character when parsing `PATH:OFFSET` for a uprobe.
However, if the path contains a ':' character, then the function
would parse the path incorrectly. Even worse, if the path does not
exist, the subsequent call to `kern_path()` would set `ret` to
`ENOENT`, leading to very cryptic errno values in user space.

The fix is to find the *last* occurence of ':'.

How to repro:: The write fails with "No such file or directory", suggesting
incorrectly that the `uprobe_events` file does not exist.

  $ mkdir testing && cd testing
  $ cp /bin/bash .
  $ cp /bin/bash ./bash:with:colon
  $ echo "p:uprobes/p__root_testing_bash_0x6 /root/testing/bash:0x6" > /sys/kernel/debug/tracing/uprobe_events     # this works
  $ echo "p:uprobes/p__root_testing_bash_with_colon_0x6 /root/testing/bash:with:colon:0x6" >> /sys/kernel/debug/tracing/uprobe_events     # this doesn't
  -bash: echo: write error: No such file or directory

With the patch:

  $ echo "p:uprobes/p__root_testing_bash_0x6 /root/testing/bash:0x6" > /sys/kernel/debug/tracing/uprobe_events     # this still works
  $ echo "p:uprobes/p__root_testing_bash_with_colon_0x6 /root/testing/bash:with:colon:0x6" >> /sys/kernel/debug/tracing/uprobe_events     # this works now too!
  $ cat /sys/kernel/debug/tracing/uprobe_events
  p:uprobes/p__root_testing_bash_0x6 /root/testing/bash:0x0000000000000006
  p:uprobes/p__root_testing_bash_with_colon_0x6 /root/testing/bash:with:colon:0x0000000000000006

Link: http://lkml.kernel.org/r/20170113165834.4081016-1-kennyyu@fb.com

Signed-off-by: Kenny Yu <kennyyu@fb.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_uprobe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -430,7 +430,8 @@ static int create_trace_uprobe(int argc,
 		pr_info("Probe point is not specified.\n");
 		return -EINVAL;
 	}
-	arg = strchr(argv[1], ':');
+	/* Find the last occurrence, in case the path contains ':' too. */
+	arg = strrchr(argv[1], ':');
 	if (!arg) {
 		ret = -EINVAL;
 		goto fail_address_parse;

