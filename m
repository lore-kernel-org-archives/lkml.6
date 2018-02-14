Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966340AbeBNAxR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 19:53:17 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:46731 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966220AbeBNAxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 19:53:15 -0500
X-Google-Smtp-Source: AH8x226at68v+vVrgpcLpyZrbOsjczpOrBcYHMowltPZ3MQouL/ZmuQe86kTatZIxHMjs5ibAbplRg==
Date: Tue, 13 Feb 2018 16:53:12 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Mike Kravetz <mike.kravetz@oracle.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
In-Reply-To: <a064d937-5746-3e14-bb63-5ff9d845a428@oracle.com>
Message-ID: <alpine.DEB.2.10.1802131651140.69963@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <a064d937-5746-3e14-bb63-5ff9d845a428@oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Mike Kravetz wrote:

> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1825,30 +1825,30 @@
> >  	keepinitrd	[HW,ARM]
> >  
> >  	kernelcore=	[KNL,X86,IA-64,PPC]
> > -			Format: nn[KMGTPE] | "mirror"
> > -			This parameter
> > -			specifies the amount of memory usable by the kernel
> > -			for non-movable allocations.  The requested amount is
> > -			spread evenly throughout all nodes in the system. The
> > -			remaining memory in each node is used for Movable
> > -			pages. In the event, a node is too small to have both
> > -			kernelcore and Movable pages, kernelcore pages will
> > -			take priority and other nodes will have a larger number
> > -			of Movable pages.  The Movable zone is used for the
> > -			allocation of pages that may be reclaimed or moved
> > -			by the page migration subsystem.  This means that
> > -			HugeTLB pages may not be allocated from this zone.
> > -			Note that allocations like PTEs-from-HighMem still
> > -			use the HighMem zone if it exists, and the Normal
> > -			zone if it does not.
> > -
> > -			Instead of specifying the amount of memory (nn[KMGTPE]),
> > -			you can specify "mirror" option. In case "mirror"
> > +			Format: nn[KMGTPE] | nn% | "mirror"
> > +			This parameter specifies the amount of memory usable by
> > +			the kernel for non-movable allocations.  The requested
> > +			amount is spread evenly throughout all nodes in the
> > +			system as ZONE_NORMAL.  The remaining memory is used for
> > +			movable memory in its own zone, ZONE_MOVABLE.  In the
> > +			event, a node is too small to have both ZONE_NORMAL and
> > +			ZONE_MOVABLE, kernelcore memory will take priority and
> > +			other nodes will have a larger ZONE_MOVABLE.
> > +
> > +			ZONE_MOVABLE is used for the allocation of pages that
> > +			may be reclaimed or moved by the page migration
> > +			subsystem.  This means that HugeTLB pages may not be
> > +			allocated from this zone.  Note that allocations like
> > +			PTEs-from-HighMem still use the HighMem zone if it
> > +			exists, and the Normal zone if it does not.
> 
> I know you are just updating the documentation for the new ability to
> specify a percentage.  However, while looking at this I noticed that
> the existing description is out of date.  HugeTLB pages CAN be treated
> as movable and allocated from ZONE_MOVABLE.
> 
> If you have to respin, could you drop that line while making this change?
> 

Hi Mike,

It's merged in -mm, so perhaps no respin is necessary.  I think a general 
cleanup to this area regarding your work with hugetlb pages would be good.

> > +
> > +			It is possible to specify the exact amount of memory in
> > +			the form of "nn[KMGTPE]", a percentage of total system
> > +			memory in the form of "nn%", or "mirror".  If "mirror"
> >  			option is specified, mirrored (reliable) memory is used
> >  			for non-movable allocations and remaining memory is used
> > -			for Movable pages. nn[KMGTPE] and "mirror" are exclusive,
> > -			so you can NOT specify nn[KMGTPE] and "mirror" at the same
> > -			time.
> > +			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
> > +			are exclusive, so you cannot specify multiple forms.
> >  
> >  	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
> >  			Format: <Controller#>[,poll interval]
> 
> Don't you need to make the same type percentage changes for 'movablecore='?
> 

The majority of the movablecore= documentation simply refers to the 
kernelcore= option as its complement, I'm not sure that we need to go 
in-depth into what the percentage specifiers mean for both options.
