Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D36C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED211204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED211204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJBSkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJBSkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7ADE83084217;
        Tue,  2 Oct 2018 11:57:13 +0000 (UTC)
Received: from rf.usersys.redhat.com (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AA5D1823E;
        Tue,  2 Oct 2018 11:57:10 +0000 (UTC)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org, piastryyy@gmail.com
Subject: [PATCH v2] CIFS: Print message when attempting a mount
Date:   Tue,  2 Oct 2018 08:57:01 -0300
Message-Id: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 02 Oct 2018 11:57:13 +0000 (UTC)
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

A terse log message is printed only if cifsFYI is not enabled.

Sample mount operations:

[root@corinthians ~]# mount -o user=administrator //172.25.250.18/c$ /mnt
(non-existent system)

[root@corinthians ~]# mount -o user=administrator //172.25.250.19/c$ /mnt
(Valid system)

Kernel message log for the mount operations:

[  450.464543] CIFS VFS: Attempting to mount //172.25.250.18/c$
[  456.478186] CIFS VFS: Error connecting to socket. Aborting operation.
[  456.478381] CIFS VFS: cifs_mount failed w/return code = -113
[  467.688866] CIFS VFS: Attempting to mount //172.25.250.19/c$

v2: Created a loop to select the right cifs_dbg message to be printed,
    considering the current system's scenario, in order to avoid a
    duplicate message or stripping out important information in
    debug.

Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
---
 fs/cifs/cifsfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 7065426..7fde6bc 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -707,7 +707,11 @@ static int cifs_set_super(struct super_block *sb, void *data)
 	struct cifs_mnt_data mnt_data;
 	struct dentry *root;
 
-	cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);
+	/* Prints in Kernel / CIFS log the attempted mount operation */
+	if (cifsFYI)
+		cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);
+	else
+		cifs_dbg(VFS, "Attempting to mount %s\n", dev_name);
 
 	volume_info = cifs_get_volume_info((char *)data, dev_name, is_smb3);
 	if (IS_ERR(volume_info))
-- 
1.8.3.1

