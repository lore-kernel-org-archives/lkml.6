Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415186-2-2106975399919373679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415185; b=ptqei/i/42bfGl1yonS4zyMglRwhx15IDClqURnlATbXKTU
    VH+UOAjk1h5N3J1J6tD+GgKG7CVpn2suyK1ItZcuZ4rQCSwW4ahPc/HOafHh7Oef
    bGgJyBedPRXqHUAULNKR8LhiDhrmBrCGibQUSFej9z8thdpmkF0R5uWxDMQJ82KI
    6MkTUm8iwoF9ulXy4ICbAenDAxNuA6X6yR9pTt+jasjT99c2GGBc9FbrbND/gBsS
    jOyPx/njh5rhG5t1rYjDXNtgX2fXKI0JIZ24orNOlE8FIwFi5ToK7TW5ioxVsVbq
    2tguMlVznO944UdoOyr1h7im6PYCThEvtGo0+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415185; bh=oqUoHKrMKf/x/pa28dSxzaKUXH
    U7a1WGtYHSZsey1sM=; b=oYywgegcH1r1riVuvv9GP9Tht4KZCGOACPvEfhMJRU
    yfvwNqOxTfq541C9aLkiNq0pGC0gFIkGVAKGkxTt1aNdH2/iFidQuxG89+Nq8xM3
    DHGmRzELP1O3Tzr+AchHtDWjTIOHzVksmHNMnuhfUlPxO21ZsmodgVlavlQ/DMTg
    +VCGJzcGxXT752m5uhiu15uaGXTa4TUPLGChuIFJu7A2b6ZsKwjoqQ+63Nqd90PM
    q0rvwbjJ40WHvc7U7Ob7TSo4+r9qLC8gaVkRseIpLrjBuknDSuF6Ua34BYbGBkYF
    Mg8mmDjfRsBWuMhur8PUMRzqYYBShZBYv5X93FTltawg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754974AbeBWTqJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:46:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44742 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934264AbeBWSr6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 089/145] powerpc/64s: Improve RFI L1-D cache flush fallback
Date: Fri, 23 Feb 2018 19:26:35 +0100
Message-Id: <20180223170736.276371585@linuxfoundation.org>
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


From: Nicholas Piggin <npiggin@gmail.com>

commit bdcb1aefc5b3f7d0f1dc8b02673602bca2ff7a4b upstream.

The fallback RFI flush is used when firmware does not provide a way
to flush the cache. It's a "displacement flush" that evicts useful
data by displacing it with an uninteresting buffer.

The flush has to take care to work with implementation specific cache
replacment policies, so the recipe has been in flux. The initial
slow but conservative approach is to touch all lines of a congruence
class, with dependencies between each load. It has since been
determined that a linear pattern of loads without dependencies is
sufficient, and is significantly faster.

Measuring the speed of a null syscall with RFI fallback flush enabled
gives the relative improvement:

P8 - 1.83x
P9 - 1.75x

The flush also becomes simpler and more adaptable to different cache
geometries.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Backport to 4.9]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/paca.h      |    3 -
 arch/powerpc/kernel/asm-offsets.c    |    3 -
 arch/powerpc/kernel/exceptions-64s.S |   76 ++++++++++++++++-------------------
 arch/powerpc/kernel/setup_64.c       |   13 -----
 4 files changed, 39 insertions(+), 56 deletions(-)

--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -212,8 +212,7 @@ struct paca_struct {
 	 */
 	u64 exrfi[13] __aligned(0x80);
 	void *rfi_flush_fallback_area;
-	u64 l1d_flush_congruence;
-	u64 l1d_flush_sets;
+	u64 l1d_flush_size;
 #endif
 };
 
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -242,8 +242,7 @@ int main(void)
 	DEFINE(PACA_IN_MCE, offsetof(struct paca_struct, in_mce));
 	DEFINE(PACA_RFI_FLUSH_FALLBACK_AREA, offsetof(struct paca_struct, rfi_flush_fallback_area));
 	DEFINE(PACA_EXRFI, offsetof(struct paca_struct, exrfi));
-	DEFINE(PACA_L1D_FLUSH_CONGRUENCE, offsetof(struct paca_struct, l1d_flush_congruence));
-	DEFINE(PACA_L1D_FLUSH_SETS, offsetof(struct paca_struct, l1d_flush_sets));
+	DEFINE(PACA_L1D_FLUSH_SIZE, offsetof(struct paca_struct, l1d_flush_size));
 #endif
 	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
 	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1602,39 +1602,37 @@ rfi_flush_fallback:
 	std	r9,PACA_EXRFI+EX_R9(r13)
 	std	r10,PACA_EXRFI+EX_R10(r13)
 	std	r11,PACA_EXRFI+EX_R11(r13)
-	std	r12,PACA_EXRFI+EX_R12(r13)
-	std	r8,PACA_EXRFI+EX_R13(r13)
 	mfctr	r9
 	ld	r10,PACA_RFI_FLUSH_FALLBACK_AREA(r13)
-	ld	r11,PACA_L1D_FLUSH_SETS(r13)
-	ld	r12,PACA_L1D_FLUSH_CONGRUENCE(r13)
-	/*
-	 * The load adresses are at staggered offsets within cachelines,
-	 * which suits some pipelines better (on others it should not
-	 * hurt).
-	 */
-	addi	r12,r12,8
+	ld	r11,PACA_L1D_FLUSH_SIZE(r13)
+	srdi	r11,r11,(7 + 3) /* 128 byte lines, unrolled 8x */
 	mtctr	r11
 	DCBT_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
 
 	/* order ld/st prior to dcbt stop all streams with flushing */
 	sync
