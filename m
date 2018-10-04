Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58405C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272B42098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272B42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeJDQq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:46:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33636 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbeJDQq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:46:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9F3C7A9;
        Thu,  4 Oct 2018 02:53:59 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55A6B3F5D3;
        Thu,  4 Oct 2018 02:53:59 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Lukas Braun <koomi@moshbit.net>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Ralph Palutke <ralph.palutke@fau.de>
Subject: Re: [PATCH v2] KVM: arm/arm64: Check memslot bounds before mapping hugepages
References: <20180926151135.16083-1-koomi@moshbit.net>
Date:   Thu, 04 Oct 2018 10:53:57 +0100
In-Reply-To: <20180926151135.16083-1-koomi@moshbit.net> (Lukas Braun's message
        of "Wed, 26 Sep 2018 17:11:35 +0200")
Message-ID: <87ftxmhway.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Lukas Braun <koomi@moshbit.net> writes:

> Userspace can create a memslot with memory backed by (transparent)
> hugepages, but with bounds that do not align with hugepages.
> In that case, we cannot map the entire region in the guest as hugepages
> without exposing additional host memory to the guest and potentially
> interfering with other memslots.
> Consequently, this patch adds a bounds check when populating guest page
> tables and forces the creation of regular PTEs if mapping an entire
> hugepage would violate the memslots bounds.
>
> Signed-off-by: Lukas Braun <koomi@moshbit.net>
> ---
>
> Hi everyone,
>
> for v2, in addition to writing the condition the way Marc suggested, I
> moved the whole check so it also catches the problem when the hugepage
> was allocated explicitly, not only for THPs.

Ok, that makes sense. Memslot bounds could exceed for hugetlbfs pages as
well.

> The second line is quite long, but splitting it up would make things
> rather ugly IMO, so I left it as it is.

Let's try to do better - user_mem_abort() is quite hard to follow as it
is.

>
>
> Regards,
> Lukas
>
>
>  virt/kvm/arm/mmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index ed162a6c57c5..ba77339e23ec 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1500,7 +1500,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		return -EFAULT;
>  	}
>  
> -	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
> +	if ((fault_ipa & S2_PMD_MASK) < (memslot->base_gfn << PAGE_SHIFT) ||
> +	    ALIGN(fault_ipa, S2_PMD_SIZE) >= ((memslot->base_gfn + memslot->npages) << PAGE_SHIFT)) {
> +		/* PMD entry would map something outside of the memslot */
> +		force_pte = true;
> +	} else if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
>  		hugetlb = true;
>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>  	} else {

For the purpose of this fix, using a helper to check whether the mapping
fits in the memslot makes things clearer (imo) (untested patch below) -

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ed162a6c57c5..8bca141eb45e 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1466,6 +1466,18 @@ static void kvm_send_hwpoison_signal(unsigned long address,
        send_sig_info(SIGBUS, &info, current);
 }
 
+static bool mapping_in_memslot(struct kvm_memory_slot *memslot,
+                        phys_addr_t fault_ipa, unsigned long mapping_size)
+{
+ gfn_t start_gfn = (fault_ipa & ~(mapping_size - 1)) >> PAGE_SHIFT;
+ gfn_t end_gfn = ALIGN(fault_ipa, mapping_size) >> PAGE_SHIFT;
+
+ WARN_ON(!is_power_of_2(mapping_size));
+
+ return memslot->base_gfn <= start_gfn &&
+         end_gfn < memslot->base_gfn + memslot->npages;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
                          struct kvm_memory_slot *memslot, unsigned long hva,
                          unsigned long fault_status)
@@ -1480,7 +1492,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
        kvm_pfn_t pfn;
        pgprot_t mem_type = PAGE_S2;
        bool logging_active = memslot_is_logging(memslot);
-   unsigned long flags = 0;
+ unsigned long vma_pagesize, flags = 0;
 
        write_fault = kvm_is_write_fault(vcpu);
        exec_fault = kvm_vcpu_trap_is_iabt(vcpu);
@@ -1500,7 +1512,15 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
                return -EFAULT;
        }
 
-   if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
+ vma_pagesize = vma_kernel_pagesize(vma);
+ /* Is the mapping contained in the memslot? */
+ if (!mapping_in_memslot(memslot, fault_ipa, vma_pagesize)) {
+         /* memslot should be aligned to page size */
+         vma_pagesize = PAGE_SIZE;
+         force_pte = true;
+ }
+
+ if (vma_pagesize == PMD_SIZE && !logging_active) {
                hugetlb = true;
                gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
        } else {

Thoughts?
