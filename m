Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv/yM9rSJWoRjhs8U1RfhHL11BUCTtTnWnMDQrbEC/3LezE45hNMRAZIzbn5Bq5MjjIfe55
ARC-Seal: i=1; a=rsa-sha256; t=1520954990; cv=none;
        d=google.com; s=arc-20160816;
        b=qrRwxd73L+wrm6mnuVVpE87/H0Ws0EzZmJX2jGFSnHaBfaFky1K93QqV5IeecFXNYc
         uHu4n78v2VJsQP6Gm8QoQXVqAagQ3adXQL1u+BImrKBoubUhGy6upVrZpIi9je4epWfW
         55dznt2/vxvkFioQExXU+ampRVzlBNH0JUB+Xj3xgdo+DljiVVxFUJVHRYDqwE3NCJjf
         Fj/Qga+xzLqHLMPoBruUGIBJ+NcJJZAnf5vwZcvw8JrbwqvsfgF8KYSkBxDDC6aiuiwl
         wwXaf5JvLU4H37LDbgdeAwcZ2Jsr7hxLPtP0CK4ycP6Y0jiHaFVl4QWBG5PmMAwx2u93
         Xidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tRkkHVmgO6KY/9xVGGxh0Q6LhihdAasCBmmof/EzqWs=;
        b=jDkhDcu9F794Bju5P4Vka59ny2x3dMxDwAVMoYOMVJw16+LCZ8LMwWaYWiDOwv60vy
         pi/n/SmOeUdDLOfDrdjoZLkwtt5NLU1Jgicb8XjJRdjOZ7RKbAw9mK236iQlNpxq1kvu
         rUzeNPOGZ9F9xqHzRTaNpomyh2QpfFftGwhkMcW8bMKpvujTJXCU3evyEzy0CH0VZWWI
         owuF0HJeqXVQGntCTs3GOjNS5d80b/qLCvDOH58/a894mMkeCA2/4s0oO9f9TCmhXFtt
         xTEV5809leHhYOS9w7QZ5XeUJe4YY4+x2WVqKEup37dxerIi+F8+QiU5smeAVLGcOXtR
         Kh7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH 4.15 052/146] virtio_ring: fix num_free handling in error case
Date: Tue, 13 Mar 2018 16:23:39 +0100
Message-Id: <20180313152324.669281046@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836899953232634?=
X-GMAIL-MSGID: =?utf-8?q?1594836899953232634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.bie@intel.com>

commit e82df670235138575b37ff0ec24412a471efd97f upstream.

The vq->vq.num_free hasn't been changed when error happens,
so it shouldn't be changed when handling the error.

Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_ring.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -428,8 +428,6 @@ unmap_release:
 		i = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
 	}
 
-	vq->vq.num_free += total_sg;
-
 	if (indirect)
 		kfree(desc);
 
