Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641323-1519411364-2-5754269427160418858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411363; b=J4BHaXZALJRC7auoF/MrXhyXEtr6Ae88FzAdDDdrpGaYKmg
    drtS8mwGwNdNG396JlGZBYXaNWVGih+z4xmW9xF4xxMaL3/yGxU5boBlBEzWHTAZ
    5r9/OobPzUP4cZ+6VbIdSLwKuYXT4xapzl9fKtlqwTb7wyy9q086iOWCSoVbovTv
    0gozahFRc2kbTBJouqXqQY9kKtEyLFTr8aagBz94m1cKol9t+niqTdGInAz+n0i+
    ao9SW5SnB67gQGYxAnw3NEuHkvTti6MDprfeiJILkYyyJq+f3+SMUAZzYVsKum5S
    lfcCjidoxWnF8uYiYJRNae1gD8Lzepq85Cy9Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411363; bh=N54dgv6qrMynZVm2xk7skfrePk
    EEi5/lByFgUg4ADnQ=; b=Hz5zUfXUn2Yzsv+3nQNbIRMdnLk+Bj1Ddh5FxKYRWZ
    7d69qybyTLRIYnL2Sy8y5PA4gEuiYY7AVJyKUulNc1RDioSk4z6dvZ4yrgEmiOvn
    gWUCJUAm+QaBbmcFrOxjk/KNkLEA4GnqhmLXSWzfb0rwkdZTkFn9nyX56nE8K1IS
    KxXqDoC+xoxKL7mBja+AsAP3oAbin1thEAZ3dsKMqa82W5wnP0068Trmo4NSfXLS
    ZoQrozhTmmY5JKdItDUFctrBJtAGPO6LFQiIutXLe179gA40czd6cZFtsH2oZ/av
    vGY0kR91W+Rd9z22Hr4T/S2qahtm46yAUBRp7WHvvA3w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeBWSmj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:42:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933066AbeBWSmh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 016/145] crypto: x86/twofish-3way - Fix %rbp usage
Date: Fri, 23 Feb 2018 19:25:22 +0100
Message-Id: <20180223170726.725280557@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
