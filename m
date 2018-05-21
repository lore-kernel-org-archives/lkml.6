Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpXzdAI0CsWo3p0IM/zh6+a/RbU4fjAojlxfdshO490k4SndFqiZCRFCALGY61nLg1BNpeA
ARC-Seal: i=1; a=rsa-sha256; t=1526937298; cv=none;
        d=google.com; s=arc-20160816;
        b=05QFzJwfVJN03yO01D9Z3u0Pvjb/ETfgRSr++sgJFx/Ogmzd1Xd6Pr7FjCOxwsRKLT
         84BAcHxEAkiXM//tNc3XdK6cBXEK9TNGmH8c8ORyf/6bC4VFG6BpFjuzBXZvzld9KEKz
         sOat3gPqyQ6Haz7HyRuDpiLuAdgRsiiQQv9ybBQSWA8BdyVSVx/wA+NzPJQm+FVencF0
         ektXffHzwzquMK/GaCC5La8hBlq1m1JQF1ohVyP33ZrFn4p+ILlIpyYAdnampVWRX84V
         csqVT7WEfE7nbWOpSy3n5OsDjtHdPaaZrh3mY0uvc/TfyWN6/3xIAHz7uu9D7IoQilAZ
         h/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=H7c/bvkb90lc5pZJAM0pgn+pQFtXkYubVTGg0OJ5hL8=;
        b=rbB5N4hA8x1BCeJFKRLYZrpwnbjwEEqLRBOnfBDNyYEt63vvpEuzrHDxkVBX30RAvd
         YpZ5RI/V/W/EAMm1hxVChZTZmawiNQ3XtpW9ObaUjaUrE8xl8AXzcly5bYoJjo3NfmGk
         xrqmBgfboxdCaGIRf7nNuXvKwWygIIdjpeZ9lHxyo1oXEZoVmCzLSDVpB3LKz7MeXSZb
         8OFTldIMFqBQalC876hSxCYt6jSdwy9RTuST+b4BcQMLVmNukr5rdy0UvyZoubn0fOOO
         kS4WHrMEfUATDu/RtPcdt2SDI7JWwkpgcovkbwFV6WyDsrqC1zBDdyGDL80GJUiluHAm
         vPDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FSY9es0U;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FSY9es0U;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.9 31/87] ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions
Date: Mon, 21 May 2018 23:11:07 +0200
Message-Id: <20180521210423.284827927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109804932649139?=
X-GMAIL-MSGID: =?utf-8?q?1601109804932649139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 0d73c3f8e7f6ee2aab1bb350f60c180f5ae21a2c upstream.

Since do_undefinstr() uses get_user to get the undefined
instruction, it can be called before kprobes processes
recursive check. This can cause an infinit recursive
exception.
Prohibit probing on get_user functions.

Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/include/asm/assembler.h |   10 ++++++++++
 arch/arm/lib/getuser.S           |   10 ++++++++++
 2 files changed, 20 insertions(+)

--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -534,4 +534,14 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+#ifdef CONFIG_KPROBES
+#define _ASM_NOKPROBE(entry)				\
+	.pushsection "_kprobe_blacklist", "aw" ;	\
+	.balign 4 ;					\
+	.long entry;					\
+	.popsection
+#else
+#define _ASM_NOKPROBE(entry)
+#endif
+
 #endif /* __ASM_ASSEMBLER_H__ */
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -38,6 +38,7 @@ ENTRY(__get_user_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_1)
+_ASM_NOKPROBE(__get_user_1)
 
 ENTRY(__get_user_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad
@@ -58,6 +59,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_2)
+_ASM_NOKPROBE(__get_user_2)
 
 ENTRY(__get_user_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad
@@ -65,6 +67,7 @@ ENTRY(__get_user_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_4)
+_ASM_NOKPROBE(__get_user_4)
 
 ENTRY(__get_user_8)
 	check_uaccess r0, 8, r1, r2, __get_user_bad8
@@ -78,6 +81,7 @@ ENTRY(__get_user_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_8)
+_ASM_NOKPROBE(__get_user_8)
 
 #ifdef __ARMEB__
 ENTRY(__get_user_32t_8)
@@ -91,6 +95,7 @@ ENTRY(__get_user_32t_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_32t_8)
+_ASM_NOKPROBE(__get_user_32t_8)
 
 ENTRY(__get_user_64t_1)
 	check_uaccess r0, 1, r1, r2, __get_user_bad8
@@ -98,6 +103,7 @@ ENTRY(__get_user_64t_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_1)
+_ASM_NOKPROBE(__get_user_64t_1)
 
 ENTRY(__get_user_64t_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad8
@@ -114,6 +120,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_2)
+_ASM_NOKPROBE(__get_user_64t_2)
 
 ENTRY(__get_user_64t_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad8
@@ -121,6 +128,7 @@ ENTRY(__get_user_64t_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_4)
+_ASM_NOKPROBE(__get_user_64t_4)
 #endif
 
 __get_user_bad8:
@@ -131,6 +139,8 @@ __get_user_bad:
 	ret	lr
 ENDPROC(__get_user_bad)
 ENDPROC(__get_user_bad8)
+_ASM_NOKPROBE(__get_user_bad)
+_ASM_NOKPROBE(__get_user_bad8)
 
 .pushsection __ex_table, "a"
 	.long	1b, __get_user_bad
