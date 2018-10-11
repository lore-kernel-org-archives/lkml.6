Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293DDC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21632077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21632077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJLFPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:15:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeJLFPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:15:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A890307D90F;
        Thu, 11 Oct 2018 21:45:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15B428737D;
        Thu, 11 Oct 2018 21:45:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix cell proc list
From:   David Howells <dhowells@redhat.com>
To:     gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Oct 2018 22:45:49 +0100
Message-ID: <153929434917.24725.5423867421481211888.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 11 Oct 2018 21:45:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to the list of cells by /proc/net/afs/cells has a couple of
problems:

 (1) It should be checking against SEQ_START_TOKEN for the keying the
     header line.

 (2) It's only holding the RCU read lock, so it can't just walk over the
     list without following the proper RCU methods.

Fix these by using an hlist instead of an ordinary list and using the
appropriate accessor functions to follow it with RCU.

Since the code that adds a cell to the list must also necessarily change,
sort the list on insertion whilst we're at it.

Fixes: 989782dcdc91 ("afs: Overhaul cell database management")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c     |   17 +++++++++++++++--
 fs/afs/dynroot.c  |    2 +-
 fs/afs/internal.h |    4 ++--
 fs/afs/main.c     |    2 +-
 fs/afs/proc.c     |    7 +++----
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index f3d0bef16d78..6127f0fcd62c 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -514,6 +514,8 @@ static int afs_alloc_anon_key(struct afs_cell *cell)
  */
 static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 {
+	struct hlist_node **p;
+	struct afs_cell *pcell;
 	int ret;
 
 	if (!cell->anonymous_key) {
@@ -534,7 +536,18 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 		return ret;
 
 	mutex_lock(&net->proc_cells_lock);
-	list_add_tail(&cell->proc_link, &net->proc_cells);
+	for (p = &net->proc_cells.first; *p; p = &(*p)->next) {
+		pcell = hlist_entry(*p, struct afs_cell, proc_link);
+		if (strcmp(cell->name, pcell->name) < 0)
+			break;
+	}
+
+	cell->proc_link.pprev = p;
+	cell->proc_link.next = *p;
+	rcu_assign_pointer(*p, &cell->proc_link.next);
+	if (cell->proc_link.next)
+		cell->proc_link.next->pprev = &cell->proc_link.next;
+
 	afs_dynroot_mkdir(net, cell);
 	mutex_unlock(&net->proc_cells_lock);
 	return 0;
@@ -550,7 +563,7 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
 	afs_proc_cell_remove(cell);
 
 	mutex_lock(&net->proc_cells_lock);
-	list_del_init(&cell->proc_link);
+	hlist_del_rcu(&cell->proc_link);
 	afs_dynroot_rmdir(net, cell);
 	mutex_unlock(&net->proc_cells_lock);
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 1cde710a8013..f29c6dade7f6 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -265,7 +265,7 @@ int afs_dynroot_populate(struct super_block *sb)
 		return -ERESTARTSYS;
 
 	net->dynroot_sb = sb;
-	list_for_each_entry(cell, &net->proc_cells, proc_link) {
+	hlist_for_each_entry(cell, &net->proc_cells, proc_link) {
 		ret = afs_dynroot_mkdir(net, cell);
 		if (ret < 0)
 			goto error;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 871a228d7f37..34c02fdcc25f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -242,7 +242,7 @@ struct afs_net {
 	seqlock_t		cells_lock;
 
 	struct mutex		proc_cells_lock;
-	struct list_head	proc_cells;
+	struct hlist_head	proc_cells;
 
 	/* Known servers.  Theoretically each fileserver can only be in one
 	 * cell, but in practice, people create aliases and subsets and there's
@@ -320,7 +320,7 @@ struct afs_cell {
 	struct afs_net		*net;
 	struct key		*anonymous_key;	/* anonymous user key for this cell */
 	struct work_struct	manager;	/* Manager for init/deinit/dns */
-	struct list_head	proc_link;	/* /proc cell list link */
+	struct hlist_node	proc_link;	/* /proc cell list link */
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
diff --git a/fs/afs/main.c b/fs/afs/main.c
index e84fe822a960..107427688edd 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -87,7 +87,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	timer_setup(&net->cells_timer, afs_cells_timer, 0);
 
 	mutex_init(&net->proc_cells_lock);
-	INIT_LIST_HEAD(&net->proc_cells);
+	INIT_HLIST_HEAD(&net->proc_cells);
 
 	seqlock_init(&net->fs_lock);
 	net->fs_servers = RB_ROOT;
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 476dcbb79713..9101f62707af 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -33,9 +33,8 @@ static inline struct afs_net *afs_seq2net_single(struct seq_file *m)
 static int afs_proc_cells_show(struct seq_file *m, void *v)
 {
 	struct afs_cell *cell = list_entry(v, struct afs_cell, proc_link);
-	struct afs_net *net = afs_seq2net(m);
 
-	if (v == &net->proc_cells) {
+	if (v == SEQ_START_TOKEN) {
 		/* display header on line 1 */
 		seq_puts(m, "USE NAME\n");
 		return 0;
@@ -50,12 +49,12 @@ static void *afs_proc_cells_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
 	rcu_read_lock();
-	return seq_list_start_head(&afs_seq2net(m)->proc_cells, *_pos);
+	return seq_hlist_start_head_rcu(&afs_seq2net(m)->proc_cells, *_pos);
 }
 
 static void *afs_proc_cells_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	return seq_list_next(v, &afs_seq2net(m)->proc_cells, pos);
+	return seq_hlist_next_rcu(v, &afs_seq2net(m)->proc_cells, pos);
 }
 
 static void afs_proc_cells_stop(struct seq_file *m, void *v)

