Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224cqO9T9jjpnR8Um007+rQt6pSEfz/DF8w5VSiReGliR6FEoF0xfWoBKEAMej0SmuYt5fMq
ARC-Seal: i=1; a=rsa-sha256; t=1518709202; cv=none;
        d=google.com; s=arc-20160816;
        b=jUs3lzxfA3VNxmj1FgD5PRE389SkCOqbrThPyWIssBJ7xQ/ouh8QSw+Ay80WGukeVP
         I7WshHBeSQN0nhI/bkWIOMGwTK5hQSu1bRfUCZZj6sMBWkZS1VidVagsS89UKZuhl4Rf
         bz24Mv/+VuvOGLBE2+mgr3axIwI6/ntliDXmnwRcJzKF1Q5QwvZ6A+lPpaIuvFtYbCkD
         bMG/Fx+YAzuJou890FdwUHFRJ+4oeufboZtXhH/XlMj15TJ/tC3aJeJLh9sPuqUudQlu
         Z4/HS5ZJ8LChxAYf4E+FKZS6dxHQ5CWHNg1DRz/kOz/eW0k6GyMT+4WWwNa51SRHkrlf
         rZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0KqrBnNjbSepq9Rpoe5qrw+hIAkxN0/PSi7QiP2LsR8=;
        b=A5eV8TRsMLYgURdqtchFmsRu2aNAJGQ1FqQPJtPYBwR9gwzAPYzIbXFgrlOatvve9q
         LvTLvmjIAYUa2YLhul0KUZNTSN2702B1n6xe03JBW2Gk+iOJVNpWYYpvWsmXrMh0JpiG
         mRHVQbNNtjRkKJEA/gxD1WHF6+Ysu9qK/tCc+0BiDe/rkjcna7BfgFH1smC72TEeIRyH
         bm4NqAOzH8qla4MRTwh/V4K4TlMrnVTZ1qEJNXR6B0QLVRrxYFO+Fs52H5QaEBDpuhvZ
         v7Cpk3HYIj8NOjaFKFidkBQaXlizeMTW9fUn/xl5Q4dN5jdtRMZWK4yg4zvDqS45+3xe
         JmIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 033/202] [Variant 3/Meltdown] arm64: use RET instruction for exiting the trampoline
Date: Thu, 15 Feb 2018 16:15:33 +0100
Message-Id: <20180215151714.729202314@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481477435502186?=
X-GMAIL-MSGID: =?utf-8?q?1592482020676065055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit be04a6d1126b upstream.

Speculation attacks against the entry trampoline can potentially resteer
the speculative instruction stream through the indirect branch and into
arbitrary gadgets within the kernel.

This patch defends against these attacks by forcing a misprediction
through the return stack: a dummy BL instruction loads an entry into
the stack, so that the predicted program flow of the subsequent RET
instruction is to a branch-to-self instruction which is finally resolved
as a branch to the kernel vectors with speculation suppressed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1029,6 +1029,14 @@ alternative_else_nop_endif
 	.if	\regsize == 64
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
+	/*
+	 * Defend against branch aliasing attacks by pushing a dummy
+	 * entry onto the return stack and using a RET instruction to
+	 * enter the full-fat kernel vectors.
+	 */
+	bl	2f
+	b	.
+2:
 	tramp_map_kernel	x30
 #ifdef CONFIG_RANDOMIZE_BASE
 	adr	x30, tramp_vectors + PAGE_SIZE
@@ -1041,7 +1049,7 @@ alternative_insn isb, nop, ARM64_WORKARO
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
 	isb
-	br	x30
+	ret
 	.endm
 
 	.macro tramp_exit, regsize = 64
