Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030390AbeEYVMe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030294AbeEYVMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:12:32 -0400
Date: Fri, 25 May 2018 17:12:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Message-ID: <20180525171229.76bae7a8@gandalf.local.home>
In-Reply-To: <20180525140731.07d7543a@gandalf.local.home>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.246539183@goodmis.org>
        <20180523231331.bf69453f05478e11b00451ab@kernel.org>
        <20180525140731.07d7543a@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 14:07:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> > 
> > BTW, would you plan to add simplar test case for the marker?
> > (like just write a marker and read trace log, and run a simple
> >  trigger, like taking a snapshot by marker)  
> 
> I wasn't planning to, but I could.

Like something like this?

I had to remove the "instance" flag because it triggered a bug, that is
unrelated to this patch series. But that's a good thing. It found a
bug :-)

-- Steve

#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# description: trace_marker trigger - test snapshot trigger
# flags:

do_reset() {
    reset_trigger
    echo > set_event
    echo 0 > snapshot
    clear_trace
}

fail() { #msg
    do_reset
    echo $1
    exit_fail
}

if [ ! -f set_event ]; then
    echo "event tracing is not supported"
    exit_unsupported
fi

if [ ! -f snapshot ]; then
    echo "snapshot is not supported"
    exit_unsupported
fi

if [ ! -d events/ftrace/print ]; then
    echo "event trace_marker is not supported"
    exit_unsupported
fi

if [ ! -f events/ftrace/print/trigger ]; then
    echo "event trigger is not supported"
    exit_unsupported
fi

test_trace() {
    file=$1
    x=$2

    cat $file | while read line; do
	if [ "$line" != "${line/\#/}" ]; then
	    continue
	fi
	echo "testing $line for >$x<"
	if [ "$line" == "${line/>$x</}" ]; then
	    fail "$line does not have >$x< in it"
	fi
	let x=$x+2
    done
}

do_reset

echo "Test snapshot trace_marker tigger"

echo 'snapshot' > events/ftrace/print/trigger

# make sure the snapshot is allocated

grep -q 'Snapshot is allocated' snapshot

for i in `seq 1 10` ; do echo "hello >$i<" > trace_marker; done

test_trace trace 1
test_trace snapshot 2

do_reset

exit 0
