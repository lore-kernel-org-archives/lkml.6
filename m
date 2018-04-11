Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49hhDkRUmIEX0MKAxsyCGT2DwfDTXp1FxR39gPRplMn801zoutKqAqfJ2GchI9Kuq0MigQA
ARC-Seal: i=1; a=rsa-sha256; t=1523472648; cv=none;
        d=google.com; s=arc-20160816;
        b=VRz17KJ/gudqm5rHI2hUdO0XYEgFQHnJvUpJRTtRsT6WunTtctzd22mu0EG7I4kXBj
         BLxaC2T+X32AvBkPF0jHw+bjYkZuqmevW2In1Sq2hWyPMTreK+eCvvoYWVEyStfhXKuS
         cfdTsqIb8vIrMLw/K9/9YxND/YEdqFTCypBRxV+vKbu6o6sJ6a1E2h2biAH2HMx5baed
         F4GZnx3+Ececd+dknEO6QNZ39p56doNiZ9BAiJE2c3CTikMm0UEpTHGFPxZGSFj2b/Gd
         0XaTiUgmUgnob8ECyC2p67ETjmfa88ndyMWmQANjq7WL3nIJTMyThGPEJeti37du8lGb
         Ff4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F/3e/I5XjSBY9U4XI0Ba+gFbvyDA0WU2Gxahfe6JpTs=;
        b=KKuJEpvQaRNTsyTymW4ZY4ZlGUlKIWoBt0e0L9OVCv60weNg5sqwjGNL2H45RQnnhc
         nqMf08RxYZtEz009N5X+avdV8gvlhET97wMzUOz/WFz4QblkWLQ8LGm9OiLq87X4Gbzi
         HVljV2C1FPuEh6FFJHx1xBrkPLdBTHbfy4KdT0u7Nx8laQcUCHH8gQnBu8ETIV+J7CUt
         ujad3F8HaLwD1ZzYcE2ohPykGjKddYYANnQLMeqK/h9WY37VuT83QV6Decd2hHFlpUYs
         VTA6AwEeiEvEgY7vXeCnlqh8DOksAdipoGbG9HAtI253NV/7Oo9D7eIb1/0OTshFqbc0
         +gpA==
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
Subject: [PATCH 4.4 161/190] virtio_net: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:36:47 +0200
Message-Id: <20180411183601.967522819@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476314710711190?=
X-GMAIL-MSGID: =?utf-8?q?1597476856430091089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit e2fcad58fd230f635a74e4e983c6f4ea893642d2 upstream.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[natechancellor: backport to 4.4]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -858,7 +858,7 @@ static int xmit_skb(struct send_queue *s
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
-	unsigned num_sg;
+	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
 	bool can_push;
 
@@ -911,11 +911,16 @@ static int xmit_skb(struct send_queue *s
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
