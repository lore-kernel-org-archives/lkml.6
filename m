Return-Path: <kernel-hardening-return-12930-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4849IEBezAxP168UmMtt0aP/sQsgN6yYldQYYzKeQXfp9Jeztj82y5YTEPTPu2Gl1nmIGM5
ARC-Seal: i=1; a=rsa-sha256; t=1523284643; cv=none;
        d=google.com; s=arc-20160816;
        b=kTQ9lRxR8OPZlDY0mczMQEylAMm0BhlsksgJXKhz1N+J2FVKtKnGLNvM9UG1afIUEv
         KsB5jCTUWUbAV0AyoT25sE7Nf4AIQbnmlwEs7CwELeEwH0yYW87oov2+jXTD4NLkIIjp
         +DFwt2Iwzxquc5V3xL3G0bb1k6SilM0RqnVczOr8PyzdSIx9AnQ1MHvX9lfcl0/D3jI/
         cOl6cbPPDUKAz3Rq9C0RM1SxqNrmMq5C2jLyimCDvA6Lc7blNxZHiFrXiyGPoybXxd/c
         POuO1DgwN3n0yEO6Cuux70/gWA6r+u++mfGvh4jBDFRYD+zYHH/aKyJA5lyHPK4cmh6X
         NTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=spL9fh0tyuY91UiXtmgfJiEp0HmOQr5vR3xgEGBVACQ=;
        b=F5WI4pqF0GnXL6mTBhmmwnSP3WjNH3r8zhCD5c2bO9/R9B9OYy1KFABffogMVXGxvT
         mdnsuSWmIcjLkKXawfrm9HoEGQ6IALmnFQJsz5a09GVhguo+TjT6RaJlXUVfiifGzeoR
         i95aocMTEIsBKvthIAJNBJi9MLA10Ifp+c5aduuJNAeOSAeOJdfUc+CrzBdsQd0T1xZS
         W0IXLWeudy+ZpePYTMowamxAwU4DYk6Aagj+FcSM1iUyqg1f2NIK63wuBXDfImLK31TL
         OSzYsy15okJLPmgczhxjCILqgmlgCyHoHfH0jhE71HZn3IG5MrFf5074Ix1IMCfM8oC5
         TvQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12930-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12930-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12930-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12930-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 9 Apr 2018 15:37:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Christoffer Dall <cdall@kernel.org>
Cc: Christoffer Dall <christoffer.dall@linaro.org>,
	linux-arch@vger.kernel.org, cdall@linaro.org, arnd@arndb.de,
	marc.zyngier@arm.com, catalin.marinas@arm.com, yao.qi@arm.com,
	kernel-hardening@lists.openwall.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, awallis@codeaurora.org,
	kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 10/12] arm64/kvm: context-switch ptrauth registers
Message-ID: <20180409143700.w4uynkhdon36purz@lakrids.cambridge.arm.com>
References: <20171127163806.31435-1-mark.rutland@arm.com>
 <20171127163806.31435-11-mark.rutland@arm.com>
 <20180206123847.GY21802@cbox>
 <20180309142838.uvcv3mhvqqlprktt@lakrids.cambridge.arm.com>
 <20180409125818.GE10904@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409125818.GE10904@cbox>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1585238074122761401?=
X-GMAIL-MSGID: =?utf-8?q?1597279718538719971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 02:58:18PM +0200, Christoffer Dall wrote:
> Hi Mark,
> 
> [Sorry for late reply]
> 
> On Fri, Mar 09, 2018 at 02:28:38PM +0000, Mark Rutland wrote:
> > On Tue, Feb 06, 2018 at 01:38:47PM +0100, Christoffer Dall wrote:
> > > On Mon, Nov 27, 2017 at 04:38:04PM +0000, Mark Rutland wrote:
> > > > When pointer authentication is supported, a guest may wish to use it.
> > > > This patch adds the necessary KVM infrastructure for this to work, with
> > > > a semi-lazy context switch of the pointer auth state.
> > > > 
> > > > When we schedule a vcpu, 
> > > 
> > > That's not quite what the code does, the code only does this when we
> > > schedule back a preempted or blocked vcpu thread.
> > 
> > Does that only leave the case of the vCPU being scheduled for the first
> > time? Or am I missing something else?
> > 
> > [...]
> 
> In the current patch, you're only calling kvm_arm_vcpu_ptrauth_disable()
> from kvm_arch_sched_in() which is only called on the preempt notifier
> patch, which leaves out every time we enter the guest from userspace and
> therefore also the initial run of the vCPU (assuming there's no
> preemption in the kernel prior to running the first time).
> 
> vcpu_load() takes care of all the cases.

I see.

> > > I still find this decision to begin trapping again quite arbitrary, and
> > > would at least prefer this to be in vcpu_load (which would make the
> > > behavior match the commit text as well).
> > 
> > Sure, done.
> > 
> > > My expectation would be that if a guest is running software with pointer
> > > authentication enabled, then it's likely to either keep using the
> > > feature, or not use it at all, so I would make this a one-time flag.
> > 
> > I think it's likely that some applications will use ptrauth while others
> > do not. Even if the gust OS supports ptrauth, KVM may repeatedly preempt
> > an application that doesn't use it, and we'd win in that case.
> > 
> > There are also some rarer cases, like kexec in a guest from a
> > ptrauth-aware kernel to a ptrauth-oblivious one.
> > 
> > I don't have strong feelings either way, and I have no data.
> 
> I think your intuition sounds sane, and let's reset the flag on every
> vcpu_load, and we can always revisit when we have hardware and data if
> someone reports a performance issue.

Cool. I've switched to vcpu_load() locally, and will use that in v3.

Thanks,
Mark.
