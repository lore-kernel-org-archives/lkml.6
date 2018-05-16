Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeEPMjl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:39:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752205AbeEPMjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:39:39 -0400
From: Jason Wang <jasowang@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: xiyou.wangcong@gmail.com, avagin@virtuozzo.com, mst@redhat.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] tuntap: fix use after free during release
Date: Wed, 16 May 2018 20:39:33 +0800
Message-Id: <1526474373-16685-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit b196d88aba8a ("tun: fix use after free for ptr_ring") we
need clean up tx ring during release(). But unfortunately, it tries to
do the cleanup blindly after socket were destroyed which will lead
another use-after-free. Fix this by doing the cleanup before dropping
the last reference of the socket in __tun_detach().

Reported-by: Andrei Vagin <avagin@virtuozzo.com>
Acked-by: Andrei Vagin <avagin@virtuozzo.com>
Fixes: b196d88aba8a ("tun: fix use after free for ptr_ring")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9fbbb32..d45ac37 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -729,6 +729,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		}
 		if (tun)
 			xdp_rxq_info_unreg(&tfile->xdp_rxq);
+		ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
 		sock_put(&tfile->sk);
 	}
 }
@@ -3245,7 +3246,6 @@ static int tun_chr_close(struct inode *inode, struct file *file)
 	struct tun_file *tfile = file->private_data;
 
 	tun_detach(tfile, true);
-	ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
 
 	return 0;
 }
-- 
2.7.4
