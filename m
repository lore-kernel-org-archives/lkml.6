Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699FDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370902082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z31HB150"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370902082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeKCDqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:09 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2C242082D;
        Fri,  2 Nov 2018 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183878;
        bh=HZkTctM+H9Hp5XQmYCcOLf1ddZKVo0khKwEXez4+is4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z31HB150Tt2sM6O5SqcsPA+XZDndxO3lt/q6/0vw8KyCyfgMym7I4WUiob6Y0DQX7
         ZGmfT6QdVre87DEpv4o+NRxtbnwy6BVNgs5ADS40Wc/y72JlXtfgMya7ZKmLhRod7g
         EFFtmbl3XvU5nft/J6zWkg/dwJUBUc226VZAIl+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH 4.19 24/24] net: bridge: remove ipv6 zero address check in mcast queries
Date:   Fri,  2 Nov 2018 19:34:57 +0100
Message-Id: <20181102182843.476397147@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 0fe5119e267f3e3d8ac206895f5922195ec55a8a upstream.

Recently a check was added which prevents marking of routers with zero
source address, but for IPv6 that cannot happen as the relevant RFCs
actually forbid such packets:
RFC 2710 (MLDv1):
"To be valid, the Query message MUST
 come from a link-local IPv6 Source Address, be at least 24 octets
 long, and have a correct MLD checksum."

Same goes for RFC 3810.

And also it can be seen as a requirement in ipv6_mc_check_mld_query()
which is used by the bridge to validate the message before processing
it. Thus any queries with :: source address won't be processed anyway.
So just remove the check for zero IPv6 source address from the query
processing function.

Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/br_multicast.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1426,8 +1426,7 @@ static void br_multicast_query_received(
 	 * is 0.0.0.0 should not be added to router port list.
 	 */
 	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
-	    (saddr->proto == htons(ETH_P_IPV6) &&
-	     !ipv6_addr_any(&saddr->u.ip6)))
+	    saddr->proto == htons(ETH_P_IPV6))
 		br_multicast_mark_router(br, port);
 }
 


