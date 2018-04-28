Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759438AbeD1Art (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:47:49 -0400
Received: from www62.your-server.de ([213.133.104.62]:54017 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754447AbeD1Arr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:47:47 -0400
Subject: Re: [PATCH v4] bpf, x86_32: add eBPF JIT compiler for ia32
To: Wang YanQing <udknight@gmail.com>, ast@kernel.org,
        illusionist.neo@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, davem@davemloft.net, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180426101257.GA29387@udknight>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <780e9ae2-f002-20bd-c491-b3e78066a8b4@iogearbox.net>
Date: Sat, 28 Apr 2018 02:47:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180426101257.GA29387@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 12:12 PM, Wang YanQing wrote:
[...]
> +/* encode 'dst_reg' and 'src_reg' registers into x86_32 opcode 'byte' */
> +static u8 add_2reg(u8 byte, u32 dst_reg, u32 src_reg)
> +{
> +	return byte + dst_reg + (src_reg << 3);
> +}
> +
> +static void jit_fill_hole(void *area, unsigned int size)
> +{
> +	/* fill whole space with int3 instructions */
> +	memset(area, 0xcc, size);
> +}
> +
> +/* Checks whether BPF register is on scratch stack space or not. */
> +static inline bool is_on_stack(u8 bpf_reg)
> +{
> +	static u8 stack_regs[] = {BPF_REG_AX};

Nit: you call this stack_regs here ...

> +	int i, reg_len = sizeof(stack_regs);
> +
> +	for (i = 0 ; i < reg_len ; i++) {
> +		if (bpf_reg == stack_regs[i])
> +			return false;

... but [BPF_REG_AX] = {IA32_ESI, IA32_EDI} is the only one
that is not on stack?

> +	}
> +	return true;
> +}
> +
> +static inline void emit_ia32_mov_i(const u8 dst, const u32 val, bool dstk,
> +				   u8 **pprog)
> +{
> +	u8 *prog = *pprog;
> +	int cnt = 0;
> +
> +	if (dstk) {
> +		if (val == 0) {
> +			/* xor eax,eax */
> +			EMIT2(0x33, add_2reg(0xC0, IA32_EAX, IA32_EAX));
> +			/* mov dword ptr [ebp+off],eax */
> +			EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EAX),
> +			      STACK_VAR(dst));
> +		} else {
> +			EMIT3_off32(0xC7, add_1reg(0x40, IA32_EBP),
> +				    STACK_VAR(dst), val);
> +		}
> +	} else {
> +		if (val == 0)
> +			EMIT2(0x33, add_2reg(0xC0, dst, dst));
> +		else
> +			EMIT2_off32(0xC7, add_1reg(0xC0, dst),
> +				    val);
> +	}
> +	*pprog = prog;
> +}
> +
[...]
> +			if (is_imm8(jmp_offset)) {
> +				EMIT2(jmp_cond, jmp_offset);
> +			} else if (is_simm32(jmp_offset)) {
> +				EMIT2_off32(0x0F, jmp_cond + 0x10, jmp_offset);
> +			} else {
> +				pr_err("cond_jmp gen bug %llx\n", jmp_offset);
> +				return -EFAULT;
> +			}
> +
> +			break;
> +		}
> +		case BPF_JMP | BPF_JA:
> +			jmp_offset = addrs[i + insn->off] - addrs[i];
> +			if (!jmp_offset)
> +				/* optimize out nop jumps */
> +				break;

Needs same fix as in x86-64 JIT in 1612a981b766 ("bpf, x64: fix JIT emission
for dead code").

> +emit_jmp:
> +			if (is_imm8(jmp_offset)) {
> +				EMIT2(0xEB, jmp_offset);
> +			} else if (is_simm32(jmp_offset)) {
> +				EMIT1_off32(0xE9, jmp_offset);
> +			} else {
> +				pr_err("jmp gen bug %llx\n", jmp_offset);
> +				return -EFAULT;
> +			}
> +			break;
