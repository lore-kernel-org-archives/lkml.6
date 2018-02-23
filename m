Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ZyxH6aKw8k0K7qLIahc5zH8dxuQxS9fHkIO7WtPAMDv5U9I2Nb2rgErnZhkKWZPMRWVSz
ARC-Seal: i=1; a=rsa-sha256; t=1519410780; cv=none;
        d=google.com; s=arc-20160816;
        b=kf844UhAZDfhA32tVdX1VlxNLYDwt+8yBgEZ9vDtua4HB8TVlTbUgv8fbHmxxK5OMB
         HD7i7WPz8NZ4VwTvUVF4kvUwxWZTqoWBlEWHKq9BFGCukLXT/ypngTWHAiBTRhwGGW5D
         CSIdwkCxgxGJu+PvaVIGiX2EXHaoxnh3zbvFvrLhIkRZorq49HET7zboV/l/NIgIalME
         u/hG6uO2s+FvrEE2r7dh6yo97EaEqsjyHgOdP/GgIFavz5DQqZ1lXa+RythXUAe87Btp
         4j4ZUNmd6CMjbxunL7yhJYo6wOJMvqEqqrryykL6FZwMjr3FPOjmZryo3jpnE0XHoP0q
         q5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ikJpQoUyF39fh/6yrZ/6OK7aslQCN/Ec61uzZkR84GE=;
        b=eO8dlioIrDD4VeYrRs6kUSNYr98ZjOXkck4m7jxXHKpUkj9F7DOzDkPC2aApSWm60z
         8MyAKPm/77C4tQU/1AmdbaUCdoV5BkayOOvRQbDFA7S470E1FEpyPUXE/TAtZNpyev+N
         CFbCLnn2Yc8lcN/GPj/TdgqmhdCx3OgVZQ5zzsEGrtewKCv6ZBlYlSl+kLoe3U1Q+Q1T
         lKvF1Ewy/91ggML+k7sBvedhOIfdQlz/q8Np7iVr1wRpOXXWxgRruZvshWPVMFBLlhZ3
         Dc+XwUci5DkmLTT1hobNpibVM4BxEMX1ZLtTQR7wgG1cAmGuNwSE9lEPUwqnyWRa0t0e
         3J7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Eric Biggers <ebiggers@google.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 012/193] crypto: x86/twofish-3way - Fix %rbp usage
Date: Fri, 23 Feb 2018 19:24:05 +0100
Message-Id: <20180223170328.073487179@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217529169344601?=
X-GMAIL-MSGID: =?utf-8?q?1593217678697882587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit d8c7fe9f2a486a6e5f0d5229ca43807af5ab22c6 upstream.

Using %rbp as a temporary register breaks frame pointer convention and
breaks stack traces when unwinding from an interrupt in the crypto code.

In twofish-3way, we can't simply replace %rbp with another register
because there are none available.  Instead, we use the stack to hold the
values that %rbp, %r11, and %r12 were holding previously.  Each of these
values represents the half of the output from the previous Feistel round
that is being passed on unchanged to the following round.  They are only
used once per round, when they are exchanged with %rax, %rbx, and %rcx.

As a result, we free up 3 registers (one per block) and can reassign
them so that %rbp is not used, and additionally %r14 and %r15 are not
used so they do not need to be saved/restored.

There may be a small overhead caused by replacing 'xchg REG, REG' with
the needed sequence 'mov MEM, REG; mov REG, MEM; mov REG, REG' once per
round.  But, counterintuitively, when I tested "ctr-twofish-3way" on a
Haswell processor, the new version was actually about 2% faster.
(Perhaps 'xchg' is not as well optimized as plain moves.)

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S |  118 ++++++++++++++-------------
 1 file changed, 63 insertions(+), 55 deletions(-)

--- a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
@@ -55,29 +55,31 @@
 #define RAB1bl %bl
 #define RAB2bl %cl
 
