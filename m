Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Y0fZkaKgYjKipowEiQ6oljV2MSZMCwFA7zTP54xfjqBCn0fO/69kEQwilbertbobG+iS6
ARC-Seal: i=1; a=rsa-sha256; t=1523022164; cv=none;
        d=google.com; s=arc-20160816;
        b=wVkePhacIRQydH5niORNsBFPQepjEOcAMjBkXP69cnm7D4J6hwXTfVivKtAaFQM1y3
         +KsE/vKi8sN/O5MnQdybb9VBby5yvsKREHe79p2rxP3qR5NGJirdYSVG75/nPq2fi/io
         VDZohmo3E5j6XAMoYeLpFMd+LzhnotZsV4c52BhjuZPUF5UZMd9aBYiajMmzSLwMY/uw
         +tqj/63g8pPtfVccwpmc4VoNCHdeIWUcUiBhziSqU+kSQp+VyQKS6d1xAGTR47H68xzt
         HQcS6GpZW7iQ0z9aojQbnAqnDY6xu1u3y3D/8A+atILPf3X3a3lUGsC47E50kgl0H5T0
         3rWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KxvO5QK6933giULWSUY/koDaiSTkF+EKl26C+o4kJzg=;
        b=hV2hL0vlBPlnMdL2hAdQTXjKIlFNJPToxdG8huMObO7NMG6NrafRydhYGyls/Q4mE/
         pO9UiMvn9ztPxHBAqtv2TD9k6LlQJvycLGgjRPAffRveh3NSaktSNzZ7ddsNg0DP+h2M
         TYhvpJbilE4kS9adVz5EHpdKi+GSI+Fgu8P8j4QNxmIn351QICkfIxxr6dM99lVWsng6
         GJIL/yZFnKLH2W/abIPeYao85Y7tkOWyttObMnZxYGmNFWUIBp6D6ey71qVGGP15XWEh
         1L673iTLfCoY1r43EQbpqi7PjSujgU5nLdXLIw5EsISYXrd8nR/XeIslhKZ5QTwEajoq
         PGbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 49/72] crypto: lrw - Free rctx->ext with kzfree
Date: Fri,  6 Apr 2018 15:24:24 +0200
Message-Id: <20180406084352.938710449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004267731189000?=
X-GMAIL-MSGID: =?utf-8?q?1597004489012008789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 8c9bdab21289c211ca1ca6a5f9b7537b4a600a02 upstream.

The buffer rctx->ext contains potentially sensitive data and should
be freed with kzfree.

Cc: <stable@vger.kernel.org>
Fixes: 700cb3f5fe75 ("crypto: lrw - Convert to skcipher")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/lrw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -313,7 +313,7 @@ static void exit_crypt(struct skcipher_r
 	rctx->left = 0;
 
 	if (rctx->ext)
-		kfree(rctx->ext);
+		kzfree(rctx->ext);
 }
 
 static int do_encrypt(struct skcipher_request *req, int err)
