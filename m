Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /k/PFb9ZGVueCgAAmS7hNA
	; Thu, 07 Jun 2018 16:14:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 996F76074D; Thu,  7 Jun 2018 16:14:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F371360115;
	Thu,  7 Jun 2018 16:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F371360115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936083AbeFGQOt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:14:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39118 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932916AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zm-5O; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002gN-2u; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jason Gunthorpe" <jgunthorpe@obsidianresearch.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Neil Horman" <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.565701811@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 005/410] sctp: Fix mangled IPv4 addresses on a IPv6
 listening socket
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

commit 9302d7bb0c5cd46be5706859301f18c137b2439f upstream.

sctp_v4_map_v6 was subtly writing and reading from members
of a union in a way the clobbered data it needed to read before
it read it.

Zeroing the v6 flowinfo overwrites the v4 sin_addr with 0, meaning
that every place that calls sctp_v4_map_v6 gets ::ffff:0.0.0.0 as the
result.

Reorder things to guarantee correct behaviour no matter what the
union layout is.

This impacts user space clients that open an IPv6 SCTP socket and
receive IPv4 connections. Prior to 299ee user space would see a
sockaddr with AF_INET and a correct address, after 299ee the sockaddr
is AF_INET6, but the address is wrong.

Fixes: 299ee123e198 (sctp: Fixup v4mapped behaviour to comply with Sock API)
Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/sctp/sctp.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -582,11 +582,14 @@ static inline void sctp_v6_map_v4(union
 /* Map v4 address to v4-mapped v6 address */
 static inline void sctp_v4_map_v6(union sctp_addr *addr)
 {
+	__be16 port;
+
+	port = addr->v4.sin_port;
+	addr->v6.sin6_addr.s6_addr32[3] = addr->v4.sin_addr.s_addr;
+	addr->v6.sin6_port = port;
 	addr->v6.sin6_family = AF_INET6;
 	addr->v6.sin6_flowinfo = 0;
 	addr->v6.sin6_scope_id = 0;
-	addr->v6.sin6_port = addr->v4.sin_port;
-	addr->v6.sin6_addr.s6_addr32[3] = addr->v4.sin_addr.s_addr;
 	addr->v6.sin6_addr.s6_addr32[0] = 0;
 	addr->v6.sin6_addr.s6_addr32[1] = 0;
 	addr->v6.sin6_addr.s6_addr32[2] = htonl(0x0000ffff);