+#define CD0 0x0(%rsp)
+#define CD1 0x8(%rsp)
+#define CD2 0x10(%rsp)
+
+# used only before/after all rounds
 #define RCD0 %r8
 #define RCD1 %r9
 #define RCD2 %r10
 
-#define RCD0d %r8d
-#define RCD1d %r9d
-#define RCD2d %r10d
-
-#define RX0 %rbp
-#define RX1 %r11
-#define RX2 %r12
-
-#define RX0d %ebp
-#define RX1d %r11d
-#define RX2d %r12d
-
-#define RY0 %r13
-#define RY1 %r14
-#define RY2 %r15
-
-#define RY0d %r13d
-#define RY1d %r14d
-#define RY2d %r15d
+# used only during rounds
+#define RX0 %r8
+#define RX1 %r9
+#define RX2 %r10
+
+#define RX0d %r8d
+#define RX1d %r9d
+#define RX2d %r10d
+
+#define RY0 %r11
+#define RY1 %r12
+#define RY2 %r13
+
+#define RY0d %r11d
+#define RY1d %r12d
+#define RY2d %r13d
 
 #define RT0 %rdx
 #define RT1 %rsi
@@ -85,6 +87,8 @@
 #define RT0d %edx
 #define RT1d %esi
 
+#define RT1bl %sil
+
 #define do16bit_ror(rot, op1, op2, T0, T1, tmp1, tmp2, ab, dst) \
 	movzbl ab ## bl,		tmp2 ## d; \
 	movzbl ab ## bh,		tmp1 ## d; \
@@ -92,6 +96,11 @@
 	op1##l T0(CTX, tmp2, 4),	dst ## d; \
 	op2##l T1(CTX, tmp1, 4),	dst ## d;
 
