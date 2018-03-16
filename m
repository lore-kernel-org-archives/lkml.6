Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuRMAFeGsNUky0EwvAXHv2N8WklHf1EXMR7XPIBk9GAtSiVWLjCwoTxG7THGJE7gXMls36A
ARC-Seal: i=1; a=rsa-sha256; t=1521214683; cv=none;
        d=google.com; s=arc-20160816;
        b=XNpAozOZ2RZ0cBsAJ9Woq0/G+WbXd5mXkiMMi9zA/mMDbXgQfBhtgS2TKVzDMO9+kf
         KYODzOTyw0IekiicYAxLLWkgjl4nQ/8QsXGnretgY6bnkX1N2PFM4hCmOBVgzrkwM6H5
         7Mi9qXt537Z/iBjVf6L6ICzQpxJhB4rYWMgIhjA3c4gXeTx8OlOSHSrFfzt+fBrEOzY+
         DG4rISpPt0DN3ZjOnOK9tdR+wwsT6U2jEPT4yXaW0JdzRh6cL64qEugQzHBYijOh5T51
         TunGH6Lqfcpm42uXt85JTNNBQFBD53uZ9a9k6cXM3t+O0zZYEl8LaTWFuqHPg/HHMkf/
         RA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rcRpeHKEY3TYIyHCnPiYWjA7eg1lySW6ttXBREUAlbA=;
        b=JngTiu50Cw5GnIFy4Q6O8t7du3GcPt6La6DHKbRQXpU+uQeCNdLfMlLfUJ+E0o4C4i
         NQnzKvBEkdktvZI7jBcIEmNV5cgv42CKKu+iQKRudgN6zPZEF6zplacgEcqv1Df/7eTr
         GA+vgCOcAeFseOVaeN98gCYGzhKTwxRc4kcZp5vugz0MnsbBBChydo8+QTZe5f888ld8
         OnM32mOQeiPKfLJ6eka6sblRXF+zsvIBPeRHpUfz+pa4utmbyiKcG4SMoy30k4oyvYZ7
         RFhWIIXPCSOOrxGvXjy+GirDp/+kG95ZgGJQH3x4p5a+fJu6gVbvfPihraLU36q9Zys9
         Id7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 089/109] virtio_net: Disable interrupts if napi_complete_done rescheduled napi
Date: Fri, 16 Mar 2018 16:23:58 +0100
Message-Id: <20180316152334.770534110@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109207160623399?=
X-GMAIL-MSGID: =?utf-8?q?1595109207160623399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>


[ Upstream commit fdaa767aefc1685f9a41e91f447c9aea94103df6 ]

Since commit 39e6c8208d7b ("net: solve a NAPI race") napi has been able
to be rescheduled within napi_complete_done() even in non-busypoll case,
but virtnet_poll() always enabled interrupts before complete, and when
napi was rescheduled within napi_complete_done() it did not disable
interrupts.
This caused more interrupts when event idx is disabled.

According to commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
processing") we cannot place virtqueue_enable_cb_prepare() after
NAPI_STATE_SCHED is cleared, so disable interrupts again if
napi_complete_done() returned false.

Tested with vhost-user of OVS 2.7 on host, which does not have the event
idx feature.

* Before patch:

$ netperf -t UDP_STREAM -H 192.168.150.253 -l 60 -- -m 1472
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.150.253 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992    1472   60.00     32763206      0    6430.32
212992           60.00     23384299           4589.56

Interrupts on guest: 9872369
Packets/interrupt:   2.37

* After patch

$ netperf -t UDP_STREAM -H 192.168.150.253 -l 60 -- -m 1472
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.150.253 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992    1472   60.00     32794646      0    6436.49
212992           60.00     32793501           6436.27

Interrupts on guest: 4941299
Packets/interrupt:   6.64

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -260,9 +260,12 @@ static void virtqueue_napi_complete(stru
 	int opaque;
 
 	opaque = virtqueue_enable_cb_prepare(vq);
-	if (napi_complete_done(napi, processed) &&
-	    unlikely(virtqueue_poll(vq, opaque)))
-		virtqueue_napi_schedule(napi, vq);
+	if (napi_complete_done(napi, processed)) {
+		if (unlikely(virtqueue_poll(vq, opaque)))
+			virtqueue_napi_schedule(napi, vq);
+	} else {
+		virtqueue_disable_cb(vq);
+	}
 }
 
 static void skb_xmit_done(struct virtqueue *vq)
