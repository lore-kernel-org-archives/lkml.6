Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757457AbeDXMhJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:37:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51242 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeDXMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:37:05 -0400
From: Colin King <colin.king@canonical.com>
To: Ilya Lesokhin <ilyal@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/tls: remove redundant second null check on sgout
Date: Tue, 24 Apr 2018 13:36:58 +0100
Message-Id: <20180424123658.6541-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A duplicated null check on sgout is redundant as it is known to be
already true because of the identical earlier check. Remove it.
Detected by cppcheck:

net/tls/tls_sw.c:696: (warning) Identical inner 'if' condition is always
true.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/tls/tls_sw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 71e79597f940..6ed1c02cfc94 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -693,8 +693,7 @@ static int decrypt_skb(struct sock *sk, struct sk_buff *skb,
 	if (!sgout) {
 		nsg = skb_cow_data(skb, 0, &unused) + 1;
 		sgin = kmalloc_array(nsg, sizeof(*sgin), sk->sk_allocation);
-		if (!sgout)
-			sgout = sgin;
+		sgout = sgin;
 	}
 
 	sg_init_table(sgin, nsg);
-- 
2.17.0
