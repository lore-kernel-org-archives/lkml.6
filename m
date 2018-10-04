Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C17C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E512084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E512084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJDUo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50149 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeJDUo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDCE030832D8;
        Thu,  4 Oct 2018 13:51:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDC3377BEA;
        Thu,  4 Oct 2018 13:51:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 3/9] afs: Do better max capacity handling on
 address lists
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:51:01 +0100
Message-ID: <153866106109.27255.7777046107626145857.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 04 Oct 2018 13:51:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note the maximum allocated capacity in an afs_addr_list struct and discard
addresses that would exceed it in afs_merge_fs_addr{4,6}().

Also, since the current maximum capacity is less than 255, reduce the
relevant members to bytes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |   19 +++++++++++--------
 fs/afs/internal.h  |    8 +++++---
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 025a9a5e1c32..4dbb8af54668 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -17,11 +17,6 @@
 #include "internal.h"
 #include "afs_fs.h"
 
-//#define AFS_MAX_ADDRESSES
-//	((unsigned int)((PAGE_SIZE - sizeof(struct afs_addr_list)) /
-//			sizeof(struct sockaddr_rxrpc)))
-#define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
-
 /*
  * Release an address list.
  */
@@ -43,11 +38,15 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr,
 
 	_enter("%u,%u,%u", nr, service, port);
 
+	if (nr > AFS_MAX_ADDRESSES)
+		nr = AFS_MAX_ADDRESSES;
+
 	alist = kzalloc(struct_size(alist, addrs, nr), GFP_KERNEL);
 	if (!alist)
 		return NULL;
 
 	refcount_set(&alist->usage, 1);
+	alist->max_addrs = nr;
 
 	for (i = 0; i < nr; i++) {
 		struct sockaddr_rxrpc *srx = &alist->addrs[i];
@@ -109,8 +108,6 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 	} while (p < end);
 
 	_debug("%u/%u addresses", nr, AFS_MAX_ADDRESSES);
-	if (nr > AFS_MAX_ADDRESSES)
-		nr = AFS_MAX_ADDRESSES;
 
 	alist = afs_alloc_addrlist(nr, service, port);
 	if (!alist)
@@ -180,7 +177,7 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 		}
 
 		alist->nr_addrs++;
-	} while (p < end && alist->nr_addrs < AFS_MAX_ADDRESSES);
+	} while (p < end && alist->nr_addrs < alist->max_addrs);
 
 	_leave(" = [nr %u]", alist->nr_addrs);
 	return alist;
@@ -241,6 +238,9 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 	__be16 xport = htons(port);
 	int i;
 
+	if (alist->nr_addrs >= alist->max_addrs)
+		return;
+
 	for (i = 0; i < alist->nr_ipv4; i++) {
 		a = &alist->addrs[i].transport.sin6;
 		if (xdr == a->sin6_addr.s6_addr32[3] &&
@@ -277,6 +277,9 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 	__be16 xport = htons(port);
 	int i, diff;
 
+	if (alist->nr_addrs >= alist->max_addrs)
+		return;
+
 	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
 		a = &alist->addrs[i].transport.sin6;
 		diff = memcmp(xdr, &a->sin6_addr, 16);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 871a228d7f37..8ae4e2ebb99a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -73,12 +73,14 @@ struct afs_addr_list {
 	struct rcu_head		rcu;		/* Must be first */
 	refcount_t		usage;
 	u32			version;	/* Version */
-	unsigned short		nr_addrs;
-	unsigned short		index;		/* Address currently in use */
-	unsigned short		nr_ipv4;	/* Number of IPv4 addresses */
+	unsigned char		max_addrs;
+	unsigned char		nr_addrs;
+	unsigned char		index;		/* Address currently in use */
+	unsigned char		nr_ipv4;	/* Number of IPv4 addresses */
 	unsigned long		probed;		/* Mask of servers that have been probed */
 	unsigned long		yfs;		/* Mask of servers that are YFS */
 	struct sockaddr_rxrpc	addrs[];
+#define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
 };
 
 /*

