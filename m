Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gtzpVGmFj4qsbNQ2K+Ex74yFmqt20ukYrKBal9Hg/o8aYElvZtiLni9O5xfPDS4IHH/OR
ARC-Seal: i=1; a=rsa-sha256; t=1523473505; cv=none;
        d=google.com; s=arc-20160816;
        b=WeBT+egGB8eO4SnmmBfcnvDc8F7LeCHS+nNMIeHqapDQ5thVHZ9U3LSn1czv0LOYlk
         kp+b9/QHF+DQz4Xt8L5ZdU5BACjES+8G0OH4aENb+HF2UsqfKPx+1MVYEDrfuIdZQBZd
         jsqy5Zf5SrY0OnWRsHDVfEo1Ozaxg9l6kfzqA0PQOZJsHEUszUXHoZMWS70phGTzQHOm
         wTutIqYffei64eYYROwZ5ISDZmiVpoBGWa05oLj+7ngp0QNhFp0cl/8ptkGyGDNarBgi
         7Epw5lZIh7bXLyn/8MPKxynSlzfb6C6MJ2NKYdEGTPK7O4QraADClhbnmiklzUeeE2/U
         k+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xVx0fvMklE4t0Bdc4pKmBfol7yL5jpXUo40LYtUHpug=;
        b=J01l/qUvaE/qUxEsqsOoDA3CXFLHqMN08iv2MKYjqkMXDlejCrwSZxmf6LybR00S6P
         /8awtnRloR+TIjP7/A2UJXCRCVkOnIUorTg/vmvpYt33QOKego0rzyHt3FSVj2W9jHCt
         8mIpE9mw7uW98UyfLS+pXa2JC9IIwqgDpypbLwiKJ6BobsB7pq2lHp2VwW8zt2yoUpBA
         ZlQ8ZkGQqD9IkBSthS1tEODZlf0mSfSf1RgY21iVIPhUjCNFx8aem6nK3hVit0kNo881
         88TgbLlTK9QQYzmY+sDQe/3aIgNQEXBcSqOn7cEYpA0W73a0ZJp7XbVffBZ4cSxFg2kO
         gzkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 272/310] virtio_net: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:36:51 +0200
Message-Id: <20180411183634.330713165@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476314710711190?=
X-GMAIL-MSGID: =?utf-8?q?1597477754308456527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit e2fcad58fd230f635a74e4e983c6f4ea893642d2 upstream.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/virtio_net.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -831,7 +831,7 @@ static int xmit_skb(struct send_queue *s
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
-	unsigned num_sg;
+	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
 	bool can_push;
 
@@ -858,11 +858,16 @@ static int xmit_skb(struct send_queue *s
 	if (can_push) {
 		__skb_push(skb, hdr_len);
 		num_sg = skb_to_sgvec(skb, sq->sg, 0, skb->len);
+		if (unlikely(num_sg < 0))
+			return num_sg;
 		/* Pull header back to avoid skew in tx bytes calculations. */
 		__skb_pull(skb, hdr_len);
 	} else {
 		sg_set_buf(sq->sg, hdr, hdr_len);
-		num_sg = skb_to_sgvec(skb, sq->sg + 1, 0, skb->len) + 1;
+		num_sg = skb_to_sgvec(skb, sq->sg + 1, 0, skb->len);
+		if (unlikely(num_sg < 0))
+			return num_sg;
+		num_sg++;
 	}
 	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
 }
