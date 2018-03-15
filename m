Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeCOPT4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:19:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752254AbeCOPTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:19:55 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on Hyper-V
References: <20180309140249.2840-1-vkuznets@redhat.com>
        <20180309140249.2840-8-vkuznets@redhat.com>
        <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com>
Date: Thu, 15 Mar 2018 16:19:50 +0100
In-Reply-To: <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com> (Paolo
        Bonzini's message of "Wed, 14 Mar 2018 15:53:32 +0100")
Message-ID: <87zi399xih.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/03/2018 15:02, Vitaly Kuznetsov wrote:
>> Enlightened VMCS is just a structure in memory, the main benefit
>> besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
>> mask: we tell the underlying hypervisor which fields were modified
>> since VMEXIT so there's no need to inspect them all.
>> 
>> Tight CPUID loop test shows significant speedup:
>> Before: 18890 cycles
>> After: 8304 cycles
>> 
>> Static key is being used to avoid performance penalty for non-Hyper-V
>> deployments. Tests show we add around 3 (three) CPU cycles on each
>> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
>> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
>> but I don't see a clean way to use static key in assembly.
>
> If you want to live dangerously, you can use text_poke_early to change
> the vmwrite to mov.  It's just a single instruction, so it's probably
> not too hard.

It is not:

+#if IS_ENABLED(CONFIG_HYPERV) && defined(CONFIG_X86_64)
+
+/* Luckily, both original and new instructions are of the same length */
+#define EVMCS_RSP_OPCODE_LEN 3
+static evmcs_patch_vmx_cpu_run(void)
+{
+       u8 *addr;
+       u8 opcode_old[] = {0x0f, 0x79, 0xd4}; // vmwrite rsp, rdx
+       u8 opcode_new[] = {0x48, 0x89, 0x26}; // mov rsp, (rsi)
+
+       /*
+        * What we're searching for MUST be present in vmx_cpu_run().
+        * We replace the first occurance only.
+        */
+       for (addr = (u8 *)vmx_vcpu_run; ; addr++) {
+               if (!memcmp(addr, opcode_old, EVMCS_RSP_OPCODE_LEN)) {
+                       /*
+                        * vmx_vcpu_run is not currently running on other CPUs but
+                        * using text_poke_early() would require us to do manual
+                        * RW remapping of the area.
+                        */
+                       text_poke(addr, opcode_new, EVMCS_RSP_OPCODE_LEN);
+                       break;
+               }
+       }
+}
+#endif
+

text_poke() also needs to be exported.

This works. But hell, this is a crude hack :-) Not sure if there's a
cleaner way to find what needs to be patched without something like jump
label table ...

-- 
  Vitaly
