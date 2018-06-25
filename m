Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E945EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFD925626
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFD925626
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbeFYIpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:45:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754488AbeFYIpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:45:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 393C7AD20;
        Mon, 25 Jun 2018 08:45:30 +0000 (UTC)
Date:   Mon, 25 Jun 2018 10:45:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180625084529.GC28965@dhcp22.suse.cz>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <d617fc1d-28a7-3441-7465-bedf4dc69976@redhat.com>
 <20180625075715.GA28965@dhcp22.suse.cz>
 <e7f3289e-3ee3-3f02-1947-9e4327e1a864@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f3289e-3ee3-3f02-1947-9e4327e1a864@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-06-18 10:10:18, Paolo Bonzini wrote:
> On 25/06/2018 09:57, Michal Hocko wrote:
> > On Sun 24-06-18 10:11:21, Paolo Bonzini wrote:
> >> On 22/06/2018 17:02, Michal Hocko wrote:
> >>> @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> >>>  	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
> >>>  	if (start <= apic_address && apic_address < end)
> >>>  		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
> >>> +
> >>> +	return 0;
> >>
> >> This is wrong, gfn_to_hva can sleep.
> > 
> > Hmm, I have tried to crawl the call chain and haven't found any
> > sleepable locks taken. Maybe I am just missing something.
> > __kvm_memslots has a complex locking assert. I do not see we would take
> > slots_lock anywhere from the notifier call path. IIUC that means that
> > users_count has to be zero at that time. I have no idea how that is
> > guaranteed.
> 
> Nevermind, ENOCOFFEE.  This is gfn_to_hva, not gfn_to_pfn.  It only
> needs SRCU.

OK, so just the make sure I follow, the change above is correct?
-- 
Michal Hocko
SUSE Labs
