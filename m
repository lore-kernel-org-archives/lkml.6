Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D2BECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A215A214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A215A214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeJTJVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:21:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeJTJVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:21:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E55C15561;
        Sat, 20 Oct 2018 01:12:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5733F80375;
        Sat, 20 Oct 2018 01:12:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/24] afs: Expand data structure fields to support YFS
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:12:55 +0100
Message-ID: <153999797554.866.15989401297453129213.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 20 Oct 2018 01:12:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand fields in various data structures to support the expanded
information that YFS is capable of returning.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h      |   35 ++++++++++++++++++-----------------
 fs/afs/fsclient.c |    9 +++++----
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index 417cd23529c5..d12ffb457e47 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -130,19 +130,18 @@ typedef u32 afs_access_t;
 struct afs_file_status {
 	u64			size;		/* file size */
 	afs_dataversion_t	data_version;	/* current data version */
-	time_t			mtime_client;	/* last time client changed data */
-	time_t			mtime_server;	/* last time server changed data */
-	unsigned		abort_code;	/* Abort if bulk-fetching this failed */
-
-	afs_file_type_t		type;		/* file type */
-	unsigned		nlink;		/* link count */
-	u32			author;		/* author ID */
-	u32			owner;		/* owner ID */
-	u32			group;		/* group ID */
+	struct timespec64	mtime_client;	/* Last time client changed data */
+	struct timespec64	mtime_server;	/* Last time server changed data */
+	s64			author;		/* author ID */
+	s64			owner;		/* owner ID */
+	s64			group;		/* group ID */
 	afs_access_t		caller_access;	/* access rights for authenticated caller */
 	afs_access_t		anon_access;	/* access rights for unauthenticated caller */
 	umode_t			mode;		/* UNIX mode */
+	afs_file_type_t		type;		/* file type */
+	u32			nlink;		/* link count */
 	s32			lock_count;	/* file lock count (0=UNLK -1=WRLCK +ve=#RDLCK */
+	u32			abort_code;	/* Abort if bulk-fetching this failed */
 };
 
 /*
@@ -159,25 +158,27 @@ struct afs_file_status {
  * AFS volume synchronisation information
  */
 struct afs_volsync {
-	time_t			creation;	/* volume creation time */
+	time64_t		creation;	/* volume creation time */
 };
 
 /*
  * AFS volume status record
  */
 struct afs_volume_status {
-	u32			vid;		/* volume ID */
-	u32			parent_id;	/* parent volume ID */
+	afs_volid_t		vid;		/* volume ID */
+	afs_volid_t		parent_id;	/* parent volume ID */
 	u8			online;		/* true if volume currently online and available */
 	u8			in_service;	/* true if volume currently in service */
 	u8			blessed;	/* same as in_service */
 	u8			needs_salvage;	/* true if consistency checking required */
 	u32			type;		/* volume type (afs_voltype_t) */
-	u32			min_quota;	/* minimum space set aside (blocks) */
-	u32			max_quota;	/* maximum space this volume may occupy (blocks) */
-	u32			blocks_in_use;	/* space this volume currently occupies (blocks) */
-	u32			part_blocks_avail; /* space available in volume's partition */
-	u32			part_max_blocks; /* size of volume's partition */
+	u64			min_quota;	/* minimum space set aside (blocks) */
+	u64			max_quota;	/* maximum space this volume may occupy (blocks) */
+	u64			blocks_in_use;	/* space this volume currently occupies (blocks) */
+	u64			part_blocks_avail; /* space available in volume's partition */
+	u64			part_max_blocks; /* size of volume's partition */
+	s64			vol_copy_date;
+	s64			vol_backup_date;
 };
 
 #define AFS_BLOCK_SIZE	1024
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 6105cdb17163..2da65309e0de 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -69,8 +69,7 @@ void afs_update_inode_from_status(struct afs_vnode *vnode,
 	struct timespec64 t;
 	umode_t mode;
 
-	t.tv_sec = status->mtime_client;
-	t.tv_nsec = 0;
+	t = status->mtime_client;
 	vnode->vfs_inode.i_ctime = t;
 	vnode->vfs_inode.i_mtime = t;
 	vnode->vfs_inode.i_atime = t;
@@ -194,8 +193,10 @@ static int xdr_decode_AFSFetchStatus(struct afs_call *call,
 	EXTRACT_M(mode);
 	EXTRACT_M(group);
 
-	status->mtime_client = ntohl(xdr->mtime_client);
-	status->mtime_server = ntohl(xdr->mtime_server);
+	status->mtime_client.tv_sec = ntohl(xdr->mtime_client);
+	status->mtime_client.tv_nsec = 0;
+	status->mtime_server.tv_sec = ntohl(xdr->mtime_server);
+	status->mtime_server.tv_nsec = 0;
 	status->lock_count   = ntohl(xdr->lock_count);
 
 	size  = (u64)ntohl(xdr->size_lo);

