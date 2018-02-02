Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591255-2-12479776568867952254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591254; b=iHvaeTpD6Q6FbsFQGEgR32czMWRNYrf+dSQSchDIcMBDQ/h
    VJ947ZOUWgN4Q+zMstpi1biONFwWP3oA/0tDuK2oEXKc1ETifIfVXyknqfkpN+Xj
    lupmwHqddmJ2w5pIgQTeYXWku3o88KOTpOjB6e2OppLjzJUtHdkl0aQovW2Oi8Um
    5zrcrE0f4/LQPe1KwfaKm64p9O88Sm1Ro6GDfxHUC6kPuj+FDxTbHc2RqoluCojR
    Yb4HhVUJykjYlsvSgymVcBgHnDpvFxGAWn2/0vfiQjKRt9G/1qcbCahyEGlBLNPE
    xeuC2TPEvxzZ75kzSV/xrWyccsmkwEQ6wmLnSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591254; bh=JpPk5j6rP9w8n78yU0oJOgXBFl
    BXpamqoQbgdmHTvkY=; b=iw2IrPtmEnBualEaFvmtpZcKU2pkrHwKnjqwQaLbI1
    t7auNUxCsyzTARBwYcMEwRA8zUvmpl4sq35x3Vfwb70LmTT1+fyEXrg93zu1N9ue
    J7fySK3b6pcjurkUJuS9RAGsVHOEICjg6hLp0NahgCseU0qBguYjFTu5+2GLJt9D
    m9amDT9bNspvj6ha7ZYxijTp8gsCZyknLBD6ar+rDOFvfH8m3kZIB95hnaWPVEaa
    QTAdGKrJP1jE2zpdVTZvpQmAF8Hc3cyfWFaCUpV6CT0xXEJHEU3lnXxKi5n1i4Ri
    oULDI/SMFS2ATpvGLgvGyiAqjVsx4J+/5iBtrF8yIVYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeBBRHb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:07:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeBBRH0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:07:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 015/156] crypto: aesni - Fix out-of-bounds access of the AAD buffer in generic-gcm-aesni
Date: Fri,  2 Feb 2018 17:56:36 +0100
Message-Id: <20180202140840.997140388@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junaid Shahid <junaids@google.com>

commit 1ecdd37e308ca149dc378cce225068cbac54e3a6 upstream.

The aesni_gcm_enc/dec functions can access memory after the end of
the AAD buffer if the AAD length is not a multiple of 4 bytes.
It didn't matter with rfc4106-gcm-aesni as in that case the AAD was
always followed by the 8 byte IV, but that is no longer the case with
generic-gcm-aesni. This can potentially result in accessing a page that
is not mapped and thus causing the machine to crash. This patch fixes
that by reading the last <16 byte block of the AAD byte-by-byte and
optionally via an 8-byte load if the block was at least 8 bytes.

Fixes: 0487ccac ("crypto: aesni - make non-AVX AES-GCM work with any aadlen")
Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_asm.S |  112 ++++----------------------------------
 1 file changed, 12 insertions(+), 100 deletions(-)

--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -90,30 +90,6 @@ SHIFT_MASK: .octa 0x0f0e0d0c0b0a09080706
 ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
             .octa 0x00000000000000000000000000000000
 
-.section .rodata
-.align 16
-.type aad_shift_arr, @object
-.size aad_shift_arr, 272
-aad_shift_arr:
-        .octa     0xffffffffffffffffffffffffffffffff
-        .octa     0xffffffffffffffffffffffffffffff0C
-        .octa     0xffffffffffffffffffffffffffff0D0C
-        .octa     0xffffffffffffffffffffffffff0E0D0C
-        .octa     0xffffffffffffffffffffffff0F0E0D0C
-        .octa     0xffffffffffffffffffffff0C0B0A0908
-        .octa     0xffffffffffffffffffff0D0C0B0A0908
-        .octa     0xffffffffffffffffff0E0D0C0B0A0908
-        .octa     0xffffffffffffffff0F0E0D0C0B0A0908
-        .octa     0xffffffffffffff0C0B0A090807060504
-        .octa     0xffffffffffff0D0C0B0A090807060504
-        .octa     0xffffffffff0E0D0C0B0A090807060504
-        .octa     0xffffffff0F0E0D0C0B0A090807060504
-        .octa     0xffffff0C0B0A09080706050403020100
-        .octa     0xffff0D0C0B0A09080706050403020100
-        .octa     0xff0E0D0C0B0A09080706050403020100
-        .octa     0x0F0E0D0C0B0A09080706050403020100
-
-
 .text
 
 
@@ -304,62 +280,30 @@ _done_read_partial_block_\@:
 XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
         MOVADQ     SHUF_MASK(%rip), %xmm14
 	mov	   arg7, %r10           # %r10 = AAD
-	mov	   arg8, %r12           # %r12 = aadLen
-	mov	   %r12, %r11
+	mov	   arg8, %r11           # %r11 = aadLen
 	pxor	   %xmm\i, %xmm\i
 	pxor       \XMM2, \XMM2
 
 	cmp	   $16, %r11
-	jl	   _get_AAD_rest8\num_initial_blocks\operation
+	jl	   _get_AAD_rest\num_initial_blocks\operation
 _get_AAD_blocks\num_initial_blocks\operation:
 	movdqu	   (%r10), %xmm\i
 	PSHUFB_XMM %xmm14, %xmm\i # byte-reflect the AAD data
 	pxor	   %xmm\i, \XMM2
 	GHASH_MUL  \XMM2, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
 	add	   $16, %r10
