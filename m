Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E69C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33D323E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33D323E10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeGDOWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:22:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38194 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbeGDOWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:22:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69B0218A;
        Wed,  4 Jul 2018 07:22:02 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A3023F5A0;
        Wed,  4 Jul 2018 07:22:02 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 2F9011AE189D; Wed,  4 Jul 2018 15:22:42 +0100 (BST)
Date:   Wed, 4 Jul 2018 15:22:42 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org,
        eric.auger@redhat.com, julien.grall@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        qemu-devel@nongnu.org
Subject: Re: [kvmtool test PATCH 24/24] kvmtool: arm: Add support for
 creating VM with PA size
Message-ID: <20180704142241.GG4828@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:15:44PM +0100, Suzuki K Poulose wrote:
> diff --git a/arm/kvm.c b/arm/kvm.c
> index 5701d41..b1969be 100644
> --- a/arm/kvm.c
> +++ b/arm/kvm.c
> @@ -11,6 +11,8 @@
>  #include <linux/kvm.h>
>  #include <linux/sizes.h>
>  
> +unsigned long kvm_arm_type;
> +
>  struct kvm_ext kvm_req_ext[] = {
>  	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
>  	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
> @@ -18,6 +20,26 @@ struct kvm_ext kvm_req_ext[] = {
>  	{ 0, 0 },
>  };
>  
> +#ifndef KVM_ARM_GET_MAX_VM_PHYS_SHIFT
> +#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT		_IO(KVMIO, 0x0b)
> +#endif
> +
> +void kvm__arch_init_hyp(struct kvm *kvm)
> +{
> +	int max_ipa;
> +
> +	max_ipa = ioctl(kvm->sys_fd, KVM_ARM_GET_MAX_VM_PHYS_SHIFT);
> +	if (max_ipa < 0)
> +		max_ipa = 40;
> +	if (!kvm->cfg.arch.phys_shift)
> +		kvm->cfg.arch.phys_shift = 40;
> +	if (kvm->cfg.arch.phys_shift > max_ipa)
> +		die("Requested PA size (%u) is not supported by the host (%ubits)\n",
> +		    kvm->cfg.arch.phys_shift, max_ipa);
> +	if (kvm->cfg.arch.phys_shift != 40)
> +		kvm_arm_type = kvm->cfg.arch.phys_shift;
> +}

Seems a bit weird that the "machine type identifier" to KVM_CREATE_VM is
dedicated entirely to holding the physical address shift verbatim. Is this
really the ABI?

Also, couldn't KVM figure it out automatically if you add memslots at high
addresses, making this a niche tunable outside of testing?

Will
