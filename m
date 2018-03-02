Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt2vL2x3S0muZAwoLADqbrb2I2fcEUDQG7SIYZs0vZtEedu1Qipin0q4iZxx+P9HxJN2uaK
ARC-Seal: i=1; a=rsa-sha256; t=1519981293; cv=none;
        d=google.com; s=arc-20160816;
        b=w8nhU11j7djSQAZ/lMlE1f13NZar3XdsHQg6c68zdUJj33M0oHTURC1bCRnWyj/6tF
         mZe+7zHAEU4r8SyTHFue7LRr0PT6q3RDBsf9wLvTNIKL1NboCniDNFCxFt3Wtg0xeJDA
         Gb6dPi/TJOjzPdkMCWmiZbeSoDh34Cqtm8VMhlzc/I9Qr+/LE271Dz9evl9MUpRGHIIG
         sykXA1XDDzWS2CnnEdueQu5IK6hrCHLS0IM0XKzwwaMoZGtXG74LnjxjwkMhswVRLGFl
         TY1DlL+XwPhP6YHiKk8KqmskLHgIHrACXe0M5GLR3rOikHaOHJDIImRU5TGLpxT/nlg6
         0QfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RQksYRTxo5psi2ugPvKRsPydm3AZMQNNFhyDSfE+yiE=;
        b=EM/w7X1lla+jY8T8IRvo1sk0fTUXDTloPJ/jVaFoIrcPmFJmbxdmi+F3Nf58ibv82D
         lme/CRleFlXv4a8eSdlWVeTMforfAMZLvxhBuiThv3g1vz/Ur25kMjZvtaPm2Rna367j
         Xf4xHVUXo+wh1L8oTmgm86gEvGEJwyEbJh/5uIQ9BdmPhCY8rf0pKU0MyC3FdJ8j2jeA
         /YR556uSwYi79lsnR6KfMBJA1Yxp36BMW3uopccKSY+Cl9CsNtME1OPQlhro+S/b5nU3
         uHyd169NZnuv9SUW5dDPRHYveJhQ5TDNHzPS4tVxVoaFR8c71bsBbJ+o1bGtUH/vvwm7
         L0lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 049/115] crypto: af_alg - Fix race around ctx->rcvused by making it atomic_t
Date: Fri,  2 Mar 2018 09:50:52 +0100
Message-Id: <20180302084505.867366245@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815904484960407?=
X-GMAIL-MSGID: =?utf-8?q?1593815904484960407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>


[ Upstream commit af955bf15d2c27496b0269b1f05c26f758c68314 ]

This variable was increased and decreased without any protection.
Result was an occasional misscount and negative wrap around resulting
in false resource allocation failures.

Fixes: 7d2c3f54e6f6 ("crypto: af_alg - remove locking in async callback")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/af_alg.c         |    4 ++--
 crypto/algif_aead.c     |    2 +-
 crypto/algif_skcipher.c |    2 +-
 include/crypto/if_alg.h |    5 +++--
 4 files changed, 7 insertions(+), 6 deletions(-)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -693,7 +693,7 @@ void af_alg_free_areq_sgls(struct af_alg
 	unsigned int i;
 
 	list_for_each_entry_safe(rsgl, tmp, &areq->rsgl_list, list) {
-		ctx->rcvused -= rsgl->sg_num_bytes;
+		atomic_sub(rsgl->sg_num_bytes, &ctx->rcvused);
 		af_alg_free_sg(&rsgl->sgl);
 		list_del(&rsgl->list);
 		if (rsgl != &areq->first_rsgl)
@@ -1192,7 +1192,7 @@ int af_alg_get_rsgl(struct sock *sk, str
 
 		areq->last_rsgl = rsgl;
 		len += err;
-		ctx->rcvused += err;
+		atomic_add(err, &ctx->rcvused);
 		rsgl->sg_num_bytes = err;
 		iov_iter_advance(&msg->msg_iter, err);
 	}
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -571,7 +571,7 @@ static int aead_accept_parent_nokey(void
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len = len;
 	ctx->used = 0;
-	ctx->rcvused = 0;
+	atomic_set(&ctx->rcvused, 0);
 	ctx->more = 0;
 	ctx->merge = 0;
 	ctx->enc = 0;
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -391,7 +391,7 @@ static int skcipher_accept_parent_nokey(
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len = len;
 	ctx->used = 0;
-	ctx->rcvused = 0;
+	atomic_set(&ctx->rcvused, 0);
 	ctx->more = 0;
 	ctx->merge = 0;
 	ctx->enc = 0;
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -18,6 +18,7 @@
 #include <linux/if_alg.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <net/sock.h>
 
 #include <crypto/aead.h>
@@ -155,7 +156,7 @@ struct af_alg_ctx {
 	struct af_alg_completion completion;
 
 	size_t used;
-	size_t rcvused;
+	atomic_t rcvused;
 
 	bool more;
 	bool merge;
@@ -228,7 +229,7 @@ static inline int af_alg_rcvbuf(struct s
 	struct af_alg_ctx *ctx = ask->private;
 
 	return max_t(int, max_t(int, sk->sk_rcvbuf & PAGE_MASK, PAGE_SIZE) -
-			  ctx->rcvused, 0);
+		     atomic_read(&ctx->rcvused), 0);
 }
 
 /**
