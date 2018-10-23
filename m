Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A07C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA653206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA653206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJXMCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeJXMCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:02:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 505BA3002F8C;
        Tue, 23 Oct 2018 23:58:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B810611C5;
        Tue, 23 Oct 2018 23:58:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/25] afs: Fix TTL on VL server and address lists [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 00:58:53 +0100
Message-ID: <154033913355.12041.14275066646402136427.stgit@warthog.procyon.org.uk>
In-Reply-To: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 23 Oct 2018 23:58:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the TTL on VL server and address lists isn't set in all
circumstances and may be set to poor choices in others, since the TTL is
derived from the SRV/AFSDB DNS record if and when available.

Fix the TTL by limiting the range to a minimum and maximum from the current
time.  At some point these can be made into sysctl knobs.  Further, use the
TTL we obtained from the upcall to set the expiry on negative results too;
in future a mechanism can be added to force reloading of such data.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c |   26 ++++++++++++++++++++++----
 fs/afs/proc.c |   14 +++++++++++---
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 963b6fa51fdf..cf445dbd5f2e 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -20,6 +20,8 @@
 #include "internal.h"
 
 static unsigned __read_mostly afs_cell_gc_delay = 10;
+static unsigned __read_mostly afs_cell_min_ttl = 10 * 60;
+static unsigned __read_mostly afs_cell_max_ttl = 24 * 60 * 60;
 
 static void afs_manage_cell(struct work_struct *);
 
@@ -171,6 +173,8 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 
 		rcu_assign_pointer(cell->vl_servers, vllist);
 		cell->dns_expiry = TIME64_MAX;
+	} else {
+		cell->dns_expiry = ktime_get_real_seconds();
 	}
 
 	_leave(" = %p", cell);
@@ -358,25 +362,39 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 static void afs_update_cell(struct afs_cell *cell)
 {
 	struct afs_vlserver_list *vllist, *old;
-	time64_t now, expiry;
+	unsigned int min_ttl = READ_ONCE(afs_cell_min_ttl);
+	unsigned int max_ttl = READ_ONCE(afs_cell_max_ttl);
+	time64_t now, expiry = 0;
 
 	_enter("%s", cell->name);
 
 	vllist = afs_dns_query(cell, &expiry);
+
+	now = ktime_get_real_seconds();
+	if (min_ttl > max_ttl)
+		max_ttl = min_ttl;
+	if (expiry < now + min_ttl)
+		expiry = now + min_ttl;
+	else if (expiry > now + max_ttl)
+		expiry = now + max_ttl;
+
 	if (IS_ERR(vllist)) {
 		switch (PTR_ERR(vllist)) {
 		case -ENODATA:
-			/* The DNS said that the cell does not exist */
+		case -EDESTADDRREQ:
+			/* The DNS said that the cell does not exist or there
+			 * weren't any addresses to be had.
+			 */
 			set_bit(AFS_CELL_FL_NOT_FOUND, &cell->flags);
 			clear_bit(AFS_CELL_FL_DNS_FAIL, &cell->flags);
-			cell->dns_expiry = ktime_get_real_seconds() + 61;
+			cell->dns_expiry = expiry;
 			break;
 
 		case -EAGAIN:
 		case -ECONNREFUSED:
 		default:
 			set_bit(AFS_CELL_FL_DNS_FAIL, &cell->flags);
-			cell->dns_expiry = ktime_get_real_seconds() + 10;
+			cell->dns_expiry = now + 10;
 			break;
 		}
 
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 6585f4bec0d3..fc36c41641ab 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -37,16 +37,24 @@ static inline struct afs_net *afs_seq2net_single(struct seq_file *m)
  */
 static int afs_proc_cells_show(struct seq_file *m, void *v)
 {
-	struct afs_cell *cell = list_entry(v, struct afs_cell, proc_link);
+	struct afs_vlserver_list *vllist;
+	struct afs_cell *cell;
 
 	if (v == SEQ_START_TOKEN) {
 		/* display header on line 1 */
-		seq_puts(m, "USE NAME\n");
+		seq_puts(m, "USE    TTL SV NAME\n");
 		return 0;
 	}
 
+	cell = list_entry(v, struct afs_cell, proc_link);
+	vllist = rcu_dereference(cell->vl_servers);
+
 	/* display one cell per line on subsequent lines */
-	seq_printf(m, "%3u %s\n", atomic_read(&cell->usage), cell->name);
+	seq_printf(m, "%3u %6lld %2u %s\n",
+		   atomic_read(&cell->usage),
+		   cell->dns_expiry - ktime_get_real_seconds(),
+		   vllist ? vllist->nr_servers : 0,
+		   cell->name);
 	return 0;
 }
 

