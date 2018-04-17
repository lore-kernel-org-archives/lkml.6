Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/MtQyXHLhlsdoox733JoJG1WCI37esS1m8QNhFTBV1SWIkXqI8Zktx9q//wLQjUw+QLTr8
ARC-Seal: i=1; a=rsa-sha256; t=1523981449; cv=none;
        d=google.com; s=arc-20160816;
        b=vjjjYfyKuBfZ0VmmYE1jSFTN5c60vWySIkIFTBx+ncmQKra2X/6fuBm8Bsnaf7PjUa
         px2niJfnoUJruBq9jsE8b2L/F7vI64MGTCMbYygpROpPVbrNPmUjoFI9vHWxSWMLMZPw
         7Q/ar95JBp0akHoN7iZtXKN800EfV23AO8wjSDWx2i/DQV2px1q9iROo35es+GhzoX8z
         OWpiRuVN3BkIN2FNiLt5ZDbe2ZrR/XRQClHs0poZaSQwSJUVPcF7Nw26xiogFZhJO75F
         N8kNvE1zSoDL/7CBqVQdewvGk/aurvWsoVv/rnaZIrQ6rpy4orbhJmJKRz6g/NjxPztX
         2mNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OmWPE69hCHHAIGAvkc1QFvjNuVEmfo6KNiEdzbPJKfw=;
        b=n6Gzs4nYsKHbpX3ze58cWVZWVW3UuMoH0pLsD46A30d+9c343GL9WAkr0Q1Y4Dj+/L
         lLDhT+A0Jbg26TRTCexQhzdIL1UP2W6gRCAPk3s2HpWCKOSw4sVxI2I//wHmRAEFpZB0
         YsgtQ4NKX6xygk+dNCYUOJ5AvqqmyaSBxgNQWT01Jyh2lNiWLx7/TxFfCBKJSrlHKjTI
         HC6rNbjVvqCCuvNWfiiawazfdA/lDZSY7MvditWlC+E3l8EB5JCgpFO3dPLv/8PeI2F+
         5MQRfycNOPc0xDwYhEyCeFUS+AwS0p317WZLHPYWzK6dxZNvQFDDjFM4tM+hkUuGJ6LB
         0LNA==
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
Subject: [PATCH 4.9 65/66] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 17 Apr 2018 17:59:38 +0200
Message-Id: <20180417155648.670658993@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009739151968451?=
X-GMAIL-MSGID: =?utf-8?q?1598010372907799403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1175,10 +1175,12 @@ static int vq_log_access_ok(struct vhost
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
