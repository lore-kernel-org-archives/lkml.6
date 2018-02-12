Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933470AbeBLJ7o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:59:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932505AbeBLJ7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:59:39 -0500
Date: Mon, 12 Feb 2018 17:59:33 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, x86@kernel.org, joro@8bytes.org,
        uobergfe@redhat.com, prarit@redhat.com
Subject: Re: [PATCH v3 0/5] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
Message-ID: <20180212095933.GA13253@localhost.localdomain>
References: <20180209121008.28980-1-bhe@redhat.com>
 <caff6f56-d8e3-1c61-e23b-1d335b6771a2@cn.fujitsu.com>
 <87wozi7pwy.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wozi7pwy.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/18 at 11:11pm, Eric W. Biederman wrote:
> Dou Liyang <douly.fnst@cn.fujitsu.com> writes:
> 
> > Hi all,
> >
> > One thing confused me.
> >
> > The disconnect_bsp_APIC() may restore the interrupt delivery mode into
> > virtual wire mode. it uses the vector F as the spurious interrput, But,
> > IMO, using the vector 0xFF(SPURIOUS_APIC_VECTOR) may more suitable and
> > will give us more detail. Why the disconnect_bsp_APIC() use vector F
> > here?
> 
> I would say this needs a documentation search before changing this.
> 
> This code originates in:
> 208fb93162d5 ("[PATCH] kexec: x86_64: restore apic virtual wire mode on shutdown")
> 
> The example in the Multi-Processor Specification v1.4 shows setting
> up the SPIV to vector 0x0f.
> 
> I don't know what is canonical and what will interact best with DOS,
> and that erra of setup.  The vector 0x0f seems an odd choice as
> it is below 0x20 putting it in the range of vectors that are
> reserved for processor exceptions.
> 
> The constant SPURIOUS_APIC_VECTOR is definitely not something we want
> to be using at this point as that is a linux specific setting and used
> when Linux is up and running.  So it is completely inapplicable.
> 
> This is all about restoring how the apics were configured at boot time
> so it may be appropriate to copy and store this value, if it was not
> architectural.
> 
> At a practical level at this point I suspect we are ok as the setting
> of the SPIV this way has not caused any known problems in the last
> decade.   If someone wants to dig through the archtectural documents
> and the real world practice and find a better value and explain the
> change I would not oppose it.
> 
> All I know for certain is using the constant SPURIOUS_APIC_VECTOR
> is completely inappropriate (as that constant is about how linux uses
> vectors) and thus the patch below is wrong.

I dig a little deep into doc and code, there are some findings:

1) In Intel® 64 and IA-32 Architectures Software Developer’s Manual and
MP-Spec, both mentioned that Spurious-Interrupt Vector Register (SVR)
should be 0xxF. For P6 family and Pentium processors, bits 0 through 3
are hardwired to logical ones. Please see 10.9 SPURIOUS INTERRUPT of
intel manual vol-3A, part 1.

2) For vector 0xf, we do have a X86_TRAP_SPURIOUS which value is 0xf. In
intel manual mentioned as above, Table 6-1. Protected-Mode Exceptions and
Interrupts, vector 15 is "(Intel reserved. Do not use.)".

3) I made a debug patch as below to print out the value of SVR at the
very beginning of system init, on a bare metal system, its value is
0x10F, means the default value of BIOS setting is 0xF for spurious
interrupt vector. 

  3.1* I tested on qemu-2.9, the printed value is 0x1ff.
  3.2* Tested with changing kdump kernel's spurious vector to 0xff, it
       works.
  3.3* Googled on internet, one guy said he ever checked bare metal
machine and vmware system, values are all 0x10f.

So agree with Eric that we should keep it as is since the value has been
there for so long time and no one met issue about it, and no
confirmative to support what value we should take, except of the example
in MP-Spec.

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 446c9ef8cfc3..739691bd3d77 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -942,6 +942,8 @@ dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
 
 void __init trap_init(void)
 {
+       unsigned int v = apic_read(APIC_SPIV);
+        pr_info("... APIC SPIV: %08x\n", v);
        /* Init cpu_entry_area before IST entries are set up */
        setup_cpu_entry_areas();

> 
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index 25ddf02598d2..550deaad6a9a 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -2130,7 +2130,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
> >         value = apic_read(APIC_SPIV);
> >         value &= ~APIC_VECTOR_MASK;
> >         value |= APIC_SPIV_APIC_ENABLED;
> > -       value |= 0xf;
> > +       value |= SPURIOUS_APIC_VECTOR;
> >         apic_write(APIC_SPIV, value);
> >
> >         if (!virt_wire_setup) {
> >
> 
> Eric
