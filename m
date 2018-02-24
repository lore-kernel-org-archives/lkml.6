Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeBXDcw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 22:32:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752865AbeBXDcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 22:32:41 -0500
From: Jason Wang <jasowang@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, sergei.shtylyov@cogentembedded.com,
        christoffer.dall@linaro.org, brouer@redhat.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V4 net 3/3] tuntap: correctly add the missing XDP flush
Date: Sat, 24 Feb 2018 11:32:26 +0800
Message-Id: <1519443146-9089-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
References: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't flush batched XDP packets through xdp_do_flush_map(), this
will cause packets stall at TX queue. Consider we don't do XDP on NAPI
poll(), the only possible fix is to call xdp_do_flush_map()
immediately after xdp_do_redirect().

Note, this in fact won't try to batch packets through devmap, we could
address in the future.

Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Fixes: 761876c857cb ("tap: XDP support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 63d39fe6..7433bb2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1663,6 +1663,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
 			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
+			xdp_do_flush_map();
 			if (err)
 				goto err_redirect;
 			rcu_read_unlock();
-- 
2.7.4
