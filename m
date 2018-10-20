Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255F7ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6117B214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6117B214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJTJUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:20:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:20:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 170A930B931A;
        Sat, 20 Oct 2018 01:11:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 993CD5B83F;
        Sat, 20 Oct 2018 01:11:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/24] afs: Implement VL server rotation
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:11:28 +0100
Message-ID: <153999788879.866.182719434826058106.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sat, 20 Oct 2018 01:11:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track VL servers as independent entities rather than lumping all their
addresses together into one set and implement server-level rotation by:

 (1) Add the concept of a VL server list, where each server has its own
     separate address list.  This code is similar to the FS server list.

 (2) Use the DNS resolver to retrieve a set of servers and their associated
     addresses, ports, preference and weight ratings.

 (3) In the case of a legacy DNS resolver or an address list given directly
     through /proc/net/afs/cells, create a list containing just a dummy
     server record and attach all the addresses to that.

 (4) Implement a simple rotation policy, for the moment ignoring the
     priorities and weights assigned to the servers.

 (5) Show the address list through /proc/net/afs/<cell>/vlservers.  This
     also displays the source and status of the data as indicated by the
     upcall.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Makefile    |    2 
 fs/afs/addr_list.c |  163 +++++++++++++------------
 fs/afs/cell.c      |   39 +++---
 fs/afs/dynroot.c   |    2 
 fs/afs/internal.h  |  114 ++++++++++++++++--
 fs/afs/proc.c      |   90 +++++++++++---
 fs/afs/server.c    |   42 ++-----
 fs/afs/vl_list.c   |  336 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/vl_rotate.c |  251 +++++++++++++++++++++++++++++++++++++++
 fs/afs/vlclient.c  |   32 ++---
 fs/afs/volume.c    |   52 ++------
 11 files changed, 905 insertions(+), 218 deletions(-)
 create mode 100644 fs/afs/vl_list.c
 create mode 100644 fs/afs/vl_rotate.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 546874057bd3..03e9f7afea1b 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -29,6 +29,8 @@ kafs-y := \
 	super.o \
 	netdevices.o \
 	vlclient.o \
+	vl_rotate.o \
+	vl_list.o \
 	volume.o \
 	write.o \
 	xattr.o
diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 7b34fad4f8f5..3f60b4012587 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -64,19 +64,25 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr,
 /*
  * Parse a text string consisting of delimited addresses.
  */
-struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
-					   char delim,
-					   unsigned short service,
-					   unsigned short port)
+struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
+					       const char *text, size_t len,
+					       char delim,
+					       unsigned short service,
+					       unsigned short port)
 {
+	struct afs_vlserver_list *vllist;
 	struct afs_addr_list *alist;
 	const char *p, *end = text + len;
+	const char *problem;
 	unsigned int nr = 0;
+	int ret = -ENOMEM;
 
 	_enter("%*.*s,%c", (int)len, (int)len, text, delim);
 
-	if (!len)
+	if (!len) {
+		_leave(" = -EDESTADDRREQ [empty]");
 		return ERR_PTR(-EDESTADDRREQ);
+	}
 
 	if (delim == ':' && (memchr(text, ',', len) || !memchr(text, '.', len)))
 		delim = ',';
@@ -84,18 +90,24 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 	/* Count the addresses */
 	p = text;
 	do {
-		if (!*p)
-			return ERR_PTR(-EINVAL);
+		if (!*p) {
+			problem = "nul";
+			goto inval;
+		}
 		if (*p == delim)
 			continue;
 		nr++;
 		if (*p == '[') {
 			p++;
-			if (p == end)
-				return ERR_PTR(-EINVAL);
+			if (p == end) {
+				problem = "brace1";
+				goto inval;
+			}
 			p = memchr(p, ']', end - p);
-			if (!p)
-				return ERR_PTR(-EINVAL);
+			if (!p) {
+				problem = "brace2";
+				goto inval;
+			}
 			p++;
 			if (p >= end)
 				break;
@@ -109,10 +121,19 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 
 	_debug("%u/%u addresses", nr, AFS_MAX_ADDRESSES);
 
-	alist = afs_alloc_addrlist(nr, service, port);
-	if (!alist)
+	vllist = afs_alloc_vlserver_list(1);
+	if (!vllist)
 		return ERR_PTR(-ENOMEM);
 
+	vllist->nr_servers = 1;
+	vllist->servers[0].server = afs_alloc_vlserver("<dummy>", 7, AFS_VL_PORT);
+	if (!vllist->servers[0].server)
+		goto error_vl;
+
+	alist = afs_alloc_addrlist(nr, service, AFS_VL_PORT);
+	if (!alist)
+		goto error;
+
 	/* Extract the addresses */
 	p = text;
 	do {
@@ -135,17 +156,21 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 					break;
 		}
 
-		if (in4_pton(p, q - p, (u8 *)&x[0], -1, &stop))
+		if (in4_pton(p, q - p, (u8 *)&x[0], -1, &stop)) {
 			family = AF_INET;
-		else if (in6_pton(p, q - p, (u8 *)x, -1, &stop))
+		} else if (in6_pton(p, q - p, (u8 *)x, -1, &stop)) {
 			family = AF_INET6;
-		else
+		} else {
+			problem = "family";
 			goto bad_address;
+		}
 
-		if (stop != q)
+		p = q;
+		if (stop != p) {
+			problem = "nostop";
 			goto bad_address;
+		}
 
-		p = q;
 		if (q < end && *q == ']')
 			p++;
 
@@ -154,18 +179,23 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 				/* Port number specification "+1234" */
 				xport = 0;
 				p++;
-				if (p >= end || !isdigit(*p))
+				if (p >= end || !isdigit(*p)) {
+					problem = "port";
 					goto bad_address;
+				}
 				do {
 					xport *= 10;
 					xport += *p - '0';
-					if (xport > 65535)
+					if (xport > 65535) {
+						problem = "pval";
 						goto bad_address;
+					}
 					p++;
 				} while (p < end && isdigit(*p));
 			} else if (*p == delim) {
 				p++;
 			} else {
+				problem = "weird";
 				goto bad_address;
 			}
 		}
@@ -177,12 +207,23 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 
 	} while (p < end);
 
+	rcu_assign_pointer(vllist->servers[0].server->addresses, alist);
 	_leave(" = [nr %u]", alist->nr_addrs);
-	return alist;
+	return vllist;
 
-bad_address:
-	kfree(alist);
+inval:
+	_leave(" = -EINVAL [%s %zu %*.*s]",
+	       problem, p - text, (int)len, (int)len, text);
 	return ERR_PTR(-EINVAL);
+bad_address:
+	_leave(" = -EINVAL [%s %zu %*.*s]",
+	       problem, p - text, (int)len, (int)len, text);
+	ret = -EINVAL;
+error:
+	afs_put_addrlist(alist);
+error_vl:
+	afs_put_vlserverlist(net, vllist);
+	return ERR_PTR(ret);
 }
 
 /*
@@ -201,30 +242,34 @@ static int afs_cmp_addr_list(const struct afs_addr_list *a1,
 /*
  * Perform a DNS query for VL servers and build a up an address list.
  */
