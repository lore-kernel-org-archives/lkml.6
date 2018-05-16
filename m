Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeEPKiC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752505AbeEPKiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:38:00 -0400
Date: Wed, 16 May 2018 06:37:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC][PATCH 06/10] tracing: Add trigger file for trace_markers
 tracefs/ftrace/print
Message-ID: <20180516063757.7d5a1ca5@gandalf.local.home>
In-Reply-To: <20180516074904.GA30309@danjae.aot.lge.com>
References: <20180511194927.190877137@goodmis.org>
        <20180511195340.876528094@goodmis.org>
        <20180514031322.GB9220@sejong>
        <20180514110436.336b214b@gandalf.local.home>
        <20180516074904.GA30309@danjae.aot.lge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 16:49:04 +0900
Namhyung Kim <namhyung@kernel.org> wrote:


> > Which will do:
> > 
> >   event_trigger_write() {
> >     event_trigger_regex_write() {
> >       trigger_process_regex() {
> >         for p in trigger_commands {
> >           p->func(); /* trigger_snapshot_cmd->func */
> >             event_trigger_callback() {
> >               cmd_ops->reg() /* register_trigger() */ {
> >                 trace_event_trigger_enable_disable() {
> >                   trace_event_enable_disable() {
> >                     call->class->reg();
> > 
> > Without this patch, we jump to NULL and BOOM!  
> 
> Thanks for the explanation.  I wonder we can skip calling
> trace_event_enable_disable() for events which have the
> TRACE_EVENT_FL_IGNORE_ENABLE flag.

Sounds like something we can do in the future. I rather have do the
minimal now as it will have the least side effects, and it's already
getting late in the current rc series. I'm looking to get this into the
next merge window.

But after that, changing it this way would be a nice clean up.

-- Steve
