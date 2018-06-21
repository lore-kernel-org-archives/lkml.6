Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383AAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3C420837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3C420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbeFUHyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:35636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754093AbeFUHyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:54:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79D6BABB8;
        Thu, 21 Jun 2018 07:54:52 +0000 (UTC)
Date:   Thu, 21 Jun 2018 09:54:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: fix unnecessary killing of additional processes
Message-ID: <20180621075451.GD10465@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1806141339580.4543@chino.kir.corp.google.com>
 <20180615065541.GA24039@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806151559360.49038@chino.kir.corp.google.com>
 <20180619083316.GB13685@dhcp22.suse.cz>
 <20180620130311.GM13685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806201325330.158126@chino.kir.corp.google.com>
 <20180621074537.GC10465@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621074537.GC10465@dhcp22.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-06-18 09:45:37, Michal Hocko wrote:
> On Wed 20-06-18 13:34:52, David Rientjes wrote:
> > On Wed, 20 Jun 2018, Michal Hocko wrote:
[...]
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 6bcecc325e7e..ac08f5d711be 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -7203,8 +7203,9 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
> > >  	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
> > >  }
> > >  
> > > -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > > -		unsigned long start, unsigned long end)
> > > +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > > +		unsigned long start, unsigned long end,
> > > +		bool blockable)
> > >  {
> > >  	unsigned long apic_address;
> > >  
> > > @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > >  	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
> > >  	if (start <= apic_address && apic_address < end)
> > >  		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
> > > +
> > > +	return 0;
> > >  }
> > >  
> > >  void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
> > 
> > Auditing the first change in the patch, this is incorrect because 
> > kvm_make_all_cpus_request() for KVM_REQ_APIC_PAGE_RELOAD can block in 
> > kvm_kick_many_cpus() and that is after kvm_make_request() has been done.
> 
> I would have to check the code closer. But doesn't
> kvm_make_all_cpus_request call get_cpu which is preempt_disable?

Sorry I meant kvm_make_vcpus_request_mask. kvm_make_all_cpus_request
only does a GFP_ATOMIC allocation on top.
-- 
Michal Hocko
SUSE Labs