+#define swap_ab_with_cd(ab, cd, tmp)	\
+	movq cd, tmp;			\
+	movq ab, cd;			\
+	movq tmp, ab;
+
 /*
  * Combined G1 & G2 function. Reordered with help of rotates to have moves
  * at begining.
@@ -110,15 +119,15 @@
 	/* G1,2 && G2,2 */ \
 	do16bit_ror(32, xor, xor, Tx2, Tx3, RT0, RT1, ab ## 0, x ## 0); \
 	do16bit_ror(16, xor, xor, Ty3, Ty0, RT0, RT1, ab ## 0, y ## 0); \
-	xchgq cd ## 0, ab ## 0; \
+	swap_ab_with_cd(ab ## 0, cd ## 0, RT0); \
 	\
 	do16bit_ror(32, xor, xor, Tx2, Tx3, RT0, RT1, ab ## 1, x ## 1); \
 	do16bit_ror(16, xor, xor, Ty3, Ty0, RT0, RT1, ab ## 1, y ## 1); \
-	xchgq cd ## 1, ab ## 1; \
+	swap_ab_with_cd(ab ## 1, cd ## 1, RT0); \
 	\
 	do16bit_ror(32, xor, xor, Tx2, Tx3, RT0, RT1, ab ## 2, x ## 2); \
 	do16bit_ror(16, xor, xor, Ty3, Ty0, RT0, RT1, ab ## 2, y ## 2); \
-	xchgq cd ## 2, ab ## 2;
+	swap_ab_with_cd(ab ## 2, cd ## 2, RT0);
 
 #define enc_round_end(ab, x, y, n) \
 	addl y ## d,			x ## d; \
@@ -168,6 +177,16 @@
 	decrypt_round3(ba, dc, (n*2)+1); \
 	decrypt_round3(ba, dc, (n*2));
 
+#define push_cd()	\
+	pushq RCD2;	\
+	pushq RCD1;	\
+	pushq RCD0;
+
+#define pop_cd()	\
+	popq RCD0;	\
+	popq RCD1;	\
+	popq RCD2;
+
 #define inpack3(in, n, xy, m) \
 	movq 4*(n)(in),			xy ## 0; \
 	xorq w+4*m(CTX),		xy ## 0; \
@@ -223,11 +242,8 @@ ENTRY(__twofish_enc_blk_3way)
 	 *	%rdx: src, RIO
 	 *	%rcx: bool, if true: xor output
 	 */
-	pushq %r15;
-	pushq %r14;
 	pushq %r13;
 	pushq %r12;
-	pushq %rbp;
 	pushq %rbx;
 
 	pushq %rcx; /* bool xor */
@@ -235,40 +251,36 @@ ENTRY(__twofish_enc_blk_3way)
 
 	inpack_enc3();
 
-	encrypt_cycle3(RAB, RCD, 0);
-	encrypt_cycle3(RAB, RCD, 1);
-	encrypt_cycle3(RAB, RCD, 2);
-	encrypt_cycle3(RAB, RCD, 3);
-	encrypt_cycle3(RAB, RCD, 4);
-	encrypt_cycle3(RAB, RCD, 5);
-	encrypt_cycle3(RAB, RCD, 6);
-	encrypt_cycle3(RAB, RCD, 7);
+	push_cd();
+	encrypt_cycle3(RAB, CD, 0);
+	encrypt_cycle3(RAB, CD, 1);
+	encrypt_cycle3(RAB, CD, 2);
+	encrypt_cycle3(RAB, CD, 3);
+	encrypt_cycle3(RAB, CD, 4);
+	encrypt_cycle3(RAB, CD, 5);
+	encrypt_cycle3(RAB, CD, 6);
+	encrypt_cycle3(RAB, CD, 7);
+	pop_cd();
 
 	popq RIO; /* dst */
-	popq %rbp; /* bool xor */
+	popq RT1; /* bool xor */
 
-	testb %bpl, %bpl;
+	testb RT1bl, RT1bl;
 	jnz .L__enc_xor3;
 
 	outunpack_enc3(mov);
 
 	popq %rbx;
-	popq %rbp;
 	popq %r12;
 	popq %r13;
-	popq %r14;
-	popq %r15;
 	ret;
 
 .L__enc_xor3:
 	outunpack_enc3(xor);
 
 	popq %rbx;
-	popq %rbp;
 	popq %r12;
 	popq %r13;
-	popq %r14;
-	popq %r15;
 	ret;
 ENDPROC(__twofish_enc_blk_3way)
 
@@ -278,35 +290,31 @@ ENTRY(twofish_dec_blk_3way)
 	 *	%rsi: dst
 	 *	%rdx: src, RIO
 	 */
-	pushq %r15;
-	pushq %r14;
 	pushq %r13;
 	pushq %r12;
-	pushq %rbp;
 	pushq %rbx;
 
 	pushq %rsi; /* dst */
 
 	inpack_dec3();
 
-	decrypt_cycle3(RAB, RCD, 7);
-	decrypt_cycle3(RAB, RCD, 6);
-	decrypt_cycle3(RAB, RCD, 5);
-	decrypt_cycle3(RAB, RCD, 4);
-	decrypt_cycle3(RAB, RCD, 3);
-	decrypt_cycle3(RAB, RCD, 2);
-	decrypt_cycle3(RAB, RCD, 1);
-	decrypt_cycle3(RAB, RCD, 0);
+	push_cd();
+	decrypt_cycle3(RAB, CD, 7);
+	decrypt_cycle3(RAB, CD, 6);
+	decrypt_cycle3(RAB, CD, 5);
+	decrypt_cycle3(RAB, CD, 4);
+	decrypt_cycle3(RAB, CD, 3);
+	decrypt_cycle3(RAB, CD, 2);
+	decrypt_cycle3(RAB, CD, 1);
+	decrypt_cycle3(RAB, CD, 0);
+	pop_cd();
 
 	popq RIO; /* dst */
 
 	outunpack_dec3();
 
 	popq %rbx;
-	popq %rbp;
 	popq %r12;
 	popq %r13;
-	popq %r14;
-	popq %r15;
 	ret;
 ENDPROC(twofish_dec_blk_3way)
