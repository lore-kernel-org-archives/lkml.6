Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227eMUaLOevM6+g9UDa2msUns1/9PZCccwSdBW9oxVLiGDrzoWmQw46iF3H0dA4XWLoiy4J7
ARC-Seal: i=1; a=rsa-sha256; t=1517591244; cv=none;
        d=google.com; s=arc-20160816;
        b=KPjODs4jO/HGw6qHx1r8caiDnwwKoq/PRU8BWgT3sxeLoqBRSEnh4kwmgZewLbYNqr
         YdokygWsBzyWOrsJONGMqQpJNmmOagfCJ3NfgFpo1u2KTmX7sbloJLa48ElKplg6nZR5
         KbTBQ8Xsx16jy89J8Vlz83pPzAnREv/s32OUQEQo/iYqPqAFyGRFoMxJSYtS423iIcV9
         CXlCqE4kqJ9QLLM/dpcIpUDLoQOXerGGJ8k/4CDx4zUE1H3MqZ+allr35Hpdz0J++B8C
         INyEB+eEeHkabCkLm+zjF0Yy1QH12EqW2zsGgqoZZPFvPqhKaZLc+93+KwgtPlsPJbg/
         o0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JQANne+jkp3DSsctURvOFEu5nTOZURcAjZxzlHngBo0=;
        b=RTLu0mHJT9MOXrwKQ5U4X5K91vCbEwyzZqQG7DmtYp8JmeJ4wT16BaevPoy1M+d5qn
         D6W4FVOM3iyTkHo2M89RQZU1NmAGvNe+MgD2jjcvYy9Um97rlDasiB8IdkpXRL1HK/XX
         WpvguA++cYyUElodroYalNthtf+NoP3ZN2JA4UnA395e5fxpIa6cOD1iAcL9K9OKN8yo
         VMFB4JUgUwgoA8yJCSJ8aY9adlGUP+7A57uFOgNQMdFsqVTCRJ308TU3T7qFKDdd1HZ0
         hnrJP8i9d7uc19XX39RFumn22z5KtqOc8HGpOqF4Vf2SZtEY+qzeYpgVgkxYXXlbE8Mb
         dRVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Junaid Shahid <junaids@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 014/156] crypto: aesni - Fix out-of-bounds access of the data buffer in generic-gcm-aesni
Date: Fri,  2 Feb 2018 17:56:35 +0100
Message-Id: <20180202140840.952027525@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309756503641082?=
X-GMAIL-MSGID: =?utf-8?q?1591309756503641082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junaid Shahid <junaids@google.com>

commit b20209c91e23a9bbad9cac2f80bc16b3c259e10e upstream.

The aesni_gcm_enc/dec functions can access memory before the start of
the data buffer if the length of the data buffer is less than 16 bytes.
This is because they perform the read via a single 16-byte load. This
can potentially result in accessing a page that is not mapped and thus
causing the machine to crash. This patch fixes that by reading the
partial block byte-by-byte and optionally an via 8-byte load if the block
was at least 8 bytes.

Fixes: 0487ccac ("crypto: aesni - make non-AVX AES-GCM work with any aadlen")
Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_asm.S |   87 +++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 42 deletions(-)

--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -257,6 +257,37 @@ aad_shift_arr:
 	pxor      \TMP1, \GH            # result is in TMP1
 .endm
 
+# Reads DLEN bytes starting at DPTR and stores in XMMDst
+# where 0 < DLEN < 16
+# Clobbers %rax, DLEN and XMM1
+.macro READ_PARTIAL_BLOCK DPTR DLEN XMM1 XMMDst
+        cmp $8, \DLEN
+        jl _read_lt8_\@
+        mov (\DPTR), %rax
+        MOVQ_R64_XMM %rax, \XMMDst
+        sub $8, \DLEN
+        jz _done_read_partial_block_\@
+	xor %eax, %eax
+_read_next_byte_\@:
+        shl $8, %rax
+        mov 7(\DPTR, \DLEN, 1), %al
+        dec \DLEN
+        jnz _read_next_byte_\@
+        MOVQ_R64_XMM %rax, \XMM1
+	pslldq $8, \XMM1
+        por \XMM1, \XMMDst
+	jmp _done_read_partial_block_\@
+_read_lt8_\@:
+	xor %eax, %eax
+_read_next_byte_lt8_\@:
+        shl $8, %rax
+        mov -1(\DPTR, \DLEN, 1), %al
+        dec \DLEN
+        jnz _read_next_byte_lt8_\@
+        MOVQ_R64_XMM %rax, \XMMDst
+_done_read_partial_block_\@:
+.endm
+
 /*
 * if a = number of total plaintext bytes
 * b = floor(a/16)
@@ -1386,14 +1417,6 @@ _esb_loop_\@:
 *
 *                        AAD Format with 64-bit Extended Sequence Number
 *
-* aadLen:
-*       from the definition of the spec, aadLen can only be 8 or 12 bytes.
-*       The code supports 16 too but for other sizes, the code will fail.
-*
-* TLen:
-*       from the definition of the spec, TLen can only be 8, 12 or 16 bytes.
-*       For other sizes, the code will fail.
-*
 * poly = x^128 + x^127 + x^126 + x^121 + 1
 *
 *****************************************************************************/
