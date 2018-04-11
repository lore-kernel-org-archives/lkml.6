Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/T1wfmOwNOjDHv7Cor+frqwlh5HiztBjOUUHOfdnuDOKrSLyhZyg+wJF+iVnx65SjeRnM4
ARC-Seal: i=1; a=rsa-sha256; t=1523472129; cv=none;
        d=google.com; s=arc-20160816;
        b=aAfxeJwuirHO5Cr8EuhcE/JoYcUr9ReesgkHPpSYMiDr7t7aqYFuB4RPoZwDE6WNc5
         r6/pJrQ4Gu9DhehPUghNtQFwstVJ1wm2vGoCUdvVQhpg0XYx4UpppvCU4CBFPLaJtBpS
         CH5e7E9r1R1IVaY/9eji5au2zs2xvG7dL1l+AC8djrWmJyTwr6NVBzQ0Us2KCMg0cLi4
         ePMKdQ99NLLEMPPOHWvuKFvpk/2XyPhzEQpTpsetLQgjDQXBNFlf9ftotYGgGq8Iombr
         xIseFB6gW+k5mNNqI6hpexIOKbzSq4Pe3Z777i25CdIVSy5dZTWlcy8PrFCOJuQoX1DB
         Jztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qzfu2p46tO3bpTkrhmfBRqGd8R08Xlb3EsaoHAUVkw0=;
        b=0QNegR2nGmUzZU4eELUtsa9KWdcO3qxFTa5HkDeUCsq31gnvMBO5bZJgdNB3KL77ls
         8GCQn8+rmZrmMXy8NKxd0djCPhJGWI5Q6wxAnKHIH0eJEX7jnnuePsfjsxaF+sgPHoK9
         lW195SDyivQ8yH9Vuk73Nch1fzShxnSQPHVGXULJAuyXDfkPUFLA4XaJOgoIeyOUVNyZ
         zsXFnno3EdDkon8HpxHW8aWMOv9UoyEijUSrtJs8w47TrKuHtex8dclhx8nJp/lBlyOZ
         f2gJ53kSAIrgQhwK7of8zYRX4dadot70CbFr6hnsl90CyBqCsotb4hnnemKEzfAAkJFm
         TgMA==
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
Subject: [PATCH 3.18 098/121] rxrpc: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:36:41 +0200
Message-Id: <20180411183502.617042125@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476311981905163?=
X-GMAIL-MSGID: =?utf-8?q?1597476311981905163?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 89a5ea99662505d2d61f2a3030a6896c2cb3cdb0 upstream.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[natechancellor: backport to 3.18]
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
 	token = call->conn->key->payload.data;
