Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224HhWipolTyFmgdbw0xz8N4poKlCt3/4f17ykBpj0434OJQjxzB9fUuDaTqCycDZdA05S7F
ARC-Seal: i=1; a=rsa-sha256; t=1519217697; cv=none;
        d=google.com; s=arc-20160816;
        b=T1oEfYcJvPhbClXWUg0kTZS51uE5p5FKvNq7dMGeDK/IAffki9+z1Zp94FwqVpOHra
         xe9CYrchzmZN7ofpjgHkGhUtR8EbnXd5mfgHp6Y++RPR4iDCUf4Yx6/9jCNs+aGzJsBl
         ut8LEgTLP3NHmhdn7/49/7t/n5y+oRUEy8977kxef0dD4zxzX/zq66SnoSfy6IFuJUC7
         IkISI+6NIB+SfCipjL5xaxcfsa4FuNE5OcRSoVoRhaHPXkwyp5wIGy7w7JJGR6UWk1LH
         suJ43+i/b4I1/xszSVHZ1IS6HPh+JUuJnRgQuYvxLt5m4smr/FrI6kf5jUOjwTnX6Bmt
         0hXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Nn4CxJkf06pHhRRfrHCF7VzhUJkCs9Q//h9T/tiljpE=;
        b=w8zVwnW2OV68+kV2mr+hisLGt7928NITDu6q13vW7PMon5vF4uf3lTZKu9vHlaxvjI
         hSpcf8U1jAPsjKVvfQJKH6fSOTqXOZDq5yCgjTTdbAegVgcWFOq3bpbVtAz77dy2etyT
         Ukc+wicV+Kxa4O+lQHzDaDmwox05AgX1Lgtq2BS8tYAZzv8s9MRB7gUlooZ3ly8JIowV
         47ichiPT4RFppub9Vx5RMBYXYC9PCQ8SBLnu8z6To1PNk0F2jG7TbGarjRttRDxLDyga
         Xp+Pa5KQZa5Mvd2IcYJnezZWYnDXQ0pZE590erPuYnRCo+hQWcVQ7jB6Z3+XGRczfZXL
         orZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greg Kurz <groug@kaod.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.9 23/77] 9p/trans_virtio: discard zero-length reply
Date: Wed, 21 Feb 2018 13:48:32 +0100
Message-Id: <20180221124433.163224691@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015216279733219?=
X-GMAIL-MSGID: =?utf-8?q?1593015216279733219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kurz <groug@kaod.org>

commit 26d99834f89e76514076d9cd06f61e56e6a509b8 upstream.

When a 9p request is successfully flushed, the server is expected to just
mark it as used without sending a 9p reply (ie, without writing data into
the buffer). In this case, virtqueue_get_buf() will return len == 0 and
we must not report a REQ_STATUS_RCVD status to the client, otherwise the
client will erroneously assume the request has not been flushed.

Cc: stable@vger.kernel.org
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/trans_virtio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -160,7 +160,8 @@ static void req_done(struct virtqueue *v
 		spin_unlock_irqrestore(&chan->lock, flags);
 		/* Wakeup if anyone waiting for VirtIO ring space. */
 		wake_up(chan->vc_wq);
-		p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
+		if (len)
+			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
 	}
 }
 
