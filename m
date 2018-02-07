Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeBGRL4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:11:56 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59101 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754463AbeBGRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:11:54 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, uobergfe@redhat.com, prarit@redhat.com
References: <20180125141134.25053-1-bhe@redhat.com>
        <20180125141134.25053-2-bhe@redhat.com>
Date: Wed, 07 Feb 2018 11:11:35 -0600
In-Reply-To: <20180125141134.25053-2-bhe@redhat.com> (Baoquan He's message of
        "Thu, 25 Jan 2018 22:11:33 +0800")
Message-ID: <87h8qsd8s8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ejTG7-0007lx-QR;;;mid=<87h8qsd8s8.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18OAIJ3UV9D8yFpkJSW4glKiZ96HBGdKKg=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Baoquan He <bhe@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3157 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.1%), b_tie_ro: 2.0 (0.1%), parse: 1.72 (0.1%),
        extract_message_metadata: 79 (2.5%), get_uri_detail_list: 28 (0.9%),
        tests_pri_-1000: 22 (0.7%), tests_pri_-950: 9 (0.3%), tests_pri_-900: 9
        (0.3%), tests_pri_-400: 129 (4.1%), check_bayes: 126 (4.0%), b_tokenize: 62
        (2.0%), b_tok_get_all: 29 (0.9%), b_comp_prob: 11 (0.3%), b_tok_touch_all: 11
        (0.4%), b_finish: 1.57 (0.0%), tests_pri_0: 2787 (88.3%),
        check_dkim_signature: 6 (0.2%), check_dkim_adsp: 27 (0.8%), tests_pri_500: 23
        (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/2] x86/apic/kexec: Enable legacy irq mode before jump to kexec/kdump kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> On kvm guest, kernel always prints warning during kdump kernel boots as
