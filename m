Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeBLJht (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:37:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34421 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932480AbeBLJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:37:46 -0500
X-Google-Smtp-Source: AH8x226oCX/u1HkRoYu7BrZLBE7LDSLJwm8h/n0JOiUgbVFwu04CmYBZkCZ8CFJ5HWJgjpmLPqh6zg==
Date: Mon, 12 Feb 2018 10:37:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dan.j.williams@intel.com,
        tglx@linutronix.de, ak@linux.intel.com, torvalds@linux-foundation.org,
        luto@kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 8/7] TESTING_ONLY x86/entry: reduce static footprint
 of idtentry
Message-ID: <20180212093742.6tj57fh7zagio3yj@gmail.com>
References: <20180211104949.12992-1-linux@dominikbrodowski.net>
 <20180211104949.12992-9-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211104949.12992-9-linux@dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Play a little trick in the generic PUSH_AND_CLEAR_REGS macro
> to insert the GP registers "above" the original return address.
> This allows us to (re-)insert the macro in error_entry() and
> paranoid_entry() and to remove it from the idtentry macro. This
> reduces the static footprint significantly.
> 
> NOTE: It still needs to be evaluated whether the reduced static
> footprint at the cost of code readability is really needed here.
> 
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  arch/x86/entry/calling.h  | 11 ++++++++++-
>  arch/x86/entry/entry_64.S | 21 ++++++++++-----------
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index 6985440c68fa..2d4523ba04a8 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -97,7 +97,7 @@ For 32-bit we have the following conventions - kernel is built with
>  
>  #define SIZEOF_PTREGS	21*8
>  
> -.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
> +.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
>  	/*
>  	 * Push registers and sanitize registers of values that a
>  	 * speculation attack might otherwise want to exploit. The
> @@ -105,8 +105,14 @@ For 32-bit we have the following conventions - kernel is built with
>  	 * could be put to use in a speculative execution gadget.
>  	 * Interleave XOR with PUSH for better uop scheduling:
>  	 */
> +	.if \save_ret
> +	pushq	%rsi		/* pt_regs->si */
> +	movq	8(%rsp), %rsi	/* temporarily store ret address in %rsi */
> +	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original ret) */
> +	.else
>  	pushq   %rdi		/* pt_regs->di */
>  	pushq   %rsi		/* pt_regs->si */
> +	.endif
>  	pushq	\rdx		/* pt_regs->dx */
>  	pushq   %rcx		/* pt_regs->cx */
>  	pushq   \rax		/* pt_regs->ax */
> @@ -131,6 +137,9 @@ For 32-bit we have the following conventions - kernel is built with
>  	pushq	%r15		/* pt_regs->r15 */
>  	xorq    %r15, %r15	/* nospec   r15*/
>  	UNWIND_HINT_REGS
> +	.if \save_ret
> +	pushq	%rsi		/* return address on top of stack */
> +	.endif
>  .endm
>  
>  .macro POP_REGS pop_rdi=1 skip_r11rcx=0
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index b868433d7e68..a2e41177e390 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -871,12 +871,8 @@ ENTRY(\sym)
>  	pushq	$-1				/* ORIG_RAX: no syscall to restart */
>  	.endif
>  
> -	/* Save all registers in pt_regs */
> -	PUSH_AND_CLEAR_REGS
> -	ENCODE_FRAME_POINTER
> -
>  	.if \paranoid < 2
> -	testb	$3, CS(%rsp)			/* If coming from userspace, switch stacks */
> +	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
>  	jnz	.Lfrom_usermode_switch_stack_\@
>  	.endif
>  
> @@ -1123,12 +1119,15 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
>  #endif
>  
>  /*
> - * Switch gs if needed.
> + * Save all registers in pt_regs, and switch gs if needed.
>   * Use slow, but surefire "are we in kernel?" check.
>   * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
>   */
>  ENTRY(paranoid_entry)
> +	UNWIND_HINT_FUNC
>  	cld
> +	PUSH_AND_CLEAR_REGS save_ret=1
> +	ENCODE_FRAME_POINTER 8
>  	movl	$1, %ebx
>  	movl	$MSR_GS_BASE, %ecx
>  	rdmsr
> @@ -1141,7 +1140,7 @@ ENTRY(paranoid_entry)
>  	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
>  
>  	ret
> -ENDPROC(paranoid_entry)
> +END(paranoid_entry)
>  
>  /*
>   * "Paranoid" exit path from exception stack.  This is invoked
> @@ -1172,12 +1171,14 @@ ENTRY(paranoid_exit)
>  END(paranoid_exit)
>  
>  /*
> - * Switch gs if needed.
> + * Save all registers in pt_regs, and switch gs if needed.
>   * Return: EBX=0: came from user mode; EBX=1: otherwise
>   */
>  ENTRY(error_entry)
> -	UNWIND_HINT_REGS offset=8
> +	UNWIND_HINT_FUNC
>  	cld
> +	PUSH_AND_CLEAR_REGS save_ret=1
> +	ENCODE_FRAME_POINTER 8
>  	testb	$3, CS+8(%rsp)
>  	jz	.Lerror_kernelspace
>  
> @@ -1568,8 +1569,6 @@ end_repeat_nmi:
>  	 * frame to point back to repeat_nmi.
>  	 */
>  	pushq	$-1				/* ORIG_RAX: no syscall to restart */
> -	PUSH_AND_CLEAR_REGS
> -	ENCODE_FRAME_POINTER
>  
>  	/*
>  	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit

Ok, so this does not look _that_ complicated, and the .text savings are 
significant:

   text    data     bss     dec     hex filename
  24182       0       0   24182    5e76 entry_64.o.before
  20878       0       0   20878    518e entry_64.o.after

But, let's try to estimate the dynamic I$ impact through the static entry points. 

I'm using the following list of 'static' IDT entry points:

    divide_error
    overflow
    bounds
    invalid_op
    device_not_available
    double_fault
    coprocessor_segment_overrun
    invalid_TSS
    segment_not_present
    spurious_interrupt_bug
    coprocessor_error
    alignment_check
    simd_coprocessor_error
    debug
    int3
    stack_segment
    general_protection
    page_fault
    machine_check
    nmi
    apic_timer_interrupt
    x86_platform_ipi
    threshold_interrupt
    deferred_error_interrupt
    thermal_interrupt
    call_function_single_interrupt
    call_function_interrupt
    reschedule_interrupt
    error_interrupt
    spurious_interrupt
    irq_work_interrupt

Which are present in the vmlinux with well-known addresses - this makes I$ 
estimates easier.

But let's first filter these entries - a big chunk of them are legacy vectors, 
never used on a modern x86 CPU built in the last decade or so. Another chunk are 
infrequent entries like <machine_check>.

The entry points that are relevant to an I$ analysis are just 11 entry points:

    divide_error
                                       # overflow
                                       # bounds
                                       # invalid_op
                                       # device_not_available
                                       # double_fault
                                       # coprocessor_segment_overrun
                                       # invalid_TSS
                                       # segment_not_present
                                       # spurious_interrupt_bug
                                       # coprocessor_error
                                       # alignment_check
                                       # simd_coprocessor_error
    debug
    int3
                                       # stack_segment
    general_protection
    page_fault
                                       # machine_check
    nmi
    apic_timer_interrupt
                                       # x86_platform_ipi
                                       # threshold_interrupt
                                       # deferred_error_interrupt
                                       # thermal_interrupt
    call_function_single_interrupt
    call_function_interrupt
    reschedule_interrupt
                                       # error_interrupt
                                       # spurious_interrupt
    irq_work_interrupt


( Also note that even this list is probably generous: for example 
  <apic_timer_interrupt> will only arrive once per timer IRQ, by which time it's 
  probably already out of the L1 cache - and <debug> only matters to a small 
  minority of users. )

Here's the x86-64 defconfig addresses of these entry points, on a 'vanilla' kernel 
that does not have any entry point bloating (and debloating) patches applied, sha1 
b7a60525e83a:

      address           symbol                               # size # offs
      ----------------  ------------------------------------ -------------
      ffffffff81a00e70: <divide_error>                       #   40 #    0
      ffffffff81a01250: <debug>                              #   60 #  3e0
      ffffffff81a012b0: <int3>                               #   60 #   60
      ffffffff81a01370: <general_protection>                 #   60 #   c0
      ffffffff81a013d0: <page_fault>                         #   60 #   60
      ffffffff81a01680: <nmi>                                #   cc #  2b0
      ffffffff81a01a40: <apic_timer_interrupt>               #   c0 #  3c0
      ffffffff81a01e00: <call_function_single_interrupt>     #   c0 #  3c0
      ffffffff81a01ec0: <call_function_interrupt>            #   c0 #   c0
      ffffffff81a01f80: <reschedule_interrupt>               #   c0 #   c0
      ffffffff81a021c0: <irq_work_interrupt>                 #   c0 #  240

The 'size' column is the size of the entry function, the 'offs' column shows the 
symbol's offset from the previous entry.

As can be seen in the table:

- even in the 'compressed' layout the entries are already far enough from each 
  other to make the dynamic I$ footprint 27 cachelines, assuming 64 byte 
  cachelines:

    27 == 1 + 2 + 2 + 2 + 2 + 3 + 3 + 3 + 3 + 3

After applying the simplification patches (sha: 5a10e729bc0a) the static footprint 
of the entry code becomes more bloated:

   text    data     bss     dec     hex filename
  19693       0       0   19693    4ced arch/x86/entry/entry_64.o.before
  24212       0       0   24212    5e94 arch/x86/entry/entry_64.o.after    (+4519 bytes)

But the dynamic I$ footprint does not change nearly as much:

      address           symbol                               # size # offs
      ----------------  ------------------------------------ -------------
      ffffffff81a00d00: <divide_error>                       #   70 #    0
      ffffffff81a01320: <debug>                              #   90 #  620
      ffffffff81a013b0: <int3>                               #   90 #   90
      ffffffff81a014c0: <general_protection>                 #   80 #  110
      ffffffff81a01540: <page_fault>                         #   80 #   80
      ffffffff81a01780: <nmi>                                #   cc #  240
      ffffffff81a01b70: <apic_timer_interrupt>               #   80 #  3f0
      ffffffff81a01df0: <call_function_single_interrupt>     #   80 #  280
      ffffffff81a01e70: <call_function_interrupt>            #   80 #   80
      ffffffff81a01ef0: <reschedule_interrupt>               #   80 #   80
      ffffffff81a02070: <irq_work_interrupt>                 #   80 #  180

The footprint is in fact 25 cache lines:

    25 == 2 + 3 + 3 + 2 + 2 + 3 + 2 + 2 + 2 + 2 + 2

The reason is that while exception entry size increased, the IRQ entry size 
actually shrunk, because the PUSH based sequences are more compact than the MOVs 
they used before:

# BEFORE:

ffffffff81a01f80 <reschedule_interrupt>:
[...]
ffffffff81a01f98:       48 83 c4 88             add    $0xffffffffffffff88,%rsp
ffffffff81a01f9c:       4c 89 5c 24 30          mov    %r11,0x30(%rsp)
ffffffff81a01fa1:       4c 89 54 24 38          mov    %r10,0x38(%rsp)
ffffffff81a01fa6:       4c 89 4c 24 40          mov    %r9,0x40(%rsp)
ffffffff81a01fab:       4c 89 44 24 48          mov    %r8,0x48(%rsp)
ffffffff81a01fb0:       48 89 44 24 50          mov    %rax,0x50(%rsp)
ffffffff81a01fb5:       48 89 4c 24 58          mov    %rcx,0x58(%rsp)
ffffffff81a01fba:       48 89 54 24 60          mov    %rdx,0x60(%rsp)
ffffffff81a01fbf:       48 89 74 24 68          mov    %rsi,0x68(%rsp)
ffffffff81a01fc4:       48 89 7c 24 70          mov    %rdi,0x70(%rsp)
ffffffff81a01fc9:       4c 89 3c 24             mov    %r15,(%rsp)
ffffffff81a01fcd:       4c 89 74 24 08          mov    %r14,0x8(%rsp)
ffffffff81a01fd2:       4c 89 6c 24 10          mov    %r13,0x10(%rsp)
ffffffff81a01fd7:       4c 89 64 24 18          mov    %r12,0x18(%rsp)
ffffffff81a01fdc:       48 89 6c 24 20          mov    %rbp,0x20(%rsp)
ffffffff81a01fe1:       48 89 5c 24 28          mov    %rbx,0x28(%rsp)
ffffffff81a01fe6:       31 ed                   xor    %ebp,%ebp
ffffffff81a01fe8:       31 db                   xor    %ebx,%ebx
ffffffff81a01fea:       4d 31 c0                xor    %r8,%r8
ffffffff81a01fed:       4d 31 c9                xor    %r9,%r9
ffffffff81a01ff0:       4d 31 d2                xor    %r10,%r10
ffffffff81a01ff3:       4d 31 db                xor    %r11,%r11
ffffffff81a01ff6:       4d 31 e4                xor    %r12,%r12
ffffffff81a01ff9:       4d 31 ed                xor    %r13,%r13
ffffffff81a01ffc:       4d 31 f6                xor    %r14,%r14
ffffffff81a01fff:       4d 31 ff                xor    %r15,%r15

# AFTER:

ffffffff81a01ef0 <reschedule_interrupt>:
[...]
ffffffff81a01f08:       57                      push   %rdi
ffffffff81a01f09:       56                      push   %rsi
ffffffff81a01f0a:       52                      push   %rdx
ffffffff81a01f0b:       51                      push   %rcx
ffffffff81a01f0c:       50                      push   %rax
ffffffff81a01f0d:       41 50                   push   %r8
ffffffff81a01f0f:       4d 31 c0                xor    %r8,%r8
ffffffff81a01f12:       41 51                   push   %r9
ffffffff81a01f14:       4d 31 c9                xor    %r9,%r9
ffffffff81a01f17:       41 52                   push   %r10
ffffffff81a01f19:       4d 31 d2                xor    %r10,%r10
ffffffff81a01f1c:       41 53                   push   %r11
ffffffff81a01f1e:       4d 31 db                xor    %r11,%r11
ffffffff81a01f21:       53                      push   %rbx
ffffffff81a01f22:       31 db                   xor    %ebx,%ebx
ffffffff81a01f24:       55                      push   %rbp
ffffffff81a01f25:       31 ed                   xor    %ebp,%ebp
ffffffff81a01f27:       41 54                   push   %r12
ffffffff81a01f29:       4d 31 e4                xor    %r12,%r12
ffffffff81a01f2c:       41 55                   push   %r13
ffffffff81a01f2e:       4d 31 ed                xor    %r13,%r13
ffffffff81a01f31:       41 56                   push   %r14
ffffffff81a01f33:       4d 31 f6                xor    %r14,%r14
ffffffff81a01f36:       41 57                   push   %r15
ffffffff81a01f38:       4d 31 ff                xor    %r15,%r15

Finally, applying the 8/7 debloating patch gives the following result:

      address           symbol                               # size # offs
      ----------------  ------------------------------------ -------------
      ffffffff81a00d00: <divide_error>                       #   40 #    0
      ffffffff81a010b0: <debug>                              #   50 #  3b0
      ffffffff81a01100: <int3>                               #   50 #   50
      ffffffff81a011a0: <general_protection>                 #   50 #   a0
      ffffffff81a011f0: <page_fault>                         #   50 #   50
      ffffffff81a01450: <nmi>                                #   cc #  260
      ffffffff81a01810: <apic_timer_interrupt>               #   80 #  3c0
      ffffffff81a01a90: <call_function_single_interrupt>     #   80 #  280
      ffffffff81a01b10: <call_function_interrupt>            #   80 #   80
      ffffffff81a01b90: <reschedule_interrupt>               #   80 #   80
      ffffffff81a01d10: <irq_work_interrupt>                 #   80 #  180

That's 22 cachelines:

    22 == 1 + 2 + 2 + 2 + 2 + 3 + 2 + 2 + 2 + 2 + 2
    25 == 2 + 3 + 3 + 2 + 2 + 3 + 2 + 2 + 2 + 2 + 2

So it's a 3 cachelines improvements, coming from the smaller size of these three 
entry points:

      ffffffff81a00d00: <divide_error>                       #   40 #    0
      ffffffff81a010b0: <debug>                              #   50 #  3b0
      ffffffff81a01100: <int3>                               #   50 #   50

... which are all debugging/instrumentation related and are thus performance 
critical only for a small minority of our users.

So I'm torn whether to apply this last patch, but the interesting, unintuitive 
result is that the existing MOV->PUSH simplification patches already appear to 
have improved the dynamic I$ footprint from 27 cachelines to 22 cachelines!

Thanks,

	Ingo