-	sub	   $16, %r12
 	sub	   $16, %r11
 	cmp	   $16, %r11
 	jge	   _get_AAD_blocks\num_initial_blocks\operation
 
 	movdqu	   \XMM2, %xmm\i
+
+	/* read the last <16B of AAD */
+_get_AAD_rest\num_initial_blocks\operation:
 	cmp	   $0, %r11
 	je	   _get_AAD_done\num_initial_blocks\operation
 
-	pxor	   %xmm\i,%xmm\i
-
-	/* read the last <16B of AAD. since we have at least 4B of
-	data right after the AAD (the ICV, and maybe some CT), we can
-	read 4B/8B blocks safely, and then get rid of the extra stuff */
-_get_AAD_rest8\num_initial_blocks\operation:
-	cmp	   $4, %r11
-	jle	   _get_AAD_rest4\num_initial_blocks\operation
-	movq	   (%r10), \TMP1
-	add	   $8, %r10
-	sub	   $8, %r11
-	pslldq	   $8, \TMP1
-	psrldq	   $8, %xmm\i
-	pxor	   \TMP1, %xmm\i
-	jmp	   _get_AAD_rest8\num_initial_blocks\operation
-_get_AAD_rest4\num_initial_blocks\operation:
-	cmp	   $0, %r11
-	jle	   _get_AAD_rest0\num_initial_blocks\operation
-	mov	   (%r10), %eax
-	movq	   %rax, \TMP1
-	add	   $4, %r10
-	sub	   $4, %r10
-	pslldq	   $12, \TMP1
-	psrldq	   $4, %xmm\i
-	pxor	   \TMP1, %xmm\i
-_get_AAD_rest0\num_initial_blocks\operation:
-	/* finalize: shift out the extra bytes we read, and align
-	left. since pslldq can only shift by an immediate, we use
-	vpshufb and an array of shuffle masks */
-	movq	   %r12, %r11
-	salq	   $4, %r11
-	movdqu	   aad_shift_arr(%r11), \TMP1
-	PSHUFB_XMM \TMP1, %xmm\i
-_get_AAD_rest_final\num_initial_blocks\operation:
+	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, %xmm\i
 	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
 	pxor	   \XMM2, %xmm\i
 	GHASH_MUL  %xmm\i, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
@@ -563,62 +507,30 @@ _initial_blocks_done\num_initial_blocks\
 XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
         MOVADQ     SHUF_MASK(%rip), %xmm14
 	mov	   arg7, %r10           # %r10 = AAD
-	mov	   arg8, %r12           # %r12 = aadLen
-	mov	   %r12, %r11
+	mov	   arg8, %r11           # %r11 = aadLen
 	pxor	   %xmm\i, %xmm\i
 	pxor	   \XMM2, \XMM2
 
 	cmp	   $16, %r11
-	jl	   _get_AAD_rest8\num_initial_blocks\operation
+	jl	   _get_AAD_rest\num_initial_blocks\operation
 _get_AAD_blocks\num_initial_blocks\operation:
 	movdqu	   (%r10), %xmm\i
 	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
 	pxor	   %xmm\i, \XMM2
 	GHASH_MUL  \XMM2, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
 	add	   $16, %r10
-	sub	   $16, %r12
 	sub	   $16, %r11
 	cmp	   $16, %r11
 	jge	   _get_AAD_blocks\num_initial_blocks\operation
 
 	movdqu	   \XMM2, %xmm\i
+
+	/* read the last <16B of AAD */
+_get_AAD_rest\num_initial_blocks\operation:
 	cmp	   $0, %r11
 	je	   _get_AAD_done\num_initial_blocks\operation
 
-	pxor	   %xmm\i,%xmm\i
-
-	/* read the last <16B of AAD. since we have at least 4B of
-	data right after the AAD (the ICV, and maybe some PT), we can
-	read 4B/8B blocks safely, and then get rid of the extra stuff */
-_get_AAD_rest8\num_initial_blocks\operation:
-	cmp	   $4, %r11
-	jle	   _get_AAD_rest4\num_initial_blocks\operation
-	movq	   (%r10), \TMP1
-	add	   $8, %r10
-	sub	   $8, %r11
-	pslldq	   $8, \TMP1
-	psrldq	   $8, %xmm\i
-	pxor	   \TMP1, %xmm\i
-	jmp	   _get_AAD_rest8\num_initial_blocks\operation
-_get_AAD_rest4\num_initial_blocks\operation:
-	cmp	   $0, %r11
-	jle	   _get_AAD_rest0\num_initial_blocks\operation
-	mov	   (%r10), %eax
-	movq	   %rax, \TMP1
-	add	   $4, %r10
-	sub	   $4, %r10
-	pslldq	   $12, \TMP1
-	psrldq	   $4, %xmm\i
-	pxor	   \TMP1, %xmm\i
-_get_AAD_rest0\num_initial_blocks\operation:
-	/* finalize: shift out the extra bytes we read, and align
-	left. since pslldq can only shift by an immediate, we use
-	vpshufb and an array of shuffle masks */
-	movq	   %r12, %r11
-	salq	   $4, %r11
-	movdqu	   aad_shift_arr(%r11), \TMP1
-	PSHUFB_XMM \TMP1, %xmm\i
-_get_AAD_rest_final\num_initial_blocks\operation:
+	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, %xmm\i
 	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
 	pxor	   \XMM2, %xmm\i
 	GHASH_MUL  %xmm\i, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
