Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7FCC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B812070C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeLNN4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:56:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52186 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbeLNN4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:56:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B233780D;
        Fri, 14 Dec 2018 05:55:59 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAD653F575;
        Fri, 14 Dec 2018 05:55:57 -0800 (PST)
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To:     Dongjiu Geng <gengdongjiu@huawei.com>
References: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
From:   James Morse <james.morse@arm.com>
Cc:     peter.maydell@linaro.org, rkrcmar@redhat.com, corbet@lwn.net,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
Date:   Fri, 14 Dec 2018 13:55:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

On 14/12/2018 10:15, Dongjiu Geng wrote:
> When user space do memory recovery, it will check whether KVM and
> guest support the error recovery, only when both of them support,
> user space will do the error recovery. This patch exports this
> capability of KVM to user space.

I can understand user-space only wanting to do the work if host and guest
support the feature. But 'error recovery' isn't a KVM feature, its a Linux
kernel feature.

KVM will send it's user-space a SIGBUS with MCEERR code whenever its trying to
map a page at stage2 that the kernel-mm code refuses this because its poisoned.
(e.g. check_user_page_hwpoison(), get_user_pages() returns -EHWPOISON)

This is exactly the same as happens to a normal user-space process.

I think you really want to know if the host kernel was built with
CONFIG_MEMORY_FAILURE. The not-at-all-portable way to tell this from user-space
is the presence of /proc/sys/vm/memory_failure_* files.
(It looks like the prctl():PR_MCE_KILL/PR_MCE_KILL_GET options silently update
an ignored policy if the kernel isn't built with CONFIG_MEMORY_FAILURE, so they
aren't helpful)


> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index cd209f7..241e2e2 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4895,3 +4895,12 @@ Architectures: x86
>  This capability indicates that KVM supports paravirtualized Hyper-V IPI send
>  hypercalls:
>  HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
> +
> +8.21 KVM_CAP_ARM_MEMORY_ERROR_RECOVERY
> +
> +Architectures: arm, arm64
> +
> +This capability indicates that guest memory error can be detected by the KVM which
> +supports the error recovery.

KVM doesn't detect these errors.
The hardware detects them and notifies the OS via one of a number of mechanisms.
This gets plumbed into memory_failure(), which sets a flag that the mm code uses
to prevent the page being used again.

KVM is only involved when it tries to map a page at stage2 and the mm code
rejects it with -EHWPOISON. This is the same as the architectures
do_page_fault() checking for (fault & VM_FAULT_HWPOISON) out of
handle_mm_fault(). We don't have a KVM cap for this, nor do we need one.


> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b72a3dd..90d1d9a 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -82,6 +82,7 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		r = kvm_arm_support_pmu_v3();
>  		break;
>  	case KVM_CAP_ARM_INJECT_SERROR_ESR:
> +	case KVM_CAP_ARM_MEMORY_ERROR_RECOVERY:
>  		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
>  		break;

The CPU RAS Extensions are not at all relevant here. It is perfectly possible to
support memory-failure without them, AMD-Seattle and APM-X-Gene do this. These
systems would report not-supported here, but the kernel does support this stuff.
Just because the CPU supports this, doesn't mean the kernel was built with
CONFIG_MEMORY_FAILURE. The CPU reports may be ignored, or upgraded to SIGKILL.



Thanks,

James
