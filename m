Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754323AbeDYLBN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:01:13 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33738 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbeDYLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:01:05 -0400
X-Google-Smtp-Source: AIpwx4+GUSLdgO/36lA669Xlyz1dt1ynt6A7fismR3H5dhSz2kjjhoi5I6Pdo3XgbEX7kUNhqJNgmg==
Date: Wed, 25 Apr 2018 19:00:55 +0800
From: Wang YanQing <udknight@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, illusionist.neo@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, davem@davemloft.net, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bpf, x86_32: add eBPF JIT compiler for ia32
Message-ID: <20180425110055.GA7313@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        illusionist.neo@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, davem@davemloft.net, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180419155420.GA5468@udknight>
 <20e1eabd-e821-8240-cb4c-6da253c49585@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e1eabd-e821-8240-cb4c-6da253c49585@iogearbox.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 02:11:16AM +0200, Daniel Borkmann wrote:
> On 04/19/2018 05:54 PM, Wang YanQing wrote:
> > The JIT compiler emits ia32 bit instructions. Currently, It supports
> > eBPF only. Classic BPF is supported because of the conversion by BPF core.
> > 
> > Almost all instructions from eBPF ISA supported except the following:
> > BPF_ALU64 | BPF_DIV | BPF_K
> > BPF_ALU64 | BPF_DIV | BPF_X
> > BPF_ALU64 | BPF_MOD | BPF_K
> > BPF_ALU64 | BPF_MOD | BPF_X
> > BPF_STX | BPF_XADD | BPF_W
> > BPF_STX | BPF_XADD | BPF_DW
> > 
> > It doesn't support BPF_JMP|BPF_CALL with BPF_PSEUDO_CALL too.
> > 
> > ia32 has few general purpose registers, EAX|EDX|ECX|EBX|ESI|EDI,
> > and in these six registers, we can't treat all of them as real
> > general purpose registers in jit:
> > MUL instructions need EAX:EDX, shift instructions need ECX.
> > 
> > So I decide to use stack to emulate all eBPF 64 registers, this will
> > simplify the implementation a lot, because we don't need to face the
> > flexible memory address modes on ia32, for example, we don't need to
> > write below code pattern for one BPF_ADD instruction:
> > 
> >     if (src is a register && dst is a register)
> >     {
> >        //one instruction encoding for ADD instruction
> >     } else if (only src is a register)
> >     {
> >        //another different instruction encoding for ADD instruction
> >     } else if (only dst is a register)
> >     {
> >        //another different instruction encoding for ADD instruction
> >     } else
> >     {
> >        //src and dst are all on stack.
> >        //move src or dst to temporary registers
> >     }
> > 
> > If the above example if-else-else-else isn't so painful, try to think
> > it for BPF_ALU64|BPF_*SHIFT* instruction which we need to use many
> > native instructions to emulate.
> > 
> > Tested on my PC (Intel(R) Core(TM) i5-5200U CPU) and virtualbox.
> 
> Just out of plain curiosity, do you have a specific use case on the
> JIT for x86_32? Are you targeting this to be used for e.g. Atom or
> the like (sorry, don't really have a good overview where x86_32 is
> still in use these days)?
Yes, you are right that x86_32 isn't the BIG DEAL anymore, but they willn't
disappear completely in near future, the same as 32-bit linux kernel on
64bit machine.

