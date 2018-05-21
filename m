Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeEUJFX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:05:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752670AbeEUJFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:05:15 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 08/12] tuntap: tweak on the path of non-xdp case in tun_build_skb()
Date: Mon, 21 May 2018 17:04:29 +0800
Message-Id: <1526893473-20128-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're sure not to go native XDP, there's no need for several things
like touching preemption counter and rcu stuffs.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f6e0f96..ed04291 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1645,10 +1645,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
 	 */
-	if (hdr->gso_type || !xdp_prog)
+	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-	else
-		*skb_xdp = 0;
+		goto build;
+	}
+
+	*skb_xdp = 0;
 
 	preempt_disable();
 	rcu_read_lock();
@@ -1695,6 +1697,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_unlock();
 	preempt_enable();
 
+build:
 	skb = build_skb(buf, buflen);
 	if (!skb) {
 		skb = ERR_PTR(-ENOMEM);
-- 
2.7.4
