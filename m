Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161874AbeE1KeN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161834AbeE1KeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:34:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 150/329] batman-adv: Ignore invalid batadv_v_gw during netlink send
Date: Mon, 28 May 2018 12:01:19 +0200
Message-Id: <20180528100255.028405597@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

[ Upstream commit 011c935fceae5252619ef730baa610c655281dda ]

The function batadv_v_gw_dump stops the processing loop when
batadv_v_gw_dump_entry returns a non-0 return code. This should only
happen when the buffer is full. Otherwise, an empty message may be
returned by batadv_gw_dump. This empty message will then stop the netlink
dumping of gateway entries. At worst, not a single entry is returned to
userspace even when plenty of possible gateways exist.

Fixes: b71bb6f924fe ("batman-adv: add B.A.T.M.A.N. V bat_gw_dump implementations")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_v.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -920,7 +920,7 @@ static int batadv_v_gw_dump_entry(struct
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	struct batadv_neigh_node *router;
 	struct batadv_gw_node *curr_gw;
-	int ret = -EINVAL;
+	int ret = 0;
 	void *hdr;
 
 	router = batadv_orig_router_get(gw_node->orig_node, BATADV_IF_DEFAULT);
