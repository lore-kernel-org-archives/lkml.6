Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtTo/9H9RlcrnmWYQu0QNUzEj5/xRSuQUEtGYsxvEd6j8hUZ9OyklKmnOa5pv8dJaWuGmRT
ARC-Seal: i=1; a=rsa-sha256; t=1520451830; cv=none;
        d=google.com; s=arc-20160816;
        b=T6VZ7sYgjGOp0G3j2e9kaTkH1TSthPEZzh5bxYD2jRJ+KLila9lQKaZvh5+oOKjM2K
         6dKu0HIBQ9fp/BoFNpVvJRdLc0PhHb2Ug63uHeNI5ubos6A6KVnSpYgjrSKCf8mfZJNh
         t6QCcRTV3dA63OO5EWq4znM9TZA5F83CEcHQkQYX4NmpjXEYfyLAaGXKw+kJfx00SG5H
         do5g+m4zqv+pfvZGM4HHJqVy2IxX1dbB9hS1fqCVZj3sWpAEC7nauvKpCP0KxTA0MLf3
         1T5t0mnaAho9Pi1IgF2HoamU/j5AEPgzzA+W5nrIPqFblrd6HWpF3Q8CM0dNVLv4A8S0
         1OTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MyFMoy8qTq24HD4UufgZw0+qBpcwvipwO1VmxeHxHyw=;
        b=FnD+uMxdw5V9tnAGcigiAB2YDl9QRRDtN3nGlQ7B1h5DNik6hSFcOaqu1TH+SuD3Xt
         6+ZD7ix9kiF+480obiW3TTU6yxdU2ifY8skzlgaL4a6mHYjRxHgTVUgqS1wVe1oXH7wu
         jJT+bkOsiT9HiRsNogqjh0qxhTMe1kCXHie9O6yUWhqF30iVyU/5oGdcmEaYqQUoX3Wo
         H3aBHyggprZkXW9mciLxh46S/CMB9uBBBJcCyQb4BXSZ4ELHdfKwzwshMvwMKqY0SpVC
         rOcMqXH5/VgQ/COUgG0wIHs8H1FtrlNyVaORgPxpOWdxe4CwB8VxaEiD/ziZokq8OUFT
         tJOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 078/122] virtio-net: disable NAPI only when enabled during XDP set
Date: Wed,  7 Mar 2018 11:38:10 -0800
Message-Id: <20180307191740.519486798@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309298927002039?=
X-GMAIL-MSGID: =?utf-8?q?1594309298927002039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit 4e09ff5362843dff3accfa84c805c7f3a99de9cd ]

We try to disable NAPI to prevent a single XDP TX queue being used by
multiple cpus. But we don't check if device is up (NAPI is enabled),
this could result stall because of infinite wait in
napi_disable(). Fixing this by checking device state through
netif_running() before.

Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2040,8 +2040,9 @@ static int virtnet_xdp_set(struct net_de
 	}
 
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		napi_disable(&vi->rq[i].napi);
+	if (netif_running(dev))
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			napi_disable(&vi->rq[i].napi);
 
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
@@ -2060,7 +2061,8 @@ static int virtnet_xdp_set(struct net_de
 		}
 		if (old_prog)
 			bpf_prog_put(old_prog);
-		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+		if (netif_running(dev))
+			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
 	}
 
 	return 0;
