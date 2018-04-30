Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpz8LzB6lskBYimMp1dL/6mg+OZm+Y1uC6iYuVbi7KxKHa6sdBk9NlOIQduc8hN/f9Cz+FE
ARC-Seal: i=1; a=rsa-sha256; t=1525116348; cv=none;
        d=google.com; s=arc-20160816;
        b=p5S1XaIQASxPchD2H7RQcsWhroT1js5JZHFubRPf7cS6CqFx6U+tcxgipF+O7+Cq4F
         uMCFzayFi/+7TbVWe55s1Wi5K2savR42/oWtasYXLiykB6sOrelJ/Vh9dX2DcQeyk+zi
         PcgKXvQ+pVt0y/aW4AP5/EX+OEh8+QM7bkrKL/TDrkcI4nyKlcYTR1gJLpTAuK8ZgiNY
         M3q8hQ8oLll8jqvmlR8Y6yJLp4rBwr1w0fhBNNVVjbNLoRPyCWJlyuWNsrygM3B9w3dL
         QjMTINPqain7dI5DX3GLbrBvOAChaNSCkEniczZYQut+F7nZtgvIl2CdZ/2hMnq3H61m
         LaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=T6v8JTDYJkQy3JXyya+0jMtt+w9ATCvH+vJ+JiL9PFw=;
        b=fYuFFRwi7eyGWPtjHL4dzunAFcrNv+E2wKbOdFr3aMBNYq034nAUJRB1FkS2NDLGro
         ZFj+1xS40OvYLg2IHMyCGSJJ0y258Ex86+ertiWxUHRX8jOIwbmyRPwTHbCy9QKoFh1N
         HyXH5AIT4egsHt5BuQJW3xsRFiO+k1znYDPD9JEiJhvIlPMcN/rmYC680GwiEYsxZAxR
         ENWWbsJEaX4jgkqa1NGW9qx8FR5v1g6IP8/UYwYG0iuU935V9i+kCKzu6dZc4KAXSJC2
         BOmtLatCnZs80dh5ic6xxxZNarfgZQK6vKxe+2lMGNvnEIg7d2gq5tV6mgSqWwezzZGr
         mJ2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B1C22DBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alain Magloire <amagloire@blackberry.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.4 15/44] drm/virtio: fix vq wait_event condition
Date: Mon, 30 Apr 2018 12:24:26 -0700
Message-Id: <20180430190946.952441015@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200400304649329?=
X-GMAIL-MSGID: =?utf-8?q?1599200400304649329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerd Hoffmann <kraxel@redhat.com>

commit d02d270014f70dcab0117776b81a37b6fca745ae upstream.

Wait until we have enough space in the virt queue to actually queue up
our request.  Avoids the guest spinning in case we have a non-zero
amount of free entries but not enough for the request.

Cc: stable@vger.kernel.org
Reported-by: Alain Magloire <amagloire@blackberry.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20180403095904.11152-1-kraxel@redhat.com
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/virtio/virtgpu_vq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -324,7 +324,7 @@ retry:
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->ctrlq.qlock);
-		wait_event(vgdev->ctrlq.ack_queue, vq->num_free);
+		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= outcnt + incnt);
 		spin_lock(&vgdev->ctrlq.qlock);
 		goto retry;
 	} else {
@@ -399,7 +399,7 @@ retry:
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue, vq->num_free);
+		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {
