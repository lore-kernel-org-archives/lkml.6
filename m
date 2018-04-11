Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48QYbH6Wl4PW5ROePb9TbQ1BPLYDzXyve938UqvDUDMJlkb6d0J724S99boZ4By0pFX4bbN
ARC-Seal: i=1; a=rsa-sha256; t=1523473502; cv=none;
        d=google.com; s=arc-20160816;
        b=bu8QbXYyJyXQCL62pUKTrA4g/mH+W+TOvMgHRKZecSLQGRIJLDmA+5NFWejYSMCpUf
         TQ2Xw6y3Szh6dlx3eZhHt0iKQ1upRfRnmf/e+MQG7yDrkSyI9ItIyrkQ3nYxPQkyqgIA
         ipXF3d+O9lVifTa6w+vduEGzqAWQCC7TFVCcTUawDbgsg02HhJyTx0MiBvtCsSmWe2bI
         PcKE9ts8pWcJetcZ7z2Oqxc8s8y9OLZiPDqAnMBUTm1VMM2OeqLD0W+Tl/d3HR0zRLKq
         mMStF0DOOY8G6TossQzLeSuhRE0YiehmGVyS5B82oJIzJPjJ294jYVYnv5Nik41HnpXn
         T2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QThIzrTvYLfRJlCX01C9DkXZ3hB01OvkM9z+lwr6Xu8=;
        b=AiaITMUBRxrtYIgHqxnD3vT+HGTczyT7UX1sGufo8ZbVYbTNnrJmEEEBW7MAMfByM6
         bP1RwS4krMIWNuA4Hr2H6IQFPm/BOxsuDhrZMXQkKvPw3JvA6HPvrw8wZUB54eCXQ92O
         e2x6UhfjlgWL7sefH0PIUfN32YFv4eyuhbsRZ25jEpq5VbwQka2qG5o/GkTVtXBw+K9l
         kE55dgSAFUyid4Mk9gc7sxzjVoQZwhsTmyHcO+xMlqeJfS6VaxJWszJKdGPALOfmAuLe
         J9hi4xsIBD2dRYf66YVqXlx1GRhwqdwuQGvSdDtVUkRGX6LR6CyZDKPUs7XRfe9dhOBy
         z93g==
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
Subject: [PATCH 4.9 271/310] rxrpc: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:36:50 +0200
Message-Id: <20180411183634.293219568@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476311981905163?=
X-GMAIL-MSGID: =?utf-8?q?1597477750742621012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 89a5ea99662505d2d61f2a3030a6896c2cb3cdb0 upstream.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rxrpc/rxkad.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -229,7 +229,9 @@ static int rxkad_secure_packet_encrypt(c
 	len &= ~(call->conn->size_align - 1);
 
 	sg_init_table(sg, nsg);
-	skb_to_sgvec(skb, sg, 0, len);
+	err = skb_to_sgvec(skb, sg, 0, len);
+	if (unlikely(err < 0))
+		goto out;
 	skcipher_request_set_crypt(req, sg, sg, len, iv.x);
 	crypto_skcipher_encrypt(req);
 
@@ -325,7 +327,7 @@ static int rxkad_verify_packet_1(struct
 	struct sk_buff *trailer;
 	u32 data_size, buf;
 	u16 check;
-	int nsg;
+	int nsg, ret;
 
 	_enter("");
 
@@ -342,7 +344,9 @@ static int rxkad_verify_packet_1(struct
 		goto nomem;
 
 	sg_init_table(sg, nsg);
-	skb_to_sgvec(skb, sg, offset, 8);
+	ret = skb_to_sgvec(skb, sg, offset, 8);
+	if (unlikely(ret < 0))
+		return ret;
 
 	/* start the decryption afresh */
 	memset(&iv, 0, sizeof(iv));
@@ -405,7 +409,7 @@ static int rxkad_verify_packet_2(struct
 	struct sk_buff *trailer;
 	u32 data_size, buf;
 	u16 check;
-	int nsg;
+	int nsg, ret;
 
 	_enter(",{%d}", skb->len);
 
@@ -429,7 +433,12 @@ static int rxkad_verify_packet_2(struct
 	}
 
 	sg_init_table(sg, nsg);
-	skb_to_sgvec(skb, sg, offset, len);
+	ret = skb_to_sgvec(skb, sg, offset, len);
+	if (unlikely(ret < 0)) {
+		if (sg != _sg)
+			kfree(sg);
+		return ret;
+	}
 
 	/* decrypt from the session key */
 	token = call->conn->params.key->payload.data[0];
