Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrttQ4P+xEvsvGsx0jejG3Nws4TsUHZQ8qKYwxuoyU6qmt5SMrjg7S4oGhOT5bAGi6lC3rb
ARC-Seal: i=1; a=rsa-sha256; t=1525116382; cv=none;
        d=google.com; s=arc-20160816;
        b=kBAIvh7iu/RxRBpeibXDlyV22nu2fWSRDzki2PR14sygfEJJHGC0Xx1SSOGKhgNMdx
         6u19ShRtKXVRuSjAOmgQjvH285JGDuLe5GHXyPpdytaYLOSIAwAJ97gBJ1D6zne6Q0ol
         BXUac2cVuCuMMiRxyLibfL5wX5qioRon6UUO5bTr+5s27v2IFyhuzJjvHWcsWdjnJr8p
         TS4yPgi1G8KbQXf8IXHRmIGs+XCW/AQzso8DK6uiiTxFwH+PHb1Lsp8cDgVmUqpI3FC7
         Ab/dAiEPAIyruv913b/TrVVHdorwyDZWi9DMHw69M1iwY/hOLR56a2s44N1rrIhK04Y0
         iCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Z6nCINH4TDQ2HvVuyaCN8BsIo0cCVla1nyYda9rteV4=;
        b=panGaDTNpvDLEo9rBaXt58sMGlWS0Uy3vAzXuq3HkjKLumro0pwAomC0FmCBeOL0c9
         AAVPFsIbp7niPxWpIBYPMPE1Ntv8+0GSvTvyVb6fJFmsFQImxgAviaBNeAxA2T7GAsHr
         ENfzrsiIB6G179xE5S26SwGnLhcz9H7c6I5XLRh6GIdyNhW/BkygHBTOw2IJAahLWYwC
         PjAyoVaQ+z171LuZUHDBMwdPMDPfHFaOW8SGin9xCXJtM/51LBAfEF0tDDSXjvlwI4NE
         MPRaHqAlMmTVxrmnxwb3Pq+T0K1yxlcHic8+F5LQBoBGFX5HxeQXDokFDJyO+T8o4b78
         kV5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9450322DC0
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
Subject: [PATCH 4.9 19/61] drm/virtio: fix vq wait_event condition
Date: Mon, 30 Apr 2018 12:24:22 -0700
Message-Id: <20180430183952.956075938@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200400304649329?=
X-GMAIL-MSGID: =?utf-8?q?1599200435510535117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
