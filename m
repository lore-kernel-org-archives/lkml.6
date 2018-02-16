Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeBPWMJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:12:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52606 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeBPWMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:12:08 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Jason Wang <jasowang@redhat.com>, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] tun: fix mismatch in mutex lock-unlock in tun_get_user()
Date: Sat, 17 Feb 2018 01:11:55 +0300
Message-Id: <1518819115-13507-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a single error path where tfile->napi_mutex is left unlocked.
It can lead to a deadlock.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/net/tun.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 81e6cc951e7f..0072a9832532 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1879,6 +1879,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			default:
 				this_cpu_inc(tun->pcpu_stats->rx_dropped);
 				kfree_skb(skb);
+				if (frags) {
+					tfile->napi.skb = NULL;
+					mutex_unlock(&tfile->napi_mutex);
+				}
 				return -EINVAL;
 			}
 		}
-- 
2.7.4