-struct afs_addr_list *afs_dns_query(struct afs_cell *cell, time64_t *_expiry)
+struct afs_vlserver_list *afs_dns_query(struct afs_cell *cell, time64_t *_expiry)
 {
-	struct afs_addr_list *alist;
-	char *vllist = NULL;
+	struct afs_vlserver_list *vllist;
+	char *result = NULL;
 	int ret;
 
 	_enter("%s", cell->name);
 
-	ret = dns_query("afsdb", cell->name, cell->name_len,
-			"", &vllist, _expiry);
-	if (ret < 0)
+	ret = dns_query("afsdb", cell->name, cell->name_len, "srv=1",
+			&result, _expiry);
+	if (ret < 0) {
+		_leave(" = %d [dns]", ret);
 		return ERR_PTR(ret);
-
-	alist = afs_parse_text_addrs(vllist, strlen(vllist), ',',
-				     VL_SERVICE, AFS_VL_PORT);
-	if (IS_ERR(alist)) {
-		kfree(vllist);
-		if (alist != ERR_PTR(-ENOMEM))
-			pr_err("Failed to parse DNS data\n");
-		return alist;
 	}
 
-	kfree(vllist);
-	return alist;
+	if (*_expiry == 0)
+		*_expiry = ktime_get_real_seconds() + 60;
+
+	if (ret > 1 && result[0] == 0)
+		vllist = afs_extract_vlserver_list(cell, result, ret);
+	else
+		vllist = afs_parse_text_addrs(cell->net, result, ret, ',',
+					      VL_SERVICE, AFS_VL_PORT);
+	kfree(result);
+	if (IS_ERR(vllist) && vllist != ERR_PTR(-ENOMEM))
+		pr_err("Failed to parse DNS data %ld\n", PTR_ERR(vllist));
+
+	return vllist;
 }
 
 /*
@@ -347,43 +392,3 @@ int afs_end_cursor(struct afs_addr_cursor *ac)
 	ac->begun = false;
 	return ac->error;
 }
-
-/*
- * Set the address cursor for iterating over VL servers.
- */
-int afs_set_vl_cursor(struct afs_addr_cursor *ac, struct afs_cell *cell)
-{
-	struct afs_addr_list *alist;
-	int ret;
-
-	if (!rcu_access_pointer(cell->vl_addrs)) {
-		ret = wait_on_bit(&cell->flags, AFS_CELL_FL_NO_LOOKUP_YET,
-				  TASK_INTERRUPTIBLE);
-		if (ret < 0)
-			return ret;
-
-		if (!rcu_access_pointer(cell->vl_addrs) &&
-		    ktime_get_real_seconds() < cell->dns_expiry)
-			return cell->error;
-	}
-
-	read_lock(&cell->vl_addrs_lock);
-	alist = rcu_dereference_protected(cell->vl_addrs,
-					  lockdep_is_held(&cell->vl_addrs_lock));
-	if (alist->nr_addrs > 0)
-		afs_get_addrlist(alist);
-	else
-		alist = NULL;
-	read_unlock(&cell->vl_addrs_lock);
-
-	if (!alist)
-		return -EDESTADDRREQ;
-
-	ac->alist = alist;
-	ac->addr = NULL;
-	ac->start = READ_ONCE(alist->index);
-	ac->index = ac->start;
-	ac->error = 0;
-	ac->begun = false;
-	return 0;
-}
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 6127f0fcd62c..963b6fa51fdf 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -119,7 +119,7 @@ struct afs_cell *afs_lookup_cell_rcu(struct afs_net *net,
  */
 static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 				       const char *name, unsigned int namelen,
-				       const char *vllist)
+				       const char *addresses)
 {
 	struct afs_cell *cell;
 	int i, ret;
@@ -134,7 +134,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	if (namelen == 5 && memcmp(name, "@cell", 5) == 0)
 		return ERR_PTR(-EINVAL);
 
-	_enter("%*.*s,%s", namelen, namelen, name, vllist);
+	_enter("%*.*s,%s", namelen, namelen, name, addresses);
 
 	cell = kzalloc(sizeof(struct afs_cell), GFP_KERNEL);
 	if (!cell) {
@@ -153,22 +153,23 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		       (1 << AFS_CELL_FL_NO_LOOKUP_YET));
 	INIT_LIST_HEAD(&cell->proc_volumes);
 	rwlock_init(&cell->proc_lock);
-	rwlock_init(&cell->vl_addrs_lock);
+	rwlock_init(&cell->vl_servers_lock);
 
 	/* Fill in the VL server list if we were given a list of addresses to
 	 * use.
 	 */
-	if (vllist) {
-		struct afs_addr_list *alist;
-
-		alist = afs_parse_text_addrs(vllist, strlen(vllist), ':',
-					     VL_SERVICE, AFS_VL_PORT);
-		if (IS_ERR(alist)) {
-			ret = PTR_ERR(alist);
+	if (addresses) {
+		struct afs_vlserver_list *vllist;
+
+		vllist = afs_parse_text_addrs(net,
+					      addresses, strlen(addresses), ':',
+					      VL_SERVICE, AFS_VL_PORT);
+		if (IS_ERR(vllist)) {
+			ret = PTR_ERR(vllist);
 			goto parse_failed;
 		}
 
-		rcu_assign_pointer(cell->vl_addrs, alist);
+		rcu_assign_pointer(cell->vl_servers, vllist);
 		cell->dns_expiry = TIME64_MAX;
 	}
 
@@ -356,14 +357,14 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
  */
 static void afs_update_cell(struct afs_cell *cell)
 {
-	struct afs_addr_list *alist, *old;
+	struct afs_vlserver_list *vllist, *old;
 	time64_t now, expiry;
 
 	_enter("%s", cell->name);
 
-	alist = afs_dns_query(cell, &expiry);
-	if (IS_ERR(alist)) {
-		switch (PTR_ERR(alist)) {
+	vllist = afs_dns_query(cell, &expiry);
+	if (IS_ERR(vllist)) {
+		switch (PTR_ERR(vllist)) {
 		case -ENODATA:
 			/* The DNS said that the cell does not exist */
 			set_bit(AFS_CELL_FL_NOT_FOUND, &cell->flags);
@@ -387,12 +388,12 @@ static void afs_update_cell(struct afs_cell *cell)
 		/* Exclusion on changing vl_addrs is achieved by a
 		 * non-reentrant work item.
 		 */
-		old = rcu_dereference_protected(cell->vl_addrs, true);
-		rcu_assign_pointer(cell->vl_addrs, alist);
+		old = rcu_dereference_protected(cell->vl_servers, true);
+		rcu_assign_pointer(cell->vl_servers, vllist);
 		cell->dns_expiry = expiry;
 
 		if (old)
-			afs_put_addrlist(old);
+			afs_put_vlserverlist(cell->net, old);
 	}
 
 	if (test_and_clear_bit(AFS_CELL_FL_NO_LOOKUP_YET, &cell->flags))
@@ -414,7 +415,7 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 
 	ASSERTCMP(atomic_read(&cell->usage), ==, 0);
 
-	afs_put_addrlist(rcu_access_pointer(cell->vl_addrs));
+	afs_put_vlserverlist(cell->net, rcu_access_pointer(cell->vl_servers));
 	key_put(cell->anonymous_key);
 	kfree(cell);
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index f29c6dade7f6..0efed0a63080 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -46,7 +46,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
 		return 0;
 	}
 
-	ret = dns_query("afsdb", name, len, "", NULL, NULL);
+	ret = dns_query("afsdb", name, len, "srv=1", NULL, NULL);
 	if (ret == -ENODATA)
 		ret = -EDESTADDRREQ;
 	return ret;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 81936a4d5035..7e264cb9b4f7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -22,6 +22,7 @@
 #include <linux/backing-dev.h>
 #include <linux/uuid.h>
 #include <linux/mm_types.h>
+#include <linux/dns_resolver.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
@@ -77,6 +78,8 @@ struct afs_addr_list {
 	unsigned char		nr_addrs;
 	unsigned char		index;		/* Address currently in use */
 	unsigned char		nr_ipv4;	/* Number of IPv4 addresses */
+	enum dns_record_source	source:8;
+	enum dns_lookup_status	status:8;
 	unsigned long		probed;		/* Mask of servers that have been probed */
 	unsigned long		yfs;		/* Mask of servers that are YFS */
 	struct sockaddr_rxrpc	addrs[];
@@ -355,12 +358,51 @@ struct afs_cell {
 	rwlock_t		proc_lock;
 
 	/* VL server list. */
-	rwlock_t		vl_addrs_lock;	/* Lock on vl_addrs */
-	struct afs_addr_list	__rcu *vl_addrs; /* List of VL servers */
+	rwlock_t		vl_servers_lock; /* Lock on vl_servers */
+	struct afs_vlserver_list __rcu *vl_servers;
+
 	u8			name_len;	/* Length of name */
 	char			name[64 + 1];	/* Cell name, case-flattened and NUL-padded */
 };
 
+/*
+ * Volume Location server record.
+ */
+struct afs_vlserver {
+	struct rcu_head		rcu;
+	struct afs_addr_list	__rcu *addresses; /* List of addresses for this VL server */
+	unsigned long		flags;
+#define AFS_VLSERVER_FL_PROBED	0		/* The VL server has been probed */
+#define AFS_VLSERVER_FL_PROBING	1		/* VL server is being probed */
+	rwlock_t		lock;		/* Lock on addresses */
+	atomic_t		usage;
+	u16			name_len;	/* Length of name */
+	u16			port;
+	char			name[];		/* Server name, case-flattened */
+};
+
+/*
+ * Weighted list of Volume Location servers.
+ */
+struct afs_vlserver_entry {
+	u16			priority;	/* Preference (as SRV) */
+	u16			weight;		/* Weight (as SRV) */
+	enum dns_record_source	source:8;
+	enum dns_lookup_status	status:8;
+	struct afs_vlserver	*server;
+};
+
+struct afs_vlserver_list {
+	struct rcu_head		rcu;
+	atomic_t		usage;
+	u8			nr_servers;
+	u8			index;		/* Server currently in use */
+	enum dns_record_source	source:8;
+	enum dns_lookup_status	status:8;
+	rwlock_t		lock;
+	struct afs_vlserver_entry servers[];
+};
+
 /*
  * Cached VLDB entry.
  *
@@ -616,6 +658,23 @@ struct afs_addr_cursor {
 	bool			responded;	/* T if the current address responded */
 };
 
+/*
+ * Cursor for iterating over a set of volume location servers.
+ */
+struct afs_vl_cursor {
+	struct afs_addr_cursor	ac;
+	struct afs_cell		*cell;		/* The cell we're querying */
+	struct afs_vlserver_list *server_list;	/* Current server list (pins ref) */
+	struct key		*key;		/* Key for the server */
+	unsigned char		start;		/* Initial index in server list */
+	unsigned char		index;		/* Number of servers tried beyond start */
+	short			error;
+	unsigned short		flags;
+#define AFS_VL_CURSOR_STOP	0x0001		/* Set to cease iteration */
+#define AFS_VL_CURSOR_RETRY	0x0002		/* Set to do a retry */
+#define AFS_VL_CURSOR_RETRIED	0x0004		/* Set if started a retry */
+};
+
 /*
  * Cursor for iterating over a set of fileservers.
  */
@@ -662,12 +721,12 @@ extern struct afs_addr_list *afs_alloc_addrlist(unsigned int,
 						unsigned short,
 						unsigned short);
 extern void afs_put_addrlist(struct afs_addr_list *);
-extern struct afs_addr_list *afs_parse_text_addrs(const char *, size_t, char,
-						  unsigned short, unsigned short);
-extern struct afs_addr_list *afs_dns_query(struct afs_cell *, time64_t *);
+extern struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *,
+						      const char *, size_t, char,
+						      unsigned short, unsigned short);
+extern struct afs_vlserver_list *afs_dns_query(struct afs_cell *, time64_t *);
 extern bool afs_iterate_addresses(struct afs_addr_cursor *);
 extern int afs_end_cursor(struct afs_addr_cursor *);
-extern int afs_set_vl_cursor(struct afs_addr_cursor *, struct afs_cell *);
 
 extern void afs_merge_fs_addr4(struct afs_addr_list *, __be32, u16);
 extern void afs_merge_fs_addr6(struct afs_addr_list *, __be32 *, u16);
@@ -1088,14 +1147,43 @@ extern void afs_fs_exit(void);
 /*
  * vlclient.c
  */
-extern struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_net *,
-							 struct afs_addr_cursor *,
-							 struct key *, const char *, int);
-extern struct afs_addr_list *afs_vl_get_addrs_u(struct afs_net *, struct afs_addr_cursor *,
-						struct key *, const uuid_t *);
+extern struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *,
+							 const char *, int);
+extern struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *, const uuid_t *);
 extern int afs_vl_get_capabilities(struct afs_net *, struct afs_addr_cursor *, struct key *);
-extern struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_net *, struct afs_addr_cursor *,
-						     struct key *, const uuid_t *);
+extern struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *, const uuid_t *);
+
+/*
+ * vl_rotate.c
+ */
+extern bool afs_begin_vlserver_operation(struct afs_vl_cursor *,
+					 struct afs_cell *, struct key *);
+extern bool afs_select_vlserver(struct afs_vl_cursor *);
+extern bool afs_select_current_vlserver(struct afs_vl_cursor *);
+extern int afs_end_vlserver_operation(struct afs_vl_cursor *);
+
+/*
+ * vlserver_list.c
+ */
+static inline struct afs_vlserver *afs_get_vlserver(struct afs_vlserver *vlserver)
+{
+	atomic_inc(&vlserver->usage);
+	return vlserver;
+}
+
+static inline struct afs_vlserver_list *afs_get_vlserverlist(struct afs_vlserver_list *vllist)
+{
+	if (vllist)
+		atomic_inc(&vllist->usage);
+	return vllist;
+}
+
+extern struct afs_vlserver *afs_alloc_vlserver(const char *, size_t, unsigned short);
+extern void afs_put_vlserver(struct afs_net *, struct afs_vlserver *);
+extern struct afs_vlserver_list *afs_alloc_vlserver_list(unsigned int);
+extern void afs_put_vlserverlist(struct afs_net *, struct afs_vlserver_list *);
+extern struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *,
+							   const void *, size_t);
 
 /*
  * volume.c
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 9101f62707af..6585f4bec0d3 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -17,6 +17,11 @@
 #include <linux/uaccess.h>
 #include "internal.h"
 
+struct afs_vl_seq_net_private {
+	struct seq_net_private		seq;	/* Must be first */
+	struct afs_vlserver_list	*vllist;
+};
+
 static inline struct afs_net *afs_seq2net(struct seq_file *m)
 {
 	return afs_net(seq_file_net(m));
@@ -247,61 +252,102 @@ static const struct seq_operations afs_proc_cell_volumes_ops = {
 	.show	= afs_proc_cell_volumes_show,
 };
 
+static const char *const dns_record_sources[NR__dns_record_source + 1] = {
+	[DNS_RECORD_UNAVAILABLE]	= "unav",
+	[DNS_RECORD_FROM_CONFIG]	= "cfg",
+	[DNS_RECORD_FROM_DNS_A]		= "A",
+	[DNS_RECORD_FROM_DNS_AFSDB]	= "AFSDB",
+	[DNS_RECORD_FROM_DNS_SRV]	= "SRV",
+	[DNS_RECORD_FROM_NSS]		= "nss",
+	[NR__dns_record_source]		= "[weird]"
+};
+
+static const char *const dns_lookup_statuses[NR__dns_lookup_status + 1] = {
+	[DNS_LOOKUP_NOT_DONE]		= "no-lookup",
+	[DNS_LOOKUP_GOOD]		= "good",
+	[DNS_LOOKUP_GOOD_WITH_BAD]	= "good/bad",
+	[DNS_LOOKUP_BAD]		= "bad",
+	[DNS_LOOKUP_GOT_NOT_FOUND]	= "not-found",
+	[DNS_LOOKUP_GOT_LOCAL_FAILURE]	= "local-failure",
+	[DNS_LOOKUP_GOT_TEMP_FAILURE]	= "temp-failure",
+	[DNS_LOOKUP_GOT_NS_FAILURE]	= "ns-failure",
+	[NR__dns_lookup_status]		= "[weird]"
+};
+
 /*
  * Display the list of Volume Location servers we're using for a cell.
  */
 static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 {
-	struct sockaddr_rxrpc *addr = v;
+	const struct afs_vl_seq_net_private *priv = m->private;
+	const struct afs_vlserver_list *vllist = priv->vllist;
+	const struct afs_vlserver_entry *entry;
+	const struct afs_vlserver *vlserver;
+	const struct afs_addr_list *alist;
+	int i;
 
-	/* display header on line 1 */
-	if (v == (void *)1) {
-		seq_puts(m, "ADDRESS\n");
+	if (v == SEQ_START_TOKEN) {
+		seq_printf(m, "# source %s, status %s\n",
+			   dns_record_sources[vllist->source],
+			   dns_lookup_statuses[vllist->status]);
 		return 0;
 	}
 
-	/* display one cell per line on subsequent lines */
-	seq_printf(m, "%pISp\n", &addr->transport);
+	entry = v;
+	vlserver = entry->server;
+	alist = rcu_dereference(vlserver->addresses);
+
+	seq_printf(m, "%s [p=%hu w=%hu s=%s,%s]:\n",
+		   vlserver->name, entry->priority, entry->weight,
+		   dns_record_sources[alist ? alist->source : entry->source],
+		   dns_lookup_statuses[alist ? alist->status : entry->status]);
+	if (alist) {
+		for (i = 0; i < alist->nr_addrs; i++)
+			seq_printf(m, " %c %pISpc\n",
+				   alist->index == i ? '>' : '-',
+				   &alist->addrs[i].transport);
+	}
 	return 0;
 }
 
 static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
-	struct afs_addr_list *alist;
+	struct afs_vl_seq_net_private *priv = m->private;
+	struct afs_vlserver_list *vllist;
 	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
 	loff_t pos = *_pos;
 
 	rcu_read_lock();
 
-	alist = rcu_dereference(cell->vl_addrs);
+	vllist = rcu_dereference(cell->vl_servers);
+	priv->vllist = vllist;
 
-	/* allow for the header line */
-	if (!pos)
-		return (void *) 1;
-	pos--;
+	if (pos < 0)
+		*_pos = pos = 0;
+	if (pos == 0)
+		return SEQ_START_TOKEN;
 
-	if (!alist || pos >= alist->nr_addrs)
+	if (!vllist || pos - 1 >= vllist->nr_servers)
 		return NULL;
 
-	return alist->addrs + pos;
+	return &vllist->servers[pos - 1];
 }
 
 static void *afs_proc_cell_vlservers_next(struct seq_file *m, void *v,
 					  loff_t *_pos)
 {
-	struct afs_addr_list *alist;
-	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
+	struct afs_vl_seq_net_private *priv = m->private;
+	struct afs_vlserver_list *vllist = priv->vllist;
 	loff_t pos;
 
-	alist = rcu_dereference(cell->vl_addrs);
-
 	pos = *_pos;
-	(*_pos)++;
-	if (!alist || pos >= alist->nr_addrs)
+	pos++;
+	*_pos = pos;
+	if (!vllist || pos - 1 >= vllist->nr_servers)
 		return NULL;
 
-	return alist->addrs + pos;
+	return &vllist->servers[pos - 1];
 }
 
 static void afs_proc_cell_vlservers_stop(struct seq_file *m, void *v)
@@ -562,7 +608,7 @@ int afs_proc_cell_setup(struct afs_cell *cell)
 
 	if (!proc_create_net_data("vlservers", 0444, dir,
 				  &afs_proc_cell_vlservers_ops,
-				  sizeof(struct seq_net_private),
+				  sizeof(struct afs_vl_seq_net_private),
 				  cell) ||
 	    !proc_create_net_data("volumes", 0444, dir,
 				  &afs_proc_cell_volumes_ops,
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 1d329e6981d5..6102ea9ee3fb 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -246,41 +246,23 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_cell *cell,
 						 struct key *key, const uuid_t *uuid)
 {
-	struct afs_addr_cursor ac;
-	struct afs_addr_list *alist;
+	struct afs_vl_cursor vc;
+	struct afs_addr_list *alist = NULL;
 	int ret;
 
-	ret = afs_set_vl_cursor(&ac, cell);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
-	while (afs_iterate_addresses(&ac)) {
-		if (test_bit(ac.index, &ac.alist->yfs))
-			alist = afs_yfsvl_get_endpoints(cell->net, &ac, key, uuid);
-		else
-			alist = afs_vl_get_addrs_u(cell->net, &ac, key, uuid);
-		switch (ac.error) {
-		case 0:
-			afs_end_cursor(&ac);
-			return alist;
-		case -ECONNABORTED:
-			ac.error = afs_abort_to_error(ac.abort_code);
-			goto error;
-		case -ENOMEM:
-		case -ENONET:
-			goto error;
-		case -ENETUNREACH:
-		case -EHOSTUNREACH:
-		case -ECONNREFUSED:
-			break;
-		default:
-			ac.error = -EIO;
-			goto error;
+	ret = -ERESTARTSYS;
+	if (afs_begin_vlserver_operation(&vc, cell, key)) {
+		while (afs_select_vlserver(&vc)) {
+			if (test_bit(vc.ac.index, &vc.ac.alist->yfs))
+				alist = afs_yfsvl_get_endpoints(&vc, uuid);
+			else
+				alist = afs_vl_get_addrs_u(&vc, uuid);
 		}
+
+		ret = afs_end_vlserver_operation(&vc);
 	}
 
-error:
-	return ERR_PTR(afs_end_cursor(&ac));
+	return ret < 0 ? ERR_PTR(ret) : alist;
 }
 
 /*
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
new file mode 100644
index 000000000000..c1e316ba105a
--- /dev/null
+++ b/fs/afs/vl_list.c
@@ -0,0 +1,336 @@
+/* AFS vlserver list management.
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+struct afs_vlserver *afs_alloc_vlserver(const char *name, size_t name_len,
+					unsigned short port)
+{
+	struct afs_vlserver *vlserver;
+
+	vlserver = kzalloc(struct_size(vlserver, name, name_len + 1),
+			   GFP_KERNEL);
+	if (vlserver) {
+		atomic_set(&vlserver->usage, 1);
+		rwlock_init(&vlserver->lock);
+		vlserver->name_len = name_len;
+		vlserver->port = port;
+		memcpy(vlserver->name, name, name_len);
+	}
+	return vlserver;
+}
+
+static void afs_vlserver_rcu(struct rcu_head *rcu)
+{
+	struct afs_vlserver *vlserver = container_of(rcu, struct afs_vlserver, rcu);
+
+	afs_put_addrlist(rcu_access_pointer(vlserver->addresses));
+	kfree_rcu(vlserver, rcu);
+}
+
+void afs_put_vlserver(struct afs_net *net, struct afs_vlserver *vlserver)
+{
+	if (vlserver) {
+		unsigned int u = atomic_dec_return(&vlserver->usage);
+		//_debug("VL PUT %p{%u}", vlserver, u);
+
+		if (u == 0)
+			call_rcu(&vlserver->rcu, afs_vlserver_rcu);
+	}
+}
+
+struct afs_vlserver_list *afs_alloc_vlserver_list(unsigned int nr_servers)
+{
+	struct afs_vlserver_list *vllist;
+
+	vllist = kzalloc(struct_size(vllist, servers, nr_servers), GFP_KERNEL);
+	if (vllist) {
+		atomic_set(&vllist->usage, 1);
+		rwlock_init(&vllist->lock);
+	}
+
+	return vllist;
+}
+
+void afs_put_vlserverlist(struct afs_net *net, struct afs_vlserver_list *vllist)
+{
+	if (vllist) {
+		unsigned int u = atomic_dec_return(&vllist->usage);
+
+		//_debug("VLLS PUT %p{%u}", vllist, u);
+		if (u == 0) {
+			int i;
+
+			for (i = 0; i < vllist->nr_servers; i++) {
+				afs_put_vlserver(net, vllist->servers[i].server);
+			}
+			kfree_rcu(vllist, rcu);
+		}
+	}
+}
+
+static u16 afs_extract_le16(const u8 **_b)
+{
+	u16 val;
+
+	val  = (u16)*(*_b)++ << 0;
+	val |= (u16)*(*_b)++ << 8;
+	return val;
+}
+
+/*
+ * Build a VL server address list from a DNS queried server list.
+ */
+static struct afs_addr_list *afs_extract_vl_addrs(const u8 **_b, const u8 *end,
+						  u8 nr_addrs, u16 port)
+{
+	struct afs_addr_list *alist;
+	const u8 *b = *_b;
+	int ret = -EINVAL;
+
+	alist = afs_alloc_addrlist(nr_addrs, VL_SERVICE, port);
+	if (!alist)
+		return ERR_PTR(-ENOMEM);
+	if (nr_addrs == 0)
+		return alist;
+
+	for (; nr_addrs > 0 && end - b >= nr_addrs; nr_addrs--) {
+		struct dns_server_list_v1_address hdr;
+		__be32 x[4];
+
+		hdr.address_type = *b++;
+
+		switch (hdr.address_type) {
+		case DNS_ADDRESS_IS_IPV4:
+			if (end - b < 4) {
+				_leave(" = -EINVAL [short inet]");
+				goto error;
+			}
+			memcpy(x, b, 4);
+			afs_merge_fs_addr4(alist, x[0], port);
+			b += 4;
+			break;
+
+		case DNS_ADDRESS_IS_IPV6:
+			if (end - b < 16) {
+				_leave(" = -EINVAL [short inet6]");
+				goto error;
+			}
+			memcpy(x, b, 16);
+			afs_merge_fs_addr6(alist, x, port);
+			b += 16;
+			break;
+
+		default:
+			_leave(" = -EADDRNOTAVAIL [unknown af %u]",
+			       hdr.address_type);
+			ret = -EADDRNOTAVAIL;
+			goto error;
+		}
+	}
+
+	/* Start with IPv6 if available. */
+	if (alist->nr_ipv4 < alist->nr_addrs)
+		alist->index = alist->nr_ipv4;
+
+	*_b = b;
+	return alist;
+
+error:
+	*_b = b;
+	afs_put_addrlist(alist);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Build a VL server list from a DNS queried server list.
+ */
+struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
+						    const void *buffer,
+						    size_t buffer_size)
+{
+	const struct dns_server_list_v1_header *hdr = buffer;
+	struct dns_server_list_v1_server bs;
+	struct afs_vlserver_list *vllist, *previous;
+	struct afs_addr_list *addrs;
+	struct afs_vlserver *server;
+	const u8 *b = buffer, *end = buffer + buffer_size;
+	int ret = -ENOMEM, nr_servers, i, j;
+
+	_enter("");
+
+	/* Check that it's a server list, v1 */
+	if (end - b < sizeof(*hdr) ||
+	    hdr->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST ||
+	    hdr->hdr.version != 1) {
+		pr_notice("kAFS: Got DNS record [%u,%u] len %zu\n",
+			  hdr->hdr.content, hdr->hdr.version, end - b);
+		ret = -EDESTADDRREQ;
+		goto dump;
+	}
+
+	nr_servers = hdr->nr_servers;
+
+	vllist = afs_alloc_vlserver_list(nr_servers);
+	if (!vllist)
+		return ERR_PTR(-ENOMEM);
+
+	vllist->source = (hdr->source < NR__dns_record_source) ?
+		hdr->source : NR__dns_record_source;
+	vllist->status = (hdr->status < NR__dns_lookup_status) ?
+		hdr->status : NR__dns_lookup_status;
+
+	read_lock(&cell->vl_servers_lock);
+	previous = afs_get_vlserverlist(
+		rcu_dereference_protected(cell->vl_servers,
+					  lockdep_is_held(&cell->vl_servers_lock)));
+	read_unlock(&cell->vl_servers_lock);
+
+	b += sizeof(*hdr);
+	while (end - b >= sizeof(bs)) {
+		bs.name_len	= afs_extract_le16(&b);
+		bs.priority	= afs_extract_le16(&b);
+		bs.weight	= afs_extract_le16(&b);
+		bs.port		= afs_extract_le16(&b);
+		bs.source	= *b++;
+		bs.status	= *b++;
+		bs.protocol	= *b++;
+		bs.nr_addrs	= *b++;
+
+		_debug("extract %u %u %u %u %u %u %*.*s",
+		       bs.name_len, bs.priority, bs.weight,
+		       bs.port, bs.protocol, bs.nr_addrs,
+		       bs.name_len, bs.name_len, b);
+
+		if (end - b < bs.name_len)
+			break;
+
+		ret = -EPROTONOSUPPORT;
+		if (bs.protocol == DNS_SERVER_PROTOCOL_UNSPECIFIED) {
+			bs.protocol = DNS_SERVER_PROTOCOL_UDP;
+		} else if (bs.protocol != DNS_SERVER_PROTOCOL_UDP) {
+			_leave(" = [proto %u]", bs.protocol);
+			goto error;
+		}
+
+		if (bs.port == 0)
+			bs.port = AFS_VL_PORT;
+		if (bs.source > NR__dns_record_source)
+			bs.source = NR__dns_record_source;
+		if (bs.status > NR__dns_lookup_status)
+			bs.status = NR__dns_lookup_status;
+
+		server = NULL;
+		if (previous) {
+			/* See if we can update an old server record */
+			for (i = 0; i < previous->nr_servers; i++) {
+				struct afs_vlserver *p = previous->servers[i].server;
+
+				if (p->name_len == bs.name_len &&
+				    p->port == bs.port &&
+				    strncasecmp(b, p->name, bs.name_len) == 0) {
+					server = afs_get_vlserver(p);
+					break;
+				}
+			}
+		}
+
+		if (!server) {
+			ret = -ENOMEM;
+			server = afs_alloc_vlserver(b, bs.name_len, bs.port);
+			if (!server)
+				goto error;
+		}
+
+		b += bs.name_len;
+
+		/* Extract the addresses - note that we can't skip this as we
+		 * have to advance the payload pointer.
+		 */
+		addrs = afs_extract_vl_addrs(&b, end, bs.nr_addrs, bs.port);
+		if (IS_ERR(addrs)) {
+			ret = PTR_ERR(addrs);
+			goto error_2;
+		}
+
+		if (vllist->nr_servers >= nr_servers) {
+			_debug("skip %u >= %u", vllist->nr_servers, nr_servers);
+			afs_put_addrlist(addrs);
+			afs_put_vlserver(cell->net, server);
+			continue;
+		}
+
+		addrs->source = bs.source;
+		addrs->status = bs.status;
+
+		if (addrs->nr_addrs == 0) {
+			afs_put_addrlist(addrs);
+			if (!rcu_access_pointer(server->addresses)) {
+				afs_put_vlserver(cell->net, server);
+				continue;
+			}
+		} else {
+			struct afs_addr_list *old = addrs;
+
+			write_lock(&server->lock);
+			rcu_swap_protected(server->addresses, old,
+					   lockdep_is_held(&server->lock));
+			write_unlock(&server->lock);
+			afs_put_addrlist(old);
+		}
+
+
+		/* TODO: Might want to check for duplicates */
+
+		/* Insertion-sort by priority and weight */
+		for (j = 0; j < vllist->nr_servers; j++) {
+			if (bs.priority < vllist->servers[j].priority)
+				break; /* Lower preferable */
+			if (bs.priority == vllist->servers[j].priority &&
+			    bs.weight > vllist->servers[j].weight)
+				break; /* Higher preferable */
+		}
+
+		if (j < vllist->nr_servers) {
+			memmove(vllist->servers + j + 1,
+				vllist->servers + j,
+				(vllist->nr_servers - j) * sizeof(struct afs_vlserver_entry));
+		}
+
+		vllist->servers[j].priority = bs.priority;
+		vllist->servers[j].weight = bs.weight;
+		vllist->servers[j].server = server;
+		vllist->nr_servers++;
+	}
+
+	if (b != end) {
+		_debug("parse error %zd", b - end);
+		goto error;
+	}
+
+	afs_put_vlserverlist(cell->net, previous);
+	_leave(" = ok [%u]", vllist->nr_servers);
+	return vllist;
+
+error_2:
+	afs_put_vlserver(cell->net, server);
+error:
+	afs_put_vlserverlist(cell->net, vllist);
+	afs_put_vlserverlist(cell->net, previous);
+dump:
+	if (ret != -ENOMEM) {
+		printk(KERN_DEBUG "DNS: at %zu\n", (const void *)b - buffer);
+		print_hex_dump_bytes("DNS: ", DUMP_PREFIX_NONE, buffer, buffer_size);
+	}
+	return ERR_PTR(ret);
+}
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
new file mode 100644
index 000000000000..44a936ad9c7a
--- /dev/null
+++ b/fs/afs/vl_rotate.c
@@ -0,0 +1,251 @@
+/* Handle vlserver selection and rotation.
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include "internal.h"
+#include "afs_vl.h"
+
+/*
+ * Begin an operation on a volume location server.
+ */
+bool afs_begin_vlserver_operation(struct afs_vl_cursor *vc, struct afs_cell *cell,
+				  struct key *key)
+{
+	memset(vc, 0, sizeof(*vc));
+	vc->cell = cell;
+	vc->key = key;
+	vc->error = -EDESTADDRREQ;
+	vc->ac.error = SHRT_MAX;
+
+	if (signal_pending(current)) {
+		vc->error = -EINTR;
+		vc->flags |= AFS_VL_CURSOR_STOP;
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Begin iteration through a server list, starting with the last used server if
+ * possible, or the last recorded good server if not.
+ */
+static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
+{
+	struct afs_cell *cell = vc->cell;
+
+	if (wait_on_bit(&cell->flags, AFS_CELL_FL_NO_LOOKUP_YET,
+			TASK_INTERRUPTIBLE)) {
+		vc->error = -ERESTARTSYS;
+		return false;
+	}
+
+	read_lock(&cell->vl_servers_lock);
+	vc->server_list = afs_get_vlserverlist(
+		rcu_dereference_protected(cell->vl_servers,
+					  lockdep_is_held(&cell->vl_servers_lock)));
+	read_unlock(&cell->vl_servers_lock);
+	if (!vc->server_list || !vc->server_list->nr_servers)
+		return false;
+
+	vc->start = READ_ONCE(vc->server_list->index);
+	vc->index = vc->start;
+	return true;
+}
+
+/*
+ * Select the vlserver to use.  May be called multiple times to rotate
+ * through the vlservers.
+ */
+bool afs_select_vlserver(struct afs_vl_cursor *vc)
+{
+	struct afs_addr_list *alist;
+	struct afs_vlserver *vlserver;
+	int error = vc->ac.error;
+
+	_enter("%u/%u,%u/%u,%d,%d",
+	       vc->index, vc->start,
+	       vc->ac.index, vc->ac.start,
+	       error, vc->ac.abort_code);
+
+	if (vc->flags & AFS_VL_CURSOR_STOP) {
+		_leave(" = f [stopped]");
+		return false;
+	}
+
+	/* Evaluate the result of the previous operation, if there was one. */
+	switch (error) {
+	case SHRT_MAX:
+		goto start;
+
+	default:
+	case 0:
+		/* Success or local failure.  Stop. */
+		vc->error = error;
+		vc->flags |= AFS_VL_CURSOR_STOP;
+		_leave(" = f [okay/local %d]", vc->ac.error);
+		return false;
+
+	case -ECONNABORTED:
+		/* The far side rejected the operation on some grounds.  This
+		 * might involve the server being busy or the volume having been moved.
+		 */
+		switch (vc->ac.abort_code) {
+		case AFSVL_IO:
+		case AFSVL_BADVOLOPER:
+		case AFSVL_NOMEM:
+			/* The server went weird. */
+			vc->error = -EREMOTEIO;
+			//write_lock(&vc->cell->vl_servers_lock);
+			//vc->server_list->weird_mask |= 1 << vc->index;
+			//write_unlock(&vc->cell->vl_servers_lock);
+			goto next_server;
+
+		default:
+			vc->error = afs_abort_to_error(vc->ac.abort_code);
+			goto failed;
+		}
+
+	case -ENETUNREACH:
+	case -EHOSTUNREACH:
+	case -ECONNREFUSED:
+	case -ETIMEDOUT:
+	case -ETIME:
+		_debug("no conn %d", error);
+		vc->error = error;
+		goto iterate_address;
+
+	case -ECONNRESET:
+		_debug("call reset");
+		vc->error = error;
+		vc->flags |= AFS_VL_CURSOR_RETRY;
+		goto next_server;
+	}
+
+restart_from_beginning:
+	_debug("restart");
+	afs_end_cursor(&vc->ac);
+	afs_put_vlserverlist(vc->cell->net, vc->server_list);
+	vc->server_list = NULL;
+	if (vc->flags & AFS_VL_CURSOR_RETRIED)
+		goto failed;
+	vc->flags |= AFS_VL_CURSOR_RETRIED;
+start:
+	_debug("start");
+
+	/* TODO: Consider checking the VL server list */
+
+	if (!afs_start_vl_iteration(vc))
+		goto failed;
+
+use_server:
+	_debug("use");
+	/* We're starting on a different vlserver from the list.  We need to
+	 * check it, find its address list and probe its capabilities before we
+	 * use it.
+	 */
+	ASSERTCMP(vc->ac.alist, ==, NULL);
+	vlserver = vc->server_list->servers[vc->index].server;
+
+	// TODO: Check the vlserver occasionally
+	//if (!afs_check_vlserver_record(vc, vlserver))
+	//	goto failed;
+
+	_debug("USING VLSERVER: %s", vlserver->name);
+
+	read_lock(&vlserver->lock);
+	alist = rcu_dereference_protected(vlserver->addresses,
+					  lockdep_is_held(&vlserver->lock));
+	afs_get_addrlist(alist);
+	read_unlock(&vlserver->lock);
+
+	memset(&vc->ac, 0, sizeof(vc->ac));
+
+	/* Probe the current vlserver if we haven't done so yet. */
+#if 0 // TODO
+	if (!test_bit(AFS_VLSERVER_FL_PROBED, &vlserver->flags)) {
+		vc->ac.alist = afs_get_addrlist(alist);
+
+		if (!afs_probe_vlserver(vc)) {
+			error = vc->ac.error;
+			switch (error) {
+			case -ENOMEM:
+			case -ERESTARTSYS:
+			case -EINTR:
+				goto failed_set_error;
+			default:
+				goto next_server;
+			}
+		}
+	}
+#endif
+
+	if (!vc->ac.alist)
+		vc->ac.alist = alist;
+	else
+		afs_put_addrlist(alist);
+
+	vc->ac.start = READ_ONCE(alist->index);
+	vc->ac.index = vc->ac.start;
+
+iterate_address:
+	ASSERT(vc->ac.alist);
+	_debug("iterate %d/%d", vc->ac.index, vc->ac.alist->nr_addrs);
+	/* Iterate over the current server's address list to try and find an
+	 * address on which it will respond to us.
+	 */
+	if (!afs_iterate_addresses(&vc->ac))
+		goto next_server;
+
+	_leave(" = t %pISpc", &vc->ac.addr->transport);
+	return true;
+
+next_server:
+	_debug("next");
+	afs_end_cursor(&vc->ac);
+	vc->index++;
+	if (vc->index >= vc->server_list->nr_servers)
+		vc->index = 0;
+	if (vc->index != vc->start)
+		goto use_server;
+
+	/* That's all the servers poked to no good effect.  Try again if some
+	 * of them were busy.
+	 */
+	if (vc->flags & AFS_VL_CURSOR_RETRY)
+		goto restart_from_beginning;
+
+	goto failed;
+
+failed:
+	vc->flags |= AFS_VL_CURSOR_STOP;
+	afs_end_cursor(&vc->ac);
+	_leave(" = f [failed %d]", vc->error);
+	return false;
+}
+
+/*
+ * Tidy up a volume location server cursor and unlock the vnode.
+ */
+int afs_end_vlserver_operation(struct afs_vl_cursor *vc)
+{
+	struct afs_net *net = vc->cell->net;
+
+	afs_end_cursor(&vc->ac);
+	afs_put_vlserverlist(net, vc->server_list);
+
+	if (vc->error == -ECONNABORTED)
+		vc->error = afs_abort_to_error(vc->ac.abort_code);
+
+	return vc->error;
+}
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index e18c51742daa..3127ab9b5521 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -128,14 +128,13 @@ static const struct afs_call_type afs_RXVLGetEntryByNameU = {
  * Dispatch a get volume entry by name or ID operation (uuid variant).  If the
  * volname is a decimal number then it's a volume ID not a volume name.
  */
-struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_net *net,
-						  struct afs_addr_cursor *ac,
-						  struct key *key,
+struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *vc,
 						  const char *volname,
 						  int volnamesz)
 {
 	struct afs_vldb_entry *entry;
 	struct afs_call *call;
+	struct afs_net *net = vc->cell->net;
 	size_t reqsz, padsz;
 	__be32 *bp;
 
@@ -155,7 +154,7 @@ struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_net *net,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	call->key = key;
+	call->key = vc->key;
 	call->reply[0] = entry;
 	call->ret_reply0 = true;
 
@@ -168,7 +167,7 @@ struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_net *net,
 		memset((void *)bp + volnamesz, 0, padsz);
 
 	trace_afs_make_vl_call(call);
-	return (struct afs_vldb_entry *)afs_make_call(ac, call, GFP_KERNEL, false);
+	return (struct afs_vldb_entry *)afs_make_call(&vc->ac, call, GFP_KERNEL, false);
 }
 
 /*
@@ -266,14 +265,13 @@ static const struct afs_call_type afs_RXVLGetAddrsU = {
  * Dispatch an operation to get the addresses for a server, where the server is
  * nominated by UUID.
  */
-struct afs_addr_list *afs_vl_get_addrs_u(struct afs_net *net,
-					 struct afs_addr_cursor *ac,
-					 struct key *key,
+struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 					 const uuid_t *uuid)
 {
 	struct afs_ListAddrByAttributes__xdr *r;
 	const struct afs_uuid *u = (const struct afs_uuid *)uuid;
 	struct afs_call *call;
+	struct afs_net *net = vc->cell->net;
 	__be32 *bp;
 	int i;
 
@@ -285,7 +283,7 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_net *net,
 	if (!call)
 		return ERR_PTR(-ENOMEM);
 
-	call->key = key;
+	call->key = vc->key;
 	call->reply[0] = NULL;
 	call->ret_reply0 = true;
 
@@ -306,7 +304,7 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_net *net,
 		r->uuid.node[i] = htonl(u->node[i]);
 
 	trace_afs_make_vl_call(call);
-	return (struct afs_addr_list *)afs_make_call(ac, call, GFP_KERNEL, false);
+	return (struct afs_addr_list *)afs_make_call(&vc->ac, call, GFP_KERNEL, false);
 }
 
 /*
@@ -367,14 +365,13 @@ static const struct afs_call_type afs_RXVLGetCapabilities = {
 };
 
 /*
- * Probe a fileserver for the capabilities that it supports.  This can
+ * Probe a volume server for the capabilities that it supports.  This can
  * return up to 196 words.
  *
  * We use this to probe for service upgrade to determine what the server at the
  * other end supports.
  */
-int afs_vl_get_capabilities(struct afs_net *net,
-			    struct afs_addr_cursor *ac,
+int afs_vl_get_capabilities(struct afs_net *net, struct afs_addr_cursor *ac,
 			    struct key *key)
 {
 	struct afs_call *call;
@@ -617,12 +614,11 @@ static const struct afs_call_type afs_YFSVLGetEndpoints = {
  * Dispatch an operation to get the addresses for a server, where the server is
  * nominated by UUID.
  */
-struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_net *net,
-					      struct afs_addr_cursor *ac,
-					      struct key *key,
+struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 					      const uuid_t *uuid)
 {
 	struct afs_call *call;
+	struct afs_net *net = vc->cell->net;
 	__be32 *bp;
 
 	_enter("");
@@ -633,7 +629,7 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_net *net,
 	if (!call)
 		return ERR_PTR(-ENOMEM);
 
-	call->key = key;
+	call->key = vc->key;
 	call->reply[0] = NULL;
 	call->ret_reply0 = true;
 
@@ -644,5 +640,5 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_net *net,
 	memcpy(bp, uuid, sizeof(*uuid)); /* Type opr_uuid */
 
 	trace_afs_make_vl_call(call);
-	return (struct afs_addr_list *)afs_make_call(ac, call, GFP_KERNEL, false);
+	return (struct afs_addr_list *)afs_make_call(&vc->ac, call, GFP_KERNEL, false);
 }
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 3037bd01f617..1cd263fa6028 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -74,55 +74,35 @@ static struct afs_vldb_entry *afs_vl_lookup_vldb(struct afs_cell *cell,
 						 const char *volname,
 						 size_t volnamesz)
 {
-	struct afs_addr_cursor ac;
-	struct afs_vldb_entry *vldb;
+	struct afs_vldb_entry *vldb = ERR_PTR(-EDESTADDRREQ);
+	struct afs_vl_cursor vc;
 	int ret;
 
-	ret = afs_set_vl_cursor(&ac, cell);
-	if (ret < 0)
-		return ERR_PTR(ret);
+	if (!afs_begin_vlserver_operation(&vc, cell, key))
+		return ERR_PTR(-ERESTARTSYS);
 
-	while (afs_iterate_addresses(&ac)) {
-		if (!test_bit(ac.index, &ac.alist->probed)) {
-			ret = afs_vl_get_capabilities(cell->net, &ac, key);
+	while (afs_select_vlserver(&vc)) {
+		if (!test_bit(vc.ac.index, &vc.ac.alist->probed)) {
+			ret = afs_vl_get_capabilities(cell->net, &vc.ac, key);
 			switch (ret) {
 			case VL_SERVICE:
-				clear_bit(ac.index, &ac.alist->yfs);
-				set_bit(ac.index, &ac.alist->probed);
-				ac.addr->srx_service = ret;
+				clear_bit(vc.ac.index, &vc.ac.alist->yfs);
+				set_bit(vc.ac.index, &vc.ac.alist->probed);
+				vc.ac.addr->srx_service = ret;
 				break;
 			case YFS_VL_SERVICE:
-				set_bit(ac.index, &ac.alist->yfs);
-				set_bit(ac.index, &ac.alist->probed);
-				ac.addr->srx_service = ret;
+				set_bit(vc.ac.index, &vc.ac.alist->yfs);
+				set_bit(vc.ac.index, &vc.ac.alist->probed);
+				vc.ac.addr->srx_service = ret;
 				break;
 			}
 		}
 		
-		vldb = afs_vl_get_entry_by_name_u(cell->net, &ac, key,
-						  volname, volnamesz);
-		switch (ac.error) {
-		case 0:
-			afs_end_cursor(&ac);
-			return vldb;
-		case -ECONNABORTED:
-			ac.error = afs_abort_to_error(ac.abort_code);
-			goto error;
-		case -ENOMEM:
-		case -ENONET:
-			goto error;
-		case -ENETUNREACH:
-		case -EHOSTUNREACH:
-		case -ECONNREFUSED:
-			break;
-		default:
-			ac.error = -EIO;
-			goto error;
-		}
+		vldb = afs_vl_get_entry_by_name_u(&vc, volname, volnamesz);
 	}
 
-error:
-	return ERR_PTR(afs_end_cursor(&ac));
+	ret = afs_end_vlserver_operation(&vc);
+	return ret < 0 ? ERR_PTR(ret) : vldb;
 }
 
 /*

