Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeBELKu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:10:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35835 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeBELKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:10:39 -0500
X-Google-Smtp-Source: AH8x2279T1zYyRgWjPSquK6G1vlJ7ncIAl945FDzJjdOGJnesC5pZ6+0DZ3maPhRMovn5+dmoBmYZw==
Date: Mon, 5 Feb 2018 12:10:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Jim Mattson <jmattson@google.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [9/8] KVM: x86: limit MSR_IA32_SPEC_CTRL access based on CPUID
 availability
Message-ID: <20180205111034.ie6vbui62wx2irkl@gmail.com>
References: <20180109120311.27565-10-pbonzini@redhat.com>
 <6dc02278-7004-1794-3705-69c8cad86be4@oracle.com>
 <CALMp9eSVC=LO-SrPkA3m6eSpgJ6X4rNCRCf3uvtJEdMG_B72cQ@mail.gmail.com>
 <beb9f9b4-7bc0-4a3a-73c2-0828febbd06c@oracle.com>
 <CALMp9eT6i9bhG005S5sqV-Y1RUhsc+AXE42ww8Ej+TXSjD6tEg@mail.gmail.com>
 <1517332457.18619.132.camel@infradead.org>
 <alpine.DEB.2.20.1801301842310.1797@nanos>
 <75049dca-3389-9cc7-44e3-a487a797c605@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75049dca-3389-9cc7-44e3-a487a797c605@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 30/01/2018 12:45, Thomas Gleixner wrote:
> > On Tue, 30 Jan 2018, David Woodhouse wrote:
> > 
> >> On Tue, 2018-01-30 at 08:57 -0800, Jim Mattson wrote:
> >>> It's really hard to tell which patches are being proposed for which
> >>> repositories, but assuming that everything else is correct, I don't
> >>> think your condition is adequate. What if the physical CPU and the
> >>> virtual CPU both have CPUID.(EAX=7H,ECX=0):EDX[26], but only the
> >>> physical CPU has CPUID.(EAX=7H,ECX=0):EDX[27]? If the guest has write
> >>> access to MSR_IA32_SPEC_CTRL, it can set MSR_IA32_SPEC_CTRL[1]
> >>> (STIBP), even though setting that bit in the guest should raise #GP.
> >>
> >> Everything we're talking about here is for tip/x86/pti. Which I note
> >> has just updated to be 4.15-based, although I thought it was going to
> >> stay on 4.14 for now. So I've updated my tree at
> >> http://git.infradead.org/linux-retpoline.git/shortlog/refs/heads/ibpb
> >> accordingly.
> > 
> > Yes, we tried to stay on 4.14 base but this started to created nasty merge
> > conflicts for no value. Merging in v4.15 turned out to resolve those issues
> > while still serving as the feed branch for Gregs stable work. For the time
> > being we try to make stable backporting at least for 4.14/15 as painless as
> > possible.
> 
> Great, then the "per-VCPU MSR bitmaps" branch
> (git://git.kernel.org/pub/scm/virt/kvm/kvm.git refs/heads/msr-bitmaps)
> that I created last weekend can be pulled directly in tip/x86/pti.

Can this branch still be rebased, to fix the SoB chain of:

  de3a0021a606 ("KVM: nVMX: Eliminate vmcs02 pool")

?

I'm not sure what workflow resulted in this commit, but it is missing your SoB:

  commit de3a0021a60635de96aa92713c1a31a96747d72c
  Author:     Jim Mattson <jmattson@google.com>
  AuthorDate: Mon Nov 27 17:22:25 2017 -0600
  Commit:     Paolo Bonzini <pbonzini@redhat.com>
  CommitDate: Sat Jan 27 09:43:03 2018 +0100

    KVM: nVMX: Eliminate vmcs02 pool
    
    The potential performance advantages of a vmcs02 pool have never been
    realized. To simplify the code, eliminate the pool. Instead, a single
    vmcs02 is allocated per VCPU when the VCPU enters VMX operation.
    
    Cc: stable@vger.kernel.org       # prereq for Spectre mitigation
    Signed-off-by: Jim Mattson <jmattson@google.com>
    Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
    Reviewed-by: Ameya More <ameya.more@oracle.com>
    Reviewed-by: David Hildenbrand <david@redhat.com>
    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>

You probably rebased Radim'm tree?

If this tree can still be rebased I'd like to re-pull it into tip:x86/pti, as
those bits are not yet upstream.

Thanks,

	Ingo
