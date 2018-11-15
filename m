Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B336C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D16E2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D16E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbeKOT34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:29:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:49884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeKOT34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:29:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26E27AE29;
        Thu, 15 Nov 2018 09:22:55 +0000 (UTC)
Date:   Thu, 15 Nov 2018 10:22:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
Message-ID: <20181115092254.GJ23831@dhcp22.suse.cz>
References: <20181015150325.GN18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810151519250.247641@chino.kir.corp.google.com>
 <20181016104855.GQ18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810161416540.83080@chino.kir.corp.google.com>
 <20181017070531.GC18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810171256330.60837@chino.kir.corp.google.com>
 <20181018070031.GW18839@dhcp22.suse.cz>
 <20181114132306.GX23419@dhcp22.suse.cz>
 <alpine.DEB.2.21.1811141336010.200345@chino.kir.corp.google.com>
 <20181115090242.GH23831@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115090242.GH23831@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 10:02:42, Michal Hocko wrote:
> On Wed 14-11-18 13:41:12, David Rientjes wrote:
> > On Wed, 14 Nov 2018, Michal Hocko wrote:
> > 
> > > > > > Do you know of any other userspace except your usecase? Is there
> > > > > > anything fundamental that would prevent a proper API adoption for you?
> > > > > > 
> > > > > 
> > > > > Yes, it would require us to go back in time and build patched binaries. 
> > > > 
> > > > I read that as there is a fundamental problem to update existing
> > > > binaries. If that is the case then there surely is no way around it
> > > > and another sad page in the screwed up APIs book we provide.
> > > > 
> > > > But I was under impression that the SW stack which actually does the
> > > > monitoring is under your controll. Moreover I was under impression that
> > > > you do not use the current vanilla kernel so there is no need for an
> > > > immediate change on your end. It is trivial to come up with a backward
> > > > compatible way to check for the new flag (if it is not present then
> > > > fallback to vma flags).
> > > > 
> > 
> > The userspace had a single way to determine if thp had been disabled for a 
> > specific vma and that was broken with your commit.  We have since fixed 
> > it.  Modifying our software stack to start looking for some field 
> > somewhere else will not help anybody else that this has affected or will 
> > affect.  I'm interested in not breaking userspace, not trying a wait and 
> > see approach to see if anybody else complains once we start looking for 
> > some other field.  The risk outweighs the reward, it already broke us, and 
> > I'd prefer not to even open the possibility of breaking anybody else.
> 
> I very much agree on "do not break userspace" part but this is kind of
> gray area. VMA flags are a deep internal implementation detail and
> nobody should really depend on it for anything important. The original
> motivation for introducing it was CRIU where it is kind of
> understandable. I would argue they should find a different way but it is
> just too late for them.
> 
> For this particular case there was no other bug report except for yours
> and if it is possible to fix it on your end then I would really love to
> make the a sensible user interface to query the status. If we are going
> to change the semantic of the exported flag again then we risk yet
> another breakage.
> 
> Therefore I am asking whether changing your particular usecase to a new
> interface is possible because that would allow to have a longerm
> sensible user interface rather than another kludge which still doesn't
> cover all the usecases (e.g. there is no way to reliably query the
> madvise status after your patch).

Btw. this is essentially the same kind of problem as
http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz
where the conclusion was to come up with a saner interface rather than
mimic the previous one.
-- 
Michal Hocko
SUSE Labs