> below.
>
> [    0.001000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1467 setup_local_APIC+0x228/0x330
> [    0.001000] Modules linked in:
> [    0.001000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc5+ #3
> [    0.001000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
> [    0.001000] RIP: 0010:setup_local_APIC+0x228/0x330
> [    0.001000] RSP: 0000:ffffffffb6e03eb8 EFLAGS: 00010286
> [    0.001000] RAX: 0000009edb4c4d84 RBX: 0000000000000000 RCX: 00000000b099d800
> [    0.001000] RDX: 0000009e00000000 RSI: 0000000000000000 RDI: 0000000000000810
> [    0.001000] RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000001
> [    0.001000] R10: ffff98ce6a801c00 R11: 0761076d072f0776 R12: 0000000000000001
> [    0.001000] R13: 00000000000000f0 R14: 0000000000004000 R15: ffffffffffffc6ff
> [    0.001000] FS:  0000000000000000(0000) GS:ffff98ce6bc00000(0000) knlGS:0000000000000000
> [    0.001000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.001000] CR2: 00000000ffffffff CR3: 0000000022209000 CR4: 00000000000406b0
> [    0.001000] Call Trace:
> [    0.001000]  apic_bsp_setup+0x56/0x74
> [    0.001000]  x86_late_time_init+0x11/0x16
> [    0.001000]  start_kernel+0x3c9/0x486
> [    0.001000]  secondary_startup_64+0xa5/0xb0
> [    0.001000] Code: 00 85 c9 74 2d 0f 31 c1 e1 0a 48 c1 e2 20 41 89 cf 4c 03 7c 24 08 48 09 d0 49 29 c7 4c 89 3c 24 48 83 3c 24 00 0f 8f 8f fe ff
> ff <0f> ff e9 10 ff ff ff 48 83 2c 24 01 eb e7 48 83 c4 18 5b 5d 41
> [    0.001000] ---[ end trace b88e71b9a6ebebdd ]---
> [    0.001000] masked ExtINT on CPU#0
>
> The root cause is the legacy irq mode is disabled before jump to kexec/kdump
> kernel since commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown
> of the local APIC"). In that commit, lapic_shutdown() calling was moved after
> disable_IO_APIC(). In fact in disable_IO_APIC(), it not only calls
> clear_IO_APIC() to disable IO-APIC, and also sets LAPIC and IO-APIC to make
> system be PIC or Virtual wire mode. Hence local APIC is disabled completely
> by the calling of lapic_shutdown().

The actions of lapic_shutdown do not depend on the actions of
disable_IO_APIC so this description and justificaiton are nonsense.

Further we don't hardware disable the local APIC except when we hardware
enable it.  And only on 32bit at that.

I keep wondering if the above oops is due to an emulation bug in kvm.
If that is the case it might be better to fix kvm.

> Later in kdump kernel, when calling setup_local_APIC(), the
> 'do { xxx } while (queued && max_loops > 0)' loop does not function well any
> more if pending irq exists in APIC IRR since LAPIC is disabled. The do while
> loop will terminate finally when max_loops overflows by subtraction. Then,
> next WARN_ON(max_loops <= 0) is triggered.

That sounds like what needs to be fixed.  That loop in the kernel
startup.  Ideally the linux kernel will be as robust as possible during
startup especially for the kdump case.

> In normal kernel it defaults to be PIC mode or Virtual Wire mode which is
> done by BIOS. But kexec/kdump kernel won't go through BIOS, we need set
> system as PIC or Virtual Wire mode before jump to kdump kernel code directly.
> With this the pending irq can be handled correclty before APIC mode
> enabling.

Nope that is not the fix.

> So take clear_IO_APIC out of disable_IO_APIC, and rename disable_IO_APIC
> as switch_to_legacy_irq_mode. Then only call clear_IO_APIC when IO-APIC
> need be disabled. And call switch_to_legacy_irq_mode before kexec/kdump
> jumping.

All I can see your code change accomplishing is moving the entry into
legacy irq mode later and thus somehow avoiding the generating of the
interrupts that are problematic at startup.


As for the change itself it is incredibly ugly.  It extends a hack
for the KEXEC_JUMP path into the default case.  When we should probably
be removing the KEXEC_JUMP code entirely.

KEXEC_JUMP was a very nice idea but I don't believe anyone except for
the developer actually used KEXEC_JUMP.  Certainly KEXEC_JUMP needs some
aditional love if it is going to be used long term.  If we were to port
suspend to ram to KEXEC_JUMP it would be worth preserving.

I do think the ordering in native_machine_shutdown between
disable_IO_APIC and local_irq_disable is a bit fishy.  So you might be
able to play with that and get some improvement.

For the kdump we definitely need to revisit:
3d1675b41b02 ("[PATCH] i386 kexec-on-panic: Don't shutdown the apics.")
And just not touch the apics at all.

If the kernel boot path is ready that would be an ideal way to solve
things.

Additionaly for any BIOS that does not trigger a hardware reset this
change which removes the return to legacy mode on the normal reboot path
is likely to break the reboot path.

Eric


> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/include/asm/io_apic.h     |  3 ++-
>  arch/x86/kernel/apic/io_apic.c     | 12 ++++--------
>  arch/x86/kernel/crash.c            |  2 +-
>  arch/x86/kernel/machine_kexec_32.c | 15 +++++----------
>  arch/x86/kernel/machine_kexec_64.c | 15 +++++----------
>  arch/x86/kernel/reboot.c           |  2 +-
>  6 files changed, 18 insertions(+), 31 deletions(-)
>
> diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
> index a8834dd546cd..e38ad3863a2c 100644
> --- a/arch/x86/include/asm/io_apic.h
> +++ b/arch/x86/include/asm/io_apic.h
> @@ -192,7 +192,8 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
>  
>  extern void setup_IO_APIC(void);
>  extern void enable_IO_APIC(void);
> -extern void disable_IO_APIC(void);
> +extern void clear_IO_APIC (void);
> +extern void switch_to_legacy_irq_mode(void);
>  extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
>  extern void print_IO_APICs(void);
>  #else  /* !CONFIG_X86_IO_APIC */
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 8a7963421460..a47aa915d18c 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -587,7 +587,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
>  		       mpc_ioapic_id(apic), pin);
>  }
>  
> -static void clear_IO_APIC (void)
> +void clear_IO_APIC (void)
>  {
>  	int apic, pin;
>  
> @@ -1439,15 +1439,11 @@ void native_disable_io_apic(void)
>  }
>  
>  /*
> - * Not an __init, needed by the reboot code
> + * Not an __init, needed by kexec/kdump code.
> + * For safety IO-APIC and Local APIC need be cleared before this.
>   */
> -void disable_IO_APIC(void)
> +void switch_to_legacy_irq_mode(void)
>  {
> -	/*
> -	 * Clear the IO-APIC before rebooting:
> -	 */
> -	clear_IO_APIC();
> -
>  	if (!nr_legacy_irqs())
>  		return;
>  
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 10e74d4778a1..318ffeaaf55a 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -199,7 +199,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  #ifdef CONFIG_X86_IO_APIC
>  	/* Prevent crash_kexec() from deadlocking on ioapic_lock. */
>  	ioapic_zap_locks();
> -	disable_IO_APIC();
> +	clear_IO_APIC();
>  #endif
>  	lapic_shutdown();
>  #ifdef CONFIG_HPET_TIMER
> diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> index edfede768688..7ab10d930cc6 100644
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -190,18 +190,13 @@ void machine_kexec(struct kimage *image)
>  	local_irq_disable();
>  	hw_breakpoint_disable();
>  
> -	if (image->preserve_context) {
>  #ifdef CONFIG_X86_IO_APIC
> -		/*
> -		 * We need to put APICs in legacy mode so that we can
> -		 * get timer interrupts in second kernel. kexec/kdump
> -		 * paths already have calls to disable_IO_APIC() in
> -		 * one form or other. kexec jump path also need
> -		 * one.
> -		 */
> -		disable_IO_APIC();
> +	/*
> +	 * We need to put APICs in legacy mode so that we can
> +	 * get timer interrupts in second kernel.
> +	 */
> +	switch_to_legacy_irq_mode();
>  #endif
> -	}
>  
>  	control_page = page_address(image->control_code_page);
>  	memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1f790cf9d38f..b5c0cbed6791 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -288,18 +288,13 @@ void machine_kexec(struct kimage *image)
>  	local_irq_disable();
>  	hw_breakpoint_disable();
>  
> -	if (image->preserve_context) {
>  #ifdef CONFIG_X86_IO_APIC
> -		/*
> -		 * We need to put APICs in legacy mode so that we can
> -		 * get timer interrupts in second kernel. kexec/kdump
> -		 * paths already have calls to disable_IO_APIC() in
> -		 * one form or other. kexec jump path also need
> -		 * one.
> -		 */
> -		disable_IO_APIC();
> +	/*
> +	 * We need to put APICs in legacy mode so that we can
> +	 * get timer interrupts in second kernel.
> +	 */
> +	switch_to_legacy_irq_mode();
>  #endif
> -	}
>  
>  	control_page = page_address(image->control_code_page) + PAGE_SIZE;
>  	memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 2126b9d27c34..b70cc0f38a29 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -666,7 +666,7 @@ void native_machine_shutdown(void)
>  	 * Even without the erratum, it still makes sense to quiet IO APIC
>  	 * before disabling Local APIC.
>  	 */
> -	disable_IO_APIC();
> +	clear_IO_APIC();
>  #endif
>  
>  #ifdef CONFIG_SMP
