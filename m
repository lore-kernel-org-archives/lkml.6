Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1E5ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8E1214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8E1214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJTJVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:21:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeJTJVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:21:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B04F33082139;
        Sat, 20 Oct 2018 01:13:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943566252D;
        Sat, 20 Oct 2018 01:13:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/24] afs: Eliminate the address pointer from the address
 list cursor
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:13:17 +0100
Message-ID: <153999799775.866.7115096426815492439.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 20 Oct 2018 01:13:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the address pointer from the address list cursor as it's
redundant (ac->addrs[ac->index] can be used to find the same address) and
address lists must be replaced rather than being rearranged, so is of
limited value.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |    2 --
 fs/afs/internal.h  |    1 -
 fs/afs/rxrpc.c     |    2 +-
 fs/afs/server.c    |    2 --
 fs/afs/vl_rotate.c |    2 +-
 fs/afs/volume.c    |    6 +++---
 6 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index bc5ce31a4ae4..1536d1d21c33 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -371,7 +371,6 @@ bool afs_iterate_addresses(struct afs_addr_cursor *ac)
 
 	ac->begun = true;
 	ac->responded = false;
-	ac->addr = &ac->alist->addrs[ac->index];
 	return true;
 }
 
@@ -389,7 +388,6 @@ int afs_end_cursor(struct afs_addr_cursor *ac)
 		afs_put_addrlist(alist);
 	}
 
-	ac->addr = NULL;
 	ac->alist = NULL;
 	ac->begun = false;
 	return ac->error;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ac9da1e4050e..e5b596bd8acf 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -653,7 +653,6 @@ struct afs_interface {
  */
 struct afs_addr_cursor {
 	struct afs_addr_list	*alist;		/* Current address list (pins ref) */
-	struct sockaddr_rxrpc	*addr;
 	u32			abort_code;
 	unsigned short		start;		/* Starting point in alist->addrs[] */
 	unsigned short		index;		/* Wrapping offset from start to current addr */
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 444ba0d511ef..42e1ea7372e9 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -359,7 +359,7 @@ static int afs_send_pages(struct afs_call *call, struct msghdr *msg)
 long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 		   gfp_t gfp, bool async)
 {
-	struct sockaddr_rxrpc *srx = ac->addr;
+	struct sockaddr_rxrpc *srx = &ac->alist->addrs[ac->index];
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
diff --git a/fs/afs/server.c b/fs/afs/server.c
index aa35cfae5440..7c1be8b4dc9a 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -367,7 +367,6 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 		.alist	= alist,
 		.start	= alist->index,
 		.index	= 0,
-		.addr	= &alist->addrs[alist->index],
 		.error	= 0,
 	};
 	_enter("%p", server);
@@ -518,7 +517,6 @@ static bool afs_do_probe_fileserver(struct afs_fs_cursor *fc)
 
 	_enter("");
 
-	fc->ac.addr = NULL;
 	fc->ac.start = READ_ONCE(fc->ac.alist->index);
 	fc->ac.index = fc->ac.start;
 	fc->ac.error = 0;
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 5b99ea7be194..ead6dedbb561 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -209,7 +209,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	if (!afs_iterate_addresses(&vc->ac))
 		goto next_server;
 
-	_leave(" = t %pISpc", &vc->ac.addr->transport);
+	_leave(" = t %pISpc", &vc->ac.alist->addrs[vc->ac.index].transport);
 	return true;
 
 next_server:
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index f0020e35bf6f..7527c081726e 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -88,16 +88,16 @@ static struct afs_vldb_entry *afs_vl_lookup_vldb(struct afs_cell *cell,
 			case VL_SERVICE:
 				clear_bit(vc.ac.index, &vc.ac.alist->yfs);
 				set_bit(vc.ac.index, &vc.ac.alist->probed);
-				vc.ac.addr->srx_service = ret;
+				vc.ac.alist->addrs[vc.ac.index].srx_service = ret;
 				break;
 			case YFS_VL_SERVICE:
 				set_bit(vc.ac.index, &vc.ac.alist->yfs);
 				set_bit(vc.ac.index, &vc.ac.alist->probed);
-				vc.ac.addr->srx_service = ret;
+				vc.ac.alist->addrs[vc.ac.index].srx_service = ret;
 				break;
 			}
 		}
-		
+
 		vldb = afs_vl_get_entry_by_name_u(&vc, volname, volnamesz);
 	}
 

