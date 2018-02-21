Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Ezvl91cNlIurx7lMy8CNgnDDLs/Cm44iGvLzgv0o3T3NNFqQKQTmSaEi3mM9aN7a1IBOd
ARC-Seal: i=1; a=rsa-sha256; t=1519218253; cv=none;
        d=google.com; s=arc-20160816;
        b=lYk5bZ5bIhsVMrvvGzFr/xKtThS01LWqTHI841toQOq89Xzgf/7YW7lyIl0e0mzd6e
         91bJcNOvwjqsQYY7PMnI0S+u+IyxnmPozO257etHnyFc3L543f5i27I5exAuNQavdl0f
         JR5+mTjV53UVSrCkhAUgdIGCWvJpFOnLMx1gRsGLGD2Fh46RYxdiy/IDQlsTa9Xbm5C6
         vPhTU+2wKlqH8Uj8MHBzISSizUNubJPXPsllljUtzS5OYEA8vFDH235ODim+ry5GI16q
         rqFxDcuGsH2GJKI+FIdr8JecO3dMBH3QnqTXTIyqTWecqDn0qw24BTYGZRaMa7I/i5RN
         gMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HzDuLndAUpzgD6SufT/1WhW7PIQDqI6gf1KFMJu5S8M=;
        b=miqywvPtTrUXhsTr/HPILifsVsDjvVRGcBX5OBD3DdVKr3pyahp6V1Nzuhs/6+Xgxh
         fI1uzyzncx1xEL9KaZ0Wk0wXlwtFFq2sl4Hfnd1uSKZ02mVjwaD3EqifmTKmJ2hojrwg
         DCinZooArBAgWAUlaIfHdbZXZac3AsJnyg2NDbTiL2UO6ttoV0+ttWl19+/DIj/s5yCo
         UX2HEu9GraK6VvpDZdr63JZ9pJt798Rkbfj4QoZ6FEY190sxuZCZdlLUfixgMEvW51z9
         RTi7v1eFfY+zKkLliM61Gkgpf1yxwHkxFYYUu6qG01sIzURLsDGS/riK5DokvNoCqW5P
         hlGA==
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
Subject: [PATCH 4.14 140/167] 9p/trans_virtio: discard zero-length reply
Date: Wed, 21 Feb 2018 13:49:11 +0100
Message-Id: <20180221124532.369609960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015216279733219?=
X-GMAIL-MSGID: =?utf-8?q?1593015799261444193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
