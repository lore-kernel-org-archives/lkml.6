Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13713C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAA920839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAA920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbeHWMTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:19:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeHWMTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:19:07 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AC0DCC5C;
        Thu, 23 Aug 2018 08:50:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Ziegler <dev@andreas-ziegler.de>,
        Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 095/324] batman-adv: Fix bat_ogm_iv best gw refcnt after netlink dump
Date:   Thu, 23 Aug 2018 09:52:41 +0200
Message-Id: <20180823075000.596122448@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit b5685d2687d6612adf5eac519eb7008f74dfd1ec ]

A reference for the best gateway is taken when the list of gateways in the
mesh is sent via netlink. This is necessary to check whether the currently
dumped entry is the currently selected gateway or not. This information is
then transferred as flag BATADV_ATTR_FLAG_BEST.

After the comparison of the current entry is done,
batadv_iv_gw_dump_entry() has to decrease the reference counter again.
Otherwise the reference will be held and thus prevents a proper shutdown of
the batman-adv interfaces (and some of the interfaces enslaved in it).

Fixes: efb766af06e3 ("batman-adv: add B.A.T.M.A.N. IV bat_gw_dump implementations")
Reported-by: Andreas Ziegler <dev@andreas-ziegler.de>
Tested-by: Andreas Ziegler <dev@andreas-ziegler.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_iv_ogm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2732,7 +2732,7 @@ static int batadv_iv_gw_dump_entry(struc
 {
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	struct batadv_neigh_node *router;
-	struct batadv_gw_node *curr_gw;
+	struct batadv_gw_node *curr_gw = NULL;
 	int ret = 0;
 	void *hdr;
 
@@ -2780,6 +2780,8 @@ static int batadv_iv_gw_dump_entry(struc
 	ret = 0;
 
 out:
+	if (curr_gw)
+		batadv_gw_node_put(curr_gw);
 	if (router_ifinfo)
 		batadv_neigh_ifinfo_put(router_ifinfo);
 	if (router)