-1:	li	r8,0
-	.rept	8 /* 8-way set associative */
-	ldx	r11,r10,r8
-	add	r8,r8,r12
-	xor	r11,r11,r11	// Ensure r11 is 0 even if fallback area is not
-	add	r8,r8,r11	// Add 0, this creates a dependency on the ldx
-	.endr
-	addi	r10,r10,128 /* 128 byte cache line */
+
+	/*
+	 * The load adresses are at staggered offsets within cachelines,
+	 * which suits some pipelines better (on others it should not
+	 * hurt).
+	 */
+1:
+	ld	r11,(0x80 + 8)*0(r10)
+	ld	r11,(0x80 + 8)*1(r10)
+	ld	r11,(0x80 + 8)*2(r10)
+	ld	r11,(0x80 + 8)*3(r10)
+	ld	r11,(0x80 + 8)*4(r10)
+	ld	r11,(0x80 + 8)*5(r10)
+	ld	r11,(0x80 + 8)*6(r10)
+	ld	r11,(0x80 + 8)*7(r10)
+	addi	r10,r10,0x80*8
 	bdnz	1b
 
 	mtctr	r9
 	ld	r9,PACA_EXRFI+EX_R9(r13)
 	ld	r10,PACA_EXRFI+EX_R10(r13)
 	ld	r11,PACA_EXRFI+EX_R11(r13)
-	ld	r12,PACA_EXRFI+EX_R12(r13)
-	ld	r8,PACA_EXRFI+EX_R13(r13)
 	GET_SCRATCH0(r13);
 	rfid
 
@@ -1645,39 +1643,37 @@ hrfi_flush_fallback:
 	std	r9,PACA_EXRFI+EX_R9(r13)
 	std	r10,PACA_EXRFI+EX_R10(r13)
 	std	r11,PACA_EXRFI+EX_R11(r13)
-	std	r12,PACA_EXRFI+EX_R12(r13)
-	std	r8,PACA_EXRFI+EX_R13(r13)
 	mfctr	r9
 	ld	r10,PACA_RFI_FLUSH_FALLBACK_AREA(r13)
-	ld	r11,PACA_L1D_FLUSH_SETS(r13)
-	ld	r12,PACA_L1D_FLUSH_CONGRUENCE(r13)
-	/*
-	 * The load adresses are at staggered offsets within cachelines,
-	 * which suits some pipelines better (on others it should not
-	 * hurt).
-	 */
-	addi	r12,r12,8
+	ld	r11,PACA_L1D_FLUSH_SIZE(r13)
+	srdi	r11,r11,(7 + 3) /* 128 byte lines, unrolled 8x */
 	mtctr	r11
 	DCBT_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
 
 	/* order ld/st prior to dcbt stop all streams with flushing */
 	sync
-1:	li	r8,0
-	.rept	8 /* 8-way set associative */
-	ldx	r11,r10,r8
-	add	r8,r8,r12
-	xor	r11,r11,r11	// Ensure r11 is 0 even if fallback area is not
-	add	r8,r8,r11	// Add 0, this creates a dependency on the ldx
-	.endr
-	addi	r10,r10,128 /* 128 byte cache line */
+
+	/*
+	 * The load adresses are at staggered offsets within cachelines,
+	 * which suits some pipelines better (on others it should not
+	 * hurt).
+	 */
+1:
+	ld	r11,(0x80 + 8)*0(r10)
+	ld	r11,(0x80 + 8)*1(r10)
+	ld	r11,(0x80 + 8)*2(r10)
+	ld	r11,(0x80 + 8)*3(r10)
+	ld	r11,(0x80 + 8)*4(r10)
+	ld	r11,(0x80 + 8)*5(r10)
+	ld	r11,(0x80 + 8)*6(r10)
+	ld	r11,(0x80 + 8)*7(r10)
+	addi	r10,r10,0x80*8
 	bdnz	1b
 
 	mtctr	r9
 	ld	r9,PACA_EXRFI+EX_R9(r13)
 	ld	r10,PACA_EXRFI+EX_R10(r13)
 	ld	r11,PACA_EXRFI+EX_R11(r13)
-	ld	r12,PACA_EXRFI+EX_R12(r13)
-	ld	r8,PACA_EXRFI+EX_R13(r13)
 	GET_SCRATCH0(r13);
 	hrfid
 
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -745,19 +745,8 @@ static void init_fallback_flush(void)
 	memset(l1d_flush_fallback_area, 0, l1d_size * 2);
 
 	for_each_possible_cpu(cpu) {
-		/*
-		 * The fallback flush is currently coded for 8-way
-		 * associativity. Different associativity is possible, but it
-		 * will be treated as 8-way and may not evict the lines as
-		 * effectively.
-		 *
-		 * 128 byte lines are mandatory.
-		 */
-		u64 c = l1d_size / 8;
-
 		paca[cpu].rfi_flush_fallback_area = l1d_flush_fallback_area;
-		paca[cpu].l1d_flush_congruence = c;
-		paca[cpu].l1d_flush_sets = c / 128;
+		paca[cpu].l1d_flush_size = l1d_size;
 	}
 }
 
