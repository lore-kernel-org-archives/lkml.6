Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrhO/UnJcTL0RcZzlqWDHdwHoltRREXfESd4KFsgX6JDuxntGYkb7Qd97BU9XLZMRpIl1Qp
ARC-Seal: i=1; a=rsa-sha256; t=1525116487; cv=none;
        d=google.com; s=arc-20160816;
        b=PVpt7IbWgBqRjJkJqeo0JSCPi9f8p9voJJQYOlfMcnZ0l2ikcj1ToUzIwis505L3TT
         KtkkFntn84YmK3kDG5uIupN+bVT7HopkLowWE1Cg9AiaMasw/clFB9/i2PElXEFb6JcB
         9kkTxuXsr8SkHOlX22JprLULgoIVB3By3XZprmQLcW+FGTOokGCDMMXAh3dAwGSAmYtL
         y3QnCtjOCo+JFV1voERBV+11MLU5QOLsodXegA8+NMa+3w/o2K47JWzNnHaVSnQ81ezm
         1QQFigYG589PgBgFdDJ03uzFTPNyrsrIfMA9jwOyLcoHlDwsTQ2wp+0pazH/gWlqBI0X
         WjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=tOgZcj4ZrDOy8Mxt5y2f9Yy4royyzsju31TyhcPFxMg=;
        b=yTMv+R7L+0hJzz013qLLis3Lsnw/8tohrHkszQcEfSqPTBeFa5SQoQDvubRSOSL5NS
         mD3uKsoHNzXJu0l7qDRXU40d1fMO8qMxDwkyeJ9BM7sW299u+iKFCG8l7sea5ntM856o
         UylL5RmQvj60cft1L63atxbRO2kr6HFL1YHRWH8VCV7H3E6/NR6cUroe4VMrvYLUWgnt
         v8CXDN5A8zITF44xg2v9bt0qNHFrgryod5oj2qRwScKZTSRlf9KSrcO4ZZRjoJVydDn8
         rJDg6xBaqjYc99dBw0NXXlXSQzl+vezkhUQaZ2LWR47ur/elJevOsrrdhLhzpIE4d+Og
         AQAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ADB22DC1
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
Subject: [PATCH 4.16 030/113] drm/virtio: fix vq wait_event condition
Date: Mon, 30 Apr 2018 12:24:01 -0700
Message-Id: <20180430184016.343904638@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200400304649329?=
X-GMAIL-MSGID: =?utf-8?q?1599200545719744158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
