Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224iPYPaTFXe9T9Aq6WXG+XrGH9HNS9ZWlbzygcDEbaX+4hb/zhwh14s2V+awW/ar9y5qKAY
ARC-Seal: i=1; a=rsa-sha256; t=1517590806; cv=none;
        d=google.com; s=arc-20160816;
        b=DBgEL/FdurgyvvU9fnSG3TmMPTUkV6O3w8vgENJf0uNt0T+0cFeG+vzoyEyOjlciV3
         TqGiD2hw29xuiuiv1kiFK+KQSDS0YTV2cgAZeDQV86SsPRoCRLpSpEXKuoshEANEoyPA
         7d06kP+rC3an/ZcdVqvhK0ZDsLVuX4QEaj3x5qkTejP1HepLcDN/0huW8XdVEhm7BQkU
         bL0+tQhXHsVa5JJcF/Xv7ueO1dwjcz0ylFDlyO719DzgG+dNs8Fvhahkd5IHc6JHu87I
         NwgyQTTl7sl4HgXHRf2+iVEvPTd2daAtsEWPsXzdo+nRRVq3qkjmYNS5aYSFBDwC9gG0
         6Y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yw4zwvKxmuTTvB2YYoDKKiSN98OMjVzs/c8pTdnjbxo=;
        b=qtv0E3T7Epv84mGfIamnoER7hPJXOWR7li7DG/M+stRmwkSR6z+WwxBd7TZ5i4Aueu
         97O8IITiFd0oD/HZAvSLZjPusIYKd9zg/JFM2g2+JX71jbtP1ZDMqrcl4zJWciUb6BWp
         nunXQ7Qbuw9tFQw0LtXuByhJdYdixUj0ljwbLupMLiiywkYMTSHSKE/LIEwVy87dQlRo
         J5sTUFL4iGQvLMW7IqOS9q6xSRoSm6CWGT1t79lIndciXYlUgs3Baqg7cFqKjqF7ZYAZ
         kWjj0nBdcEpEnMqwkPQX2qaAsj1gwGln+mtRYnRvPImoUsirAbl7v6PZPm7CzSiXrZaU
         /KgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.4 02/67] bpf: fix branch pruning logic
Date: Fri,  2 Feb 2018 17:57:31 +0100
Message-Id: <20180202140815.463324737@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309298049682478?=
X-GMAIL-MSGID: =?utf-8?q?1591309298049682478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@fb.com>

[ Upstream commit c131187db2d3fa2f8bf32fdf4e9a4ef805168467 ]

when the verifier detects that register contains a runtime constant
and it's compared with another constant it will prune exploration
of the branch that is guaranteed not to be taken at runtime.
This is all correct, but malicious program may be constructed
in such a way that it always has a constant comparison and
the other branch is never taken under any conditions.
In this case such path through the program will not be explored
by the verifier. It won't be taken at run-time either, but since
all instructions are JITed the malicious program may cause JITs
to complain about using reserved fields, etc.
To fix the issue we have to track the instructions explored by
the verifier and sanitize instructions that are dead at run time
with NOPs. We cannot reject such dead code, since llvm generates
it for valid C code, since it doesn't do as much data flow
analysis as the verifier does.

Fixes: 17a5267067f3 ("bpf: verifier (add verifier core)")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -191,6 +191,7 @@ struct bpf_insn_aux_data {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
 		struct bpf_map *map_ptr;	/* pointer for call insn into lookup_elem */
 	};
+	bool seen; /* this insn was processed by the verifier */
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -1793,6 +1794,7 @@ static int do_check(struct verifier_env
 			print_bpf_insn(env, insn);
 		}
 
+		env->insn_aux_data[insn_idx].seen = true;
 		if (class == BPF_ALU || class == BPF_ALU64) {
 			err = check_alu_op(env, insn);
 			if (err)
@@ -1988,6 +1990,7 @@ process_bpf_exit:
 					return err;
 
 				insn_idx++;
+				env->insn_aux_data[insn_idx].seen = true;
 			} else {
 				verbose("invalid BPF_LD mode\n");
 				return -EINVAL;
@@ -2125,6 +2128,7 @@ static int adjust_insn_aux_data(struct v
 				u32 off, u32 cnt)
 {
 	struct bpf_insn_aux_data *new_data, *old_data = env->insn_aux_data;
+	int i;
 
 	if (cnt == 1)
 		return 0;
@@ -2134,6 +2138,8 @@ static int adjust_insn_aux_data(struct v
 	memcpy(new_data, old_data, sizeof(struct bpf_insn_aux_data) * off);
 	memcpy(new_data + off + cnt - 1, old_data + off,
 	       sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
+	for (i = off; i < off + cnt - 1; i++)
+		new_data[i].seen = true;
 	env->insn_aux_data = new_data;
 	vfree(old_data);
 	return 0;
@@ -2152,6 +2158,25 @@ static struct bpf_prog *bpf_patch_insn_d
 	return new_prog;
 }
 
+/* The verifier does more data flow analysis than llvm and will not explore
+ * branches that are dead at run time. Malicious programs can have dead code
+ * too. Therefore replace all dead at-run-time code with nops.
+ */
+static void sanitize_dead_code(struct verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
+	struct bpf_insn nop = BPF_MOV64_REG(BPF_REG_0, BPF_REG_0);
+	struct bpf_insn *insn = env->prog->insnsi;
+	const int insn_cnt = env->prog->len;
+	int i;
+
+	for (i = 0; i < insn_cnt; i++) {
+		if (aux_data[i].seen)
+			continue;
+		memcpy(insn + i, &nop, sizeof(nop));
+	}
+}
+
 /* convert load instructions that access fields of 'struct __sk_buff'
  * into sequence of instructions that access fields of 'struct sk_buff'
  */
@@ -2371,6 +2396,9 @@ skip_full_check:
 	free_states(env);
 
 	if (ret == 0)
+		sanitize_dead_code(env);
+
+	if (ret == 0)
 		/* program is valid, convert *(u32*)(ctx + off) accesses */
 		ret = convert_ctx_accesses(env);
 
