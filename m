Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrkSfUAsUq7MEw+fazSuqgmex4DqdpCp3Unnr3v1yf0ciNdLFlCMBTwWLLf47U+LFB4I3Ui
ARC-Seal: i=1; a=rsa-sha256; t=1525116444; cv=none;
        d=google.com; s=arc-20160816;
        b=Z7Q29kmn0B5L8YwDLcxX0JYpVl025ig28HFabBY8e8rW9TniGwpJB0OdP+5VXg9DVV
         pdMRmfK3RSd+O+xXqRRpipDfAE3fao3CybDtb8l1pn1lXgaZUhArz/m7uVetYPSGst43
         GzWfJPKAA4yDgG+0HEk6+MqHJg33tV7AEmIZq0k4yO4z6lbxh3TvyCtL4kt3KDhNj+4P
         TvpxESca+kOnFWyq1gupvqBimsRjePMoSjTQ8/yaBDOx2ZYPgrLGqLuncY9qdKdHResk
         vw8nbh33cI8KI+lXTLW4tQ/HcTH+4l0B1cnyiZOa8ca7JPIbSAXoyz56pMIzxrniw+BZ
         PH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Fm+DabXkO1nPCnIcyxnDGnbgpMga76E7bpXJlS1AIKs=;
        b=EXboU6gF6bfCkdtm7i2sBQ+VUREshEb/u4+7iLvKpa8OYV25cNwcG4HavsERqWtLKS
         oMp0+zC2HyFfTcUfZ3LAplx2fOAUeLZ6LyumMwRITw6LbqvBcxvqzHHjG8aedokZ9WeZ
         NTrrw235HH79rBplB8yxJAsovzskL+GU7C7QfYyNL3NqdaUdtdjLykcyOtUfUXb/pNsH
         IHsdo1oIlKNPzHzjgxgzaYamL5qHaciZtvmDR/OAtd1TYsYbXyoKoYDXcfWHgTUyaI6w
         UVZAqJEUSAoVsAm5nXTVI0yIuUbkYK8TTWTuyveYCcnp4e6Xall54294daYoa5CCXBCY
         fVcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0579422DAC
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
Subject: [PATCH 4.14 28/91] drm/virtio: fix vq wait_event condition
Date: Mon, 30 Apr 2018 12:24:10 -0700
Message-Id: <20180430184005.658968269@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200400304649329?=
X-GMAIL-MSGID: =?utf-8?q?1599200500756226485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -291,7 +291,7 @@ retry:
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->ctrlq.qlock);
-		wait_event(vgdev->ctrlq.ack_queue, vq->num_free);
+		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= outcnt + incnt);
 		spin_lock(&vgdev->ctrlq.qlock);
 		goto retry;
 	} else {
@@ -366,7 +366,7 @@ retry:
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue, vq->num_free);
+		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {
