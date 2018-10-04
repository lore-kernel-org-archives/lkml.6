Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDDC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D74521470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D74521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeJDUol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeJDUok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:40 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CF1981102;
        Thu,  4 Oct 2018 13:51:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B80C9E8C5;
        Thu,  4 Oct 2018 13:51:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 5/9] afs: Sort address lists so that they are in
 logical ascending order
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:51:15 +0100
Message-ID: <153866107540.27255.12435443747589645381.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 04 Oct 2018 13:51:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort address lists so that they are in logical ascending order rather than
being partially in ascending order of the BE representations of those
values.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |   51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 00e87f859b9f..89374de4785c 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -232,22 +232,23 @@ struct afs_addr_list *afs_dns_query(struct afs_cell *cell, time64_t *_expiry)
  */
 void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 {
-	struct sockaddr_in6 *a;
-	__be16 xport = htons(port);
+	struct sockaddr_in6 *p;
+	u32 addr = ntohl(xdr);
 	int i;
 
 	if (alist->nr_addrs >= alist->max_addrs)
 		return;
 
 	for (i = 0; i < alist->nr_ipv4; i++) {
-		a = &alist->addrs[i].transport.sin6;
-		if (xdr == a->sin6_addr.s6_addr32[3] &&
-		    xport == a->sin6_port)
+		struct sockaddr_in6 *a = &alist->addrs[i].transport.sin6;
+		u32 a_addr = ntohl(a->sin6_addr.s6_addr32[3]);
+		u16 a_port = ntohs(a->sin6_port);
+
+		if (addr == a_addr && port == a_port)
 			return;
-		if (xdr == a->sin6_addr.s6_addr32[3] &&
-		    (u16 __force)xport < (u16 __force)a->sin6_port)
+		if (addr == a_addr && port < a_port)
 			break;
-		if ((u32 __force)xdr < (u32 __force)a->sin6_addr.s6_addr32[3])
+		if (addr < a_addr)
 			break;
 	}
 
@@ -256,12 +257,12 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	a = &alist->addrs[i].transport.sin6;
-	a->sin6_port		  = xport;
-	a->sin6_addr.s6_addr32[0] = 0;
-	a->sin6_addr.s6_addr32[1] = 0;
-	a->sin6_addr.s6_addr32[2] = htonl(0xffff);
-	a->sin6_addr.s6_addr32[3] = xdr;
+	p = &alist->addrs[i].transport.sin6;
+	p->sin6_port		  = htons(port);
+	p->sin6_addr.s6_addr32[0] = 0;
+	p->sin6_addr.s6_addr32[1] = 0;
+	p->sin6_addr.s6_addr32[2] = htonl(0xffff);
+	p->sin6_addr.s6_addr32[3] = xdr;
 	alist->nr_ipv4++;
 	alist->nr_addrs++;
 }
@@ -271,21 +272,20 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
  */
 void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 {
-	struct sockaddr_in6 *a;
-	__be16 xport = htons(port);
+	struct sockaddr_in6 *p;
 	int i, diff;
 
 	if (alist->nr_addrs >= alist->max_addrs)
 		return;
 
 	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-		a = &alist->addrs[i].transport.sin6;
+		struct sockaddr_in6 *a = &alist->addrs[i].transport.sin6;
+		u16 a_port = ntohs(a->sin6_port);
+
 		diff = memcmp(xdr, &a->sin6_addr, 16);
-		if (diff == 0 &&
-		    xport == a->sin6_port)
+		if (diff == 0 && port == a_port)
 			return;
-		if (diff == 0 &&
-		    (u16 __force)xport < (u16 __force)a->sin6_port)
+		if (diff == 0 && port < a_port)
 			break;
 		if (diff < 0)
 			break;
@@ -296,12 +296,9 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	a = &alist->addrs[i].transport.sin6;
-	a->sin6_port		  = xport;
-	a->sin6_addr.s6_addr32[0] = xdr[0];
-	a->sin6_addr.s6_addr32[1] = xdr[1];
-	a->sin6_addr.s6_addr32[2] = xdr[2];
-	a->sin6_addr.s6_addr32[3] = xdr[3];
+	p = &alist->addrs[i].transport.sin6;
+	p->sin6_port = htons(port);
+	memcpy(&p->sin6_addr, xdr, 16);
 	alist->nr_addrs++;
 }
 

