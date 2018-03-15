Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeCORCL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:02:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751834AbeCORCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:02:09 -0400
Date: Thu, 15 Mar 2018 18:02:03 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
Message-ID: <20180315170202.GA5180@flask>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-8-vkuznets@redhat.com>
 <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com>
 <87zi399xih.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zi399xih.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-15 16:19+0100, Vitaly Kuznetsov:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On 09/03/2018 15:02, Vitaly Kuznetsov wrote:
> >> Enlightened VMCS is just a structure in memory, the main benefit
> >> besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
> >> mask: we tell the underlying hypervisor which fields were modified
> >> since VMEXIT so there's no need to inspect them all.
> >> 
> >> Tight CPUID loop test shows significant speedup:
> >> Before: 18890 cycles
> >> After: 8304 cycles
> >> 
> >> Static key is being used to avoid performance penalty for non-Hyper-V
> >> deployments. Tests show we add around 3 (three) CPU cycles on each
> >> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
> >> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
> >> but I don't see a clean way to use static key in assembly.
> >
> > If you want to live dangerously, you can use text_poke_early to change
> > the vmwrite to mov.  It's just a single instruction, so it's probably
> > not too hard.
> 
> It is not:
> 
> +#if IS_ENABLED(CONFIG_HYPERV) && defined(CONFIG_X86_64)
> +
> +/* Luckily, both original and new instructions are of the same length */
> +#define EVMCS_RSP_OPCODE_LEN 3
> +static evmcs_patch_vmx_cpu_run(void)
> +{
> +       u8 *addr;
> +       u8 opcode_old[] = {0x0f, 0x79, 0xd4}; // vmwrite rsp, rdx
> +       u8 opcode_new[] = {0x48, 0x89, 0x26}; // mov rsp, (rsi)
> +
> +       /*
> +        * What we're searching for MUST be present in vmx_cpu_run().
> +        * We replace the first occurance only.
> +        */
> +       for (addr = (u8 *)vmx_vcpu_run; ; addr++) {
> +               if (!memcmp(addr, opcode_old, EVMCS_RSP_OPCODE_LEN)) {
> +                       /*
> +                        * vmx_vcpu_run is not currently running on other CPUs but
> +                        * using text_poke_early() would require us to do manual
> +                        * RW remapping of the area.
> +                        */
> +                       text_poke(addr, opcode_new, EVMCS_RSP_OPCODE_LEN);
> +                       break;
> +               }
> +       }
> +}
> +#endif
> +
> 
> text_poke() also needs to be exported.
> 
> This works. But hell, this is a crude hack :-) Not sure if there's a
> cleaner way to find what needs to be patched without something like jump
> label table ...

Yeah, I can see us accidently patching parts of other instructions. :)

The target instruction address can be made into a C-accessible symbol
with the same trick that vmx_return uses -- add a .global containing the
address of a label (not sure if a more direct approach would work).

The evil in me likes it.  (The good is too lazy to add a decent patching
infrastructure for just one user.)

I would be a bit happier if we didn't assume the desired instruction and
therefore put constraints on a remote code.
We actually already have mov in the assembly:

  "cmp %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
  "je 1f \n\t"
  "mov %%" _ASM_SP ", %c[host_rsp](%0) \n\t" // here
  __ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
  "1: \n\t"

Is there a drawback in switching '%c[host_rsp](%0)' to be a general
memory pointer and put either &vmx->host_rsp or &current_evmcs->host_rsp
in there?

We could just overwrite ASM_VMX_VMWRITE_RSP_RDX with a nop then. :)

Thanks.
