Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932577AbeCOPlf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:41:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:36825 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751918AbeCOPlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:41:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="25540547"
Date: Thu, 15 Mar 2018 17:37:34 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Joe Perches <joe@perches.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
Message-ID: <20180315153734.GT5453@intel.com>
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
 <20180315133026.GR5453@intel.com>
 <1b50f5d8-97a6-2442-34bb-2782c35505fd@linux.intel.com>
 <20180315150524.GS5453@intel.com>
 <1521127073.22221.13.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521127073.22221.13.camel@perches.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 08:17:53AM -0700, Joe Perches wrote:
> On Thu, 2018-03-15 at 17:05 +0200, Ville Syrjälä wrote:
> > On Thu, Mar 15, 2018 at 03:04:52PM +0100, Maarten Lankhorst wrote:
> > > Op 15-03-18 om 14:30 schreef Ville Syrjälä:
> > > > On Tue, Mar 13, 2018 at 03:02:15PM -0700, Joe Perches wrote:
> > > > > drm_printk is used for both DRM_ERROR and DRM_DEBUG with unnecessary
> > > > > arguments that can be removed by creating separate functins.
> > > > > 
> > > > > Create specific functions for these calls to reduce x86/64 defconfig
> > > > > size by ~20k.
> > > > > 
> > > > > Modify the existing macros to use the specific calls.
> > > > > 
> > > > > new:
> > > > > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > > > > 1876562	  44542	    995	1922099	 1d5433	(TOTALS)
> > > > > 
> > > > > old:
> > > > > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > > > > 1897565	  44542	    995	1943102	 1da63e	(TOTALS)
> > > > > 
> > > > > Miscellanea:
> > > > > 
> > > > > o intel_display requires a change to use the specific calls.
> > > > 
> > > > How much would we lose if we move the (drm_debug&FOO) outside the
> > > > functions again?
> 
> again?

We used to do that. Someone changed it a while back, unintentially
I believe.

> 
> > > >  I'm somewhat concerned about all the function call
> > > > overhead when debugs aren't even enabled.
> 
> Perhaps better to have compilation elimination
> of the entire debug output instead.

That would require every bug reporter to recompile the kernel first.
So this is not a solution we would ever seriously consider.

Not sure if it would be possible to use the alternatives thing to
eliminate the function calls unless the user boots wih drm.debug!=0?

> 
> I think you are discussing a different issue and
> this discussion should not block this patch as
> this patch has no impact other than code size
> reduction.

But what is the goal of the code size reduction? I assume the main
goal is to make better use of the instruction cache to make the
code faster. If there's a tradeoff between smaller and slightly
faster vs. larger and a singificantly faster I tend to think we
should go for the latter option.

-- 
Ville Syrjälä
Intel OTC
