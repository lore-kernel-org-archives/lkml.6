Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D7EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CF524F27
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CF524F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeGBTOA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:14:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752526AbeGBTN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3694401EF07;
        Mon,  2 Jul 2018 19:13:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-57.ams2.redhat.com [10.36.116.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2DE7111AF34;
        Mon,  2 Jul 2018 19:13:55 +0000 (UTC)
Subject: Re: [PATCH v3 12/20] kvm: arm64: Add helper for loading the stage2
 setting for a VM
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-13-git-send-email-suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, julien.grall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c8091c05-b7ea-92fa-6d04-917619691381@redhat.com>
Date:   Mon, 2 Jul 2018 21:13:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-13-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 02 Jul 2018 19:13:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 02 Jul 2018 19:13:58 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> We load the stage2 context of a guest for different operations,
> including running the guest and tlb maintenance on behalf of the
> guest. As of now only the vttbr is private to the guest, but this
> is about to change with IPA per VM. Add a helper to load the stage2
> configuration for a VM, which could do the right thing with the
> future changes.
> 
> Cc: Christoffer Dall <cdall@kernel.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> Changes since v2:
>  - New patch
> ---
>  arch/arm64/include/asm/kvm_hyp.h | 6 ++++++
>  arch/arm64/kvm/hyp/switch.c      | 2 +-
>  arch/arm64/kvm/hyp/tlb.c         | 4 ++--
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 384c343..82f9994 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -155,5 +155,11 @@ void deactivate_traps_vhe_put(void);
>  u64 __guest_enter(struct kvm_vcpu *vcpu, struct kvm_cpu_context *host_ctxt);
>  void __noreturn __hyp_do_panic(unsigned long, ...);
>  
> +/* Must be called from hyp code running at EL2 */
> +static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
> +{
> +	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +}
> +
>  #endif /* __ARM64_KVM_HYP_H__ */
>  
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index d496ef5..355fb25 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -195,7 +195,7 @@ void deactivate_traps_vhe_put(void)
>  
>  static void __hyp_text __activate_vm(struct kvm *kvm)
>  {
> -	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +	__load_guest_stage2(kvm);
>  }
>  
>  static void __hyp_text __deactivate_vm(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
> index 131c777..4dbd9c6 100644
> --- a/arch/arm64/kvm/hyp/tlb.c
> +++ b/arch/arm64/kvm/hyp/tlb.c
> @@ -30,7 +30,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
>  	 * bits. Changing E2H is impossible (goodbye TTBR1_EL2), so
>  	 * let's flip TGE before executing the TLB operation.
>  	 */
> -	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +	__load_guest_stage2(kvm);
>  	val = read_sysreg(hcr_el2);
>  	val &= ~HCR_TGE;
>  	write_sysreg(val, hcr_el2);
> @@ -39,7 +39,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
>  
>  static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm)
>  {
> -	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +	__load_guest_stage2(kvm);
>  	isb();
>  }
>  
> 
