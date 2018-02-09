Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeBIRSr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeBIRSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:18:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A242173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Feb 2018 12:18:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 17/18] tracing: Add indirect to indirect access for
 function based events
Message-ID: <20180209121840.5f96d400@gandalf.local.home>
In-Reply-To: <20180209104758.093d31ad@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231019.582037880@goodmis.org>
        <20180209051301.GE28206@sejong>
        <20180209104758.093d31ad@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018 10:47:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Good catch!
> 
> It should have been:
> 
> 		return process_redirects(arg, val, buf);

Although I need to add this :-p

diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 673336e352be..2690d4e46322 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -562,7 +564,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
                ret = add_arg_redirect(fevent->last_arg, val, 0);
                if (ret)
                        break;
-               return FUNC_STATE_VAR;
+               return FUNC_STATE_BRACKET_END;
 
        case FUNC_STATE_REDIRECT_BRACKET:
                if (WARN_ON(!fevent->last_arg))
@@ -656,6 +658,7 @@ static unsigned long process_redirects(struct func_arg *arg, unsigned long val,
                        ret = probe_kernel_read(buf, (void *)val, sizeof(long));
                        if (ret)
                                return 0;
+                       val = *(unsigned long *)buf;
                }
        }
        return val;

Because it wasn't parsing properly, and then not getting the redirect.

-- Steve
