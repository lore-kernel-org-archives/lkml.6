Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1FCC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 13:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D339F21906
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548510821;
	bh=9T6E6J9aX8oChauSgOhGmLT1yBtMdILqSqRZxsmisl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i0Pq5hXtN81ML4tIf1Og/bxbXbg1WMmMLkuou6g+6k2XD7qXxESgkGiL1qJCpNqdf
	 etBqvV2sdQ4xtvcKygAgoQRxLXdiU0p0Pp+p/7FRHFAbQP/vcKvwpDHJV5H0kF095F
	 +EK6u0DreL63kglcA0K0RkLC52rTh/hiviGEGqdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfAZNxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 08:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfAZNxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 08:53:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E3621902;
        Sat, 26 Jan 2019 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548510818;
        bh=9T6E6J9aX8oChauSgOhGmLT1yBtMdILqSqRZxsmisl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oo2+Pfp38PJZ+zLpdcBfSc0PzuH22ql1RDMsFQGueAO1VoCA3Byk6vtruM8othFvb
         aY0p0z5upsjqWwH2KxJ2hNbSmmAuaaDMYZdFUXQE3ERYXkbwDhz4X/mn/o86W3q7wu
         AMlfV+6Tx9NYZJ9sYJUXzqItvy2sznh8SyOFOHIE=
Date:   Sat, 26 Jan 2019 14:53:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 3/6] x86: kvm: no need to check return value of
 debugfs_create functions
Message-ID: <20190126135336.GD23749@kroah.com>
References: <20190122143542.8816-1-gregkh@linuxfoundation.org>
 <20190122143542.8816-4-gregkh@linuxfoundation.org>
 <5495f33a-8d15-6f1a-36be-fa980831e830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5495f33a-8d15-6f1a-36be-fa980831e830@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:49:47PM +0100, Paolo Bonzini wrote:
> On 22/01/19 15:35, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: <x86@kernel.org>
> > Cc: <kvm@vger.kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/x86/kvm/debugfs.c | 26 ++++++++------------------
> >  1 file changed, 8 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
> > index c19c7ede9bd6..827cd58400d2 100644
> > --- a/arch/x86/kvm/debugfs.c
> > +++ b/arch/x86/kvm/debugfs.c
> > @@ -43,26 +43,16 @@ DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_frac_fops, vcpu_get_tsc_scaling_frac_bi
> >  
> >  int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
> >  {
> > -	struct dentry *ret;
> > -
> > -	ret = debugfs_create_file("tsc-offset", 0444,
> > -							vcpu->debugfs_dentry,
> > -							vcpu, &vcpu_tsc_offset_fops);
> > -	if (!ret)
> > -		return -ENOMEM;
> > +	debugfs_create_file("tsc-offset", 0444, vcpu->debugfs_dentry, vcpu,
> > +			    &vcpu_tsc_offset_fops);
> >  
> >  	if (kvm_has_tsc_control) {
> > -		ret = debugfs_create_file("tsc-scaling-ratio", 0444,
> > -							vcpu->debugfs_dentry,
> > -							vcpu, &vcpu_tsc_scaling_fops);
> > -		if (!ret)
> > -			return -ENOMEM;
> > -		ret = debugfs_create_file("tsc-scaling-ratio-frac-bits", 0444,
> > -							vcpu->debugfs_dentry,
> > -							vcpu, &vcpu_tsc_scaling_frac_fops);
> > -		if (!ret)
> > -			return -ENOMEM;
> > -
> > +		debugfs_create_file("tsc-scaling-ratio", 0444,
> > +				    vcpu->debugfs_dentry, vcpu,
> > +				    &vcpu_tsc_scaling_fops);
> > +		debugfs_create_file("tsc-scaling-ratio-frac-bits", 0444,
> > +				    vcpu->debugfs_dentry, vcpu,
> > +				    &vcpu_tsc_scaling_frac_fops);
> >  	}
> >  
> >  	return 0;
> > 
> 
> I'm still not sure about this.  I think it's better if debugfs files are
> created "all or none", i.e. something like
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5ecea812cb6a..ce70c30b2861 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2573,9 +2573,7 @@ static int kvm_vm_ioctl_create_vcpu(
>  	if (r)
>  		goto vcpu_destroy;
> 
> -	r = kvm_create_vcpu_debugfs(vcpu);
> -	if (r)
> -		goto vcpu_destroy;
> +	kvm_create_vcpu_debugfs(vcpu);

Ah, yes, sorry, I missed that.  I'll respin the patch with this change
in it in a few days.

thanks for the review.

greg k-h
