Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8EFC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163292086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163292086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeK0Eiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:38:55 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:41674 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbeK0Eiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:38:55 -0500
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 7DFDF1C2E63
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:44:04 +0000 (GMT)
Received: (qmail 10025 invoked from network); 26 Nov 2018 17:44:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Nov 2018 17:44:04 -0000
Date:   Mon, 26 Nov 2018 17:44:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: Hackbench pipes regression bisected to PSI
Message-ID: <20181126174402.GR23260@techsingularity.net>
References: <20181126133420.GN23260@techsingularity.net>
 <20181126160724.GA21268@cmpxchg.org>
 <20181126165446.GQ23260@techsingularity.net>
 <20181126173218.GA22640@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181126173218.GA22640@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:32:18PM -0500, Johannes Weiner wrote:
> On Mon, Nov 26, 2018 at 04:54:47PM +0000, Mel Gorman wrote:
> > On Mon, Nov 26, 2018 at 11:07:24AM -0500, Johannes Weiner wrote:
> > > @@ -509,6 +509,15 @@ config PSI
> > >  
> > >  	  Say N if unsure.
> > >  
> > > +config PSI_DEFAULT_DISABLED
> > > +	bool "Require boot parameter to enable pressure stall information tracking"
> > > +	default n
> > > +	depends on PSI
> > > +	help
> > > +	  If set, pressure stall information tracking will be disabled
> > > +	  per default but can be enabled through passing psi_enable=1
> > > +	  on the kernel commandline during boot.
> > > +
> > >  endmenu # "CPU/Task time and stats accounting"
> > >  
> > 
> > Should this default y on the basis that someone only wants the feature if
> > they are aware of it? This is not that important as CONFIG_PSI is disabled
> > by default and it's up to distribution maintainers to use their brain.
> 
> I went with the NUMA balancing example again here, which defaults to
> enabling the feature at boot time. IMO that makes sense, as somebody
> would presumably first read through the PSI help text, then decide y
> on that before being asked the second question. A "yes, but
> <stipulations>" for vendor kernels seems more appropriate than
> requiring a double yes for other users to simply get the feature.
> 

That's fair enough. The original NUMA balancing thinking was that it
should be enabled because there is a reasonable expectation that it
would improve performance regardless of user awareness. PSI is not
necessarily the same as it requires a consumer but I accept that a
distro maintainer should read the Kconfig text and figure it out.

I'll make sure the updated version gets tested, thanks.

-- 
Mel Gorman
SUSE Labs
