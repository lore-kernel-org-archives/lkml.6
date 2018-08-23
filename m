Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5020EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C152084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C152084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbeHWM1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHWM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:24 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8BFECA0;
        Thu, 23 Aug 2018 08:58:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 202/324] tipc: correct discovery message handling during address trial period
Date:   Thu, 23 Aug 2018 09:54:28 +0200
Message-Id: <20180823075006.243252536@linuxfoundation.org>
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

From: Jon Maloy <jon.maloy@ericsson.com>

[ Upstream commit e415577f57f4452150642500364cbe5fa6112813 ]

With the duplicate address discovery protocol for tipc nodes addresses
we introduced a one second trial period before a node is allocated a
hash number to use as address.

Unfortunately, we miss to handle the case when a regular LINK REQUEST/
RESPONSE arrives from a cluster node during the trial period. Such
messages are not ignored as they should be, leading to links setup
attempts while the node still has no address.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/discover.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -133,6 +133,8 @@ static void disc_dupl_alert(struct tipc_
 }
 
 /* tipc_disc_addr_trial(): - handle an address uniqueness trial from peer
+ * Returns true if message should be dropped by caller, i.e., if it is a
+ * trial message or we are inside trial period. Otherwise false.
  */
 static bool tipc_disc_addr_trial_msg(struct tipc_discoverer *d,
 				     struct tipc_media_addr *maddr,
@@ -168,8 +170,9 @@ static bool tipc_disc_addr_trial_msg(str
 		msg_set_type(buf_msg(d->skb), DSC_REQ_MSG);
 	}
 
+	/* Accept regular link requests/responses only after trial period */
 	if (mtyp != DSC_TRIAL_MSG)
-		return false;
+		return trial;
 
 	sugg_addr = tipc_node_try_addr(net, peer_id, src);
 	if (sugg_addr)


