Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8333E217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406314AbfBNVrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:47:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:27518 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406222AbfBNVq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:46:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 13:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,370,1544515200"; 
   d="scan'208";a="118016118"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2019 13:46:57 -0800
Date:   Thu, 14 Feb 2019 13:46:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz,
        cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com,
        atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
 <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
 <20190214201231.GC1739@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214201231.GC1739@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:12:31PM -0700, Jason Gunthorpe wrote:
> On Thu, Feb 14, 2019 at 11:33:53AM -0800, Ira Weiny wrote:
> 
> > > I think it had to do with double accounting pinned and mlocked pages
> > > and thus delivering a lower than expected limit to userspace.
> > > 
> > > vfio has this bug, RDMA does not. RDMA has a bug where it can
> > > overallocate locked memory, vfio doesn't.
> > 
> > Wouldn't vfio also be able to overallocate if the user had RDMA pinned pages?
> 
> Yes
>  
> > I think the problem is that if the user calls mlock on a large range then both
> > vfio and RDMA could potentially overallocate even with this fix.  This was your
> > initial email to Daniel, I think...  And Alex's concern.
> 
> Here are the possibilities
> - mlock and pin on the same pages - RDMA respects the limit, VFIO halfs it.
> - mlock and pin on different pages - RDMA doubles the limit, VFIO
>   respects it
> - VFIO and RDMA in the same process, the limit is halfed or doubled, depending.
> 
> IHMO we should make VFIO & RDMA the same, and then decide what to do
> about case #2.

I'm not against that.  Sorry if I came across that way.  For this series I
agree we should make it consistent.

> 
> > > Really unclear how to fix this. The pinned/locked split with two
> > > buckets may be the right way.
> > 
> > Are you suggesting that we have 2 user limits?
> 
> This is what RDMA has done since CL's patch.

I don't understand?  What is the other _user_ limit (other than
RLIMIT_MEMLOCK)?

> 
> It is very hard to fix as you need to track how many pages are mlocked
> *AND* pinned.

Understood. :-/

Ira

> 
> Jason
