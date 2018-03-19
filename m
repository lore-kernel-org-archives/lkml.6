Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtcPqyj0WsbI5D1jDMZ0ZJhKsDFcSSftFAfmRPfx/l9T9Wjwj6jsmFqwH/I1tQwYayfeo6v
ARC-Seal: i=1; a=rsa-sha256; t=1521483823; cv=none;
        d=google.com; s=arc-20160816;
        b=oDBzaFRl3U3Z5ulNRQmp1XPg6FtSsVVxmyVsYGsIDnnTMt5VGJJpUhNkMJdSKq2FGM
         XnslQWh5EYfLLC/Cn3yWdncyvgg/16Br5Xw85nJah/Aw/SJGVWnQC02Dbgu7lO43mMXJ
         8Jv4xcjU+gkBhikInwecJEz159wipr0r2kdMP8myFPl6gLER7TZPLXb0X/PjTnGPL/4Z
         kjYf6zEDXA/BKydlAHQY78KcpMka39W4aaL+X1zmmzDuDWGZ0k9pPm7pUjhohGlZUJlF
         3I5xSmPXtm4xxeIiUX3RpRPCmN2AFYwdlkh/M200CNlBTljmHMnIaBDixd6Y/zvQq2ne
         P2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mLoY1D6E8XOoVTGEEDrQdo+idb5ZkNy/i9ZXFPm1fBo=;
        b=lQQhT6K+ALtvPpm3o4KKbpKZq95AETSszQ+LNTBQO1EQtF62fwuvLyQ/8X0GIN9vIV
         lcBXbVO8SS3F8kdCBDlIq9t2auQl19GbuWjlTP0+kAA0zOrH7o+uubHQGVpd0VLXqLNx
         ETn0x2oRbbqw5SrnqVKxoBSNNWQHMKHF4ncJJyu9m1gq4tB5x0R9gK8URQQVAGy/7nhN
         qyPutccujtunEeZBP4w136gcxyBX2lotXRClJ5Vf4zE+iOG6R3QU/lJ2MQ31WlEOfuo/
         UnG9iF7i/AJDtV1Bv9polIc/O6MdueI+mYlakWgRhtwMGp/KO58PJhDhivE55Mp7ya/m
         Zfow==
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
Subject: [PATCH 4.9 129/241] MIPS: BPF: Quit clobbering callee saved registers in JIT code.
Date: Mon, 19 Mar 2018 19:06:34 +0100
Message-Id: <20180319180756.537482734@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390571440048375?=
X-GMAIL-MSGID: =?utf-8?q?1595391422172823464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -526,7 +526,8 @@ static void save_bpf_jit_regs(struct jit
 	u32 sflags, tmp_flags;
 
 	/* Adjust the stack pointer */
-	emit_stack_offset(-align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(-align_sp(offset), ctx);
 
 	tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
 	/* sflags is essentially a bitmap */
@@ -578,7 +579,8 @@ static void restore_bpf_jit_regs(struct
 		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
 
 	/* Restore the sp and discard the scrach memory */
-	emit_stack_offset(align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(align_sp(offset), ctx);
 }
 
 static unsigned int get_stack_depth(struct jit_ctx *ctx)
@@ -625,8 +627,14 @@ static void build_prologue(struct jit_ct
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
 
