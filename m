Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBJOJU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:09:20 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:45699 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeBJOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:09:19 -0500
Date: Sat, 10 Feb 2018 15:09:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH V3 1/5] perf/x86/intel: fix event update for auto-reload
Message-ID: <20180210140910.GQ25201@hirez.programming.kicks-ass.net>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <1517243373-355481-2-git-send-email-kan.liang@linux.intel.com>
 <20180206150648.GK2249@hirez.programming.kicks-ass.net>
 <ae4c7aff-da12-8cb3-4fac-4637ab001060@linux.intel.com>
 <20180209140905.GG25181@hirez.programming.kicks-ass.net>
 <cafc7994-bb39-14a3-ad20-1357d688a7ff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cafc7994-bb39-14a3-ad20-1357d688a7ff@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 10:49:35AM -0500, Liang, Kan wrote:
> 
> 
> On 2/9/2018 9:09 AM, Peter Zijlstra wrote:
> > On Tue, Feb 06, 2018 at 12:58:23PM -0500, Liang, Kan wrote:
> > > 
> > > 
> > > > With the exception of handling 'empty' buffers, I ended up with the
> > > > below. Please try again.
> > > > 
> > > 
> > > There are two small errors. After fixing them, the patch works well.
> > 
> > Well, it still doesn't do A, two read()s without PEBS record in between.
> > So that needs fixing. What 3/5 does, call x86_perf_event_update() after
> > drain_pebs() is actively wrong after this patch.
> > 
> 
> As my understanding, for case A, drain_pebs() will return immediately. It
> cannot reach the patch.
> Because there is no PEBS record ready. So the ds->pebs_index should be the
> same as ds->pebs_buffer_base.

Right, so fix that.

> 3/5 is to handle case A.

3/5 is terminatlly broken, you should not call x86_perf_event_update()
on a auto-reload event _ever_ after my patch.
