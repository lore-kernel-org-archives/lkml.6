Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932471AbeCLJni (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:43:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932383AbeCLJna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:30 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 09/13] libbpf: Add bpf_insn__interpret function
Date: Mon, 12 Mar 2018 10:43:09 +0100
Message-Id: <20180312094313.18738-10-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bpf_insn__interpret function to run ebpf program
in user space.

It's 'borrowed' from systemtap code, I still need to figure
the proper credits, that will go to the file header in case
this would ever go in.

Link: http://lkml.kernel.org/n/tip-qqxsyw6imdisj3dydd6e21y7@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/Build    |   2 +-
 tools/lib/bpf/interp.c | 245 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/bpf/interp.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 64c679d67109..af99109f3d2d 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1 +1 @@
-libbpf-y := libbpf.o bpf.o nlattr.o
+libbpf-y := libbpf.o bpf.o nlattr.o interp.o
diff --git a/tools/lib/bpf/interp.c b/tools/lib/bpf/interp.c
new file mode 100644
index 000000000000..2ceb6a0836c3
--- /dev/null
+++ b/tools/lib/bpf/interp.c
@@ -0,0 +1,245 @@
+#include <uapi/linux/bpf.h>
+#include <stdlib.h>
+#include "interp.h"
+
+u64 bpf_interp__run(struct bpf_interp *interp)
+{
+	const struct bpf_insn *i = interp->insns + interp->insns_start;
+	u64 stack[512 / 8];
+	u64 regs[MAX_BPF_REG];
+
+	regs[BPF_REG_10] = (uintptr_t)stack + sizeof(stack);
+
+	while ((size_t)(i - interp->insns) < interp->insns_cnt) {
+		u64 dr, sr, si, s1;
+
+		dr = regs[i->dst_reg];
+		sr = regs[i->src_reg];
+		si = i->imm;
+		s1 = i->code & BPF_X ? sr : si;
+
+		switch (i->code) {
+		case BPF_LDX | BPF_MEM | BPF_B:
+			dr = *(u8 *)((uintptr_t) sr + i->off);
+			break;
+		case BPF_LDX | BPF_MEM | BPF_H:
+			dr = *(u16 *)((uintptr_t) sr + i->off);
+			break;
+		case BPF_LDX | BPF_MEM | BPF_W:
+			dr = *(u32 *)((uintptr_t) sr + i->off);
+			break;
+		case BPF_LDX | BPF_MEM | BPF_DW:
+			dr = *(u64 *)((uintptr_t) sr + i->off);
+			break;
+		case BPF_ST | BPF_MEM | BPF_B:
+			sr = si;
+			/* Fallthrough */
+		case BPF_STX | BPF_MEM | BPF_B:
+			*(u8 *)((uintptr_t) dr + i->off) = sr;
+			goto nowrite;
+		case BPF_ST | BPF_MEM | BPF_H:
+			sr = si;
+			/* Fallthrough */
+		case BPF_STX | BPF_MEM | BPF_H:
+			*(u16 *)((uintptr_t) dr + i->off) = sr;
+			goto nowrite;
+		case BPF_ST | BPF_MEM | BPF_W:
+			sr = si;
+			/* Fallthrough */
+		case BPF_STX | BPF_MEM | BPF_W:
+			*(u32 *)((uintptr_t) dr + i->off) = sr;
+			goto nowrite;
+		case BPF_ST | BPF_MEM | BPF_DW:
+			sr = si;
+			/* Fallthrough */
+		case BPF_STX | BPF_MEM | BPF_DW:
+			*(u64 *)((uintptr_t) dr + i->off) = sr;
+			goto nowrite;
+
+		case BPF_ALU64 | BPF_ADD | BPF_X:
+		case BPF_ALU64 | BPF_ADD | BPF_K:
+			dr += s1;
+			break;
+		case BPF_ALU64 | BPF_SUB | BPF_X:
+		case BPF_ALU64 | BPF_SUB | BPF_K:
+			dr -= s1;
+			break;
+		case BPF_ALU64 | BPF_AND | BPF_X:
+		case BPF_ALU64 | BPF_AND | BPF_K:
+			dr &= s1;
+			break;
+		case BPF_ALU64 | BPF_OR  | BPF_X:
+		case BPF_ALU64 | BPF_OR  | BPF_K:
+			dr |= s1;
+			break;
+		case BPF_ALU64 | BPF_LSH | BPF_X:
+		case BPF_ALU64 | BPF_LSH | BPF_K:
+			dr <<= s1;
+			break;
+		case BPF_ALU64 | BPF_RSH | BPF_X:
+		case BPF_ALU64 | BPF_RSH | BPF_K:
+			dr >>= s1;
+			break;
+		case BPF_ALU64 | BPF_XOR | BPF_X:
+		case BPF_ALU64 | BPF_XOR | BPF_K:
+			dr ^= s1;
+			break;
+		case BPF_ALU64 | BPF_MUL | BPF_X:
+		case BPF_ALU64 | BPF_MUL | BPF_K:
+			dr *= s1;
+			break;
+		case BPF_ALU64 | BPF_MOV | BPF_X:
+		case BPF_ALU64 | BPF_MOV | BPF_K:
+			dr = s1;
+			break;
+		case BPF_ALU64 | BPF_ARSH | BPF_X:
+		case BPF_ALU64 | BPF_ARSH | BPF_K:
+			dr = (u64) dr >> s1;
+			break;
+		case BPF_ALU64 | BPF_NEG:
+			dr = -sr;
+			/* Fallthrough */
+		case BPF_ALU64 | BPF_DIV | BPF_X:
+		case BPF_ALU64 | BPF_DIV | BPF_K:
+			if (s1 == 0)
+				return 0;
+			dr /= s1;
+			break;
+		case BPF_ALU64 | BPF_MOD | BPF_X:
+		case BPF_ALU64 | BPF_MOD | BPF_K:
+			if (s1 == 0)
+				return 0;
+			dr %= s1;
+			break;
+
+		case BPF_ALU | BPF_ADD | BPF_X:
+		case BPF_ALU | BPF_ADD | BPF_K:
+			dr = (u32)(dr + s1);
+			break;
+		case BPF_ALU | BPF_SUB | BPF_X:
+		case BPF_ALU | BPF_SUB | BPF_K:
+			dr = (u32)(dr - s1);
+			break;
+		case BPF_ALU | BPF_AND | BPF_X:
+		case BPF_ALU | BPF_AND | BPF_K:
+			dr = (u32)(dr & s1);
+			break;
+		case BPF_ALU | BPF_OR  | BPF_X:
+		case BPF_ALU | BPF_OR  | BPF_K:
+			dr = (u32)(dr | s1);
+			break;
+		case BPF_ALU | BPF_LSH | BPF_X:
+		case BPF_ALU | BPF_LSH | BPF_K:
+			dr = (u32)dr << s1;
+			break;
+		case BPF_ALU | BPF_RSH | BPF_X:
+		case BPF_ALU | BPF_RSH | BPF_K:
+			dr = (u32)dr >> s1;
+			break;
+		case BPF_ALU | BPF_XOR | BPF_X:
+		case BPF_ALU | BPF_XOR | BPF_K:
+			dr = (u32)(dr ^ s1);
+			break;
+		case BPF_ALU | BPF_MUL | BPF_X:
+		case BPF_ALU | BPF_MUL | BPF_K:
+			dr = (u32)(dr * s1);
+			break;
+		case BPF_ALU | BPF_MOV | BPF_X:
+		case BPF_ALU | BPF_MOV | BPF_K:
+			dr = (u32)s1;
+			break;
+		case BPF_ALU | BPF_ARSH | BPF_X:
+		case BPF_ALU | BPF_ARSH | BPF_K:
+			dr = (u32)dr >> s1;
+			break;
+		case BPF_ALU | BPF_NEG:
+			dr = -(u32)sr;
+			/* Fallthrough */
+		case BPF_ALU | BPF_DIV | BPF_X:
+		case BPF_ALU | BPF_DIV | BPF_K:
+			if ((u32)s1 == 0)
+				return 0;
+			dr = (u32)dr / (u32)s1;
+			break;
+		case BPF_ALU | BPF_MOD | BPF_X:
+		case BPF_ALU | BPF_MOD | BPF_K:
+			if ((u32)s1 == 0)
+				return 0;
+			dr = (u32)dr % (u32)s1;
+			break;
+
+		case BPF_LD | BPF_IMM | BPF_DW:
+			switch (i->src_reg) {
+			case 0:
+				dr = (u32)si | ((u64 )i[1].imm << 32);
+				break;
+			case BPF_PSEUDO_MAP_FD:
+				dr = (u64) si;
+				break;
+			default:
+				abort();
+			}
+			regs[i->dst_reg] = dr;
+			i += 2;
+			continue;
+
+		case BPF_JMP | BPF_JEQ | BPF_X:
+		case BPF_JMP | BPF_JEQ | BPF_K:
+			if (dr == s1)
+				goto dojmp;
+			goto nowrite;
+		case BPF_JMP | BPF_JNE | BPF_X:
+		case BPF_JMP | BPF_JNE | BPF_K:
+			if (dr != s1)
+				goto dojmp;
+			goto nowrite;
+		case BPF_JMP | BPF_JGT | BPF_X:
+		case BPF_JMP | BPF_JGT | BPF_K:
+			if (dr > s1)
+				goto dojmp;
+			goto nowrite;
+		case BPF_JMP | BPF_JGE | BPF_X:
+		case BPF_JMP | BPF_JGE | BPF_K:
+			if (dr >= s1)
+				goto dojmp;
+			goto nowrite;
+		case BPF_JMP | BPF_JSGT | BPF_X:
+		case BPF_JMP | BPF_JSGT | BPF_K:
+			if ((u64) dr > (u64) s1)
+				goto dojmp;
+			goto nowrite;
+		case BPF_JMP | BPF_JSGE | BPF_X:
+		case BPF_JMP | BPF_JSGE | BPF_K:
+			if ((u64) dr >= (u64) s1)
+				goto dojmp;
+			goto nowrite;
+		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP | BPF_JSET | BPF_K:
+			if (dr & s1)
+				goto dojmp;
+			goto nowrite;
+		case BPF_JMP | BPF_JA:
+		dojmp:
+			i += 1 + i->off;
+			continue;
+
+		case BPF_JMP | BPF_CALL:
+			if (interp->call_cb(interp, si, regs))
+				return (u64) -1;
+
+			goto nowrite;
+
+		case BPF_JMP | BPF_EXIT:
+			return regs[0];
+
+		default:
+			abort();
+		}
+
+		regs[i->dst_reg] = dr;
+	nowrite:
+		i++;
+	}
+
+	return 0;
+}
-- 
2.13.6
