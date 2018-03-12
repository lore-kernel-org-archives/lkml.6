Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCLXws (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932176AbeCLXwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:52:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1011B2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 12 Mar 2018 19:52:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180312195245.346cef71@vmware.local.home>
In-Reply-To: <20180312185414.GA13138@krava>
References: <20180310023442.791997138@goodmis.org>
        <20180310023907.798690563@goodmis.org>
        <20180312151017.GE23111@krava>
        <20180312144001.788380fa@vmware.local.home>
        <20180312185414.GA13138@krava>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018 19:54:14 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Mon, Mar 12, 2018 at 02:40:01PM -0400, Steven Rostedt wrote:
> > On Mon, 12 Mar 2018 16:10:17 +0100
> > Jiri Olsa <jolsa@redhat.com> wrote:
> >   
> > > got it crashed when clearing the filter via 'echo > filter'  
> > 
> > Awesome. I'll go and test this out. Thanks!
> > 
> > Hmm, could you pull my tree and test my branch: ftrace/core. I may have
> > already fixed this but haven't posted the latest (which I'll do before
> > pushing to next).  
> 
> I couldn't apply your patches from mailbox so I used your ftrace/core already
>

Jiri, If you apply the below, does it fix it for you?

-- Steve

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a5a131ec3c9c..4099e141188c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1498,11 +1498,14 @@ static int process_preds(struct trace_event_call *call,
 		return ret;
 	}
 
-	prog = predicate_parse(filter_string, nr_parens, nr_preds,
+	if (!nr_preds) {
+		prog = NULL;
+	} else {
+		prog = predicate_parse(filter_string, nr_parens, nr_preds,
 			       parse_pred, call, pe);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
-
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+	}
 	rcu_assign_pointer(filter->prog, prog);
 	return 0;
 }
