Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeEUJFL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:05:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751234AbeEUJFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:05:06 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 06/12] tuntap: enable premmption early
Date: Mon, 21 May 2018 17:04:27 +0800
Message-Id: <1526893473-20128-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 44d4f3d..24ecd82 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1697,6 +1697,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			goto err_xdp;
 		}
 	}
+	rcu_read_unlock();
+	preempt_enable();
 
 	skb = build_skb(buf, buflen);
 	if (!skb) {
@@ -1710,9 +1712,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	get_page(alloc_frag->page);
 	alloc_frag->offset += buflen;
 
-	rcu_read_unlock();
-	preempt_enable();
-
 	return skb;
 
 err_redirect:
-- 
2.7.4
