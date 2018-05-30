Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbeE3Lm3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:42:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60693 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751958AbeE3LG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:58 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Alexander Potapenko" <glider@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.968508082@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 145/153] netlink: make sure nladdr has correct size in
 netlink_connect()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>

commit 7880287981b60a6808f39f297bb66936e8bdf57a upstream.

KMSAN reports use of uninitialized memory in the case when |alen| is
smaller than sizeof(struct sockaddr_nl), and therefore |nladdr| isn't
fully copied from the userspace.

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netlink/af_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -706,6 +706,9 @@ static int netlink_connect(struct socket
 	if (addr->sa_family != AF_NETLINK)
 		return -EINVAL;
 
+	if (alen < sizeof(struct sockaddr_nl))
+		return -EINVAL;
+
 	/* Only superuser is allowed to send multicasts */
 	if (nladdr->nl_groups && !netlink_capable(sock, NL_NONROOT_SEND))
 		return -EPERM;
