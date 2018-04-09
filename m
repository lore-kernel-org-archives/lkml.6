Return-Path: <kernel-hardening-return-12931-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+NE/Nb5V2t3T4b1Y5XSPFq4Juy8+vXao7M6cAYSE52eJ1wjAG2WFjmV/NsW0SMimL3CvnZ
ARC-Seal: i=1; a=rsa-sha256; t=1523285851; cv=none;
        d=google.com; s=arc-20160816;
        b=awbQL7xZ2B7NGz6XwYSACB4xO+1x3dkw4amTsWI6DPpWehyGrwThskGus2bI5JoI99
         2HhbcP+aCimKwDJ90PU5U8S0RWLDFJDV/xhgrtFRp5h32dtPU07jD3d0tdWbMY9Gof7D
         dWTfXnS8Zy3FY1YnXNLOpFWGH0KqvX8xwAz/aVTD52LnbhGiutQP1yW1DcBeSA3/9+cG
         kQOucuenryuAr+zpzNi6JbOh4ZGCDVTAghcfnPtvAkSxPNrAfh2nEVbzXxyDyKG32rui
         Np0O+urOl9B0sYDFJ4eUtApnXZp0TLK7kGljDtILKC5/PBFBjUsMB6c/xH+Ow06T6T0E
         DiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=QXQ1VzYrNJdRV1vsZW+7/uAhEt3wPTP17A5KQ4I9aow=;
        b=MXpmsiPXfjj6w9xY4SbnNLut5syozdaQL2jN87e4CmEtz+ua+g9jbySvECfXHIh90U
         M+1S/WDSSL1mrEMZqGbf6W7Cm3hys7wabEN17EKrfitMCyLhiqsyu2u26NBQtrWQHkog
         0dNyshiwwEhSmz5iggZkGSGshx5JrxzrsFqBNE6W8URO1iT3RnaXX1EmGM5+f73lZTBk
         p8x1I7BoOVfygPoLgwgVmEwo9SrdJSkz+Nlq9oxCGsGRH0lL6CZH5XDVP0uCVzj0sQ60
         3DXlzqIM0JnU9DKkttoNpxWEsIeJguBfjwWpes0TQ3n160wZmhbQXHkF0RasuBP67dMV
         CsLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12931-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12931-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12931-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12931-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 9 Apr 2018 15:57:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Christoffer Dall <cdall@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
	linux-arch@vger.kernel.org, marc.zyngier@arm.com,
	suzuki.poulose@arm.com, will.deacon@arm.com, yao.qi@arm.com,
	kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	awallis@codeaurora.org
Subject: Re: [PATCHv2 09/12] arm64/kvm: preserve host HCR_EL2 value
Message-ID: <20180409145709.dneotb6xaznw44c4@lakrids.cambridge.arm.com>
References: <20171127163806.31435-1-mark.rutland@arm.com>
 <20171127163806.31435-10-mark.rutland@arm.com>
 <20180206123915.GA21802@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206123915.GA21802@cbox>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1585238090523877601?=
X-GMAIL-MSGID: =?utf-8?q?1597280985410167148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 01:39:15PM +0100, Christoffer Dall wrote:
> On Mon, Nov 27, 2017 at 04:38:03PM +0000, Mark Rutland wrote:
> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index 525c01f48867..2205f0be3ced 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -71,6 +71,8 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
> >  {
> >  	u64 val;
> >  
> > +	vcpu->arch.host_hcr_el2 = read_sysreg(hcr_el2);
> > +
> 
> Looking back at this, it seems excessive to switch this at every
> round-trip.  I think it should be possible to have this as a single
> global (or per-CPU) variable that gets restored directly when returning
> from the VM.

I suspect this needs to be per-cpu, to account for heterogeneous
systems.

I guess if we move hcr_el2 into kvm_cpu_context, that gives us a
per-vcpu copy for guests, and a per-cpu copy for the host (in the global
kvm_host_cpu_state).

I'll have a look at how gnarly that turns out. I'm not sure how we can
initialise that sanely for the !VHE case to match whatever el2_setup
did.

Thanks,
Mark.
