Return-Path: <kernel-hardening-return-12325-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsjPqOaaP4P5IZYEFHtNWmq1GGm/M/hMQK0djlccfpUS3ZnbxvtXx4FX551RYbDFNmS0kjb
ARC-Seal: i=1; a=rsa-sha256; t=1520605743; cv=none;
        d=google.com; s=arc-20160816;
        b=O3vnlmtfbh834PGHpzv0pyLkwVeECVnvgd9yayc8ps/9A9hMIOPNz1Vqiix49fD6+7
         flKVNM1JkL3k2R0dvsXvqbWhEs3ROBatWb8qGrGWrICV8DGYa5g2Xs0piTcaEeNZxlQw
         BoES+xQa+TSZbvB0chKay5i4J1pS5TPxb6kMeRL2QKDnQe0eouSY7BgVItKTtPKJIuEM
         SOWP/IUCzeZFZqa7WlzPpOi0zDKGqNHDtxpqWLNyD2HHq/PdgNETin0cBi4ukrLOOC0v
         7b3tseSu/JWNLSQ7nvTPW/phYmSEEMY3zHqcrEibp7hIgKAvwzDya75RSniAZXaRlRu4
         H+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=2bAbF+6ZlMtUZB09HK0JJBSGI9onPyd8/FTpx2NVj+M=;
        b=aFg2nMQVv6TzMUbMmjmKaBZixNS4jziLjNtnA/i0m5N+h/AkrfHt6HzdtFxg00neTx
         9+l/t8RUgkfsghvvw4JXfXmgPtDGpdZdPCt7aV97n9wd/0ePoTkYMbxrpi0S/1sUcvfB
         7lfkZy1eeXVFZiPitx64tDQL/n5d17DUbIzcU0aKaBNCaSlDQL9L9DH8Fs8RRrRaQ3X2
         1zRybFjWOOp39i8eL8L7loFBuVIlhuIwBH8zCL/S+vt1qZaL4subZ2wiYsKQPiH2uGoN
         GJ3YGoTIO5/KL064KyAviUbqY3hP1xTWesNATRUsSTF/Fwr6ySkAvaTmAW1D0QpgqLRI
         +9wQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12325-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12325-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12325-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12325-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 14:28:38 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	catalin.marinas@arm.com, cdall@linaro.org,
	kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
	marc.zyngier@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
	yao.qi@arm.com, kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org, awallis@codeaurora.org
Subject: Re: [PATCHv2 10/12] arm64/kvm: context-switch ptrauth registers
Message-ID: <20180309142838.uvcv3mhvqqlprktt@lakrids.cambridge.arm.com>
References: <20171127163806.31435-1-mark.rutland@arm.com>
 <20171127163806.31435-11-mark.rutland@arm.com>
 <20180206123847.GY21802@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206123847.GY21802@cbox>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1585238074122761401?=
X-GMAIL-MSGID: =?utf-8?q?1594470688574114533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 01:38:47PM +0100, Christoffer Dall wrote:
> On Mon, Nov 27, 2017 at 04:38:04PM +0000, Mark Rutland wrote:
> > When pointer authentication is supported, a guest may wish to use it.
> > This patch adds the necessary KVM infrastructure for this to work, with
> > a semi-lazy context switch of the pointer auth state.
> > 
> > When we schedule a vcpu, 
> 
> That's not quite what the code does, the code only does this when we
> schedule back a preempted or blocked vcpu thread.

Does that only leave the case of the vCPU being scheduled for the first
time? Or am I missing something else?

[...]

> > we disable guest usage of pointer
> > authentication instructions and accesses to the keys. While these are
> > disabled, we avoid context-switching the keys. When we trap the guest
> > trying to use pointer authentication functionality, we change to eagerly
> > context-switching the keys, and enable the feature. The next time the
> > vcpu is scheduled out/in, we start again.
> > 
> > Pointer authentication consists of address authentication and generic
> > authentication, and CPUs in a system might have varied support for
> > either. Where support for either feature is not uniform, it is hidden
> > from guests via ID register emulation, as a result of the cpufeature
> > framework in the host.
> > 
> > Unfortunately, address authentication and generic authentication cannot
> > be trapped separately, as the architecture provides a single EL2 trap
> > covering both. If we wish to expose one without the other, we cannot
> > prevent a (badly-written) guest from intermittently using a feature
> > which is not uniformly supported (when scheduled on a physical CPU which
> > supports the relevant feature). 
> 
> We could choose to always trap and emulate in software in this case,
> couldn't we?  (not saying we should though).

Practically speaking, we cannot. Emulating the feature would be so
detrimental to performance as to render the feature useless --  every
function prologue/epilogue in a guest would end up trapping to hyp.

Additionally, if the algorithm is IMP DEF, we simply don't know how to
emulate it.

[...]

> Also, this patch doesn't let userspace decide if we should hide or
> expose the feature to guests, and will expose new system registers to
> userspace.  That means that on hardware supporting pointer
> authentication, with this patch, it's not possible to migrate to a
> machine which doesn't have the support.  That's probably a good thing
> (false sense of security etc.), but I wonder if we should have a
> mechanism for userspace to ask for pointer authentication in the guest
> and only if that's enabled, do we expose the feature to the guest and in
> the system register list to user space as well?

Making this an opt-in makes sense to me, given it affects migration.
I'll take a look at what we do for SVE.

[...]

> > When the guest is scheduled on a
> > physical CPU lacking the feature, these atetmps will result in an UNDEF
> 
> attempts

Whoops. Fixed.

[...]

> > +static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
> > +{
> > +	kvm_arm_vcpu_ptrauth_disable(vcpu);
> > +}
> > +
> 
> I still find this decision to begin trapping again quite arbitrary, and
> would at least prefer this to be in vcpu_load (which would make the
> behavior match the commit text as well).

Sure, done.

> My expectation would be that if a guest is running software with pointer
> authentication enabled, then it's likely to either keep using the
> feature, or not use it at all, so I would make this a one-time flag.

I think it's likely that some applications will use ptrauth while others
do not. Even if the gust OS supports ptrauth, KVM may repeatedly preempt
an application that doesn't use it, and we'd win in that case.

There are also some rarer cases, like kexec in a guest from a
ptrauth-aware kernel to a ptrauth-oblivious one.

I don't have strong feelings either way, and I have no data.

Thanks,
Mark.
