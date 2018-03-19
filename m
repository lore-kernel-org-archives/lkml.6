Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuJj8SxT8Tas90yOY2LBXUe5GPeflKhhobdwaQGO7gH6eMYjasOcAhEZAPx9NCSbg5MNadX
ARC-Seal: i=1; a=rsa-sha256; t=1521483271; cv=none;
        d=google.com; s=arc-20160816;
        b=auOj1iRLOEgD3Ircc3IbXiIugxsNGf035szXxAu6gSY6jwwq+ef0Y98COHQRIQeCRN
         UQBHty9Olyj4q8AZiMzys/ztaUGUWHzbDPxt7erVDU4+TYbt2hN2BGVZe1soMqjou2FB
         vQSImUVJTlqEKcP7zUzH+HsDYaRXnnpnUIhYpfBiH+6PYufo9BvgM4qhfkQ9os6Pxbgc
         MOaBFR7Dr+V0B6PEMq9j3tqYIndNia7LLBrKZAYvhWTzDDSH6StF5mLBaKHMB+2Qgipe
         rg+cUYr8o7meVAHlB0yJXyUV0OL1I69BqxdgGeLUu2vI3XUqJDI0QOOvfNSqgtF8WXVN
         rt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QjH5/fdda9K8fl4Rdgs9GeIwotMzDiXMULyLJrEPNr8=;
        b=zA6QXbfEaZ6GHm7tuZykmXgghN0L6q8bZ2FJiiybVXvbiTfXixzQrl7CBd8O5AvegF
         /EDOuhB6LqfvRK12kJbTuZUx+G6EG3Gb2TXYTbhztguKYmK3sVw50ONZ8uqCnUPHY7jA
         sW3yNkOGAWgGEDFYKSnVodRr44mZM9g5i5t9rWotWV1gRzUQ5zvDeDCn+RegLEuhmrox
         orTiIfh2DjKOMYduj4Cq9qHQ7QT4JJdLG0GWtVtxGzvTqiTmuiTing+gln4zEXpsDw+4
         SoPrPgjGTWTfRoI/Xuknb+QPlwvcGK/m4pbJDF9hbdb7dQOf9viWP7i+r3/bSAecmXRg
         Saag==
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
Subject: [PATCH 4.4 062/134] MIPS: BPF: Quit clobbering callee saved registers in JIT code.
Date: Mon, 19 Mar 2018 19:05:45 +0100
Message-Id: <20180319171858.257403615@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390571440048375?=
X-GMAIL-MSGID: =?utf-8?q?1595390843202396415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -527,7 +527,8 @@ static void save_bpf_jit_regs(struct jit
 	u32 sflags, tmp_flags;
 
 	/* Adjust the stack pointer */
-	emit_stack_offset(-align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(-align_sp(offset), ctx);
 
 	tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
 	/* sflags is essentially a bitmap */
@@ -579,7 +580,8 @@ static void restore_bpf_jit_regs(struct
 		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
 
 	/* Restore the sp and discard the scrach memory */
-	emit_stack_offset(align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(align_sp(offset), ctx);
 }
 
 static unsigned int get_stack_depth(struct jit_ctx *ctx)
@@ -626,8 +628,14 @@ static void build_prologue(struct jit_ct
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
 
