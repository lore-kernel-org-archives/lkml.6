Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeC0Dra (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 23:47:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751765AbeC0Dr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 23:47:29 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] vhost: correctly remove wait queue during poll failure
Date: Tue, 27 Mar 2018 11:47:22 +0800
Message-Id: <1522122442-30317-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We tried to remove vq poll from wait queue, but do not check whether
or not it was in a list before. This will lead double free. Fixing
this by checking poll->wqh to make sure it was in a list.

Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1b3e8d2d..5d5a9d9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -212,8 +212,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file)
 	if (mask)
 		vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
 	if (mask & EPOLLERR) {
-		if (poll->wqh)
-			remove_wait_queue(poll->wqh, &poll->wait);
+		vhost_poll_stop(poll);
 		ret = -EINVAL;
 	}
 
-- 
2.7.4
