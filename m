Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA30C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDC720854
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L94H/HvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDC720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeKCDvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbeKCDvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:51:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1242084A;
        Fri,  2 Nov 2018 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184179;
        bh=0mwhO9z9uOzjTgobil2ZWsS9niOX3WuBmvfItPeEHjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L94H/HvMfzFkwm5WDVaS9Z5sfnkH41MT1KtfiuC6wqQvVWsBT46GR+mAabmvZPcZP
         2fxP+Cv672fpehJrrcbl/mfNUhO2bvLpeYhSbXwQ6EMHKURC2w+Guj/tAojarnuLRL
         VQHP8Ig59JsCfbJ0gcXDuVY91kXjTgOsDG7+nqqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 103/150] bridge: do not add port to router list when receives query with source 0.0.0.0
Date:   Fri,  2 Nov 2018 19:34:25 +0100
Message-Id: <20181102182910.500575023@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 5a2de63fd1a59c30c02526d427bc014b98adf508 ]

Based on RFC 4541, 2.1.1.  IGMP Forwarding Rules

  The switch supporting IGMP snooping must maintain a list of
  multicast routers and the ports on which they are attached.  This
  list can be constructed in any combination of the following ways:

  a) This list should be built by the snooping switch sending
     Multicast Router Solicitation messages as described in IGMP
     Multicast Router Discovery [MRDISC].  It may also snoop
     Multicast Router Advertisement messages sent by and to other
     nodes.

  b) The arrival port for IGMP Queries (sent by multicast routers)
     where the source address is not 0.0.0.0.

We should not add the port to router list when receives query with source
0.0.0.0.

Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_multicast.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1420,7 +1420,15 @@ static void br_multicast_query_received(
 		return;
 
 	br_multicast_update_query_timer(br, query, max_delay);
-	br_multicast_mark_router(br, port);
+
+	/* Based on RFC4541, section 2.1.1 IGMP Forwarding Rules,
+	 * the arrival port for IGMP Queries where the source address
+	 * is 0.0.0.0 should not be added to router port list.
+	 */
+	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
+	    (saddr->proto == htons(ETH_P_IPV6) &&
+	     !ipv6_addr_any(&saddr->u.ip6)))
+		br_multicast_mark_router(br, port);
 }
 
 static int br_ip4_multicast_query(struct net_bridge *br,


