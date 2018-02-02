Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226WOqGu4mGgYh25fi9kLM4CG44ydcCcVQvG4haEmNCeUl5vV2E4yIvZAtRWiuUvu16Parvi
ARC-Seal: i=1; a=rsa-sha256; t=1517591726; cv=none;
        d=google.com; s=arc-20160816;
        b=AgH3WQjyoxMZc9rHTrkqErcAPmkxcJEiMXA9pLmjv0HxjiUi1IyRXebSGhwx2nzJOy
         aQNBEN40Q8TVvqvoN36wf5DFwZCWdcXlf74wx+RwljbzpbJ40RpS0rrx+motV1Ydzmr5
         9c832fvit3vSMDsf7rmGBqm6yRwrImpZmUtTNuOzI47HyIVMvR2gwYQkLTH8n1JhMcsk
         BGrUeVheqYFOJIp5F4q9Hy0ur2FYIaitq5hNTt2mhpsRoROzl+XmF0eW/Bs5olKiD3IY
         bPfuMNbX5Z0OszqpsW/E8QHLN61FEg6wl3sNW+c9SjSXbBkb1D3K9ccDKO70nCshJdX9
         o25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pfP2CFFNXtGwI/Qr7c9KNCOKaBEnbPfIsYgFVEBpMhI=;
        b=atwZwE3QUb0ymMFTbWG5O+VZyMWjOdV18rypENa7aEim5BNExvh4TLDVAB8wvMuFVD
         Krzs1YWievF2rKvP7RHzp2+JB1cvDxic9/M61Cxah6z6gQr6Vgw1cEagys8gHeR7Qsx+
         bLA6HTKZAhB9rQINOocSXm4z4lRktKr+evO0wV4hWl0u19mN9UA3zC7f6tU7Cl3GfTiT
         KQHGbwVn9/NQisWyhKxby/8UiPxpmPVKJPCMg04FgeIzHnUShdzbQB2bcc/NX+2bVS1F
         nCAsxAVsgsMAnH/LjxsGFroGKqVlW8kYRC75I7IZvXTpVCbYlmqMfTK3lgCxS9BhB3nZ
         SPUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stefano Brivio <sbrivio@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 08/55] crypto: aesni - fix typo in generic_gcmaes_decrypt
Date: Fri,  2 Feb 2018 17:58:26 +0100
Message-Id: <20180202140826.773429227@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309745134653616?=
X-GMAIL-MSGID: =?utf-8?q?1591310262157828308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

commit 106840c41096a01079d3a2025225029c13713802 upstream.

generic_gcmaes_decrypt needs to use generic_gcmaes_ctx, not
aesni_rfc4106_gcm_ctx. This is actually harmless because the fields in
struct generic_gcmaes_ctx share the layout of the same fields in
aesni_rfc4106_gcm_ctx.

Fixes: cce2ea8d90fe ("crypto: aesni - add generic gcm(aes)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1117,7 +1117,7 @@ static int generic_gcmaes_decrypt(struct
 {
 	__be32 counter = cpu_to_be32(1);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(tfm);
+	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
 	u8 iv[16] __attribute__ ((__aligned__(AESNI_ALIGN)));
 
