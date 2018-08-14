Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57631C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A288208C2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A288208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbeHNTIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:08:36 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.120]:46021 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728978AbeHNTIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:08:36 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 1069F329E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 11:20:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pc3UfNqsmaSeypc3gfug6N; Tue, 14 Aug 2018 11:20:45 -0500
X-Authority-Reason: nr=8
Received: from [189.250.37.72] (port=46808 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fpc3T-000v4a-Iq; Tue, 14 Aug 2018 11:20:23 -0500
Date:   Tue, 14 Aug 2018 11:20:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: filter: mark expected switch fall-through
Message-ID: <20180814162021.GA31493@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.37.72
X-Source-L: No
X-Exim-ID: 1fpc3T-000v4a-Iq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.37.72]:46808
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1472592 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 15b9d2d..fd423ce 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7235,6 +7235,7 @@ sk_reuseport_is_valid_access(int off, int size,
 	case offsetof(struct sk_reuseport_md, eth_protocol):
 		if (size < FIELD_SIZEOF(struct sk_buff, protocol))
 			return false;
+		/* fall through */
 	case offsetof(struct sk_reuseport_md, ip_protocol):
 	case offsetof(struct sk_reuseport_md, bind_inany):
 	case offsetof(struct sk_reuseport_md, len):
-- 
2.7.4

