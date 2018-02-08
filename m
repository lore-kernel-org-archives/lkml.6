Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeBHQQf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:16:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752337AbeBHQQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:32 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/7] afs: Fix server list handling
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 16:16:30 +0000
Message-ID: <151810659005.20070.3295416071173460909.stgit@warthog.procyon.org.uk>
In-Reply-To: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
References: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix server list handling in the following ways:

 (1) In afs_alloc_volume(), remove duplicate server list build code.  This
     was already done by afs_alloc_server_list() which afs_alloc_volume()
     previously called.  This just results in twice as many VL RPCs.

 (2) In afs_deliver_vl_get_entry_by_name_u(), use the number of server
     records indicated by ->nServers in the UVLDB record returned by the
     VL.GetEntryByNameU RPC call rather than scanning all NMAXNSERVERS
     slots.  Unused slots may contain garbage.

 (3) In afs_alloc_server_list(), don't stop converting a UVLDB record into
     a server list just because we can't look up one of the servers.  Just
     skip that server and go on to the next.  If we can't look up any of
     the servers then we'll fail at the end.

Without this patch, an attempt to view the umich.edu root cell using
something like "ls /afs/umich.edu" on a dynamic root (future patch) mount
or an autocell mount will result in ENOMEDIUM.  The failure is due to kafs
not stopping after nServers'worth of records have been read, but then
trying to access a server with a garbage UUID and getting an error, which
aborts the server list build.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Reported-by: Jonathan Billings <jsbillings@jsbillings.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: stable@vger.kernel.org
---

 fs/afs/server_list.c |    3 ++-
 fs/afs/vlclient.c    |   10 +++++++---
 fs/afs/volume.c      |   46 ++--------------------------------------------
 3 files changed, 11 insertions(+), 48 deletions(-)

diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 0ab3f8457839..0f8dc4c8f07c 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -58,7 +58,8 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 		server = afs_lookup_server(cell, key, &vldb->fs_server[i]);
 		if (IS_ERR(server)) {
 			ret = PTR_ERR(server);
-			if (ret == -ENOENT)
+			if (ret == -ENOENT ||
+			    ret == -ENOMEDIUM)
 				continue;
 			goto error_2;
 		}
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index e372f89fd36a..5d8562f1ad4a 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -23,7 +23,7 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs_call *call)
 	struct afs_uvldbentry__xdr *uvldb;
 	struct afs_vldb_entry *entry;
 	bool new_only = false;
-	u32 tmp;
+	u32 tmp, nr_servers;
 	int i, ret;
 
 	_enter("");
@@ -36,6 +36,10 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs_call *call)
 	uvldb = call->buffer;
 	entry = call->reply[0];
 
+	nr_servers = ntohl(uvldb->nServers);
+	if (nr_servers > AFS_NMAXNSERVERS)
+		nr_servers = AFS_NMAXNSERVERS;
+
 	for (i = 0; i < ARRAY_SIZE(uvldb->name) - 1; i++)
 		entry->name[i] = (u8)ntohl(uvldb->name[i]);
 	entry->name[i] = 0;
@@ -44,14 +48,14 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs_call *call)
 	/* If there is a new replication site that we can use, ignore all the
 	 * sites that aren't marked as new.
 	 */
-	for (i = 0; i < AFS_NMAXNSERVERS; i++) {
+	for (i = 0; i < nr_servers; i++) {
 		tmp = ntohl(uvldb->serverFlags[i]);
 		if (!(tmp & AFS_VLSF_DONTUSE) &&
 		    (tmp & AFS_VLSF_NEWREPSITE))
 			new_only = true;
 	}
 
-	for (i = 0; i < AFS_NMAXNSERVERS; i++) {
+	for (i = 0; i < nr_servers; i++) {
 		struct afs_uuid__xdr *xdr;
 		struct afs_uuid *uuid;
 		int j;
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 79db9021f140..b517a588781f 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -26,9 +26,8 @@ static struct afs_volume *afs_alloc_volume(struct afs_mount_params *params,
 					   unsigned long type_mask)
 {
 	struct afs_server_list *slist;
-	struct afs_server *server;
 	struct afs_volume *volume;
-	int ret = -ENOMEM, nr_servers = 0, i, j;
+	int ret = -ENOMEM, nr_servers = 0, i;
 
 	for (i = 0; i < vldb->nr_servers; i++)
 		if (vldb->fs_mask[i] & type_mask)
@@ -58,49 +57,8 @@ static struct afs_volume *afs_alloc_volume(struct afs_mount_params *params,
 
 	refcount_set(&slist->usage, 1);
 	volume->servers = slist;
-
-	/* Make sure a records exists for each server this volume occupies. */
-	for (i = 0; i < nr_servers; i++) {
-		if (!(vldb->fs_mask[i] & type_mask))
-			continue;
-
-		server = afs_lookup_server(params->cell, params->key,
-					   &vldb->fs_server[i]);
-		if (IS_ERR(server)) {
-			ret = PTR_ERR(server);
-			if (ret == -ENOENT)
-				continue;
-			goto error_2;
-		}
-
-		/* Insertion-sort by server pointer */
-		for (j = 0; j < slist->nr_servers; j++)
-			if (slist->servers[j].server >= server)
-				break;
-		if (j < slist->nr_servers) {
-			if (slist->servers[j].server == server) {
-				afs_put_server(params->net, server);
-				continue;
-			}
-
-			memmove(slist->servers + j + 1,
-				slist->servers + j,
-				(slist->nr_servers - j) * sizeof(struct afs_server_entry));
-		}
-
-		slist->servers[j].server = server;
-		slist->nr_servers++;
-	}
-
-	if (slist->nr_servers == 0) {
-		ret = -EDESTADDRREQ;
-		goto error_2;
-	}
-
 	return volume;
 
-error_2:
-	afs_put_serverlist(params->net, slist);
 error_1:
 	afs_put_cell(params->net, volume->cell);
 	kfree(volume);
@@ -328,7 +286,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 
 	/* See if the volume's server list got updated. */
 	new = afs_alloc_server_list(volume->cell, key,
-				      vldb, (1 << volume->type));
+				    vldb, (1 << volume->type));
 	if (IS_ERR(new)) {
 		ret = PTR_ERR(new);
 		goto error_vldb;
