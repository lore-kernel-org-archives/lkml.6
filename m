Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48GASLVYLuAve0G3XD+r7YC3SAdI+IhJw0MGqfSxhhlAvWV+Lv77ARC6QMm7BYDgXy3em8g
ARC-Seal: i=1; a=rsa-sha256; t=1523981197; cv=none;
        d=google.com; s=arc-20160816;
        b=GrMmIXRPkB9W5kruZ9v7nOkq1btl5DRUXaOYunU1l07e5d2K7SgA75T1upo948RS3x
         HaqO73vE2z8oZiitdP1ftbeMClY+lPpafh1ZWKkV83X1kiPHufSiE2pUC6UwXq5mSzA3
         PaCzaHs0gBVP+8+N4KVgceiaybmR3MbtDvrL4+92VEsZwDK7U42sBWAdeQPbc8699ktO
         rx4PMpBJ9qkpFaa8KEtp8KQx0I3ORx2DMR+Q+mRJzDyTfnPOoKkNDoSKQ/W8YwYqURqQ
         Cz/Rkskzgry6UU0ZGDlRHOReuSHI3u8UaCytnxWvMA4b0k31qD0YCVRobWAFLt0nAUC9
         ILGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mJ+kSA4UWFjca7Y7coiHDk5GCWqSWWVRhRP6B6kIC9E=;
        b=g8mRQKXTFcS+yw2om5v4Tli9TfUR5IjmLn6RSKrB9PvQtm53xnF7sMpFxCI4M9Ih5b
         dKdUlTpeQ807A+l3+smJ6Y3cfnyay5EbTNTUiitFV7jW8YLFhybVC+9aQbX5v9Ky22IW
         f0BiLfs8o0I+Qd+qFUEQmZPW8NU0M95pL/4Yvdp/HsOJ8Cxs1p/0gcetrzSbzjyTvhr3
         X3JYYGQOHc352N2UI6IUtIiQW+nonrby04C+Ud3vhj9+6cwq+002+iNr8KVH2RrQZAIh
         bXuj7VBCCmnPdkxXyY3NJmWL/Xu8XPzxxIabXsN7J4ZLniKoR0BJevLnlPqus7QKTjA2
         PXAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/49] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 17 Apr 2018 17:58:44 +0200
Message-Id: <20180417155715.271026372@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009739151968451?=
X-GMAIL-MSGID: =?utf-8?q?1598010108002643368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Hajnoczi <stefanha@redhat.com>


[ Upstream commit d14d2b78090c7de0557362b26a4ca591aa6a9faa ]

Commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log
when IOTLB is enabled") introduced a regression.  The logic was
originally:

  if (vq->iotlb)
      return 1;
  return A && B;

After the patch the short-circuit logic for A was inverted:

  if (A || vq->iotlb)
      return A;
  return B;

This patch fixes the regression by rewriting the checks in the obvious
way, no longer returning A when vq->iotlb is non-NULL (which is hard to
understand).

Reported-by: syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1252,10 +1252,12 @@ static int vq_log_access_ok(struct vhost
 /* Caller should have vq mutex and device mutex */
 int vhost_vq_access_ok(struct vhost_virtqueue *vq)
 {
-	int ret = vq_log_access_ok(vq, vq->log_base);
+	if (!vq_log_access_ok(vq, vq->log_base))
+		return 0;
 
-	if (ret || vq->iotlb)
-		return ret;
+	/* Access validation occurs at prefetch time with IOTLB */
+	if (vq->iotlb)
+		return 1;
 
 	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
 }
