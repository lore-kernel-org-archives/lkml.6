Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+43erLMCyrbVMfwME8jVg6cdxT02l2AmD5k41rBM/uqPfNgyLaV9z2DwGd1YPC6pI5lE8a
ARC-Seal: i=1; a=rsa-sha256; t=1523980845; cv=none;
        d=google.com; s=arc-20160816;
        b=Okw8jvNmRI1/iG2Jctensz+SvgUVH3yhT7EII8+B9b2QLRXtRyswiYJjhoyqA1CrwJ
         jxLhXcIty/4J4RHE/D9tyzTHQcAjTLmAbKkruvnUTGRqrw1Io62uyW2Nt6HIg3k4SquD
         jQtewcYOyvOIMuGCUnz+vBspllUiV4eM4UoSzQm8dZwo5SF50Hvz87cYNsMZcxEIltIM
         evZ0TDyWbAwrnQ0g8vyP//qbGiVbYZtSEEbLU+MSpMMqIWadnnlUSlso+Ekxn2444UsS
         /2G0h8qKCO2jhaU8m+q+/RAF4YGfSTQKveF53+vZm1b74XUhQzGEMVGpkOoKXWjNtMyP
         AbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=T2pRhT17wl/YRwiNCVXRMv1KLzJ5zm9XMJ3bZoO1XMo=;
        b=vqguVq701KlKgy1zHA0aCTTy7PzKEs4cuSOHQr4/diFtef5PWEFNmY9c1lLL04jkey
         AVqTViemCOIFZ8AhQbTyTrxtpX+JM1E7AysAQQODkfSvBheHeqRPIPWh4MAE2rOOvFao
         NXvgB1vLhIuPXfrcEC6xgILMs7fkeaQapu5+S3A8oyP9nQFkfw8acGXv8BEl83BA9dwW
         2BA0kgNZWw0L1qr0MQzBg8yLI5vqzID4cKwa5UafGGItpExU3NFZk3/p0zjsePIB+a4a
         vCdMhXuaTwK9DJKD12nlo6tfxnny9ozoHMTfa/PWhW2RgOD5KBVAVT+i7M1beY1woOQ2
         bajQ==
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
Subject: [PATCH 4.16 04/68] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 17 Apr 2018 17:57:17 +0200
Message-Id: <20180417155749.519346445@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009739151968451?=
X-GMAIL-MSGID: =?utf-8?q?1598009739151968451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1244,10 +1244,12 @@ static int vq_log_access_ok(struct vhost
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
