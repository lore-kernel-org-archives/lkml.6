Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4DFECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA13C2147A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0XWXmFCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA13C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeKIHiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbeKIHiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:01 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D752147A;
        Thu,  8 Nov 2018 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714432;
        bh=8NMhd0OcougCFlvNC+uvwxloDmSLa8/Olkli2KBbsXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XWXmFCEbBwI1BPnEYLTk/kjDrGLlQYMxSm2+O2w8BxmdXMmmwG5lvNCgXHGY8ZJ7
         v58gpsJzGvmwZjfbmeUx/q1ml/1pKCxqs3kXmyTlhuqKNsvNT45sSzLvVHSfLlKigc
         SaP+Xh5i1+MBYc5vCNWDU/sw8h+Ia4tZ3Xebaf54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH 4.4 089/114] net: bridge: remove ipv6 zero address check in mcast queries
Date:   Thu,  8 Nov 2018 13:51:44 -0800
Message-Id: <20181108215108.859338385@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1267,8 +1267,7 @@ static void br_multicast_query_received(
 	 * is 0.0.0.0 should not be added to router port list.
 	 */
 	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
-	    (saddr->proto == htons(ETH_P_IPV6) &&
-	     !ipv6_addr_any(&saddr->u.ip6)))
+	    saddr->proto == htons(ETH_P_IPV6))
 		br_multicast_mark_router(br, port);
 }
 


