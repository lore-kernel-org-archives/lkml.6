Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv0gUs3pEaN3/+npWiX7bvOI8jx8o9cO6XfReeGjXp/DW+wNDHzjCqA4nKZ1YSuiTPO++xN
ARC-Seal: i=1; a=rsa-sha256; t=1521483466; cv=none;
        d=google.com; s=arc-20160816;
        b=vtJgHDYJsdiEGfhRIHJlTxoIwijU8ZCPjXyz8GwMGw0RpMXcUp890cX0iABcXA4Z86
         Sc0kx/eezeLayi3U2XKWsHM62/d6LtmbjzC0HTSVi2uzQwYhSw9fJVpMrfgTuGHIJ+c8
         SaYT/wu0JiBkYqsv0pddJVYoCNegDCXAqFPYHswreKeuI8R4iOdU4Q1ajGF3srWDoLx1
         37R1Jac4zCFXA732ZDN0uoSm7PfWm/H4dhmkCUFiLObzjmO9QjJxHlxAdLGeBW+DrrZw
         lplp7t3JWGvJVUDQbeEsvfDnX8t1ydXAW8dZO9ZN49BeljEfAzh2X+kfK+uowpGtvQ6o
         u99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LFUMWEpjhi9szBLCWJos4GQcziqM0QuG5cXCQzQeVgY=;
        b=sXJJkUmZd7abQhhMglN8sEY9PqLE9K/eaocnMm4+XeEhqdbA31zyYpIM/F338+h83V
         J5HPUwNoU6sB14ImpVKHZc84siv/0LoYfu3KRCfIOIutaS0QpIACqhWW3rQ13iSJKAWA
         s5VSyvwKAVAQkfwy9zeq4vWyP83dVAiGmgEANtqP06KfebpdLdCg1uKQWbZJyTuIDt55
         k6vfYirn02yT18nsajcMJkRKtqQRhbiVMYi1/6p3Vhl+OnUgqWenKe01PLuiWYgBDTbx
         X62WtGEhzHKCbFYc6AbVWFpPmBM7fAJpg9ugiMJhLqdCLpSTkD9h6PTcJURy6Tch9J60
         4G3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.4 134/134] bpf: fix incorrect sign extension in check_alu_op()
Date: Mon, 19 Mar 2018 19:06:57 +0100
Message-Id: <20180319171908.560879519@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391047586032261?=
X-GMAIL-MSGID: =?utf-8?q?1595391047586032261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 95a762e2c8c942780948091f8f2a4f32fce1ac6f upstream.

Distinguish between
BPF_ALU64|BPF_MOV|BPF_K (load 32-bit immediate, sign-extended to 64-bit)
and BPF_ALU|BPF_MOV|BPF_K (load 32-bit immediate, zero-padded to 64-bit);
only perform sign extension in the first case.

This patch differs from the mainline one because the verifier's internals
have changed in the meantime. Mainline tracks register values as 64-bit
values; however, 4.4 still stores tracked register values as 32-bit
values with sign extension. Therefore, in the case of a 32-bit op with
negative immediate, the value can't be tracked; leave the register as
UNKNOWN_VALUE (set by the preceding check_reg_arg() call).


I have manually tested this patch on top of 4.4.122. For the following BPF
bytecode:

        BPF_MOV64_IMM(BPF_REG_1, 1),
        BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
        BPF_EXIT_INSN(),

        BPF_MOV32_IMM(BPF_REG_1, 1),
        BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
        BPF_EXIT_INSN(),

        BPF_MOV64_IMM(BPF_REG_1, -1),
        BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, -1, 1),
        BPF_EXIT_INSN(),

        BPF_MOV32_IMM(BPF_REG_1, -1),
        BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, -1, 2),
        BPF_MOV32_IMM(BPF_REG_0, 42),
        BPF_EXIT_INSN(),

        BPF_MOV32_IMM(BPF_REG_0, 43),
        BPF_EXIT_INSN()

Verifier output on 4.4.122 without this patch:

0: (b7) r1 = 1
1: (15) if r1 == 0x1 goto pc+1
3: (b4) (u32) r1 = (u32) 1
4: (15) if r1 == 0x1 goto pc+1
6: (b7) r1 = -1
7: (15) if r1 == 0xffffffff goto pc+1
9: (b4) (u32) r1 = (u32) -1
10: (15) if r1 == 0xffffffff goto pc+2
13: (b4) (u32) r0 = (u32) 43
14: (95) exit

Verifier output on 4.4.122+ with this patch:

0: (b7) r1 = 1
1: (15) if r1 == 0x1 goto pc+1
3: (b4) (u32) r1 = (u32) 1
4: (15) if r1 == 0x1 goto pc+1
6: (b7) r1 = -1
7: (15) if r1 == 0xffffffff goto pc+1
9: (b4) (u32) r1 = (u32) -1
10: (15) if r1 == 0xffffffff goto pc+2
 R1=inv R10=fp
11: (b4) (u32) r0 = (u32) 42
12: (95) exit

from 10 to 13: R1=imm-1 R10=fp
13: (b4) (u32) r0 = (u32) 43
14: (95) exit


Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1135,7 +1135,8 @@ static int check_alu_op(struct verifier_
 				regs[insn->dst_reg].type = UNKNOWN_VALUE;
 				regs[insn->dst_reg].map_ptr = NULL;
 			}
-		} else {
+		} else if (BPF_CLASS(insn->code) == BPF_ALU64 ||
+			   insn->imm >= 0) {
 			/* case: R = imm
 			 * remember the value we stored into this reg
 			 */
