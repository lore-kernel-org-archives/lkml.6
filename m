Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D8EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866A8208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866A8208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeGaK7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:59:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbeGaK7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:59:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 658AA7A9;
        Tue, 31 Jul 2018 02:19:38 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B97233F5BA;
        Tue, 31 Jul 2018 02:19:36 -0700 (PDT)
Subject: Re: [PATCH v2] arm64, kaslr: export offset in VMCOREINFO ELF notes
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, bhupesh.linux@gmail.com,
        takahiro.akashi@linaro.org, catalin.marinas@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com>
Date:   Tue, 31 Jul 2018 10:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 30/07/18 07:24, Bhupesh Sharma wrote:
> Include KASLR offset in arm64 VMCOREINFO ELF notes to assist in
> debugging. vmcore parsing in user-space already expects this value in
> the notes and we are providing it for portability of those existing
> tools with x86.
> 
> Ideally we would like core code to do this (so that way this
> information won't be missed when an architecture adds KASLR support),
> but mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
> so I am not sure if this is needed for mips (and other such similar arch
> cases in future). So, lets keep this architecture specific for now.

(heh, I assumed you would rewrite my train-of-thought, but I guess this works!)


> As an example of a user-space use-case, consider the
> makedumpfile user-space utility which will need fixup to use this
> KASLR offset to work with cases where we need to find a way to
> translate symbol address from vmlinux to kernel run time address
> in case of KASLR boot on arm64.

Acked-by: James Morse <james.morse@arm.com>

If we want to send this to stable, it looks like it should have been part of the
KASLR series, f80fb3a3d5084 ("arm64: add support for kernel ASLR") was merged
for v4.6.
CC: <stable@vger.kernel.org> # 4.6.x


Thanks,

James


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index f62effc6e064..028df356a5fd 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -360,4 +360,5 @@ void arch_crash_save_vmcoreinfo(void)
>  						kimage_voffset);
>  	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>  						PHYS_OFFSET);
> +	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>  }
> 

