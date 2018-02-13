Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933736AbeBMH7u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:59:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50199 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933550AbeBMH7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:59:48 -0500
X-Google-Smtp-Source: AH8x225vmFepf9R/TG/oojHOomF14bzLcuSRXjOSfqprJz1eu3jMSNtlVgIWqdNL0WpfSlpyEBAfYQ==
Date: Tue, 13 Feb 2018 08:59:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, tglx@linutronix.de,
        karahmed@amazon.de, sironi@amazon.de, x86@kernel.org,
        kvm@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jmattson@google.com, rkrcmar@redhat.com, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
Subject: Re: [PATCH v2 0/6] Spectre v2 updates
Message-ID: <20180213075943.55em5k6ofg3bfebi@gmail.com>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
 <ef5f1242-c050-3259-8c48-b3797f8c248f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef5f1242-c050-3259-8c48-b3797f8c248f@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/02/2018 00:39, David Woodhouse wrote:
> > Using retpoline ensures the kernel is safe because it doesn't contain
> > any indirect branches, but firmware still can — and we make calls into
> > firmware at runtime. Where the IBRS microcode support is available, use
> > that before calling into firmware.
> > 
> > While doing that, I noticed that we were calling C functions without
> > telling the compiler about the call-clobbered registers. Stop that.
> > 
> > This also contains the always_inline fix for the performance problem
> > introduced by retpoline in KVM code, and fixes some other issues with
> > the per-vCPU KVM handling for the SPEC_CTRL MSR.
> > 
> > Finally, update the microcode blacklist to reflect the latest
> > information from Intel.
> > 
> > v2: Drop IBRS_ALL patch for the time being
> >     Add KVM MSR fixes (karahmed)
> >     Update microcode blacklist
> > 
> > 
> > 
> > David Woodhouse (4):
> >   x86/speculation: Update Speculation Control microcode blacklist
> >   Revert "x86/speculation: Simplify
> >     indirect_branch_prediction_barrier()"
> >   KVM: x86: Reduce retpoline performance impact in
> >     slot_handle_level_range()
> >   x86/speculation: Use IBRS if available before calling into firmware
> > 
> > KarimAllah Ahmed (2):
> >   X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
> >   KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR
> >     bitmap
> > 
> >  arch/x86/include/asm/apm.h           |  6 ++++++
> >  arch/x86/include/asm/cpufeatures.h   |  1 +
> >  arch/x86/include/asm/efi.h           | 17 +++++++++++++++--
> >  arch/x86/include/asm/nospec-branch.h | 32 ++++++++++++++++++++++++++++----
> >  arch/x86/include/asm/processor.h     |  3 ---
> >  arch/x86/kernel/cpu/bugs.c           | 18 +++++++++++-------
> >  arch/x86/kernel/cpu/intel.c          |  4 ----
> >  arch/x86/kvm/mmu.c                   | 10 +++++-----
> >  arch/x86/kvm/vmx.c                   |  7 ++++---
> >  drivers/watchdog/hpwdt.c             |  3 +++
> >  10 files changed, 73 insertions(+), 28 deletions(-)
> > 
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks - I've added your Ack to the three KVM patches.

Thanks,

	Ingo
