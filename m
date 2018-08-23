Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F64C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9247208DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9247208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbeHWL4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:56:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeHWL4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:56:30 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ECDFCC74;
        Thu, 23 Aug 2018 08:27:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 078/217] batman-adv: Fix bat_v best gw refcnt after netlink dump
Date:   Thu, 23 Aug 2018 09:53:11 +0200
Message-Id: <20180823075509.023238160@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 9713cb0cf19f1cec6c007e3b37be0697042b6720 ]

A reference for the best gateway is taken when the list of gateways in the
mesh is sent via netlink. This is necessary to check whether the currently
dumped entry is the currently selected gateway or not. This information is
then transferred as flag BATADV_ATTR_FLAG_BEST.

After the comparison of the current entry is done,
batadv_v_gw_dump_entry() has to decrease the reference counter again.
Otherwise the reference will be held and thus prevents a proper shutdown of
the batman-adv interfaces (and some of the interfaces enslaved in it).

Fixes: b71bb6f924fe ("batman-adv: add B.A.T.M.A.N. V bat_gw_dump implementations")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_v.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -929,7 +929,7 @@ static int batadv_v_gw_dump_entry(struct
 {
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	struct batadv_neigh_node *router;
-	struct batadv_gw_node *curr_gw;
+	struct batadv_gw_node *curr_gw = NULL;
 	int ret = 0;
 	void *hdr;
 
@@ -997,6 +997,8 @@ static int batadv_v_gw_dump_entry(struct
 	ret = 0;
 
 out:
+	if (curr_gw)
+		batadv_gw_node_put(curr_gw);
 	if (router_ifinfo)
 		batadv_neigh_ifinfo_put(router_ifinfo);
 	if (router)


