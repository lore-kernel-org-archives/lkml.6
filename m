Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C86FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1A32075C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550758536;
	bh=RS7g4KO7o5BM0WXTu8njXOeY8w47moJrOYGKOrZuemY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dXm67zyE6ku2fCQQDaYEg6SuyzFdeEALsISQsx3wNhKjXi8eCSN5+e3YN03/aZX7J
	 117QH0VTCqGTuG+oIuMOM1hdZNk5Q2yHhXGmoe/M7zfv1VXjXfwRNoo5stm1h/zOnO
	 8Fcta+qVEvX30T7syVwH4r4wkqNvd9IX33ywf+nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfBUOPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfBUOPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:15:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951902070B;
        Thu, 21 Feb 2019 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550758533;
        bh=RS7g4KO7o5BM0WXTu8njXOeY8w47moJrOYGKOrZuemY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNUii4OJWfKagw+F6lWfkyMShw3eFXZhncrdjte7eJsvkp3ukJFi2BtzD3XDvSXtC
         tsL/0qSOS0lmeOGwr2gski1ZXyxdR3eCd/W/r8PJnmJxdIN0NQp2OMgtdl00/pRP+T
         LGGV1FaVTKLCbyA2bKrFKFRg+2Vaomy8gJXHBYOI=
Date:   Thu, 21 Feb 2019 15:15:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH stable-4.4.y] KVM: VMX: Fix x2apic check in
 vmx_msr_bitmap_mode()
Message-ID: <20190221141530.GA18436@kroah.com>
References: <20190221135213.23926-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221135213.23926-1-joro@8bytes.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:52:13PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The stable backport of upstream commit
> 
> 	904e14fb7cb96 KVM: VMX: make MSR bitmaps per-VCPU
> 
> has a bug in vmx_msr_bitmap_mode(). It enables the x2apic
> MSR-bitmap when the kernel emulates x2apic for the guest in
> software. The upstream version of the commit checkes whether
> the hardware has virtualization enabled for x2apic
> emulation.
> 
> Since KVM emulates x2apic for guests even when the host does
> not support x2apic in hardware, this causes the intercept of
> at least the X2APIC_TASKPRI MSR to be disabled on machines
> not supporting that MSR. The result is undefined behavior,
> on some machines (Intel Westmere based) it causes a crash of
> the guest kernel when it tries to access that MSR.
> 
> Change the check in vmx_msr_bitmap_mode() to match the upstream
> code. This fixes the guest crashes observed with stable
> kernels starting with v4.4.168 through v4.4.175.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kvm/vmx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index aee2886a387c..14553f6c03a6 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4628,7 +4628,9 @@ static u8 vmx_msr_bitmap_mode(struct kvm_vcpu *vcpu)
>  {
>  	u8 mode = 0;
>  
> -	if (irqchip_in_kernel(vcpu->kvm) && apic_x2apic_mode(vcpu->arch.apic)) {
> +	if (cpu_has_secondary_exec_ctrls() &&
> +	    (vmcs_read32(SECONDARY_VM_EXEC_CONTROL) &
> +	     SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE)) {
>  		mode |= MSR_BITMAP_MODE_X2APIC;
>  		if (enable_apicv)
>  			mode |= MSR_BITMAP_MODE_X2APIC_APICV;
> -- 
> 2.16.3
> 

Ugh, good catch!

Any hint as to what type of testing that you did that caught this?  I
keep asking people to run some kvm tests, but so far no one is :(

thanks,

greg k-h
