Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/sUUVRl3LhGlJUTPQJyfnNDiADb0uquhGqy91pBPstIlOuRMFxk3O4nCbc07VnFGJ/MSaZ
ARC-Seal: i=1; a=rsa-sha256; t=1523472132; cv=none;
        d=google.com; s=arc-20160816;
        b=wK/DjNGNExoAZq7LwSjSFzHe584mop0Whw6YUiOI4r2uVw0BqRdeLfJYDRiH2pYrOW
         Gh1hRR4nVD4muhNp7cL+YaJ4EbFuJuNsXy+XUoxd8B/wnsnaauVX/sLc/GdP9ZQQRHrj
         WXCLETAt+XHv1tTCQ2wrmufcJJAtTD7f6flGqMXV3pnWT9fbqOJUu8COPG4pG6pgRpOs
         Kw2NOaL4sR82r5dBbXTHoOcHOYGumEQc6kIWSJxOJngq2kKRFt55x5arS/NzVvaKJfy8
         JiCDQh2bisjFlhFTSC9P41Twuk0h5GG1KcOFpe9e6EeCWtX7QANcJ2lWfjDM0b88G5Cr
         319A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UXIRMULYzhSuMMnZiADBNAmwePbkx/4eBMwy+ji0igk=;
        b=YFfnyOOFPl2T3kkQtzrTdUw0M72A+6XWy+v2XbjRfBoteCPykm50NqBl9w95MJ5Fvn
         +fRi0bw/kwtcjYCMnIJpDCUPkdalzZmHv5vTIq8uXm0F0Oa4bxW11fDUnYqbGyfm8DKu
         Bh4vD/K+uJo5Bp+5V6XMQJQcG8Eclhn/PHa1qJ0+nWf3GwM2gFdZLMUsxONznDNK0ldD
         Kk8YuXczY+6JACcVfpZjyX9cYul/aypeuQdYls3zZlsLmACye1ecs/JM9hT7C81w3owg
         opgCkqQ/XsZHckifXoHYi2mw4uSy+x2yGzx5foyb8mg+wofxy7lCdhRMyOcy8FjgRB3L
         0eGQ==
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
Subject: [PATCH 3.18 099/121] virtio_net: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:36:42 +0200
Message-Id: <20180411183502.763761140@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476314710711190?=
X-GMAIL-MSGID: =?utf-8?q?1597476314710711190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit e2fcad58fd230f635a74e4e983c6f4ea893642d2 upstream.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[natechancellor: backport to 3.18]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -854,7 +854,7 @@ static int xmit_skb(struct send_queue *s
 	struct skb_vnet_hdr *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
-	unsigned num_sg;
+	int num_sg;
 	unsigned hdr_len;
 	bool can_push;
 
@@ -906,11 +906,16 @@ static int xmit_skb(struct send_queue *s
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
