Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeE3LPW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:15:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60693 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751911AbeE3LH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:27 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>,
        "Jianlin Shi" <jishi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Hangbin Liu" <liuhangbin@gmail.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.680781280@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 033/153] l2tp: fix missing print session offset info
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

commit 820da5357572715c6235ba3b3daa2d5b43a1198f upstream.

Report offset parameter in L2TP_CMD_SESSION_GET command if
it has been configured by userspace

Fixes: 309795f4bec ("l2tp: Add netlink control API for L2TP")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2:
 - Use NLA_PUT_U16, consistent with the rest of the function
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -589,6 +589,8 @@ static int l2tp_nl_session_send(struct s
 
 	if (session->ifname && session->ifname[0])
 		NLA_PUT_STRING(skb, L2TP_ATTR_IFNAME, session->ifname);
+	if (session->offset)
+		NLA_PUT_U16(skb, L2TP_ATTR_OFFSET, session->offset);
 	if (session->cookie_len)
 		NLA_PUT(skb, L2TP_ATTR_COOKIE, session->cookie_len, &session->cookie[0]);
 	if (session->peer_cookie_len)
