Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeDINKd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:10:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeDINKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:10:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, kvm@vger.kernel.org,
        mst@redhat.com, syzkaller-bugs@googlegroups.com,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] vhost: fix vhost_vq_access_ok() log check
Date: Mon,  9 Apr 2018 21:10:21 +0800
Message-Id: <20180409131021.5132-1-stefanha@redhat.com>
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

The correct logic is:

  if (!A || vq->iotlb)
      return A;
  return B;

Reported-by: syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5320039671b7..f6af4210679a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1246,7 +1246,7 @@ int vhost_vq_access_ok(struct vhost_virtqueue *vq)
 {
 	int ret = vq_log_access_ok(vq, vq->log_base);
 
-	if (ret || vq->iotlb)
+	if (!ret || vq->iotlb)
 		return ret;
 
 	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
-- 
2.14.3
