Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADECBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF3820894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF3820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeGaARW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbeGaARW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:17:22 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CABC20890;
        Mon, 30 Jul 2018 22:40:12 +0000 (UTC)
Date:   Mon, 30 Jul 2018 18:40:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] tracing: kprobes: Prohibit probing on notrace
 function
Message-ID: <20180730184010.0d5597a1@gandalf.local.home>
In-Reply-To: <153294601436.32740.10557881188933661239.stgit@devbox>
References: <153294598465.32740.17737878083872427008.stgit@devbox>
        <153294601436.32740.10557881188933661239.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 19:20:14 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Prohibit kprobe-events probing on notrace function.
> Since probing on the notrace function can cause recursive
> event call. In most case those are just skipped, but
> in some case it falls into infinit recursive call.
> 
> This protection can be disabled by the kconfig
> CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, but it is highly
> recommended to keep it "n" for normal kernel.
> Note that this is only available if "kprobes on ftrace"
> has been implemented on target arch and
> CONFIG_KPROBES_ON_FTRACE=y.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>

Hi Masami,

Note, I made the following changes for grammar. For the Change log I
have this:

    tracing: kprobes: Prohibit probing on notrace function
    
    Prohibit kprobe-events probing on notrace functions.  Since probing on a
    notrace function can cause a recursive event call. In most cases those are just
    skipped, but in some cases it falls into an infinite recursive call.
    
    This protection can be disabled by the kconfig
    CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, but it is highly recommended to keep it
    "n" for normal kernel builds.  Note that this is only available if "kprobes on
    ftrace" has been implemented on the target arch and CONFIG_KPROBES_ON_FTRACE=y.
    
    Link: http://lkml.kernel.org/r/153294601436.32740.10557881188933661239.stgit@devbox
    
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
    Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>
    [ Slight grammar and spelling fixes ]
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


And this change to the patch:

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 4d4eb15cc7fd..23fc7c9abedb 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -457,7 +457,7 @@ config KPROBE_EVENTS
 	  If you want to use perf tools, this option is strongly recommended.
 
 config KPROBE_EVENTS_ON_NOTRACE
-	bool "Do NOT protect notrace function from kprobe events"
+	bool "Do NOT protect notrace functions from kprobe events"
 	depends on KPROBE_EVENTS
 	depends on KPROBES_ON_FTRACE
 	default n
@@ -465,13 +465,13 @@ config KPROBE_EVENTS_ON_NOTRACE
 	  This is only for the developers who want to debug ftrace itself
 	  using kprobe events.
 
-	  If kprobes can use ftrace instead of breakpoint, ftrace related
-	  functions are protected from kprobe-events to prevent an infinit
-	  recursion or any unexpected execution path which leads to a kernel
-	  crash.
+	  If kprobes is using ftrace to hook to a function instead of a
+	  breakpoint, ftrace related functions are protected from
+	  kprobe-events to prevent an infinite recursion or any unexpected
+	  execution path which would lead to a kernel crash.
 
 	  This option disables such protection and allows you to put kprobe
-	  events on ftrace functions for debugging ftrace by itself.
+	  events on ftrace functions for debugging ftrace itself.
 	  Note that this might let you shoot yourself in the foot.
 
 	  If unsure, say N.


Are you OK with this?

-- Steve
