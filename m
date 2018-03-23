Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeCWMty (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:49:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45215 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeCWMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:49:47 -0400
X-Google-Smtp-Source: AG47ELs0EzFqsR6Wd6G+kDeNgpA4KZO0Rqeb3dD7PSF5SHn9MXLoUUbPF3hrDcEosmikBXE68GnuZw==
From: Alexander Potapenko <glider@google.com>
To: dvyukov@google.com, edumazet@google.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netlink: make sure nladdr has correct size in netlink_connect()
Date: Fri, 23 Mar 2018 13:49:02 +0100
Message-Id: <20180323124902.41625-1-glider@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reports use of uninitialized memory in the case when |alen| is
smaller than sizeof(struct sockaddr_nl), and therefore |nladdr| isn't
fully copied from the userspace.

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
---
v2: fixed a typo spotted by Eric Dumazet
---
 net/netlink/af_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 07e8478068f0..70c455341243 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1085,6 +1085,9 @@ static int netlink_connect(struct socket *sock, struct sockaddr *addr,
 	if (addr->sa_family != AF_NETLINK)
 		return -EINVAL;
 
+	if (alen < sizeof(struct sockaddr_nl))
+		return -EINVAL;
+
 	if ((nladdr->nl_groups || nladdr->nl_pid) &&
 	    !netlink_allowed(sock, NL_CFG_F_NONROOT_SEND))
 		return -EPERM;
-- 
2.17.0.rc0.231.g781580f067-goog
