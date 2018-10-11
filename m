Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E372C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D032087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DafpJ0Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D032087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeJKTep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:34:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37751 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:34:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id u6-v6so1407818plz.4;
        Thu, 11 Oct 2018 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzvxPtwOAyCPT1RV3hPDohoKNze5alJNtGN0RbZ12fY=;
        b=DafpJ0SmfTPIDvFl8dRtUHFapmutM2kKGgr0fMKhMwzOGZBm6cIUQ/4/rbH8HH87Z8
         xKmwpUgGZqmvbS8auGIlz0Vv9+/x2FYOzjIgDgINad1AaKqjhsexrL0pPdxaNJm/28zy
         oHP1M03jcmL8dHCD98/CSOssWgxTIei5xug5CVnVLPZdnK0WMu36tkkSJMhAcf59UO8R
         8M88dIRj9cDYWPBGv59fLaAaoFU+MwDxBSz16bJryWLKlapIZkQvMPZRiEBLp7kmq1cI
         1dIi0meA/Ig9IejeV/xf2aabO7qCN3KsjgN7caE+hTEJdAUiuKdZcGALXjbOADVJk3Df
         83uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzvxPtwOAyCPT1RV3hPDohoKNze5alJNtGN0RbZ12fY=;
        b=M/k9LHf65XwLo+FQjYSZK98DJmTbX3XPm7aTc+XE3o8GYV2lUGd4dmtYeSlYFkNkFc
         AvetPjW0X0iZFzMoXCPiGkqsbdHU8xddSR6XMG+Sk5imP1mdmMgOm6DDqzoYvWGmKAuE
         xcJHtJ2YtrTQJ/A6+ERWwlmJzQV2IsYUxFq7DSW3ok64FADyFv9LKPCWzoQezwyQgdH7
         sx16qggwPgBIjkhOLZ7Z5NuA20AXqFYHSWGE4mmV2rJnXq4rAEW5N0msOruE+fVKLyUv
         k41F901TKvoqI7blz1tKMKIweMdJYurE5ghlRROPsl15PdqGyODV87FZJXLjM5ptbkq3
         pHOQ==
X-Gm-Message-State: ABuFfoiQju6JlKz2r48QbiprYQjn2WsHbstgOGixaa6bHtcJz6Ljrw22
        zrYmNd4EwJ2CpY+mCIvPHyP3j3/Y3KKmAk/qyR8=
X-Google-Smtp-Source: ACcGV61r/Bj5N0Y4kU7ZCmU9WymYyT0Es5ss17/XMi0Djsp2slPulZQHegEeqZU+l6tv1gYVMpCXxqAKMsy5xE+yo5E=
X-Received: by 2002:a17:902:bb96:: with SMTP id m22-v6mr1307467pls.117.1539259668661;
 Thu, 11 Oct 2018 05:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181011100312.4083-1-vkuznets@redhat.com>
In-Reply-To: <20181011100312.4083-1-vkuznets@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 11 Oct 2018 20:07:36 +0800
Message-ID: <CAOLK0pzTzubAcgv3nd_G6pSbB48Xw-ANbCn7+wX0NE1ssDW2Vg@mail.gmail.com>
Subject: Re: [PATCH] KVM: vmx: hyper-v: don't pass EPT configuration info to vmx_hv_remote_flush_tlb()
To:     vkuznets@redhat.com
Cc:     kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 6:32 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> I'm observing random crashes in multi-vCPU L2 guests running on KVM on
> Hyper-V. I bisected the issue to the commit 877ad952be3d ("KVM: vmx: Add
> tlb_remote_flush callback support"). Hyper-V TLFS states:
>
> "AddressSpace specifies an address space ID (an EPT PML4 table pointer)"
>
> So apparently, Hyper-V doesn't expect us to pass naked EPTP, only PML4
> pointer should be used. Strip off EPT configuration information before
> calling into vmx_hv_remote_flush_tlb().

Hi Vitaly:
:               Thanks to fix this. Sorry, I didn't meet the issue..
I think we may just store EPT PML4 table pointer without EPT
configuration information
in the ept_pointer field for this case.

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 619307b3e6bb..e316058b41a6 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5379,7 +5379,7 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu,
unsigned long cr3)

                if (kvm_x86_ops->tlb_remote_flush) {
                        spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
-                       to_vmx(vcpu)->ept_pointer = eptp;
+                       to_vmx(vcpu)->ept_pointer = cr3;
                        to_kvm_vmx(kvm)->ept_pointers_match
                                = EPT_POINTERS_CHECK;
                        spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);



>
> Fixes: 877ad952be3d ("KVM: vmx: Add tlb_remote_flush callback support")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 612fd17be635..e665aa7167cf 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -1572,8 +1572,12 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
>                 goto out;
>         }
>
> +       /*
> +        * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
> +        * base of EPT PML4 table, strip off EPT configuration information.
> +        */
>         ret = hyperv_flush_guest_mapping(
> -                       to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
> +                       to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
>
>  out:
>         spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
> --
> 2.17.1
>


-- 
Best regards
Tianyu Lan
