Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163872084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163872084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJDUod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeJDUod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF8C031649AF;
        Thu,  4 Oct 2018 13:51:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDC232D02A;
        Thu,  4 Oct 2018 13:51:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 4/9] afs: Always build address lists using the
 helper functions
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:51:08 +0100
Message-ID: <153866106801.27255.8624119397341650068.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 04 Oct 2018 13:51:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the address list string parser use the helper functions for adding
addresses to an address list so that they end up appropriately sorted.
This will better handles overruns and make them easier to compare.

It also reduces the number of places that addresses are handled, making it
easier to fix the handling.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 4dbb8af54668..00e87f859b9f 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -116,8 +116,10 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 	/* Extract the addresses */
 	p = text;
 	do {
-		struct sockaddr_rxrpc *srx = &alist->addrs[alist->nr_addrs];
 		const char *q, *stop;
+		unsigned int xport = port;
+		__be32 x[4];
+		int family;
 
 		if (*p == delim) {
 			p++;
@@ -133,19 +135,12 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 					break;
 		}
 
-		if (in4_pton(p, q - p,
-			     (u8 *)&srx->transport.sin6.sin6_addr.s6_addr32[3],
-			     -1, &stop)) {
-			srx->transport.sin6.sin6_addr.s6_addr32[0] = 0;
-			srx->transport.sin6.sin6_addr.s6_addr32[1] = 0;
-			srx->transport.sin6.sin6_addr.s6_addr32[2] = htonl(0xffff);
-		} else if (in6_pton(p, q - p,
-				    srx->transport.sin6.sin6_addr.s6_addr,
-				    -1, &stop)) {
-			/* Nothing to do */
-		} else {
+		if (in4_pton(p, q - p, (u8 *)&x[0], -1, &stop))
+			family = AF_INET;
+		else if (in6_pton(p, q - p, (u8 *)x, -1, &stop))
+			family = AF_INET6;
+		else
 			goto bad_address;
-		}
 
 		if (stop != q)
 			goto bad_address;
@@ -157,7 +152,7 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 		if (p < end) {
 			if (*p == '+') {
 				/* Port number specification "+1234" */
-				unsigned int xport = 0;
+				xport = 0;
 				p++;
 				if (p >= end || !isdigit(*p))
 					goto bad_address;
@@ -168,7 +163,6 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 						goto bad_address;
 					p++;
 				} while (p < end && isdigit(*p));
-				srx->transport.sin6.sin6_port = htons(xport);
 			} else if (*p == delim) {
 				p++;
 			} else {
@@ -176,8 +170,12 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 			}
 		}
 
-		alist->nr_addrs++;
-	} while (p < end && alist->nr_addrs < alist->max_addrs);
+		if (family == AF_INET)
+			afs_merge_fs_addr4(alist, x[0], xport);
+		else
+			afs_merge_fs_addr6(alist, x, xport);
+
+	} while (p < end);
 
 	_leave(" = [nr %u]", alist->nr_addrs);
 	return alist;

