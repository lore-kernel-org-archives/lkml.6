Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ITqOkfFGbtg3qQ8TSsnB36HBRviKefGOy7ONMETP72AI6dSlBTonHr5jGJ3iYs2Oz2UXU
ARC-Seal: i=1; a=rsa-sha256; t=1523022257; cv=none;
        d=google.com; s=arc-20160816;
        b=b//7DRRA4OSTlOy7wpOWQKmsxlGysRk40ipxgWdK4si+fGSHe+43Ck3WzfKpmnMBTs
         fZb2yNTnEN8U+pioFy24EGVq7MB2IidKTn1MyQAtGEZVXORAcuUtg27/ywyltXV9ztNv
         lEvFY/gAsIYloaW6KNfT+BA6ZG4IuZ8S/9wXqy4yBE35+f2iXVVanjfIQmtA2vsBMXDe
         yuB77tUIbcSBx+ZF6xc4saZOFZEQ52LjXESzkQAtKC3aKy5I5FAskZpsK6BTfZ3tjHj2
         8JWJ/H0T8mNwZFfqm/yAepiCPGXCIVml+TBOVg2yAabQko+AQDzsdAKYCNCbwIMHm4WD
         yP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j9Xfyy31P5u8yYHWJchKlOadTSyPQ9ktFThodAMCAT4=;
        b=KTv+7806df2aR51VfX/uWTqPlCynFv+sJ3SFwR6vpu1tGt2Dcnd4DWdqVtcvc1+9KJ
         hiXfOHe2riX2D6EXRE6sHkpUP6poXs6+CqZqfCQtp9IzP19ZCb7F1AU/Nty+qLyowBfq
         fy4CKe3+sT3EcOIRkYUN9fLBuKMfBv3Dzouqfy2cJoWpH6UKflxCgqBiY6JgkuJh3THg
         4hua9Jhgvm7fuGQP7HdSDAA+gd0SnDcp7E8Sx5nrJZkvGwu6DRi/lWRmGtitjqtbtBKY
         xpIuYOtW1zcsiiZlj/yIOuMKmN2j9b3JP/ZCN5G8+yDHcGw9mhQxTiVBOJj2ywMwr9aZ
         Y6LA==
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
Subject: [PATCH 4.16 10/31] crypto: lrw - Free rctx->ext with kzfree
Date: Fri,  6 Apr 2018 15:24:35 +0200
Message-Id: <20180406084342.491101095@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004267731189000?=
X-GMAIL-MSGID: =?utf-8?q?1597004587270077315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
