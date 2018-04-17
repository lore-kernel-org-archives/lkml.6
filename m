Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492PT5XYoabLRLunlcm+x9oNUx0wkj3ivLOITj9AyJ0KISv86jKuxptuqwmmnIQwWAtunz0
ARC-Seal: i=1; a=rsa-sha256; t=1523981082; cv=none;
        d=google.com; s=arc-20160816;
        b=wvAO0suL0+KRR7sEXJ96YTufdn4MQn36dtfa9YrNWDiGEMz+xtmaoQ+sP1ozxVOZxM
         PHCTOZLTwslOAh6Tg2OnJLf1zVgtPCO//LLMOsbUouBdnDvO+LFxDNywXsR6PDpoXFLd
         4fWVeRkHKDXTGOQAua2Y+qdD81zvW39AOP8ulUBy0m1OUQkKBFqWKrQu2wlcdrDlkiGX
         pUkfXPachdixgG48JgCNpsWKxhHs0skADNeZOT8WmHVtP8cwEF5snuO2vwU64Kd+mW+Y
         z14MauSRHYL0Ymu8Ak+iuhSu3z8j7n2J45svxLpmabP1KAuXxF6fTgirnsVnLURVWM/0
         f/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BH3MwUDFcaW8ZlZqq53LWw5GpTkkQamUwaxqDKXWm2g=;
        b=VdXs8UzdIt/pLoZePKMxm8Blpwwu7GxD6+57FxoaUzhEpN9sMRj6VTBmYFhCnkzcCa
         ANqBqOaHWUP4JAlySZvQZS6w4DLnPFK8tR9tNSbK6qbsYTgdo8NiNnCpVYkWFRguoxHk
         vvQ6Mm4SeaZm2W/X24CmZNkFNgJWv/nVcfq85ngc9m2VmPJ9Y1ZwFEMzQXH7w0cDB8LL
         CodVRQgk09DIcBSMb0BNRY5gAJIZn38JeeFZ95GrOJeNf7hXyoZBDkU4emwK0ujicx1W
         3sNnamrUlCYQzx21f3yjDIWvgjCdlWvNSYSTtmEvHjQdez8+R27LSo32Dqbz9eXVzjSj
         WyxQ==
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
Subject: [PATCH 4.15 06/53] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 17 Apr 2018 17:58:31 +0200
Message-Id: <20180417155723.350725633@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009739151968451?=
X-GMAIL-MSGID: =?utf-8?q?1598009987196334827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1256,10 +1256,12 @@ static int vq_log_access_ok(struct vhost
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
