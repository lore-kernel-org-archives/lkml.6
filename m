Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D860C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDDF20867
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDDF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeLJI7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:59:07 -0500
Received: from foss.arm.com ([217.140.101.70]:48882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeLJI7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:59:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E226A1596;
        Mon, 10 Dec 2018 00:59:06 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 536C73F575;
        Mon, 10 Dec 2018 00:59:06 -0800 (PST)
Date:   Mon, 10 Dec 2018 09:59:04 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com,
        marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, punitagrawal@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/8] KVM: arm/arm64: Re-factor setting the Stage 2
 entry to exec on fault
Message-ID: <20181210085904.GC30263@e113682-lin.lund.arm.com>
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-3-punit.agrawal@arm.com>
 <12212830-ffc6-a0e0-5de6-3e6a15ed7141@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12212830-ffc6-a0e0-5de6-3e6a15ed7141@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 07:02:23PM +0530, Anshuman Khandual wrote:
> 
> 
> On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> > Stage 2 fault handler marks a page as executable if it is handling an
> > execution fault or if it was a permission fault in which case the
> > executable bit needs to be preserved.
> > 
> > The logic to decide if the page should be marked executable is
> > duplicated for PMD and PTE entries. To avoid creating another copy
> > when support for PUD hugepages is introduced refactor the code to
> > share the checks needed to mark a page table entry as executable.
> > 
> > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  virt/kvm/arm/mmu.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> > index 59595207c5e1..6912529946fb 100644
> > --- a/virt/kvm/arm/mmu.c
> > +++ b/virt/kvm/arm/mmu.c
> > @@ -1475,7 +1475,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >  			  unsigned long fault_status)
> >  {
> >  	int ret;
> > -	bool write_fault, exec_fault, writable, force_pte = false;
> > +	bool write_fault, writable, force_pte = false;
> > +	bool exec_fault, needs_exec;
> 
> New line not required, still within 80 characters.
> 

He's trying to logically group the two variables.  I don't see a problem
with that.


Thanks,

    Christoffer
