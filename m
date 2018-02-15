Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518711135-2-925200806910245226
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711134; b=W9lbYFe3o0B5ym5Y86XI+QikkJA64rbAnp1mQiE2YrSosU0
    Yvq5hPl63zp4j0eweP09/BrP6SRRzRWesDzzaE5fkFN6HhNpo+jg8eRW0z3c1uQ9
    b/hsW93IhKACGLCjx+j0M34KHrHFBVIwVz68F2BJh0pYhv7gbQLrVqDCg5uCVLui
    qTQewZATifZtcUt9PuPIkL+KBDkLTpJStarZ+qjVdY4tx1KDlbvsJPOqXxxxtveU
    kw1QRYPRihY+4xvA+WdNoWQpsIv5OX9qOAbyvUZtBe0373p2Xkfi0DAmiu7Gzckx
    AG0o5TQYca3RfkEwCHaJSobFyLe6LUXwg9HYfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711134; bh=EtIfRxTQ9PVoxhEBxrhrQM/meX
    mF63a0PXluqmZSPVI=; b=m4Pg0ds9ygTUPfEd4JIS6l+9OccmYE2K6dML91CWjl
    yPJC3FGmBwoPU6/uXdVR3Y2l9IOA9GAy+97jTAlPAexHRATKI4lRhwDW0tmJHEjD
    39E9SipA+WgNLr5BTaaVCdweTzeH6c+EvS5RoZnqSmf9a1M4AvezqILo1Kzq+s0p
    5VwHBaTSSocihQAi62U5L8xlvQ0O3Wh/6sByqtTHkLD41R/v0DiggzEjyInWV+MU
    A3iio7R0CcZeDDsPIW60UL85rl3rFfCK/bUWmX+SBsF6j6hOOxYRk95oCcGIt9GA
    UBB+Han1jIOVnNfG0z/pKRvIMQc4lHQtP9iwvna1H2aQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424427AbeBOPpR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424390AbeBOPpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Billings <jsbillings@jsbillings.org>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 4.15 145/202] afs: Fix server list handling
Date: Thu, 15 Feb 2018 16:17:25 +0100
Message-Id: <20180215151720.625144922@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 45df8462730d2149834980d3db16e2d2b9daaf60 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/server_list.c |    3 ++-
 fs/afs/vlclient.c    |   10 +++++++---
 fs/afs/volume.c      |   46 ++--------------------------------------------
 3 files changed, 11 insertions(+), 48 deletions(-)

--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -58,7 +58,8 @@ struct afs_server_list *afs_alloc_server
 		server = afs_lookup_server(cell, key, &vldb->fs_server[i]);
 		if (IS_ERR(server)) {
 			ret = PTR_ERR(server);
-			if (ret == -ENOENT)
+			if (ret == -ENOENT ||
+			    ret == -ENOMEDIUM)
 				continue;
 			goto error_2;
 		}
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -23,7 +23,7 @@ static int afs_deliver_vl_get_entry_by_n
 	struct afs_uvldbentry__xdr *uvldb;
 	struct afs_vldb_entry *entry;
 	bool new_only = false;
-	u32 tmp;
+	u32 tmp, nr_servers;
 	int i, ret;
 
 	_enter("");
@@ -36,6 +36,10 @@ static int afs_deliver_vl_get_entry_by_n
 	uvldb = call->buffer;
 	entry = call->reply[0];
 
+	nr_servers = ntohl(uvldb->nServers);
+	if (nr_servers > AFS_NMAXNSERVERS)
+		nr_servers = AFS_NMAXNSERVERS;
+
 	for (i = 0; i < ARRAY_SIZE(uvldb->name) - 1; i++)
 		entry->name[i] = (u8)ntohl(uvldb->name[i]);
 	entry->name[i] = 0;
@@ -44,14 +48,14 @@ static int afs_deliver_vl_get_entry_by_n
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
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -26,9 +26,8 @@ static struct afs_volume *afs_alloc_volu
 					   unsigned long type_mask)
 {
 	struct afs_server_list *slist;
-	struct afs_server *server;
 	struct afs_volume *volume;
-	int ret = -ENOMEM, nr_servers = 0, i, j;
+	int ret = -ENOMEM, nr_servers = 0, i;
 
 	for (i = 0; i < vldb->nr_servers; i++)
 		if (vldb->fs_mask[i] & type_mask)
@@ -58,49 +57,8 @@ static struct afs_volume *afs_alloc_volu
 
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
@@ -328,7 +286,7 @@ static int afs_update_volume_status(stru
 
 	/* See if the volume's server list got updated. */
 	new = afs_alloc_server_list(volume->cell, key,
-				      vldb, (1 << volume->type));
+				    vldb, (1 << volume->type));
 	if (IS_ERR(new)) {
 		ret = PTR_ERR(new);
 		goto error_vldb;
