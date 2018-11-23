Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF23C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EB2206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IOvGqfIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EB2206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502026AbeKWQyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:54:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43173 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeKWQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 11:54:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so2607782pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 22:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hvP9WYXIg/P90MnU6ooiGy94rkZJGJ7qHsKoPd4V5h0=;
        b=IOvGqfIoAVK2JQUtHKcco5SDlXX3sGKrUEXAME2q1pg9raQPMeFtqaomDdlhmARPMk
         HiBx0ePiCVvXFZdjIxbnpXvDA28PiuAsG2Iey9qqEq7OypoTg36cUd9cHstNIu3YWXmn
         3e2pvaJfBa0IuH7bCL8HHnqNdbSjxK2PvkiZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hvP9WYXIg/P90MnU6ooiGy94rkZJGJ7qHsKoPd4V5h0=;
        b=gb9WX3WKdiGOvPQ2Y8/UzfBYFLvirh3yvZ4kTtR5UqGX+LQn/ZjcCdmJJ6grlkKtrf
         54dVpSa61VLQv36DcmUh8tmsA0AGoZBvkMHYraDdPiZsU+aBFTUHbe6VONj9OiVfveeD
         tkvP40R3Din7j13TzRjUOAI7W7Ees/OQXdc6d//MF3a/m/eEohkYIBfJZytKvNs7yi0w
         1juwpA7orpOi4/WgnGBR8Nn+RRh8ZXC86BNEInrquZFbTMaHik8Q8BGg4+M0Bh4fURVY
         jqmvMCvIYVJiIu5ynpvQexI+7lNKVZGX5eeFESek2w3MEEH4n4Jg798PIZnSyin27zpW
         5cSw==
X-Gm-Message-State: AGRZ1gLIK3mrBEPnP/QA1QihxXrO4c1kklSCktKcKXeHh6UnRSjR+NnX
        pR2SS5MTF2zys/xEYv/HW+058Q==
X-Google-Smtp-Source: AJdET5dRG1i2sjjlwytbYL81s1cFCFn3i1cY40eC9GLQTpXjmF4EA4/csJiyGCLFX64GWoLdd9ZLpQ==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr14365556pfj.58.1542953495814;
        Thu, 22 Nov 2018 22:11:35 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 12sm17172870pgd.35.2018.11.22.22.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 22:11:34 -0800 (PST)
Date:   Thu, 22 Nov 2018 22:11:33 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 06/14] fgraph: Move function graph specific code
 into fgraph.c
Message-ID: <20181123061133.GA195223@google.com>
References: <20181122012708.491151844@goodmis.org>
 <20181122012803.442190047@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122012803.442190047@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:27:14PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> To make the function graph infrastructure more managable, the code needs to
> be in its own file (fgraph.c). Move the code that is specific for managing
> the function graph infrastructure out of ftrace.c and into fgraph.c
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I think this patch causes a build error if CONFIG_FUNCTION_PROFILER is
disabled but function graph is enabled. The following diff fixes it for me.

thanks,

 - Joel

 ----8<------
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3b8c307c7ff0..ce38bb962f91 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -382,6 +382,15 @@ static void ftrace_update_pid_func(void)
 	update_ftrace_function();
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+static bool fgraph_graph_time = true;
+
+void ftrace_graph_graph_time_control(bool enable)
+{
+	fgraph_graph_time = enable;
+}
+#endif
+
 #ifdef CONFIG_FUNCTION_PROFILER
 struct ftrace_profile {
 	struct hlist_node		node;
@@ -783,12 +792,6 @@ function_profile_call(unsigned long ip, unsigned long parent_ip,
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-static bool fgraph_graph_time = true;
-
-void ftrace_graph_graph_time_control(bool enable)
-{
-	fgraph_graph_time = enable;
-}
 
 static int profile_graph_entry(struct ftrace_graph_ent *trace)
 {
