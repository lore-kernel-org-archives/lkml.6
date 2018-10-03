Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4890C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956F221470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956F221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJCOXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbeJCOXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:23:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF780ACC2;
        Wed,  3 Oct 2018 07:36:41 +0000 (UTC)
Date:   Wed, 3 Oct 2018 09:36:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
Message-ID: <20181003073640.GF18290@dhcp22.suse.cz>
References: <20180924195603.GJ18685@dhcp22.suse.cz>
 <20180924200258.GK18685@dhcp22.suse.cz>
 <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
 <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
 <20180925202959.GY18685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com>
 <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org>
 <20180926060624.GA18685@dhcp22.suse.cz>
 <20181002112851.GP18290@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-10-18 13:29:42, David Rientjes wrote:
> On Tue, 2 Oct 2018, Michal Hocko wrote:
> 
> > On Wed 26-09-18 08:06:24, Michal Hocko wrote:
> > > On Tue 25-09-18 15:04:06, Andrew Morton wrote:
> > > > On Tue, 25 Sep 2018 14:45:19 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> > > > 
> > > > > > > It is also used in 
> > > > > > > automated testing to ensure that vmas get disabled for thp appropriately 
> > > > > > > and we used "nh" since that is how PR_SET_THP_DISABLE previously enforced 
> > > > > > > this, and those tests now break.
> > > > > > 
> > > > > > This sounds like a bit of an abuse to me. It shows how an internal
> > > > > > implementation detail leaks out to the userspace which is something we
> > > > > > should try to avoid.
> > > > > > 
> > > > > 
> > > > > Well, it's already how this has worked for years before commit 
> > > > > 1860033237d4 broke it.  Changing the implementation in the kernel is fine 
> > > > > as long as you don't break userspace who relies on what is exported to it 
> > > > > and is the only way to determine if MADV_NOHUGEPAGE is preventing it from 
> > > > > being backed by hugepages.
> > > > 
> > > > 1860033237d4 was over a year ago so perhaps we don't need to be
> > > > too worried about restoring the old interface.  In which case
> > > > we have an opportunity to make improvements such as that suggested
> > > > by Michal?
> > > 
> > > Yeah, can we add a way to export PR_SET_THP_DISABLE to userspace
> > > somehow? E.g. /proc/<pid>/status. It is a process wide thing so
> > > reporting it per VMA sounds strange at best.
> > 
> > So how about this? (not tested yet but it should be pretty
> > straightforward)
> 
> Umm, prctl(PR_GET_THP_DISABLE)?

/me confused. I thought you want to query for the flag on a
_different_ process. 
-- 
Michal Hocko
SUSE Labs
