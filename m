Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2258p9YThpkdMRV0UYf5/QLbJAAlXMx678zgdiz9e/ROt6fkmRzyN7mkTV/LtdlGe6DNO1XK
ARC-Seal: i=1; a=rsa-sha256; t=1519218721; cv=none;
        d=google.com; s=arc-20160816;
        b=MKDYZjWiizubAXn1Gu7NSClGIphy5cmjWeM0QQsFaggeLzU9SYUWMHHWFlgz4HzrG7
         K7LKfkazLENQ0oDTJGjoq1aTWL2LmGsouhYMxVLP0AAoVVt25j3EwHFx308mGvje46u/
         PKyL445xxdAAnuNiABLuBc9tp2fTKBQHGQAj4lYCC4XrF5jIyTFew1bJWnNO0W8KYqP0
         FRL7T+qOmWm0hklc2nodKiKXit1VpTffVWj6kqT/AzwpbqWf0CZFHZRbgqs5iqm+xK2I
         TegtYStzYujw/92Nu+H51Cgw57Ka7hwBrN3CD3DOhqyY3I5pm04Z9VPgAtmo4sjpsqd+
         LMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QBwTSRP3e4CDA/4j4ofTm2NRl0umK7RXC6XZMzDdNM4=;
        b=fIFGTfWEsXzmVLrbDoYGKVDEw9VFxkJf0Jj8mKn7SCvsBLL79FTWbVd5o3fxoS5OZs
         HgYArwvLknmSWCjPlId2YzR7bsz4iwV3C0jFckDmu9ZYqRctdscOY31Z6E8UdG/yYe6j
         VdT1+wHySQSF9wlDRO+8uUuCFFWrArqWFQowRZOwLaJJ6tCXjGowrAo2HzLUtteko4R+
         TwKlYVRL6wHIHGllagOfctRIKE9uzdOpPR6b+eURUqDY+WcAGSv9RgVYSz9TqiErmRZj
         QSyuyHmjjMZ9w9Rlz3Xa4DyuTb0JOsCaguagDbxqcIrHRkYHQJq9cCKJG4ojX4VMXmUX
         +QfQ==
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
Subject: [PATCH 4.15 141/163] 9p/trans_virtio: discard zero-length reply
Date: Wed, 21 Feb 2018 13:49:30 +0100
Message-Id: <20180221124537.930777399@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015216279733219?=
X-GMAIL-MSGID: =?utf-8?q?1593016290538774343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
