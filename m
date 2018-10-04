Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE98C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA77213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA77213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJDMuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:50:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:54146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726858AbeJDMuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 08:50:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BC1FACE7;
        Thu,  4 Oct 2018 05:58:43 +0000 (UTC)
Date:   Thu, 4 Oct 2018 07:58:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
Message-ID: <20181004055842.GA22173@dhcp22.suse.cz>
References: <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
 <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
 <20180925202959.GY18685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com>
 <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org>
 <20180926060624.GA18685@dhcp22.suse.cz>
 <20181002112851.GP18290@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com>
 <20181003073640.GF18290@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-10-18 15:51:05, David Rientjes wrote:
> On Wed, 3 Oct 2018, Michal Hocko wrote:
> 
> > > > So how about this? (not tested yet but it should be pretty
> > > > straightforward)
> > > 
> > > Umm, prctl(PR_GET_THP_DISABLE)?
> > 
> > /me confused. I thought you want to query for the flag on a
> > _different_ process. 
> 
> Why would we want to check three locations (system wide setting, prctl 
> setting, madvise setting) to determine if a heap can be backed by thp?

Because we simply have 3 different ways to control THP? Is this a real
problem?

> If the nh flag being exported to VmFlag is to be extended beyond what my 
> patch did, I suggest (1) it does it for the system wide setting as well 
> and/or (2) calling a helper function to determine if the vma could be 
> backed by thp in the first place regardless of any setting to determine if 
> nh/hg is important.
> 
> The last thing I suggest is done is adding a third place to check.

But conflating the three ways into a single exported symbol (be it nh
or something else) just makes the api more confusing longterm. I am
pretty sure we have made that mistake in the past already.

What if somebody really wants to check for PR_SET_THP_DISABLE? There is
currently no way to do that on a remote process right now AFAICS. So it
makes sense to export the state in general. Any exported API should be
about consistency. If you want to combine all three checks then
just do that in the userspace or in a library function.
-- 
Michal Hocko
SUSE Labs
