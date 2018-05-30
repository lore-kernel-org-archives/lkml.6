Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeE3XJv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932416AbeE3XJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:09:47 -0400
Date: Thu, 31 May 2018 08:09:41 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH v3 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Message-Id: <20180531080941.fd02980b7fd9aac015dbfd73@kernel.org>
In-Reply-To: <20180528212055.21e24c52@vmware.local.home>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.246539183@goodmis.org>
        <20180523231331.bf69453f05478e11b00451ab@kernel.org>
        <20180525140731.07d7543a@gandalf.local.home>
        <20180525171229.76bae7a8@gandalf.local.home>
        <20180525171353.53b44f5e@gandalf.local.home>
        <20180528013258.59715b8111d3e59319006cd2@kernel.org>
        <20180528212055.21e24c52@vmware.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018 21:20:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 28 May 2018 01:32:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Fri, 25 May 2018 17:13:53 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 25 May 2018 17:12:29 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > >    
> > > > #!/bin/sh  
> > > 
> > > Hmm, I think I need to make this #!/bin/bash
> > >   
> > > > test_trace() {
> > > >     file=$1
> > > >     x=$2
> > > > 
> > > >     cat $file | while read line; do
> > > > 	if [ "$line" != "${line/\#/}" ]; then
> > > > 	    continue
> > > > 	fi
> > > > 	echo "testing $line for >$x<"
> > > > 	if [ "$line" == "${line/>$x</}" ]; then  
> > > 
> > > The ${line/>$x</} is unique to bash I believe.  
> > 
> > Hmm, could you try to use only posix-shell based test ?
> > Since I would like to keep this can run on small 
> > environment, like busybox, etc.
> >
> 
> Like something like this?

This looks good to me. :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> -- Steve
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
> index c6c50a2..3a3c33d 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
> @@ -41,11 +41,13 @@ test_trace() {
>      x=$2
>  
>      cat $file | while read line; do
> -	if [ "$line" != "${line/\#/}" ]; then
> +	comment=`echo $line | sed -e 's/^#//'`
> +	if [ "$line" != "$comment" ]; then
>  	    continue
>  	fi
>  	echo "testing $line for >$x<"
> -	if [ "$line" == "${line/>$x</}" ]; then
> +	match=`echo $line | sed -e "s/>$x<//"`
> +	if [ "$line" == "$match" ]; then
>  	    fail "$line does not have >$x< in it"
>  	fi
>  	let x=$x+2


-- 
Masami Hiramatsu <mhiramat@kernel.org>
