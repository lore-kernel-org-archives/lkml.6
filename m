Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E36FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF56023E55
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF56023E55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeFVHnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:43:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:48742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeFVHm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:42:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01E28ADCC;
        Fri, 22 Jun 2018 07:42:57 +0000 (UTC)
Date:   Fri, 22 Jun 2018 09:42:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: fix unnecessary killing of additional processes
Message-ID: <20180622074257.GQ10465@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1806141339580.4543@chino.kir.corp.google.com>
 <20180615065541.GA24039@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806151559360.49038@chino.kir.corp.google.com>
 <20180619083316.GB13685@dhcp22.suse.cz>
 <20180620130311.GM13685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806201325330.158126@chino.kir.corp.google.com>
 <20180621074537.GC10465@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806211347050.213939@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806211347050.213939@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-06-18 13:50:53, David Rientjes wrote:
> On Thu, 21 Jun 2018, Michal Hocko wrote:
> 
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index 6bcecc325e7e..ac08f5d711be 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -7203,8 +7203,9 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
> > > >  	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
> > > >  }
> > > >  
> > > > -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > > > -		unsigned long start, unsigned long end)
> > > > +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > > > +		unsigned long start, unsigned long end,
> > > > +		bool blockable)
> > > >  {
> > > >  	unsigned long apic_address;
> > > >  
> > > > @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > > >  	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
> > > >  	if (start <= apic_address && apic_address < end)
> > > >  		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
> > > > +
> > > > +	return 0;
> > > >  }
> > > >  
> > > >  void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
> > > 
> > > Auditing the first change in the patch, this is incorrect because 
> > > kvm_make_all_cpus_request() for KVM_REQ_APIC_PAGE_RELOAD can block in 
> > > kvm_kick_many_cpus() and that is after kvm_make_request() has been done.
> > 
> > I would have to check the code closer. But doesn't
> > kvm_make_all_cpus_request call get_cpu which is preempt_disable? I
> > definitely plan to talk to respective maintainers about these changes of
> > course.
> > 
> 
> preempt_disable() is required because it calls kvm_kick_many_cpus() with 
> wait == true because KVM_REQ_APIC_PAGE_RELOAD sets KVM_REQUEST_WAIT and 
> thus the smp_call_function_many() is going to block until all cpus can run 
> ack_flush().

I will make sure to talk to the maintainer of the respective code to
do the nonblock case correctly.

-- 
Michal Hocko
SUSE Labs
