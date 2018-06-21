Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99954C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32AB208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32AB208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeFUHpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:45:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:35019 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeFUHpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:45:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9F24AD4E;
        Thu, 21 Jun 2018 07:45:39 +0000 (UTC)
Date:   Thu, 21 Jun 2018 09:45:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: fix unnecessary killing of additional processes
Message-ID: <20180621074537.GC10465@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1806141339580.4543@chino.kir.corp.google.com>
 <20180615065541.GA24039@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806151559360.49038@chino.kir.corp.google.com>
 <20180619083316.GB13685@dhcp22.suse.cz>
 <20180620130311.GM13685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806201325330.158126@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806201325330.158126@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 13:34:52, David Rientjes wrote:
> On Wed, 20 Jun 2018, Michal Hocko wrote:
> 
> > On Tue 19-06-18 10:33:16, Michal Hocko wrote:
> > [...]
> > > As I've said, if you are not willing to work on a proper solution, I
> > > will, but my nack holds for this patch until we see no other way around
> > > existing and real world problems.
> > 
> > OK, so I gave it a quick try and it doesn't look all that bad to me.
> > This is only for blockable mmu notifiers.  I didn't really try to
> > address all the problems down the road - I mean some of the blocking
> > notifiers can check the range in their interval tree without blocking
> > locks. It is quite probable that only few ranges will be of interest,
> > right?
> > 
> > So this is only to give an idea about the change. It probably even
> > doesn't compile. Does that sound sane?
> 
> It depends on how invasive we want to make this, it should result in more 
> memory being freeable if the invalidate callbacks can guarantee that they 
> won't block.  I think it's much more invasive than the proposed patch, 
> however.

It is a larger patch for sure but it heads towards a more deterministic
behavior because we know _why_ we are trying. It is a specific and
rarely taken lock that we need. If we get one step further and examine
the range without blocking then we are almost lockless from the oom
reaper POV for most notifiers.

> For the same reason as the mm->mmap_sem backoff, however, this should 
> retry for a longer period of time than HZ.  If we can't grab mm->mmap_sem 
> the first five times with the trylock because of writer queueing, for 
> example, then we only have five attempts for each blockable mmu notifier 
> invalidate callback, and any of the numerous locks it can take to declare 
> it will not block.
> 
> Note that this doesn't solve the issue with setting MMF_OOM_SKIP too early 
> on processes with mm->mmap_sem contention or now invalidate callbacks that 
> will block; the decision that the mm cannot be reaped should come much 
> later.

I do not mind tuning the number of retries or the sleep duration. All
that based on real life examples.

I have asked about a specific mmap_sem contention case several times but
didn't get any answer yet.

> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 6bcecc325e7e..ac08f5d711be 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7203,8 +7203,9 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
> >  	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
> >  }
> >  
> > -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > -		unsigned long start, unsigned long end)
> > +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > +		unsigned long start, unsigned long end,
> > +		bool blockable)
> >  {
> >  	unsigned long apic_address;
> >  
> > @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> >  	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
> >  	if (start <= apic_address && apic_address < end)
> >  		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
> > +
> > +	return 0;
> >  }
> >  
> >  void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
> 
> Auditing the first change in the patch, this is incorrect because 
> kvm_make_all_cpus_request() for KVM_REQ_APIC_PAGE_RELOAD can block in 
> kvm_kick_many_cpus() and that is after kvm_make_request() has been done.

I would have to check the code closer. But doesn't
kvm_make_all_cpus_request call get_cpu which is preempt_disable? I
definitely plan to talk to respective maintainers about these changes of
course.

-- 
Michal Hocko
SUSE Labs
