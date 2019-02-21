Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBFEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECC62085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfBUMeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:34:23 -0500
Received: from foss.arm.com ([217.140.101.70]:43664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBUMeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:34:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E1080D;
        Thu, 21 Feb 2019 04:34:22 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 695383F575;
        Thu, 21 Feb 2019 04:34:19 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:34:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 4/6] arm64/kvm: add a userspace option to enable
 pointer authentication
Message-ID: <20190221123416.GD33673@lakrids.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-5-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550568271-5319-5-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 02:54:29PM +0530, Amit Daniel Kachhap wrote:
> This feature will allow the KVM guest to allow the handling of
> pointer authentication instructions or to treat them as undefined
> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
> supply this parameter instead of creating a new API.
> 
> A new register is not created to pass this parameter via
> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
> supplied is enough to enable this feature.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  Documentation/arm64/pointer-authentication.txt |  9 +++++----
>  Documentation/virtual/kvm/api.txt              |  4 ++++
>  arch/arm64/include/asm/kvm_host.h              |  3 ++-
>  arch/arm64/include/uapi/asm/kvm.h              |  1 +
>  arch/arm64/kvm/handle_exit.c                   |  2 +-
>  arch/arm64/kvm/hyp/ptrauth-sr.c                | 16 +++++++++++++++-
>  arch/arm64/kvm/reset.c                         |  3 +++
>  arch/arm64/kvm/sys_regs.c                      | 26 +++++++++++++-------------
>  include/uapi/linux/kvm.h                       |  1 +
>  9 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index a25cd21..0529a7d 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -82,7 +82,8 @@ pointers).
>  Virtualization
>  --------------
>  
> -Pointer authentication is not currently supported in KVM guests. KVM
> -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
> -the feature will result in an UNDEFINED exception being injected into
> -the guest.
> +Pointer authentication is enabled in KVM guest when virtual machine is
> +created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
> +to be enabled. Without this flag, pointer authentication is not enabled
> +in KVM guests and attempted use of the feature will result in an UNDEFINED
> +exception being injected into the guest.
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 356156f..1e646fb 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2642,6 +2642,10 @@ Possible features:
>  	  Depends on KVM_CAP_ARM_PSCI_0_2.
>  	- KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
>  	  Depends on KVM_CAP_ARM_PMU_V3.
> +	- KVM_ARM_VCPU_PTRAUTH: Emulate Pointer authentication for the CPU.
> +	  Depends on KVM_CAP_ARM_PTRAUTH and only on arm64 architecture. If
> +	  set, then the KVM guest allows the execution of pointer authentication
> +	  instructions. Otherwise, KVM treats these instructions as undefined.

I think that we should have separate flags for address auth and generic
auth, to match the ID register split.

For now, we can have KVM only support the case where both are set, but
it gives us freedom to support either in isolation if we have to in
future, without an ABI break.

Thanks,
Mark.
