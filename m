Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932559AbeCOPoP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:44:15 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:37591 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932227AbeCOPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:44:13 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1605:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4470:4559:5007:7808:7903:8603:8660:9040:10004:10400:10848:11232:11658:11914:12296:12555:12663:12740:12895:12986:13148:13161:13163:13229:13230:13439:13894:14096:14097:14181:14659:14721:21080:21451:21611:21627:30012:30051:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: coat43_5e31a9a107300
X-Filterd-Recvd-Size: 3945
Message-ID: <1521128645.22221.18.camel@perches.com>
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
From: Joe Perches <joe@perches.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Thu, 15 Mar 2018 08:44:05 -0700
In-Reply-To: <20180315153734.GT5453@intel.com>
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
         <20180315133026.GR5453@intel.com>
         <1b50f5d8-97a6-2442-34bb-2782c35505fd@linux.intel.com>
         <20180315150524.GS5453@intel.com> <1521127073.22221.13.camel@perches.com>
         <20180315153734.GT5453@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 17:37 +0200, Ville Syrjälä wrote:
> On Thu, Mar 15, 2018 at 08:17:53AM -0700, Joe Perches wrote:
> > On Thu, 2018-03-15 at 17:05 +0200, Ville Syrjälä wrote:
> > > On Thu, Mar 15, 2018 at 03:04:52PM +0100, Maarten Lankhorst wrote:
> > > > Op 15-03-18 om 14:30 schreef Ville Syrjälä:
> > > > > On Tue, Mar 13, 2018 at 03:02:15PM -0700, Joe Perches wrote:
> > > > > > drm_printk is used for both DRM_ERROR and DRM_DEBUG with unnecessary
> > > > > > arguments that can be removed by creating separate functins.
> > > > > > 
> > > > > > Create specific functions for these calls to reduce x86/64 defconfig
> > > > > > size by ~20k.
> > > > > > 
> > > > > > Modify the existing macros to use the specific calls.
> > > > > > 
> > > > > > new:
> > > > > > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > > > > > 1876562	  44542	    995	1922099	 1d5433	(TOTALS)
> > > > > > 
> > > > > > old:
> > > > > > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > > > > > 1897565	  44542	    995	1943102	 1da63e	(TOTALS)
> > > > > > 
> > > > > > Miscellanea:
> > > > > > 
> > > > > > o intel_display requires a change to use the specific calls.
> > > > > 
> > > > > How much would we lose if we move the (drm_debug&FOO) outside the
> > > > > functions again?
> > 
> > again?
> 
> We used to do that. Someone changed it a while back, unintentially
> I believe.
> 
> > 
> > > > >  I'm somewhat concerned about all the function call
> > > > > overhead when debugs aren't even enabled.
> > 
> > Perhaps better to have compilation elimination
> > of the entire debug output instead.
> 
> That would require every bug reporter to recompile the kernel first.
> So this is not a solution we would ever seriously consider.
> 
> Not sure if it would be possible to use the alternatives thing to
> eliminate the function calls unless the user boots wih drm.debug!=0?
> 
> > 
> > I think you are discussing a different issue and
> > this discussion should not block this patch as
> > this patch has no impact other than code size
> > reduction.
> 
> But what is the goal of the code size reduction?

Smaller code.

> I assume the main
> goal is to make better use of the instruction cache to make the
> code faster. If there's a tradeoff between smaller and slightly
> faster vs. larger and a singificantly faster I tend to think we
> should go for the latter option.

There's no trade-off in this patch for faster/larger.
This patch is simply smaller.  Smaller is better.

Your faster/larger should be a different patch proposal.
