Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeFAQKj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:10:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:12177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbeFAQKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:10:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="59588705"
Date: Sat, 2 Jun 2018 00:12:13 +0800
From: Feng Tang <feng.tang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        alek.du@intel.com, pasha.tatashin@oracle.com, arjan@linux.intel.com
Subject: Re: [RFC 2/2] x86, tsc: Enable clock for ealry printk timestamp
Message-ID: <20180601161213.tm44nhrhwfxa2767@shbuild888>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <1527672059-6225-2-git-send-email-feng.tang@intel.com>
 <20180531135542.4j7w7bxsw43ydx3j@pathway.suse.cz>
 <20180531155210.GL12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531155210.GL12180@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Petr,

Thanks for your suggestions, will try to find a cleaner and less hacky way,
and it may take some time as dealing with all kinds of TSC is tricky :)

- Feng

On Thu, May 31, 2018 at 05:52:10PM +0200, Peter Zijlstra wrote:
> On Thu, May 31, 2018 at 03:55:42PM +0200, Petr Mladek wrote:
> > I wonder if we could get some cleaner integration into the timer and
> > printk code.
> 
> Yes, these patches are particularly horrific..
> 
> There were some earlier patches by Pavel Tatashin, which attempted do
> get things running earlier.
> 
>   http://lkml.kernel.org/r/20180209211143.16215-1-pasha.tatashin@oracle.com
> 
> I'm not entirely happy with that, but I never did get around to
> reviewing that last version :-( In particuarly, now that you made me
> look, I dislike his patch 6 almost as much as these patches.
> 
> The idea was to get regular sched_clock() running earlier, not to botch
> some early_sched_clock() into it.
> 
> Basically run calibrate_tsc() earlier (like _waaay_ earlier, it doesn't
> rely on anything other than CPUID) and if you have a recent part (with
> exception of SKX) you'll get a usable tsc rate (and TSC_RELIABLE) and
> things will work.
> 
> If you have a dodgy part (sorry SKX), you'll just have to live with
> sched_clock starting late(r).
> 
> Do not cobble things on the side, try and get the normal things running
> earlier.
