Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeDKNbS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:31:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753027AbeDKNbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:31:17 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, jasowang@redhat.com, mst@redhat.com,
        kvmarm@lists.cs.columbia.edu
Cc: stefanha@redhat.com
Subject: [PATCH] vhost: Fix vhost_copy_to_user()
Date: Wed, 11 Apr 2018 15:30:38 +0200
Message-Id: <1523453438-4266-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhost_copy_to_user is used to copy vring used elements to userspace.
We should use VHOST_ADDR_USED instead of VHOST_ADDR_DESC.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

This fixes a stall observed when running an aarch64 guest with
virtual smmu
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bec722e..f44aead 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -744,7 +744,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
 		struct iov_iter t;
 		void __user *uaddr = vhost_vq_meta_fetch(vq,
 				     (u64)(uintptr_t)to, size,
-				     VHOST_ADDR_DESC);
+				     VHOST_ADDR_USED);
 
 		if (uaddr)
 			return __copy_to_user(uaddr, from, size);
-- 
2.5.5
