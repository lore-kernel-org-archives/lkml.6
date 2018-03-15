Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeCOOsg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:48:36 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:53207 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752201AbeCOOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:48:34 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4559:5007:6119:7903:8531:8603:8985:9025:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12050:12296:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21611:21627:30012:30029:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: snow62_2d58d48886d15
X-Filterd-Recvd-Size: 2566
Message-ID: <1521125310.22221.4.camel@perches.com>
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
From: Joe Perches <joe@perches.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Date: Thu, 15 Mar 2018 07:48:30 -0700
In-Reply-To: <7dac9dbd-b57b-6e37-c1bb-9ab6c2711613@linux.intel.com>
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
         <7dac9dbd-b57b-6e37-c1bb-9ab6c2711613@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 14:22 +0100, Maarten Lankhorst wrote:
> Op 13-03-18 om 23:02 schreef Joe Perches:
> > drm_printk is used for both DRM_ERROR and DRM_DEBUG with unnecessary
> > arguments that can be removed by creating separate functins.
> > 
> > Create specific functions for these calls to reduce x86/64 defconfig
> > size by ~20k.
> > 
> > Modify the existing macros to use the specific calls.
> > 
> > new:
> > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > 1876562	  44542	    995	1922099	 1d5433	(TOTALS)
> > 
> > old:
> > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > 1897565	  44542	    995	1943102	 1da63e	(TOTALS)
[]
> I guess this adds up. Nice reduction. :)

Yup. 1% of all drm object code.

> > diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
[]
> >  
> > -	drm_printk(level, category, "mismatch in %s %pV", name, &vaf);
> > +	if (adjust)
> > +		drm_dbg(DRM_UT_KMS, "mismatch in %s %pV", name, &vaf);
> > +	else
> > +		drm_err("mismatch in %s %pV", name, &vaf);
> 
> Could this use DRM_DEBUG_KMS/DRM_ERROR?
> 
> Rest looks good, so I can fix up if you want.

If want you change something like that, it should be separate patch.

btw: There was  separate patch that also reduced object size
of the drm_dev_printk calls several months ago.  Never applied.

https://lkml.org/lkml/2017/9/25/247

cheers, Joe
