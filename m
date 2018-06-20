Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF89C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA6F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA6F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeFTJmX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:42:23 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754268AbeFTI3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:12 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MgDrd-1ft06H42Uf-00NR5g; Wed, 20 Jun 2018 09:46:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: use a consistent interpretation of time values
Date:   Wed, 20 Jun 2018 09:46:39 +0200
Message-Id: <20180620074647.4152617-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:8tZHIp9wTxGykRLfAAbbBLJ88u93pWA83epIet8NDXC6qTt4dUg
 MN7LNWjvAifMMu5jFwIMGUbJweZdc9OylxHPSz2nhgxIrjsgkkE0kFxBpWv2lonNaXxWp97
 GshLNlhgEPO5OMWypUk8jQSVzoeTlTL0kIGD+Rf+VfSdmBS94KMmt7UcvllVC4hz8nVFng4
 ewtYnHIZ09Bqj0uyc8kTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JqiX6A9JI1A=:OtLeVSNL9DAqFYLSl2huNR
 By8dCtcOWVi9cvyfbUYflq2XTfWOvgpnbjJcs0MpJxqxVyv91w/k7lzZU8FmERSX3KvBUUW2z
 M8VJmXEF9qMc28nVUlB8Kp7lJ3rnWkXgUeYuhOPzKG+9cvBbajFNh0/QLaovFirwuyePV+Wji
 O4ytPPepXU9DuQJaqd3VenDS8CBfjSbN5n47p6cqgWU7s12LYfCJD3e6kNRHDgmP22hkbev8/
 dJdoJC5FEYqydzeibpTA8PcW/d3vcxuwllWk6zgJ58zy94O6ajUtwVpjFa0S6WZjQ+DvHQyhJ
 7UK+ve6rhurHqxP4b5CaIBQ9THpM5uon3769NKb4Nsqpitp8wbiNDzKemRdm7hB30k6FAgcm2
 fmjSfKUl9P1ByP0vufG/AzO6SFLF/vmhemimPxODlbGTaf+naK4JKEdpDAzHTBW7mObqYyWk0
 q1MSgbdFqMizv2MUglxXj2Bm7aFx/tactzIeZyWZJpatipUZu7WYrzMBaujbH7thQppoKwWqK
 4lKnt7pBMd7xecyPVYx5a+ev8b9lAJb0IkodHZ9FjAOgXg8tXfFN2PlEnujxGVMwao6chNBdn
 sU6vH9/8rKUWwT1izBJ2uQTsNd4djnVdQT4fW+Ue5IQ6AmpUSQQUZ3p4YmAQcXWqvaF5juHGL
 tMP1yFQvvk/+tfXIWvh0XM0nehLDofjL6mM5/yDSYcyY/+EPWXEXEqhKyJVSQ8WLo8iY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs uses 32-bit timestamps everywhere, but mixes signed and unsigned
usage, which is a bit inconsistent. In particular on 32-bit machines,
it currently uses unsigned timestamps (ranging from 1970 to 2106) for
locally modified files, but signed timestamps (rand 1902 to 2038) when
reading from a remote end. On 64-bit machines, we always interpret
timestamps as unsigned here.

This replaces the deprecated time_t and get_seconds() interfaces with the
modern time64_t and current_time() to locally store 64-bit timestamps,
taking care to use unsigned interpretation of the raw values everywhere,
which avoids the y2038 overflow and is consistent with the previous
usage on 64-bit machines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/afs/afs.h   | 6 +++---
 fs/afs/inode.c | 4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index b4ff1f7ae4ab..6ca50c293553 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -129,8 +129,8 @@ typedef u32 afs_access_t;
 struct afs_file_status {
 	u64			size;		/* file size */
 	afs_dataversion_t	data_version;	/* current data version */
-	time_t			mtime_client;	/* last time client changed data */
-	time_t			mtime_server;	/* last time server changed data */
+	time64_t		mtime_client;	/* last time client changed data */
+	time64_t		mtime_server;	/* last time server changed data */
 	unsigned		abort_code;	/* Abort if bulk-fetching this failed */
 
 	afs_file_type_t		type;		/* file type */
@@ -158,7 +158,7 @@ struct afs_file_status {
  * AFS volume synchronisation information
  */
 struct afs_volsync {
-	time_t			creation;	/* volume creation time */
+	time64_t		creation;	/* volume creation time */
 };
 
 /*
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 479b7fdda124..0507e52e3330 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -213,9 +213,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 	set_nlink(inode, 2);
 	inode->i_uid		= GLOBAL_ROOT_UID;
 	inode->i_gid		= GLOBAL_ROOT_GID;
-	inode->i_ctime.tv_sec	= get_seconds();
-	inode->i_ctime.tv_nsec	= 0;
-	inode->i_atime		= inode->i_mtime = inode->i_ctime;
+	inode->i_ctime = inode->i_atime = inode->i_mtime = current_time(inode);
 	inode->i_blocks		= 0;
 	inode_set_iversion_raw(inode, 0);
 	inode->i_generation	= 0;
-- 
2.9.0

