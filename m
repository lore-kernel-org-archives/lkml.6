Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeERNA4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:00:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752263AbeERNAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:00:51 -0400
From: Jason Wang <jasowang@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, Jason Wang <jasowang@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] tuntap: raise EPOLLOUT on device up
Date: Fri, 18 May 2018 21:00:43 +0800
Message-Id: <1526648443-24128-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We return -EIO on device down but can not raise EPOLLOUT after it was
up. This may confuse user like vhost which expects tuntap to raise
EPOLLOUT to re-enable its TX routine after tuntap is down. This could
be easily reproduced by transmitting packets from VM while down and up
the tap device. Fixing this by set SOCKWQ_ASYNC_NOSPACE on -EIO.

Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: Eric Dumazet <edumazet@google.com>
Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d45ac37..1b29761 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1734,8 +1734,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	int skb_xdp = 1;
 	bool frags = tun_napi_frags_enabled(tun);
 
-	if (!(tun->dev->flags & IFF_UP))
+	if (!(tun->dev->flags & IFF_UP)) {
+		set_bit(SOCKWQ_ASYNC_NOSPACE, &tfile->socket.flags);
 		return -EIO;
+	}
 
 	if (!(tun->flags & IFF_NO_PI)) {
 		if (len < sizeof(pi))
-- 
2.7.4
