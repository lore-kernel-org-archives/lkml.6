Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5A3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E62145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5E62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKUSc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:32:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:35298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbeKUSc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:32:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BE09AC5E;
        Wed, 21 Nov 2018 07:59:29 +0000 (UTC)
Date:   Wed, 21 Nov 2018 08:59:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Stefan Priebe <s.priebe@profihost.ag>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.4 131/160] mm: thp: relax __GFP_THISNODE for
 MADV_HUGEPAGE mappings
Message-ID: <20181121075928.GJ12932@dhcp22.suse.cz>
References: <20181119162630.031306128@linuxfoundation.org>
 <20181119162643.032920932@linuxfoundation.org>
 <alpine.DEB.2.21.1811191410520.150313@chino.kir.corp.google.com>
 <20181120074447.GZ22247@dhcp22.suse.cz>
 <alpine.DEB.2.21.1811201551250.89573@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811201551250.89573@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 15:53:10, David Rientjes wrote:
> On Tue, 20 Nov 2018, Michal Hocko wrote:
> 
> > On Mon 19-11-18 14:16:24, David Rientjes wrote:
> > > On Mon, 19 Nov 2018, Greg Kroah-Hartman wrote:
> > > 
> > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > 
> > > As I noted when this patch was originally proposed and when I nacked it[*] 
> > > because it causes a 13.9% increase in remote memory access latency and up 
> > > to 40% increase in remote memory allocation latency on much of our 
> > > software stack that uses MADV_HUGEPAGE after mremapping the text segment 
> > > to memory backed by hugepages, I don't think this is stable material.
> > 
> > There was a wider consensus that this is the most minimal fix for users
> > who see a regression introduced by 5265047ac301 ("mm, thp: really
> > limit transparent hugepage allocation to local node"). As it has been
> > discussed extensively there is no universal win but we should always opt
> > for the safer side which this patch is accomplishing. The changelog goes
> > in length explaining them along with numbers. I am not happy that your
> > particular workload is suffering but this area certainly requires much
> > more changes to satisfy wider range of users.
> > 
> > > The 4.4 kernel is almost three years old and this changes the NUMA 
> > > locality of any user of MADV_HUGEPAGE.
> > 
> > Yes and we have seen bug reports as we adopted this older kernel only
> > now.
> 
> I think the responsible thing to do would be allow users to remain on 
> their stable kernel that they know works, whether that's 4.4 or any of the 
> others this is proposed for, and downgrade from any current kernel release 
> that causes their workloads to have such severe regressions once they try 
> a kernel with this commit.

But we do know that there are people affected on 4.4 kernel. Besides
that we can revert in the stable tree as soon as we see bug reports on
new stable tree releases.

Really, there is no single proper behavior. It was a mistake to merge
5265047ac301. Since then we are in an unfortunate situation that some
workload might have started to depend on the new behavior.

But rather than repeating the previous long discussion I would call for
a new one which actually deals with fallouts. AFAIR there is a patch
series to reduce the fragmentation issues by Mel with a zero feedback so
far. I also think we should start discussing a new memory policy to
establish the semantic you are after.

-- 
Michal Hocko
SUSE Labs
