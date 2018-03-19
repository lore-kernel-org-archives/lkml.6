Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtuRSmIGcJiBZ+D96EZ3viDHR2SX1icBSEKqM2ovkjkhWUDH8Ol8sQueIJqCAMBzlAPQAoM
ARC-Seal: i=1; a=rsa-sha256; t=1521483012; cv=none;
        d=google.com; s=arc-20160816;
        b=KkahrDDcXaKlVP2NGN02f77H8ZpRIFH8+VpUX3Ax1kUy+gMqp2LiZlSMS8sUDWCHid
         IrR/o6w0sa7XXVy7uenr8XtSt8edGukHJ6aCYBwKwygKV6s/pqq3JOEOMVnT4T0ncEBI
         bsctuqlITXy0U3gNDiOJrnC9W4S1J/RcNWG6LMi98sQIWXMAJspHsXjaxcrS8z4RU6CE
         505Lu+aBqL8/NNfW9fh7jiNfojkSTx9eKfnZ46qU/ozNaQe5tBOow07+vKUlFoGW7duh
         zgLNLQrJQ26Har6qjpfd1ESAM9lco2/voOH+bAdy7Q97QTprx7uLTH6a0hqpa9C26Ink
         ypjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9CiIr20HwP4ZEYaamj5rxxHYBttLwvcCWImRi4KD/i8=;
        b=ZToUA+LZBJTX1pk/U6LMzStuhN5IaI1CP9QU+BVzTmrA0Z93enJMHqObvf4ZqRefZy
         T/d0/J7lrSzaccdh2siZ4l/8sPbCeNKnUomr77LdocekFGR/wqnsZi2S5VgBJa0WAKPU
         PzuHRjpjtNoDMp825FCLC/ThRmFNe7JkM2wSKSia0qnQUeOS9l2IUd6nN4sbMqMLyWdJ
         zodXO2pHUC/wo9wKjMAunrZ5G4sXOUU2sKSEkaIjRt6ZYZ0+2RJAVhYayfVWDqtpj26W
         7k5ATIwFG5obrPzYOGra+R/DuXhb5cFPCK9tQb7FBmM/2JNEPvliY2WjLrcJq2whoGW8
         aS8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Daney <david.daney@cavium.com>,
	James Hogan <james.hogan@imgtec.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Steven J. Hill" <steven.hill@cavium.com>,
	linux-mips@linux-mips.org,
	netdev@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 34/68] MIPS: BPF: Quit clobbering callee saved registers in JIT code.
Date: Mon, 19 Mar 2018 19:06:12 +0100
Message-Id: <20180319171832.588011158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390571440048375?=
X-GMAIL-MSGID: =?utf-8?q?1595390571440048375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>


[ Upstream commit 1ef0910cfd681f0bd0b81f8809935b2006e9cfb9 ]

If bpf_needs_clear_a() returns true, only actually clear it if it is
ever used.  If it is not used, we don't save and restore it, so the
clearing has the nasty side effect of clobbering caller state.

Also, don't emit stack pointer adjustment instructions if the
adjustment amount is zero.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven J. Hill <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15745/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/net/bpf_jit.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -562,7 +562,8 @@ static void save_bpf_jit_regs(struct jit
 	u32 sflags, tmp_flags;
 
 	/* Adjust the stack pointer */
-	emit_stack_offset(-align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(-align_sp(offset), ctx);
 
 	if (ctx->flags & SEEN_CALL) {
 		/* Argument save area */
@@ -641,7 +642,8 @@ static void restore_bpf_jit_regs(struct
 		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
 
 	/* Restore the sp and discard the scrach memory */
-	emit_stack_offset(align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(align_sp(offset), ctx);
 }
 
 static unsigned int get_stack_depth(struct jit_ctx *ctx)
@@ -689,8 +691,14 @@ static void build_prologue(struct jit_ct
 	if (ctx->flags & SEEN_X)
 		emit_jit_reg_move(r_X, r_zero, ctx);
 
-	/* Do not leak kernel data to userspace */
-	if (bpf_needs_clear_a(&ctx->skf->insns[0]))
+	/*
+	 * Do not leak kernel data to userspace, we only need to clear
+	 * r_A if it is ever used.  In fact if it is never used, we
+	 * will not save/restore it, so clearing it in this case would
+	 * corrupt the state of the caller.
+	 */
+	if (bpf_needs_clear_a(&ctx->skf->insns[0]) &&
+	    (ctx->flags & SEEN_A))
 		emit_jit_reg_move(r_A, r_zero, ctx);
 }
 