For me, because I use 32-bit linux on development/hacking notebook for many years,
I try to trace/perf the kernel, then I meet eBPF, it is strange that there isn't
a jit for it, so I try to fill the empty.
> 
> > Testing results on i5-5200U:
> > 
> > 1) test_bpf: Summary: 349 PASSED, 0 FAILED, [319/341 JIT'ed]
> > 2) test_progs: Summary: 81 PASSED, 2 FAILED.
> >    test_progs report "libbpf: incorrect bpf_call opcode" for
> >    test_l4lb_noinline and test_xdp_noinline, because there is
> >    no llvm-6.0 on my machine, and current implementation doesn't
> >    support BPF_PSEUDO_CALL, so I think we can ignore the two failed
> >    testcases.
> > 3) test_lpm: OK
> > 4) test_lru_map: OK
> > 5) test_verifier: Summary: 823 PASSED, 5 FAILED
> >    test_verifier report "invalid bpf_context access off=68 size=1/2/4/8"
> >    for all the 5 FAILED testcases with/without jit, we need to fix the
> >    failed testcases themself instead of this jit.
> 
> Can you elaborate further on these? Looks like this definitely needs
> fixing on 32 bit. Would be great to get a better understanding of the
> underlying bug(s) and properly fix them.
Ok! I will try to dig them out.
> 
> > Above tests are all done with following flags settings discretely:
> > 1:bpf_jit_enable=1 and bpf_jit_harden=0
> > 2:bpf_jit_enable=1 and bpf_jit_harden=2
> > 
> > Below are some numbers for this jit implementation:
> > Note:
> >   I run test_progs in kselftest 100 times continuously for every testcase,
> >   the numbers are in format: total/times=avg.
> >   The numbers that test_bpf reports show almost the same relation.
> > 
> > a:jit_enable=0 and jit_harden=0            b:jit_enable=1 and jit_harden=0
> >   test_pkt_access:PASS:ipv4:15622/100=156  test_pkt_access:PASS:ipv4:10057/100=100
> >   test_pkt_access:PASS:ipv6:9130/100=91    test_pkt_access:PASS:ipv6:5055/100=50
> >   test_xdp:PASS:ipv4:240198/100=2401       test_xdp:PASS:ipv4:145945/100=1459
> >   test_xdp:PASS:ipv6:137326/100=1373       test_xdp:PASS:ipv6:67337/100=673
> >   test_l4lb:PASS:ipv4:61100/100=611        test_l4lb:PASS:ipv4:38137/100=381
> >   test_l4lb:PASS:ipv6:101000/100=1010      test_l4lb:PASS:ipv6:57779/100=577
> > 
> > c:jit_enable=1 and jit_harden=2
> >   test_pkt_access:PASS:ipv4:12650/100=126
> >   test_pkt_access:PASS:ipv6:7074/100=70
> >   test_xdp:PASS:ipv4:147211/100=1472
> >   test_xdp:PASS:ipv6:85783/100=857
> >   test_l4lb:PASS:ipv4:53222/100=532
> >   test_l4lb:PASS:ipv6:76322/100=763
> > 
> > Yes, the numbers are pretty when turn off jit_harden, if we want to speedup
> > jit_harden, then we need to move BPF_REG_AX to *real* register instead of stack
> > emulation, but when we do it, we need to face all the pain I describe above. We
> > can do it in next step.
> > 
> > See Documentation/networking/filter.txt for more information.
> > 
> > Signed-off-by: Wang YanQing <udknight@gmail.com>
> [...]
> > +		/* call */
> > +		case BPF_JMP | BPF_CALL:
> > +		{
> > +			const u8 *r1 = bpf2ia32[BPF_REG_1];
> > +			const u8 *r2 = bpf2ia32[BPF_REG_2];
> > +			const u8 *r3 = bpf2ia32[BPF_REG_3];
> > +			const u8 *r4 = bpf2ia32[BPF_REG_4];
> > +			const u8 *r5 = bpf2ia32[BPF_REG_5];
> > +
> > +			if (insn->src_reg == BPF_PSEUDO_CALL)
> > +				goto notyet;
> 
> Here you bail out on BPF_PSEUDO_CALL, but in below bpf_int_jit_compile() you
> implement half of e.g. 1c2a088a6626 ("bpf: x64: add JIT support for multi-function
> programs"), which is rather confusing to leave it in this half complete state;
> either remove altogether or implement everything.
Done.
> 
> > +			func = (u8 *) __bpf_call_base + imm32;
> > +			jmp_offset = func - (image + addrs[i]);
> > +
> > +			if (!imm32 || !is_simm32(jmp_offset)) {
> > +				pr_err("unsupported bpf func %d addr %p image %p\n",
> > +				       imm32, func, image);
> > +				return -EINVAL;
> > +			}
> > +
> > +			/* mov eax,dword ptr [ebp+off] */
> > +			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]),
> > +			      STACK_VAR(r1[0]));
> > +			/* mov edx,dword ptr [ebp+off] */
> > +			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[1]),
> > +			      STACK_VAR(r1[1]));
> > +
> > +			emit_push_r64(r5, &prog);
> > +			emit_push_r64(r4, &prog);
> > +			emit_push_r64(r3, &prog);
> > +			emit_push_r64(r2, &prog);
> > +
> > +			EMIT1_off32(0xE8, jmp_offset + 9);
> > +
> > +			/* mov dword ptr [ebp+off],eax */
> > +			EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[0]),
> > +			      STACK_VAR(r0[0]));
> > +			/* mov dword ptr [ebp+off],edx */
> > +			EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[1]),
> > +			      STACK_VAR(r0[1]));
> > +
> > +			/* add esp,32 */
> > +			EMIT3(0x83, add_1reg(0xC0, IA32_ESP), 32);
> > +			break;
> > +		}
> > +		case BPF_JMP | BPF_TAIL_CALL:
> > +			emit_bpf_tail_call(&prog);
> > +			break;
> > +
> > +		/* cond jump */
> > +		case BPF_JMP | BPF_JEQ | BPF_X:
> > +		case BPF_JMP | BPF_JNE | BPF_X:
> > +		case BPF_JMP | BPF_JGT | BPF_X:
> > +		case BPF_JMP | BPF_JLT | BPF_X:
> > +		case BPF_JMP | BPF_JGE | BPF_X:
> > +		case BPF_JMP | BPF_JLE | BPF_X:
> > +		case BPF_JMP | BPF_JSGT | BPF_X:
> > +		case BPF_JMP | BPF_JSLE | BPF_X:
> > +		case BPF_JMP | BPF_JSLT | BPF_X:
> > +		case BPF_JMP | BPF_JSGE | BPF_X:
> > +			/* mov esi,dword ptr [ebp+off] */
> > +			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(src_hi));
> > +			/* cmp dword ptr [ebp+off], esi */
> > +			EMIT3(0x39, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(dst_hi));
> > +
> > +			EMIT2(IA32_JNE, 6);
> > +			/* mov esi,dword ptr [ebp+off] */
> > +			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(src_lo));
> > +			/* cmp dword ptr [ebp+off], esi */
> > +			EMIT3(0x39, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(dst_lo));
> > +			goto emit_cond_jmp;
> > +
> > +		case BPF_JMP | BPF_JSET | BPF_X:
> > +			/* mov esi,dword ptr [ebp+off] */
> > +			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(dst_lo));
> > +			/* and esi,dword ptr [ebp+off]*/
> > +			EMIT3(0x23, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(src_lo));
> > +
> > +			/* mov edi,dword ptr [ebp+off] */
> > +			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]),
> > +			      STACK_VAR(dst_hi));
> > +			/* and edi,dword ptr [ebp+off] */
> > +			EMIT3(0x23, add_2reg(0x40, IA32_EBP, tmp[1]),
> > +			      STACK_VAR(src_hi));
> > +			/* or esi,edi */
> > +			EMIT2(0x09, add_2reg(0xC0, tmp[0], tmp[1]));
> > +			goto emit_cond_jmp;
> > +
> > +		case BPF_JMP | BPF_JSET | BPF_K: {
> > +			u32 hi;
> > +
> > +			hi = imm32 & (1<<31) ? (u32)~0 : 0;
> > +			/* mov esi,imm32 */
> > +			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), imm32);
> > +			/* and esi,dword ptr [ebp+off]*/
> > +			EMIT3(0x23, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(dst_lo));
> > +
> > +			/* mov esi,imm32 */
> > +			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[1]), hi);
> > +			/* and esi,dword ptr [ebp+off] */
> > +			EMIT3(0x23, add_2reg(0x40, IA32_EBP, tmp[1]),
> > +			      STACK_VAR(dst_hi));
> > +			/* or esi,edi */
> > +			EMIT2(0x09, add_2reg(0xC0, tmp[0], tmp[1]));
> > +			goto emit_cond_jmp;
> > +		}
> > +		case BPF_JMP | BPF_JEQ | BPF_K:
> > +		case BPF_JMP | BPF_JNE | BPF_K:
> > +		case BPF_JMP | BPF_JGT | BPF_K:
> > +		case BPF_JMP | BPF_JLT | BPF_K:
> > +		case BPF_JMP | BPF_JGE | BPF_K:
> > +		case BPF_JMP | BPF_JLE | BPF_K:
> > +		case BPF_JMP | BPF_JSGT | BPF_K:
> > +		case BPF_JMP | BPF_JSLE | BPF_K:
> > +		case BPF_JMP | BPF_JSLT | BPF_K:
> > +		case BPF_JMP | BPF_JSGE | BPF_K: {
> > +			u32 hi;
> > +
> > +			hi = imm32 & (1<<31) ? (u32)~0 : 0;
> > +			/* mov esi,imm32 */
> > +			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), hi);
> > +			/* cmp dword ptr [ebp+off],esi */
> > +			EMIT3(0x39, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(dst_hi));
> > +
> > +			EMIT2(IA32_JNE, 6);
> > +			/* mov esi,imm32 */
> > +			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), imm32);
> > +			/* cmp dword ptr [ebp+off],esi */
> > +			EMIT3(0x39, add_2reg(0x40, IA32_EBP, tmp[0]),
> > +			      STACK_VAR(dst_lo));
> > +
> > +emit_cond_jmp:		/* convert BPF opcode to x86 */
> > +			switch (BPF_OP(code)) {
> > +			case BPF_JEQ:
> > +				jmp_cond = IA32_JE;
> > +				break;
> > +			case BPF_JSET:
> > +			case BPF_JNE:
> > +				jmp_cond = IA32_JNE;
> > +				break;
> > +			case BPF_JGT:
> > +				/* GT is unsigned '>', JA in x86 */
> > +				jmp_cond = IA32_JA;
> > +				break;
> > +			case BPF_JLT:
> > +				/* LT is unsigned '<', JB in x86 */
> > +				jmp_cond = IA32_JB;
> > +				break;
> > +			case BPF_JGE:
> > +				/* GE is unsigned '>=', JAE in x86 */
> > +				jmp_cond = IA32_JAE;
> > +				break;
> > +			case BPF_JLE:
> > +				/* LE is unsigned '<=', JBE in x86 */
> > +				jmp_cond = IA32_JBE;
> > +				break;
> > +			case BPF_JSGT:
> > +				/* signed '>', GT in x86 */
> > +				jmp_cond = IA32_JG;
> > +				break;
> > +			case BPF_JSLT:
> > +				/* signed '<', LT in x86 */
> > +				jmp_cond = IA32_JL;
> > +				break;
> > +			case BPF_JSGE:
> > +				/* signed '>=', GE in x86 */
> > +				jmp_cond = IA32_JGE;
> > +				break;
> > +			case BPF_JSLE:
> > +				/* signed '<=', LE in x86 */
> > +				jmp_cond = IA32_JLE;
> > +				break;
> > +			default: /* to silence gcc warning */
> > +				return -EFAULT;
> > +			}
> > +			jmp_offset = addrs[i + insn->off] - addrs[i];
> > +			if (is_imm8(jmp_offset)) {
> > +				EMIT2(jmp_cond, jmp_offset);
> > +			} else if (is_simm32(jmp_offset)) {
> > +				EMIT2_off32(0x0F, jmp_cond + 0x10, jmp_offset);
> > +			} else {
> > +				pr_err("cond_jmp gen bug %llx\n", jmp_offset);
> > +				return -EFAULT;
> > +			}
> > +
> > +			break;
> > +		}
> > +		case BPF_JMP | BPF_JA:
> > +			jmp_offset = addrs[i + insn->off] - addrs[i];
> > +			if (!jmp_offset)
> > +				/* optimize out nop jumps */
> > +				break;
> > +emit_jmp:
> > +			if (is_imm8(jmp_offset)) {
> > +				EMIT2(0xEB, jmp_offset);
> > +			} else if (is_simm32(jmp_offset)) {
> > +				EMIT1_off32(0xE9, jmp_offset);
> > +			} else {
> > +				pr_err("jmp gen bug %llx\n", jmp_offset);
> > +				return -EFAULT;
> > +			}
> > +			break;
> > +
> > +		case BPF_LD | BPF_IND | BPF_W:
> > +			func = sk_load_word;
> > +			goto common_load;
> > +		case BPF_LD | BPF_ABS | BPF_W:
> > +			func = CHOOSE_LOAD_FUNC(imm32, sk_load_word);
> > +common_load:
> > +			jmp_offset = func - (image + addrs[i]);
> > +			if (!func || !is_simm32(jmp_offset)) {
> > +				pr_err("unsupported bpf func %d addr %p image %p\n",
> > +				       imm32, func, image);
> > +				return -EINVAL;
> > +			}
> > +			if (BPF_MODE(code) == BPF_ABS) {
> > +				/* mov %edx, imm32 */
> > +				EMIT1_off32(0xBA, imm32);
> > +			} else {
> > +				/* mov edx,dword ptr [ebp+off] */
> > +				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EDX),
> > +				      STACK_VAR(src_lo));
> > +				if (imm32) {
> > +					if (is_imm8(imm32))
> > +						/* add %edx, imm8 */
> > +						EMIT3(0x83, 0xC2, imm32);
> > +					else
> > +						/* add %edx, imm32 */
> > +						EMIT2_off32(0x81, 0xC2, imm32);
> > +				}
> > +			}
> > +			emit_load_skb_data_hlen(&prog);
> 
> The only place where you call the emit_load_skb_data_hlen() is here, so it
> effectively doesn't cache anything as with the other JITs. I would suggest
> to keep the complexity of the BPF_ABS/IND rather very low, remove the
> arch/x86/net/bpf_jit32.S handling altogether and just follow the model the
> way arm64 implemented this in the arch/arm64/net/bpf_jit_comp.c JIT. For
> eBPF these instructions are legacy and have been source of many subtle
> bugs in the various BPF JITs in the past, plus nobody complained about the
> current interpreter speed for LD_ABS/IND on x86_32 anyway so far. ;) We're
> also very close to have a rewrite of LD_ABS/IND out of native eBPF with
> similar performance to be able to finally remove them from the core.
Done.

Thanks.
