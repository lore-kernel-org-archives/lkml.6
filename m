Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48248ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E43321479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0swfoOjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E43321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbeKIHou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732277AbeKIHou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:50 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1925520989;
        Thu,  8 Nov 2018 22:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714839;
        bh=o8UMET9v51xLDfoBlum7ggh41ZvtOeRD2t7Qyzm9NA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0swfoOjhHmAQ2VEFfcenaaMTyFjqBO8W+fKRoIq95P+0HnOMy15KctB/lTdX/Iklq
         Rstq3rNQomfgEbQ9565qKT0ajQpGyV9uLPJ55v9hd4EN4aKdxKhWcbI8o97PQIQj6J
         b/4EDq+xQue/7nsXTmKWtdnezCvP2IIgri03LLtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 134/171] bridge: do not add port to router list when receives query with source 0.0.0.0
Date:   Thu,  8 Nov 2018 13:51:44 -0800
Message-Id: <20181108215136.822301253@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

commit 5a2de63fd1a59c30c02526d427bc014b98adf508 upstream.

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
@@ -1287,7 +1287,15 @@ static void br_multicast_query_received(
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


