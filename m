Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/r667JFm0gEIRU7voKVLywHnnmzlkfxqVyCmRs9wt00RVxYkREvt34B9KFF9U/RVjEXQIz
ARC-Seal: i=1; a=rsa-sha256; t=1523022260; cv=none;
        d=google.com; s=arc-20160816;
        b=KGwEL1EaOeomp+SxCNZXrb96nQ5tIFXQUnCoL8v8LLNcOMxgTBPHAzw5Df1bOxvJB+
         nNSP2Hn07aNzFoH9u+JG0enYdzqNLOd6Ee57mcBiG1OI8TFXsAfRWzwMhLUipqst+Hj6
         ty+LFjtKMHtXLKUqYdeOrGu84a/JMPJ6VQ4W8R+AZ7BH1/5efqtYzL2Cw/T91YDL+OXa
         RhsJ6v2mDgJTJqFGZnY2jkdDWEniSUwS127vgj9MmrvQAwjdaD65kK6B1q2fGpMGgAZP
         RZ9LGH2HD55GSOnwjELC0q0BfKeyKZjSqYar9G1vxo2/NPt//MLofOUzJ7IBPb3VIo1n
         KKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=glKlSm8E70c+/4zYYwxHuoaDeMM1VycXQHqutQr+Pic=;
        b=MZ/mhK2Ch5qQbrDytotheoAbn9ieYgqOi4DSqWIJRsBV0IWyU+UyRWHf5LRZlQhgKJ
         W5pP0ZayWk1XSTrCfP6H1qDfnFcRhgc/KbqKtptXfXlIf1oDeVTKVDUShW3d0JzxWRqh
         9Aop+qGuxJ7P/vpK2EapLvBe/b3JEX9tBa3tSU5zJK4E3nRamc97ioNWLIIL7aYzd/ls
         o9I2kb68Qi4BQ17WAzj6SFi3ZKm7QTtUB8Gsma5TOeOsyWnp78QD7pSnHuiI28m7efio
         XwLpD6UpqTUGzZkY1FLxmZqnkABN2Bx5Pb4pxRqncFPN+AgsYLMFE3vtqG23HKngrOAG
         hd1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gary R Hook <gary.hook@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.16 11/31] crypto: ccp - Fill the result buffer only on digest, finup, and final ops
Date: Fri,  6 Apr 2018 15:24:36 +0200
Message-Id: <20180406084342.606416182@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004590069891244?=
X-GMAIL-MSGID: =?utf-8?q?1597004590069891244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gary R Hook <gary.hook@amd.com>

commit 0ee991be4cdd88587aedbf68cdacd1765f57236a upstream.

Any change to the result buffer should only happen on final, finup
and digest operations. Changes to the buffer for update, import, export,
etc, are not allowed.

Fixes: 66d7b9f6175e ("crypto: testmgr - test misuse of result in ahash")
Signed-off-by: Gary R Hook <gary.hook@amd.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-crypto-aes-cmac.c |    2 +-
 drivers/crypto/ccp/ccp-crypto-sha.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/ccp/ccp-crypto-aes-cmac.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes-cmac.c
@@ -46,7 +46,7 @@ static int ccp_aes_cmac_complete(struct
 	}
 
 	/* Update result area if supplied */
-	if (req->result)
+	if (req->result && rctx->final)
 		memcpy(req->result, rctx->iv, digest_size);
 
 e_free:
--- a/drivers/crypto/ccp/ccp-crypto-sha.c
+++ b/drivers/crypto/ccp/ccp-crypto-sha.c
@@ -47,7 +47,7 @@ static int ccp_sha_complete(struct crypt
 	}
 
 	/* Update result area if supplied */
-	if (req->result)
+	if (req->result && rctx->final)
 		memcpy(req->result, rctx->ctx, digest_size);
 
 e_free:
