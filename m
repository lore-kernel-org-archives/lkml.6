Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC0AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AA720666
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AA720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLCVZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:25:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:38686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbeLCVZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:25:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA236B059;
        Mon,  3 Dec 2018 21:25:41 +0000 (UTC)
Date:   Mon, 3 Dec 2018 22:25:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181203212539.GR31738@dhcp22.suse.cz>
References: <20181127205737.GI16136@redhat.com>
 <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812031237340.192288@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812031237340.192288@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 12:39:34, David Rientjes wrote:
> On Mon, 3 Dec 2018, Michal Hocko wrote:
> 
> > I have merely said that a better THP locality needs more work and during
> > the review discussion I have even volunteered to work on that. There
> > are other reclaim related fixes under work right now. All I am saying
> > is that MADV_TRANSHUGE having numa locality implications cannot satisfy
> > all the usecases and it is particurarly KVM that suffers from it.
> 
> I think extending functionality so thp can be allocated remotely if truly 
> desired is worthwhile

This is a complete NUMA policy antipatern that we have for all other
user memory allocations. So far you have to be explicit for your numa
requirements. You are trying to conflate NUMA api with MADV and that is
just conflating two orthogonal things and that is just wrong.

Let's put the __GFP_THISNODE issue aside. I do not remember you
confirming that __GFP_COMPACT_ONLY patch is OK for you (sorry it might
got lost in the emails storm from back then) but if that is the only
agreeable solution for now then I can live with that. __GFP_NORETRY hack
was shown to not work properly by Mel AFAIR. Again if I misremember then
I am sorry and I can live with that. But conflating MADV_TRANSHUGE with
an implicit numa placement policy and/or adding an opt-in for remote
NUMA placing is completely backwards and a broken API which will likely
bites us later. I sincerely hope we are not going to repeat mistakes
from the past.
-- 
Michal Hocko
SUSE Labs
