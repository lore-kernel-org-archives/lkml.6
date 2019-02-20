Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D7BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F94D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfBTOGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:06:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45063 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfBTOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:06:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so26064520wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 06:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QhdKxjSHt8fRpu216w3QldRhS7amvwsLlM5e+FTFDU8=;
        b=BmX4lND+7cszI7xsN5noFZWu4YHbpHZiu8/n9s5DWzcEUns1lLNqA/+EN4b5m6HgfH
         b2Edo7zDfWgCzIZRBqjIy1m3I3Wxo91VW511h5RpY8s0OIXe01RJbHCIAm08mV/b5MIx
         BwZVg7ZxnnnLnRa9mKu69Ti4X/E5JeyJLlPvWOII0doYZbJh1qChhIigQV9h1jHQpDdV
         ihN9T4ioK1wv/hfFBrqQJfpzFMAZ82ExlskfyvGp8PP5VoEhWEOGCQAvkeRXdxWZn8wS
         6m2RmmlhBTSt5SMyzdPdfOhveK10ijOG7hrHaVRKvRuTHKR7WTALwF8Y3iABaIvszwCs
         6QGw==
X-Gm-Message-State: AHQUAubUCsPBrRny+8OtpVc/3vN2YOvAPCcpHGgPIoj9S40+4noo691H
        e00tBzP1+E8cF2rYuk82s0HV4hxUzY4=
X-Google-Smtp-Source: AHgI3IasjM4bGw+7tm8q18LnFRCqdyd8HhkUYFd/PfRRvenxYStYKbAZeOK3TrAbdVsaPXscX29NrA==
X-Received: by 2002:adf:f805:: with SMTP id s5mr24810599wrp.234.1550671572978;
        Wed, 20 Feb 2019 06:06:12 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w23sm5660078wmc.38.2019.02.20.06.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 06:06:11 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: MMU: record maximum physical address width in kvm_mmu_extended_role
In-Reply-To: <1548950963-18414-1-git-send-email-yu.c.zhang@linux.intel.com>
References: <1548950963-18414-1-git-send-email-yu.c.zhang@linux.intel.com>
Date:   Wed, 20 Feb 2019 15:06:10 +0100
Message-ID: <878syatuzx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhang <yu.c.zhang@linux.intel.com> writes:

> Previously, commit 7dcd57552008 ("x86/kvm/mmu: check if tdp/shadow
> MMU reconfiguration is needed") offered some optimization to avoid
> the unnecessary reconfiguration. Yet one scenario is broken - when
> cpuid changes VM's maximum physical address width, reconfiguration
> is needed to reset the reserved bits.  Also, the TDP may need to
> reset its shadow_root_level when this value is changed.
>
> To fix this, a new field, maxphyaddr, is introduced in the extended
> role structure to keep track of the configured guest physical address
> width.
>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/mmu.c              | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4660ce9..be87f71 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -299,6 +299,7 @@ struct kvm_mmu_memory_cache {
>  		unsigned int cr4_smap:1;
>  		unsigned int cr4_smep:1;
>  		unsigned int cr4_la57:1;
> +		unsigned int maxphyaddr:6;
>  	};
>  };
>  
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index ce770b4..2b74505 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4769,6 +4769,7 @@ static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu)
>  	ext.cr4_pse = !!is_pse(vcpu);
>  	ext.cr4_pke = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE);
>  	ext.cr4_la57 = !!kvm_read_cr4_bits(vcpu, X86_CR4_LA57);
> +	ext.maxphyaddr = cpuid_maxphyaddr(vcpu);
>  
>  	ext.valid = 1;

It seems that we can now drop 'valid' from role_ext as maxphyaddr can't
be 0.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
