Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeDJF1L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:27:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751595AbeDJF1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:27:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Cc: syzkaller-bugs@googlegroups.com, mst@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/2] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 10 Apr 2018 13:26:29 +0800
Message-Id: <20180410052630.11270-2-stefanha@redhat.com>
In-Reply-To: <20180410052630.11270-1-stefanha@redhat.com>
References: <20180410052630.11270-1-stefanha@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/vhost/vhost.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5320039671b7..93fd0c75b0d8 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1244,10 +1244,12 @@ static int vq_log_access_ok(struct vhost_virtqueue *vq,
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
-- 
2.14.3
