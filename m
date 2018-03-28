Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeC1OQW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:16:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1OQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:16:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next] sctp: fix unused lable warning
Date: Wed, 28 Mar 2018 16:14:56 +0200
Message-Id: <20180328141512.3083992-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:qo4Ek2FBOEURCfLYnGAe3yJkfdBfLKN3POgROGsftD1hTqYdLtA
 Kp5GzU3uC0Zez807SbLvbO76oQ5+Y61/7S6GsjgHpqN5H54Z/sys3yyvFbJI0vahx2LRz4k
 4jDjR9fnDIBh7HJXuCpY/UNJU+ojJqnSjsIAEwzWjP9xP3PG+dNvF95JFseKcZFFNiyUG2W
 8Jaj0GXYVw49UJeQufrBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FOzLZwsgrRs=:IhSQpmbETOHkiymkpj17tJ
 mercD+ekhcdUiq1tlTpUYCB3V4m5cutIRLTEos2Zd7WZgenlF+dmBfElvvyhYj2l4E4w2t3hI
 UoMitvbCWy5neBoJDu0+s0eYSDuyYVW9wwGR/wzIAu5MG+IaK5r9oK14/Vl0MUKxn+kzOFO+g
 8Ie5j7wVG7Vb7hr8/PsHWx3TnnlmVl+GbryQHr73ZiFUzpwPS9Ymnni9908hhCZBzB89k6fqN
 WsYDr/GPZWWsAE7BcbH6ktIqsWFawKeYYzbfE8p1MZPUJ0LjkOq5fxhJu3KFTc4Quia9exTCS
 dT7c0Qvz0pFfhnLE98sStx2KFby3U09KviIvlz50Cby7vnMyfbii5ZQZ8uok4Oee3guJFtyLk
 AGfX62DZp3zRZVloEqGL1oipfVvx7UytfQ/NKC/uSIigPs+1pwUGqT6Q9yhB5T6boGID6QIj4
 o8CW2X4yvTZ8Qj+utMAoHOywtI9K6GhpGcG0hsYnIiIMta9zCtEco0KSn//vbyY650t3I1sls
 tD+HxvFu0n5WeVmEE/GSOVR/qO+NRFNDMFXXRjMXatYUueE+DrET4gtjtlMNgndpSZZmEVC4r
 0dwyvpnJb7hLFd4hlEGjo2DD0bITh2tn6WL1nbztu1UAyqhYCOGtifYpnEWCW0Shf7opAdZJ9
 URzAhj3SKzfzzC9v9amvFoW5Cq76sZgXQXTvk4E6kB+JCOmtiCD4JQbYFIcY/oUHM0L44uf+N
 Lx5pGZ0xrGg7vUxqhWLJCaA85wuMOc+9s+bJvg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proc file cleanup left a label possibly unused:

net/sctp/protocol.c: In function 'sctp_defaults_init':
net/sctp/protocol.c:1304:1: error: label 'err_init_proc' defined but not used [-Werror=unused-label]

This adds an #ifdef around it to match the respective 'goto'.

Fixes: d47d08c8ca05 ("sctp: use proc_remove_subtree()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/sctp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index c1c64b78c39d..d685f8456762 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1301,8 +1301,10 @@ static int __net_init sctp_defaults_init(struct net *net)
 
 	return 0;
 
+#ifdef CONFIG_PROC_FS
 err_init_proc:
 	cleanup_sctp_mibs(net);
+#endif
 err_init_mibs:
 	sctp_sysctl_net_unregister(net);
 err_sysctl_register:
-- 
2.9.0
