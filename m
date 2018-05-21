Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpRv1Vaf5QZIdH79PspD4dgflN7G8o/87Pe0fyCEWe8CM+i+2BDo3314zOEIvinAF75FQ6n
ARC-Seal: i=1; a=rsa-sha256; t=1526937867; cv=none;
        d=google.com; s=arc-20160816;
        b=j+/lbOChwL4kY+WMAoc+TTTcdzDo5GFhveffmNdK+9JLZQ4H1Mp4Co4Acqs6Msm1H4
         uf98Xzq957p9Db4Cgmz8SQ98OJxMvIf79sEskWKnDQpo0pRk0oSTaXgPWXzLRgJGgx3g
         GI4gUCbXEd9dJUpP1reC6aRD3Y/YamSf+G7py9SIZC3VfbABCa/zpiq2YDydU/TtUtoe
         QfpkYfq9/VWCxaOvfft1I2AsNt8MgamcjqQmC8lzeJI2YjSgzOxrSUi9y/nHFNkzRk32
         EaSingFfQT0BR5K5CE2qs1+4dNcwNJHscvmmCTzi1+Fs1zGP4z7u1nMYEbw5EvZE0Vjp
         qCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Bkq7+KtuVw7YPvT1usmPtSaZubq3XRxetZg94XzoXXs=;
        b=hrmjokqjD8Z1rWQhlWVpOgz0Kth0tv4vMv6v9XM5yMuKW2Tv7DUZVVNPxdzRS6B+To
         wwTzH86jZTPE855ILPjFfCEjDCWyzvG1ljFg7WJGGFIkKSKsnPI+boTdUMiP2NqPDKe/
         AgZPyRwg7Qs4M6xRmWRSX8E1pwzlRG9FJqVONmyViGCxfTCPNVr6gJrSm4LD8GGB0ESx
         OpVLQsfKdm53iWhd/MrXLfcUoLlMQQaD3TGNruEn37L3b/QPkucB5CUxcCgcxbtXU80k
         rI90GxrJ6OlRYqjym5UrgBD9JbcyoL7PIqefaAs321sI8zyJzfMOgnIi3Lqc2Rf6HcM6
         I0KQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0Eh53Ja4;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0Eh53Ja4;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.16 054/110] ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions
Date: Mon, 21 May 2018 23:11:51 +0200
Message-Id: <20180521210510.230954031@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109804932649139?=
X-GMAIL-MSGID: =?utf-8?q?1601110401462862730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -536,4 +536,14 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
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
