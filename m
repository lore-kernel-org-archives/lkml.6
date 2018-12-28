Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B482C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40882070B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbeL1TKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:10:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:8692 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbeL1TKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:10:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 11:10:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,410,1539673200"; 
   d="scan'208";a="121838978"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Dec 2018 11:10:06 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1CC76300B65; Fri, 28 Dec 2018 11:10:06 -0800 (PST)
Date:   Fri, 28 Dec 2018 11:10:06 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v4 10/10] KVM/x86/lbr: lazy save the guest lbr stack
Message-ID: <20181228191006.GI25620@tassilo.jf.intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-11-git-send-email-wei.w.wang@intel.com>
 <20181227205104.GG25620@tassilo.jf.intel.com>
 <5C259CBA.4030805@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C259CBA.4030805@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:47:06AM +0800, Wei Wang wrote:
> On 12/28/2018 04:51 AM, Andi Kleen wrote:
> > Thanks. This looks a lot better than the earlier versions.
> > 
> > Some more comments.
> > 
> > On Wed, Dec 26, 2018 at 05:25:38PM +0800, Wei Wang wrote:
> > > When the vCPU is scheduled in:
> > > - if the lbr feature was used in the last vCPU time slice, set the lbr
> > >    stack to be interceptible, so that the host can capture whether the
> > >    lbr feature will be used in this time slice;
> > > - if the lbr feature wasn't used in the last vCPU time slice, disable
> > >    the vCPU support of the guest lbr switching.
> > time slice is the time from exit to exit?
> 
> It's the vCPU thread time slice (e.g. 100ms).

I don't think the time slices are that long, but ok.

> 
> > 
> > This might be rather short in some cases if the workload does a lot of exits
> > (which I would expect PMU workloads to do) Would be better to use some
> > explicit time check, or at least N exits.
> 
> Did you mean further increasing the lazy time to multiple host thread
> scheduling time slices?
> What would be a good value for "N"?

I'm not sure -- i think the goal would be to find a value that optimizes
performance (or rather minimizes overhead). But perhaps if it's as you say the
scheduler time slice it might be good enough as it is.

I guess it could be tuned later based on more experneice.

> > or partially cleared. This would be user visible.
> > 
> > In theory could try to detect if the guest is inside a PMI and
> > save/restore then, but that would likely be complicated. I would
> > save/restore for all cases.
> 
> Yes, it is easier to save for all the cases. But curious for the
> non-callstack
> mode, it's just ponit sampling functions (kind of speculative in some
> degree).
> Would rarely losing a few recordings important in that case?

In principle no for statistical samples, but I know some tools complain
for bogus samples (e.g. autofdo will). Also with perf report --branch-history it will
be definitely visible. I think it's easier to always safe now than to
handle the user complaints about this later.


-Andi
