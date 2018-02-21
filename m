Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBUDmK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:42:10 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:51897 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbeBUDmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:42:09 -0500
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: davem@davemloft.net, johannes.berg@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] netlink: put module reference if dump start fails
Date: Wed, 21 Feb 2018 04:41:59 +0100
Message-Id: <20180221034159.14685-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before, if cb->start() failed, the module reference would never be put,
because cb->cb_running is intentionally false at this point. Users are
generally annoyed by this because they can no longer unload modules that
leak references. Also, it may be possible to tediously wrap a reference
counter back to zero, especially since module.c still uses atomic_inc
instead of refcount_inc.

This patch expands the error path to simply call module_put if
cb->start() fails.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
This probably should be queued up for stable.

 net/netlink/af_netlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2ad445c1d27c..07e8478068f0 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2308,7 +2308,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	if (cb->start) {
 		ret = cb->start(cb);
 		if (ret)
-			goto error_unlock;
+			goto error_put;
 	}
 
 	nlk->cb_running = true;
@@ -2328,6 +2328,8 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	 */
 	return -EINTR;
 
+error_put:
+	module_put(control->module);
 error_unlock:
 	sock_put(sk);
 	mutex_unlock(nlk->cb_mutex);
-- 
2.16.1
