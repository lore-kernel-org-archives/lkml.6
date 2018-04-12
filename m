Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeDLGm0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:42:26 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:48659 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752125AbeDLGmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:42:24 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2563:2682:2685:2689:2692:2693:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6742:7903:9025:10004:10400:10848:11232:11658:11914:12043:12555:12663:12679:12740:12760:12895:13069:13141:13161:13229:13230:13255:13311:13357:13439:13845:14096:14097:14181:14659:14721:21080:21324:21326:21627:30034:30054:30060:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: cows04_31b147349af5c
X-Filterd-Recvd-Size: 3105
Message-ID: <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 11 Apr 2018 23:42:20 -0700
In-Reply-To: <alpine.DEB.2.20.1804120816130.3559@hadrien>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
          <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
          <20180410123305.GF4082@hirez.programming.kicks-ass.net>
          <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
          <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
          <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
          <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
          <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
          <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
          <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
         <1c9f185f6086e9d89659f93720a27b660ee17c13.camel@perches.com>
         <alpine.DEB.2.20.1804120816130.3559@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-12 at 08:22 +0200, Julia Lawall wrote:
> On Wed, 11 Apr 2018, Joe Perches wrote:
> > On Wed, 2018-04-11 at 09:29 -0700, Andrew Morton wrote:
> > > We already have some 500 bools-in-structs
> > 
> > I got at least triple that only in include/
> > so I expect there are at probably an order
> > of magnitude more than 500 in the kernel.
> > 
> > I suppose some cocci script could count the
> > actual number of instances.  A regex can not.
> 
> I got 12667.

Could you please post the cocci script?

> I'm not sure to understand the issue.  Will using a bitfield help if there
> are no other bitfields in the structure?

IMO, not really.

The primary issue is described by Linus here:
https://lkml.org/lkml/2017/11/21/384

I personally do not find a significant issue with
uncontrolled sizes of bool in kernel structs as
all of the kernel structs are transitory and not
written out to storage.

I suppose bool bitfields are also OK, but for the
RMW required.

Using unsigned int :1 bitfield instead of bool :1
has the negative of truncation so that the uint
has to be set with !! instead of a simple assign.
