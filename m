Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeEBWM7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:12:59 -0400
Received: from www62.your-server.de ([213.133.104.62]:52977 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEBWM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:12:56 -0400
Subject: Re: [PATCH v5] bpf, x86_32: add eBPF JIT compiler for ia32
To: Wang YanQing <udknight@gmail.com>, ast@kernel.org,
        illusionist.neo@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, davem@davemloft.net, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180429123723.GA7309@udknight>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <daad73b8-7a87-1c70-130a-d71582a92c40@iogearbox.net>
Date: Thu, 3 May 2018 00:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180429123723.GA7309@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On 04/29/2018 02:37 PM, Wang YanQing wrote:
> The JIT compiler emits ia32 bit instructions. Currently, It supports eBPF
> only. Classic BPF is supported because of the conversion by BPF core.
> 
> Almost all instructions from eBPF ISA supported except the following:
> BPF_ALU64 | BPF_DIV | BPF_K
> BPF_ALU64 | BPF_DIV | BPF_X
> BPF_ALU64 | BPF_MOD | BPF_K
> BPF_ALU64 | BPF_MOD | BPF_X
> BPF_STX | BPF_XADD | BPF_W
> BPF_STX | BPF_XADD | BPF_DW
> 
> It doesn't support BPF_JMP|BPF_CALL with BPF_PSEUDO_CALL at the moment.
> 
> IA32 has few general purpose registers, EAX|EDX|ECX|EBX|ESI|EDI. I use
> EAX|EDX|ECX|EBX as temporary registers to simulate instructions in eBPF
> ISA, and allocate ESI|EDI to BPF_REG_AX for constant blinding, all others
> eBPF registers, R0-R10, are simulated through scratch space on stack.
> 
[...]
> 
> The numbers show we get 30%~50% improvement.
> 
> See Documentation/networking/filter.txt for more information.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Sorry for the delay. There's still a memory leak in this patch I found
while reviewing, more below and how to fix it. Otherwise few small nits
that would be nice to address in the respin along with it.

> ---
>  Changes v4-v5:
>  1:Delete is_on_stack, BPF_REG_AX is the only one
>    on real hardware registers, so just check with
>    it.
>  2:Apply commit 1612a981b766 ("bpf, x64: fix JIT emission
>    for dead code"), suggested by Daniel Borkmann.
>  
>  Changes v3-v4:
>  1:Fix changelog in commit.
>    I install llvm-6.0, then test_progs willn't report errors.
>    I submit another patch:
>    "bpf: fix misaligned access for BPF_PROG_TYPE_PERF_EVENT program type on x86_32 platform"
>    to fix another problem, after that patch, test_verifier willn't report errors too.
>  2:Fix clear r0[1] twice unnecessarily in *BPF_IND|BPF_ABS* simulation.
> 
>  Changes v2-v3:
>  1:Move BPF_REG_AX to real hardware registers for performance reason.
>  3:Using bpf_load_pointer instead of bpf_jit32.S, suggested by Daniel Borkmann.
>  4:Delete partial codes in 1c2a088a6626, suggested by Daniel Borkmann.
>  5:Some bug fixes and comments improvement.
> 
>  Changes v1-v2:
>  1:Fix bug in emit_ia32_neg64.
>  2:Fix bug in emit_ia32_arsh_r64.
>  3:Delete filename in top level comment, suggested by Thomas Gleixner.
>  4:Delete unnecessary boiler plate text, suggested by Thomas Gleixner.
>  5:Rewrite some words in changelog.
>  6:CodingSytle improvement and a little more comments.
> 
>  arch/x86/Kconfig                     |    2 +-
>  arch/x86/include/asm/nospec-branch.h |   26 +-
>  arch/x86/net/Makefile                |    9 +-
>  arch/x86/net/bpf_jit_comp32.c        | 2527 ++++++++++++++++++++++++++++++++++
>  4 files changed, 2559 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/net/bpf_jit_comp32.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 00fcf81..1f5fa2f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -137,7 +137,7 @@ config X86
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
> -	select HAVE_EBPF_JIT			if X86_64
> +	select HAVE_EBPF_JIT
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_EXIT_THREAD
>  	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index f928ad9..a4c7ca4 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -291,14 +291,17 @@ static inline void indirect_branch_prediction_barrier(void)
>   *    lfence
>   *    jmp spec_trap
>   *  do_rop:
> - *    mov %rax,(%rsp)
> + *    mov %rax,(%rsp) for x86_64
> + *    mov %edx,(%esp) for x86_32
>   *    retq
>   *
>   * Without retpolines configured:
>   *
> - *    jmp *%rax
> + *    jmp *%rax for x86_64
> + *    jmp *%edx for x86_32
>   */
>  #ifdef CONFIG_RETPOLINE
> +#ifdef CONFIG_X86_64
>  # define RETPOLINE_RAX_BPF_JIT_SIZE	17
>  # define RETPOLINE_RAX_BPF_JIT()				\
>  	EMIT1_off32(0xE8, 7);	 /* callq do_rop */		\
> @@ -310,9 +313,28 @@ static inline void indirect_branch_prediction_barrier(void)
>  	EMIT4(0x48, 0x89, 0x04, 0x24); /* mov %rax,(%rsp) */	\
>  	EMIT1(0xC3);             /* retq */
>  #else
> +# define RETPOLINE_EDX_BPF_JIT()				\
> +do {								\
> +	EMIT1_off32(0xE8, 7);	 /* call do_rop */		\
> +	/* spec_trap: */					\
> +	EMIT2(0xF3, 0x90);       /* pause */			\
> +	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
> +	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
> +	/* do_rop: */						\
> +	EMIT3(0x89, 0x14, 0x24); /* mov %edx,(%esp) */		\
> +	EMIT1(0xC3);             /* ret */			\
> +} while (0)

Nit: by the way, the RETPOLINE_RAX_BPF_JIT() doesn't have a do {} while (0)
construct but for RETPOLINE_EDX_BPF_JIT(), you add it. Could you make both
consistent to each other? I don't really mind which way as long as they're
both consistent.

> +#endif
> +#else /* !CONFIG_RETPOLINE */
> +
> +#ifdef CONFIG_X86_64
>  # define RETPOLINE_RAX_BPF_JIT_SIZE	2
>  # define RETPOLINE_RAX_BPF_JIT()				\
>  	EMIT2(0xFF, 0xE0);	 /* jmp *%rax */
> +#else
> +# define RETPOLINE_EDX_BPF_JIT()				\
> +	EMIT2(0xFF, 0xE2) /* jmp *%edx */
> +#endif
>  #endif
>  
>  #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
[...]
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +{
> +	struct bpf_binary_header *header = NULL;
> +	struct bpf_prog *tmp, *orig_prog = prog;
> +	int proglen, oldproglen = 0;
> +	struct jit_context ctx = {};
> +	bool tmp_blinded = false;
> +	u8 *image = NULL;
> +	int *addrs;
> +	int pass;
> +	int i;
> +
> +	if (!prog->jit_requested)
> +		return orig_prog;
> +
> +	tmp = bpf_jit_blind_constants(prog);
> +	/* If blinding was requested and we failed during blinding,
> +	 * we must fall back to the interpreter.
> +	 */
> +	if (IS_ERR(tmp))
> +		return orig_prog;
> +	if (tmp != prog) {
> +		tmp_blinded = true;
> +		prog = tmp;
> +	}
> +
> +	addrs = kmalloc(prog->len * sizeof(*addrs), GFP_KERNEL);
> +	if (!addrs) {
> +		prog = orig_prog;
> +		goto out;
> +	}
> +
> +	/* Before first pass, make a rough estimation of addrs[]
> +	 * each bpf instruction is translated to less than 64 bytes
> +	 */
> +	for (proglen = 0, i = 0; i < prog->len; i++) {
> +		proglen += 64;
> +		addrs[i] = proglen;
> +	}
> +	ctx.cleanup_addr = proglen;
> +
> +	/* JITed image shrinks with every pass and the loop iterates
> +	 * until the image stops shrinking. Very large bpf programs
> +	 * may converge on the last pass. In such case do one more
> +	 * pass to emit the final image
> +	 */
> +	for (pass = 0; pass < 20 || image; pass++) {
> +		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
> +		if (proglen <= 0) {
> +			image = NULL;
> +			if (header)
> +				bpf_jit_binary_free(header);
> +			prog = orig_prog;
> +			goto out_addrs;
> +		}
> +		if (image) {
> +			if (proglen != oldproglen) {
> +				pr_err("bpf_jit: proglen=%d != oldproglen=%d\n",
> +				       proglen, oldproglen);
> +				prog = orig_prog;
> +				goto out_addrs;

This one above will leak image, you need to also free the header by
calling bpf_jit_binary_free(). You've copied this from x86-64 JIT,
fixed there:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3aab8884c9eb99189a3569ac4e6b205371c9ac0b

We've recently merged this cleanup as well for x86-64 JIT, could you
please adapt the x86-32 JIT with similar cleanup as here:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=a2c7a98301d9f9bcfc4244de04252a04c0b68a79

Would be nice to address in one go so we don't need a follow-up cleanup.
Rest looks good from my side.

Thanks,
Daniel

> +			}
> +			break;
> +		}
> +		if (proglen == oldproglen) {
> +			header = bpf_jit_binary_alloc(proglen, &image,
> +						      1, jit_fill_hole);
> +			if (!header) {
> +				prog = orig_prog;
> +				goto out_addrs;
> +			}
> +		}
> +		oldproglen = proglen;
> +		cond_resched();
> +	}
> +
> +	if (bpf_jit_enable > 1)
> +		bpf_jit_dump(prog->len, proglen, pass + 1, image);
> +
> +	if (image) {
> +		bpf_jit_binary_lock_ro(header);
> +		prog->bpf_func = (void *)image;
> +		prog->jited = 1;
> +		prog->jited_len = proglen;
> +	} else {
> +		prog = orig_prog;
> +	}
> +
> +out_addrs:
> +	kfree(addrs);
> +out:
> +	if (tmp_blinded)
> +		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> +					   tmp : orig_prog);
> +	return prog;
> +}
> 
