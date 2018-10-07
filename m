Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B97C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98E2205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98E2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeJGW3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:29:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJGW3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:29:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFD19308212B;
        Sun,  7 Oct 2018 15:21:40 +0000 (UTC)
Received: from rf.usersys.redhat.com (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F90C10021B2;
        Sun,  7 Oct 2018 15:21:39 +0000 (UTC)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org, piastryyy@gmail.com
Subject: [PATCH v3 2/2] CIFS: Print message when attempting a mount
Date:   Sun,  7 Oct 2018 12:21:26 -0300
Message-Id: <ecd759a4ee4ac73b1157702761f6458e18f38906.1538873915.git.rfreire@redhat.com>
In-Reply-To: <cover.1538873915.git.rfreire@redhat.com>
References: <cover.1538873915.git.rfreire@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 07 Oct 2018 15:21:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, no messages are printed when mounting a CIFS filesystem and
no debug configuration is enabled.

However, a CIFS mount information is valuable when troubleshooting
and/or forensic analyzing a system and finding out if was a CIFS
endpoint mount attempted.

Other filesystems such as XFS, EXT* does issue a printk() when mounting
their filesystems.

A terse log message is printed only if cifsFYI is not enabled. Otherwise,
the default full debug message is printed.

In order to not clutter and classify correctly the event messages, these
are logged as KERN_INFO level.

Sample mount operations:

[root@corinthians ~]# mount -o user=administrator //172.25.250.18/c$ /mnt
(non-existent system)

[root@corinthians ~]# mount -o user=administrator //172.25.250.19/c$ /mnt
(Valid system)

Kernel message log for the mount operations:

[  450.464543] CIFS: Attempting to mount //172.25.250.18/c$
[  456.478186] CIFS VFS: Error connecting to socket. Aborting operation.
[  456.478381] CIFS VFS: cifs_mount failed w/return code = -113
[  467.688866] CIFS: Attempting to mount //172.25.250.19/c$

Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
---
 fs/cifs/cifsfs.c    | 7 ++++++-
 fs/cifs/transport.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 7065426..ebdf25e 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -707,7 +707,12 @@ static int cifs_set_super(struct super_block *sb, void *data)
 	struct cifs_mnt_data mnt_data;
 	struct dentry *root;
 
-	cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);
+	/* Prints in Kernel / CIFS log the attempted mount operation *
+ 	 *	IF CIFS_DEBUG && cifs_FYI */
+	if (cifsFYI)
+		cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);
+	else
+		cifs_info("Attempting to mount %s\n", dev_name);
 
 	volume_info = cifs_get_volume_info((char *)data, dev_name, is_smb3);
 	if (IS_ERR(volume_info))
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 78f96fa..c2afd6a 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -128,7 +128,7 @@ void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
 		if (cifsFYI & CIFS_TIMER) {
 			pr_debug(" CIFS slow rsp: cmd %d mid %llu",
 			       midEntry->command, midEntry->mid);
-			pr_info(" A: 0x%lx S: 0x%lx R: 0x%lx\n",
+			cifs_info(" A: 0x%lx S: 0x%lx R: 0x%lx\n",
 			       now - midEntry->when_alloc,
 			       now - midEntry->when_sent,
 			       now - midEntry->when_received);
-- 
1.8.3.1

