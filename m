Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeCFL7u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:59:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbeCFL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:59:33 -0500
Date: Tue, 6 Mar 2018 12:59:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com
Subject: Re: [RFC 3/4] trace_uprobe: Support SDT markers having semaphore
Message-ID: <20180306115921.GD25201@hirez.programming.kicks-ass.net>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228075345.674-4-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228075345.674-4-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 01:23:44PM +0530, Ravi Bangoria wrote:
> Userspace Statically Defined Tracepoints[1] are dtrace style markers
> inside userspace applications. These markers are added by developer at
> important places in the code. Each marker source expands to a single
> nop instruction in the compiled code but there may be additional
> overhead for computing the marker arguments which expands to couple of
> instructions. If this computaion is quite more, execution of it can be
> ommited by runtime if() condition when no one is tracing on the marker:
> 
>     if (semaphore > 0) {
>         Execute marker instructions;
>     }   
> 
> Default value of semaphore is 0. Tracer has to increment the semaphore
> before recording on a marker and decrement it at the end of tracing.
> 
> Implement the semaphore flip logic in trace_uprobe, leaving core uprobe
> infrastructure as is, except one new callback from uprobe_mmap() to
> trace_uprobe.

W.T.H. is that called a semaphore? afaict its just a usage-counter.
There is no blocking, no releasing, nothing that would make it an actual
semaphore.

So please, remove all mention of semaphore from this code, because it,
most emphatically, is not one.

Also, would it not be much better to do userspace jump-labels for this?
That completely avoids the dynamic branch at the SDT site.
