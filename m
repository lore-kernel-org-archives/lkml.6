Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F790FA374F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94C42154D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94C42154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeIMVTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:19:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbeIMVTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:19:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DDAF30024C4;
        Thu, 13 Sep 2018 16:09:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00854600C8;
        Thu, 13 Sep 2018 16:09:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/6] afs: Always build address lists using the helper
 functions
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 17:09:34 +0100
Message-ID: <153685497417.16086.8080066610207629320.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
References: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 13 Sep 2018 16:09:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the address list string parser use the helper functions for adding
addresses to an address list so that they end up appropriately sorted.
This will better handles overruns and make them easier to compare.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 630f91633b40..a7fdc05ba8d2 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -129,8 +129,10 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
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
@@ -146,19 +148,12 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
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
@@ -170,7 +165,7 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 		if (p < end) {
 			if (*p == '+') {
 				/* Port number specification "+1234" */
-				unsigned int xport = 0;
+				xport = 0;
 				p++;
 				if (p >= end || !isdigit(*p))
 					goto bad_address;
@@ -181,7 +176,6 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 						goto bad_address;
 					p++;
 				} while (p < end && isdigit(*p));
-				srx->transport.sin6.sin6_port = htons(xport);
 			} else if (*p == delim) {
 				p++;
 			} else {
@@ -189,8 +183,12 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
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
 	return vllist;

