Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48s1EYKssbV4Fo6O5ZlSTuuOk7y/udM0eMsje+ttMDCSPUrGoN7HAs4GrnDIDcntSNyy0d2
ARC-Seal: i=1; a=rsa-sha256; t=1523472646; cv=none;
        d=google.com; s=arc-20160816;
        b=Ct1lGlQwh3KYLdXlUhfMnYxgaZBurFTEj/RFfHL/sxtN6Qeh7xzGjPMJ8ga3nFc8cn
         DTYb8GBACDkZ12mrO2ahn5YcpmUYlCxmCC/r2h+aQ+Wmnct9gFuKTfCjMimmr37TKXu7
         cAE2mghRqY9FI4KKpJiOgyBsZJp8D3k3P0LYJgfbgfg2lyywtdQZv2Kuy0RmD2cuGjPb
         debE7twlO3VS279gkQIc+Qfo2b/MtDaywVtYTm6FHd1UChtVrQB0Yvr41Duw6OtN03QJ
         uAXSqBnUnVcg4TC4IbVzEb7PjlslPLWMVf5SUXwXaZtGXqsxpTsnPgtcMe2KU6vGxeav
         Te9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aZS/ifUYKqrdXHGymLUxEvA9TPtb8HeEkG52meDPuf0=;
        b=hdPmatqJ9XcW/oNBpXry04TtYENodt/e7zQTbN6Rauref/d7eQCJW+UvYguour6WQz
         UOcmXc71+1n/FPVs39ILj1gS4huVjHOYIge81XzECZW52NmktjZ4i2FEL1CSqrsAeygw
         q+9BnT6j25CYaQwYV1JdMvK1prv1sxN26lTwzOroiQIJbJ0NIYKlOtNRVeO5oC/Wp0d5
         sFsrisfc/dy1hZ3X12+MyUTJOy0yMz9hcn+V523IJoz6ng2KgaPxhaI3f+N0LJ6rg1ku
         3zlLODb67r7VDZYELxAK2BV6QmQ7z5AdDb9y2uIybWtmwQsBX7VhW7hNTjGjSH8Qqc6f
         k/3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 160/190] rxrpc: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:36:46 +0200
Message-Id: <20180411183601.906704883@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476311981905163?=
X-GMAIL-MSGID: =?utf-8?q?1597476853608363423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 89a5ea99662505d2d61f2a3030a6896c2cb3cdb0 upstream.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[natechancellor: backport to 4.4]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxkad.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -209,7 +209,7 @@ static int rxkad_secure_packet_encrypt(c
 	struct sk_buff *trailer;
 	unsigned int len;
 	u16 check;
-	int nsg;
+	int nsg, err;
 
 	sp = rxrpc_skb(skb);
 
@@ -240,7 +240,9 @@ static int rxkad_secure_packet_encrypt(c
 	len &= ~(call->conn->size_align - 1);
 
 	sg_init_table(sg, nsg);
-	skb_to_sgvec(skb, sg, 0, len);
+	err = skb_to_sgvec(skb, sg, 0, len);
+	if (unlikely(err < 0))
+		return err;
 	crypto_blkcipher_encrypt_iv(&desc, sg, sg, len);
 
 	_leave(" = 0");
@@ -336,7 +338,7 @@ static int rxkad_verify_packet_auth(cons
 	struct sk_buff *trailer;
 	u32 data_size, buf;
 	u16 check;
-	int nsg;
+	int nsg, ret;
 
 	_enter("");
 
@@ -348,7 +350,9 @@ static int rxkad_verify_packet_auth(cons
 		goto nomem;
 
 	sg_init_table(sg, nsg);
-	skb_to_sgvec(skb, sg, 0, 8);
+	ret = skb_to_sgvec(skb, sg, 0, 8);
+	if (unlikely(ret < 0))
+		return ret;
 
 	/* start the decryption afresh */
 	memset(&iv, 0, sizeof(iv));
@@ -411,7 +415,7 @@ static int rxkad_verify_packet_encrypt(c
 	struct sk_buff *trailer;
 	u32 data_size, buf;
 	u16 check;
-	int nsg;
+	int nsg, ret;
 
 	_enter(",{%d}", skb->len);
 
@@ -430,7 +434,12 @@ static int rxkad_verify_packet_encrypt(c
 	}
 
 	sg_init_table(sg, nsg);
-	skb_to_sgvec(skb, sg, 0, skb->len);
+	ret = skb_to_sgvec(skb, sg, 0, skb->len);
+	if (unlikely(ret < 0)) {
+		if (sg != _sg)
+			kfree(sg);
+		return ret;
+	}
 
 	/* decrypt from the session key */
 	token = call->conn->key->payload.data[0];
