Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E43C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2768920880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2768920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbeGYAWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388614AbeGYAWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:22:19 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7A920874;
        Tue, 24 Jul 2018 23:13:32 +0000 (UTC)
Date:   Tue, 24 Jul 2018 19:13:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] [BUGFIX] tracing: Fix double free of
 event_trigger_data
Message-ID: <20180724191331.738eb819@gandalf.local.home>
In-Reply-To: <20180724173008.454cdf10@gandalf.local.home>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
        <153149926702.11274.12489440326560729788.stgit@devbox>
        <20180723221006.60cc7aa9@vmware.local.home>
        <20180725000909.6c8b2f3881ee75c4f6bd466b@kernel.org>
        <20180724164959.3cbc1422@gandalf.local.home>
        <20180724173008.454cdf10@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 17:30:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I don't see where ->reg() would return anything but 1 on success. Maybe
> I'm missing something. I'll look some more, but I'm thinking of changing
> ->reg() to return zero on all success, and negative on all errors and  
> just check those results.

Yeah, I'm going to make these changes. That is, all struct
event_command .reg functions will return negative on error, and
zero or positive on everything else. All the checks are going to be
only for the negative value.

But for the bug fix itself, I believe this should do it. Masami, what
do you think?

-- Steve

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d18249683682..8771a27ca60f 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -679,6 +679,8 @@ event_trigger_callback(struct event_command *cmd_ops,
 		goto out_free;
 
  out_reg:
+	/* Up the trigger_data count to make sure reg doesn't free it on failure */
+	event_trigger_init(trigger_ops, trigger_data);
 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
 	/*
 	 * The above returns on success the # of functions enabled,
@@ -687,10 +689,11 @@ event_trigger_callback(struct event_command *cmd_ops,
 	 */
 	if (!ret) {
 		ret = -ENOENT;
-		goto out_free;
-	} else if (ret < 0)
-		goto out_free;
-	ret = 0;
+	} else if (ret > 0)
+		ret = 0;
+
+	/* Down the counter of trigger_data or free it if not used anymore */
+	event_trigger_free(trigger_ops, trigger_data);
  out:
 	return ret;
 
