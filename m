Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeBVJg6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:36:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753015AbeBVJgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:36:54 -0500
From: Jason Wang <jasowang@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, christoffer.dall@linaro.org,
        sergei.shtylyov@cogentembedded.com, Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v3 2/2] tuntap: correctly add the missing xdp flush
Date: Thu, 22 Feb 2018 17:36:46 +0800
Message-Id: <1519292206-6384-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1519292206-6384-1-git-send-email-jasowang@redhat.com>
References: <1519292206-6384-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 762c330d670e ("tuntap: add missing xdp flush") tries to fix the
devmap stall caused by missed xdp flush by counting the pending xdp
redirected packets and flush when it exceeds NAPI_POLL_WEIGHT or
MSG_MORE is clear. This may lead to BUG() since xdp_do_flush() was
called in the process context with preemption enabled. Simply
disabling preemption may silence the warning but be not enough since
process may move between different CPUS during a batch which cause
xdp_do_flush() misses some CPU where the process run
previously. Consider the fallouts, that commit was reverted. To fix
the issue correctly, we can simply call xdp_do_flush() immediately
after xdp_do_redirect(), a side effect is that this removes any
possibility of batching which could be addressed in the future.

Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Fixes: 762c330d670e ("tuntap: add missing xdp flush")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 2823a4a..a363ea2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1662,6 +1662,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
 			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
+			xdp_do_flush_map();
 			if (err)
 				goto err_redirect;
 			rcu_read_unlock();
-- 
2.7.4
