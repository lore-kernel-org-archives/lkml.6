Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E0DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BA12081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BA12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbeKFGLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:11:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:47122 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeKFGLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:11:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 12:49:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="277323400"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2018 12:49:34 -0800
Date:   Mon, 5 Nov 2018 12:49:34 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Oded Gabbay <oded.gabbay@amd.com>
Subject: Re: [PATCH] mm/mmu_notifier: rename mmu_notifier_synchronize() to
 <...>_barrier()
Message-ID: <20181105204934.GA27247@linux.intel.com>
References: <20181105192955.26305-1-sean.j.christopherson@intel.com>
 <20181105121833.200d5b53300a7ef4df7d349d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105121833.200d5b53300a7ef4df7d349d@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:18:33PM -0800, Andrew Morton wrote:
> On Mon,  5 Nov 2018 11:29:55 -0800 Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> 
> > ...and update its comment to explicitly reference its association with
> > mmu_notifier_call_srcu().
> > 
> > Contrary to its name, mmu_notifier_synchronize() does not synchronize
> > the notifier's SRCU instance, but rather waits for RCU callbacks to
> > finished, i.e. it invokes rcu_barrier().  The RCU documentation is
> > quite clear on this matter, explicitly calling out that rcu_barrier()
> > does not imply synchronize_rcu().  The misnomer could lean an unwary
> > developer to incorrectly assume that mmu_notifier_synchronize() can
> > be used in conjunction with mmu_notifier_unregister_no_release() to
> > implement a variation of mmu_notifier_unregister() that synchronizes
> > SRCU without invoking ->release.  A Documentation-allergic and hasty
> > developer could be further confused by the fact that rcu_barrier() is
> > indeed a pass-through to synchronize_rcu()... in tiny SRCU.
> 
> Fair enough.
> 
> > --- a/mm/mmu_notifier.c
> > +++ b/mm/mmu_notifier.c
> > @@ -35,12 +35,12 @@ void mmu_notifier_call_srcu(struct rcu_head *rcu,
> >  }
> >  EXPORT_SYMBOL_GPL(mmu_notifier_call_srcu);
> >  
> > -void mmu_notifier_synchronize(void)
> > +void mmu_notifier_barrier(void)
> >  {
> > -	/* Wait for any running method to finish. */
> > +	/* Wait for any running RCU callbacks (see above) to finish. */
> >  	srcu_barrier(&srcu);
> >  }
> > -EXPORT_SYMBOL_GPL(mmu_notifier_synchronize);
> > +EXPORT_SYMBOL_GPL(mmu_notifier_barrier);
> >  
> >  /*
> >   * This function can't run concurrently against mmu_notifier_register
> 
> But as it has no callers, why retain it?

I was hesitant to remove it altogether since it was explicitly added to
complement mmu_notifier_call_srcu()[1] even though the initial user of
mmu_notifier_call_srcu() didn't use mmu_notifier_synchronize()[2].  I
assume there was a good reason for adding the barrier function, but
maybe that's a bad assumption.

[1] b972216e27d1 ("mmu_notifier: add call_srcu and sync function for listener to delay call and sync")
[2] https://lore.kernel.org/patchwork/patch/515318/
