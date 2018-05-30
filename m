Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753736AbeE3Lqu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:46:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60652 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751444AbeE3LG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:57 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Daniel Borkmann" <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Jason Gunthorpe" <jgunthorpe@obsidianresearch.com>,
        "Neil Horman" <nhorman@tuxdriver.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.879901012@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 001/153] sctp: Fix mangled IPv4 addresses on a IPv6
 listening socket
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -704,11 +704,14 @@ static inline void sctp_v6_map_v4(union
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
