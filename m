Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5E9C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BDF2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BDF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeJDQjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:39:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbeJDQjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12341B016;
        Thu,  4 Oct 2018 09:46:39 +0000 (UTC)
Date:   Thu, 4 Oct 2018 11:46:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
Message-ID: <20181004094637.GG22173@dhcp22.suse.cz>
References: <20180925202959.GY18685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com>
 <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org>
 <20180926060624.GA18685@dhcp22.suse.cz>
 <20181002112851.GP18290@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com>
 <20181003073640.GF18290@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com>
 <20181004055842.GA22173@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810040209130.113459@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810040209130.113459@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-10-18 02:15:38, David Rientjes wrote:
> On Thu, 4 Oct 2018, Michal Hocko wrote:
> 
> > > > > > So how about this? (not tested yet but it should be pretty
> > > > > > straightforward)
> > > > > 
> > > > > Umm, prctl(PR_GET_THP_DISABLE)?
> > > > 
> > > > /me confused. I thought you want to query for the flag on a
> > > > _different_ process. 
> > > 
> > > Why would we want to check three locations (system wide setting, prctl 
> > > setting, madvise setting) to determine if a heap can be backed by thp?
> > 
> > Because we simply have 3 different ways to control THP? Is this a real
> > problem?
> > 
> 
> And prior to the offending commit, there were three ways to control thp 
> but two ways to determine if a mapping was eligible for thp based on the 
> implementation detail of one of those ways.

Yes, it is really unfortunate that we have ever allowed to leak such an
internal stuff like VMA flags to userspace.

> If there are three ways to 
> control thp, userspace is still in the dark wrt which takes precedence 
> over the other: we have PR_SET_THP_DISABLE but globally sysfs has it set 
> to "always", or we have MADV_HUGEPAGE set per smaps but PR_SET_THP_DISABLE 
> shown in /proc/pid/status, etc.
> 
> Which one is the ultimate authority?

Isn't our documentation good enough? If not then we should document it
properly.

> There's one way to specify it: in a 
> single per-mapping location that reveals whether that mapping is eligible 
> for thp or not.  So I think it would be a very sane extension so that 
> smaps reveals if a mapping can be backed by hugepages or not depending on 
> the helper function thp uses itself to determine if it can fault 
> hugepages.  I don't think we should have three locations to check and then 
> try to resolve which one takes precedence over the other for each 
> userspace implementation (and perhaps how the kernel implementation 
> evolves).

But we really have three different ways to disable thp. Which one has
caused the end result might be interesting/important because different
entities might be under control. You either have to contact your admin
for the global one, or whomever has launched you for the prctl thing. So
the distinction might be important.

Checking 3 different places and the precedence rules is not really
trivial but I do not see any reason why this couldn't be implemented in
a library so the user doesn't really have to scratch head.

If you really insist to have per-vma thing then all right but do not
conflate vma flags and the higher level logic and make it its own line
in the smaps output and make sure it reports only THP able VMAs.
-- 
Michal Hocko
SUSE Labs
