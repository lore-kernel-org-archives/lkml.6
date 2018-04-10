Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+r4IlCjN2/sw7BXUvjOp5+1u0bp6Q5RjVe7P1m0E8uzGY8F3oLXA2i7m+mLg04cn1eQpko
ARC-Seal: i=1; a=rsa-sha256; t=1523399569; cv=none;
        d=google.com; s=arc-20160816;
        b=rlxv6BiDe+S3t1F5NfJWKdIRDGcCt5vfm+rVtjd3uTfpZSgVYBG7srfg14Taqw37Ht
         YGAzar881C5mKyxb10DFeDvYY9JDliZDsrvWKwi0k7TQNDGhKZOg5j4yP5IU+yZerD7l
         c2fzBykJzgrLwGv3c2xdYjqCgP1WZszj6RGSGXufUsyzzuMhJrnWHFnCnHd89F8+cU8e
         bGKHK1O6gMzpf5Wg3l1XSckW4aXkJO2Z7VQDHnIwfYfQUwiw71MPyIVRG0FqGLusIQxu
         Z+Ll0PJ1zBD+P/4oRvpEEZZOu95jO/7ZX/FEyJF5Y0p57KEV5q2LqA6B++n91spIl/0F
         3+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6KkqR5Z+gdW5TAyjeqa2PG2fswOLPsE9WhFJipr6/eY=;
        b=Na/pZHxKLa3qhB0pFUFQ2rCKCCCmzr7HsTUfSvSsfcvFu6y/Yxij6RBLtC2erdYxAc
         c3zusopqdz38NprJXskrX7LV4o2MynmddMhRNwi9vc3y0+tK9NZ5r8hx5WLnx6jT6Wyl
         1kW/1k3N/PXJxi3JNESv8/kRE6TjQnKCQfribYpxA2r2l5OxMDGskSLXeih94OvENe5D
         xnzgf5JPs55gXxwJODY8TKHxYYse+YdfWE+weRipTiZ8CM7kpIEUO33ao+c8wFTS1/qs
         1MNLHR72KkkbO4H9DlxaFHD+ugSyDCv1IeVVgFrh1LjTLjXeDrdfxxRG+6jV4wpIfrV6
         6Q7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>,
	syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 137/168] vhost: correctly remove wait queue during poll failure
Date: Wed, 11 Apr 2018 00:24:39 +0200
Message-Id: <20180410212806.890245506@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400226985696464?=
X-GMAIL-MSGID: =?utf-8?q?1597400226985696464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit dc6455a71c7fc5117977e197f67f71b49f27baba ]

We tried to remove vq poll from wait queue, but do not check whether
or not it was in a list before. This will lead double free. Fixing
this by switching to use vhost_poll_stop() which zeros poll->wqh after
removing poll from waitqueue to make sure it won't be freed twice.

Cc: Darren Kenny <darren.kenny@oracle.com>
Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -213,8 +213,7 @@ int vhost_poll_start(struct vhost_poll *
 	if (mask)
 		vhost_poll_wakeup(&poll->wait, 0, 0, (void *)mask);
 	if (mask & POLLERR) {
-		if (poll->wqh)
-			remove_wait_queue(poll->wqh, &poll->wait);
+		vhost_poll_stop(poll);
 		ret = -EINVAL;
 	}
 