@@ -1487,19 +1510,16 @@ _zero_cipher_left_decrypt:
 	PSHUFB_XMM %xmm10, %xmm0
 
 	ENCRYPT_SINGLE_BLOCK  %xmm0, %xmm1    # E(K, Yn)
-	sub $16, %r11
-	add %r13, %r11
-	movdqu (%arg3,%r11,1), %xmm1   # receive the last <16 byte block
-	lea SHIFT_MASK+16(%rip), %r12
-	sub %r13, %r12
-# adjust the shuffle mask pointer to be able to shift 16-%r13 bytes
-# (%r13 is the number of bytes in plaintext mod 16)
-	movdqu (%r12), %xmm2           # get the appropriate shuffle mask
-	PSHUFB_XMM %xmm2, %xmm1            # right shift 16-%r13 butes
 
+	lea (%arg3,%r11,1), %r10
+	mov %r13, %r12
+	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
+
+	lea ALL_F+16(%rip), %r12
+	sub %r13, %r12
 	movdqa  %xmm1, %xmm2
 	pxor %xmm1, %xmm0            # Ciphertext XOR E(K, Yn)
-	movdqu ALL_F-SHIFT_MASK(%r12), %xmm1
+	movdqu (%r12), %xmm1
 	# get the appropriate mask to mask out top 16-%r13 bytes of %xmm0
 	pand %xmm1, %xmm0            # mask out top 16-%r13 bytes of %xmm0
 	pand    %xmm1, %xmm2
@@ -1508,9 +1528,6 @@ _zero_cipher_left_decrypt:
 
 	pxor %xmm2, %xmm8
 	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-	          # GHASH computation for the last <16 byte block
-	sub %r13, %r11
-	add $16, %r11
 
         # output %r13 bytes
 	MOVQ_R64_XMM	%xmm0, %rax
@@ -1664,14 +1681,6 @@ ENDPROC(aesni_gcm_dec)
 *
 *                         AAD Format with 64-bit Extended Sequence Number
 *
-* aadLen:
-*       from the definition of the spec, aadLen can only be 8 or 12 bytes.
-*       The code supports 16 too but for other sizes, the code will fail.
-*
-* TLen:
-*       from the definition of the spec, TLen can only be 8, 12 or 16 bytes.
-*       For other sizes, the code will fail.
-*
 * poly = x^128 + x^127 + x^126 + x^121 + 1
 ***************************************************************************/
 ENTRY(aesni_gcm_enc)
@@ -1764,19 +1773,16 @@ _zero_cipher_left_encrypt:
         movdqa SHUF_MASK(%rip), %xmm10
 	PSHUFB_XMM %xmm10, %xmm0
 
-
 	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
-	sub $16, %r11
-	add %r13, %r11
-	movdqu (%arg3,%r11,1), %xmm1     # receive the last <16 byte blocks
-	lea SHIFT_MASK+16(%rip), %r12
+
+	lea (%arg3,%r11,1), %r10
+	mov %r13, %r12
+	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
+
+	lea ALL_F+16(%rip), %r12
 	sub %r13, %r12
-	# adjust the shuffle mask pointer to be able to shift 16-r13 bytes
-	# (%r13 is the number of bytes in plaintext mod 16)
-	movdqu	(%r12), %xmm2           # get the appropriate shuffle mask
-	PSHUFB_XMM	%xmm2, %xmm1            # shift right 16-r13 byte
 	pxor	%xmm1, %xmm0            # Plaintext XOR Encrypt(K, Yn)
-	movdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
+	movdqu	(%r12), %xmm1
 	# get the appropriate mask to mask out top 16-r13 bytes of xmm0
 	pand	%xmm1, %xmm0            # mask out top 16-r13 bytes of xmm0
         movdqa SHUF_MASK(%rip), %xmm10
@@ -1785,9 +1791,6 @@ _zero_cipher_left_encrypt:
 	pxor	%xmm0, %xmm8
 	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
 	# GHASH computation for the last <16 byte block
-	sub	%r13, %r11
-	add	$16, %r11
-
 	movdqa SHUF_MASK(%rip), %xmm10
 	PSHUFB_XMM %xmm10, %xmm0
 
