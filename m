Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036BCC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC079218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfAXRj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:39:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43637 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfAXRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:39:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so7403492wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 09:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KJYC6aQdTAezeJ8Z5hmL7iHtHcoWplSiWC+qJCJ6By0=;
        b=eH9BewTkXWKh4F9oR6kwIaszD5rt3nSNZPNvqkmj2kvWcamtmI4MGyaBUICkhsj5J2
         9oRAH/Aw9toPnwt/GVggsC0hbUvLw/motMx7Ayk6eCJFK8tcDvQPwpreVL9wW0xyxFfk
         O+83JDou7Xk3VBnjRapvsZAJ4NFqQi8Xoyz5HTwIpGHutkNRqPsP5uRqPULZC9axrOay
         2NfIi6KAE4N37Y2PMQIc7WRcTy/5l1dGE+oAPuP4T9B+uwLoOXAv524L6V8zD8YTqHy9
         DjqXbQzFY1Dl/plreRpARD2fiEhgsJmUVs8zTJKGDm0rZSQn59+xXATXiiTozITvbpPT
         b/sQ==
X-Gm-Message-State: AJcUukdkZfA8RTcZqoUCL3+qAhHRzQF1DomDkQZq+nJcfxKhPWoGYgn0
        lU1uDMvgB2U/Jls0TMBl4SRYkfVK7ReNAA==
X-Google-Smtp-Source: ALg8bN6kMcp0hO2Z6xN8LGcHpfSQjVePcZpfZfZHA8Zm9IfqNLwioP2Fx1uMv5Aah470mnvzm36sPw==
X-Received: by 2002:adf:8122:: with SMTP id 31mr8263422wrm.48.1548351563795;
        Thu, 24 Jan 2019 09:39:23 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 143sm129809788wml.14.2019.01.24.09.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 09:39:22 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvm/hyper-v: tweak HYPERV_CPUID_ENLIGHTMENT_INFO
In-Reply-To: <805B7B08-734E-4A96-AF98-D33065C59105@oracle.com>
References: <20190124171516.23626-1-vkuznets@redhat.com> <805B7B08-734E-4A96-AF98-D33065C59105@oracle.com>
Date:   Thu, 24 Jan 2019 18:39:21 +0100
Message-ID: <8736pigdkm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

>> On 24 Jan 2019, at 19:15, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> We shouldn't probably be suggesting using Enlightened VMCS when it's not
>> enabled (not supported from guest's point of view). System reset through
>> synthetic MSR is not recommended neither by genuine Hyper-V nor my QEMU.
>> 
>> Windows seems to be fine either way but let's be consistent.
>> 
>> Fixes: 2bc39970e932 ("x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> arch/x86/kvm/hyperv.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index ac44a681f065..4730fcaa70cf 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1847,11 +1847,11 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>> 		case HYPERV_CPUID_ENLIGHTMENT_INFO:
>> 			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
>> 			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
>> -			ent->eax |= HV_X64_SYSTEM_RESET_RECOMMENDED;
>> 			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
>> 			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
>> 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
>> -			ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
>> +			if (evmcs_ver)
>> +				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
>> 
>> 			/*
>> 			 * Default number of spinlock retry attempts, matches
>> -- 
>> 2.20.1
>> 
>
> Seems to me that there are 2 unrelated separated patches here. Why not
> split them?

They seem to be too small :-) No problem, I'll split them up in v2.

> For content itself: Reviewed-by: Liran Alon <liran.alon@oracle.com>
>

Thanks!

-- 
Vitaly
