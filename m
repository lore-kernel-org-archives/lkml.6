Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05ACC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2F121471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2F121471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJBHjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeJBHjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30913307D844;
        Tue,  2 Oct 2018 00:59:03 +0000 (UTC)
Received: from rf.usersys.redhat.com (ovpn-116-170.phx2.redhat.com [10.3.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47CDD10016DC;
        Tue,  2 Oct 2018 00:59:02 +0000 (UTC)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org
Subject: [PATCH] CIFS: Print message when attempting mount
Date:   Mon,  1 Oct 2018 21:58:46 -0300
Message-Id: <463f424e3d4724a4ab7b84c395e7b0cf3068e31f.1538441538.git.rfreire@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 02 Oct 2018 00:59:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, no messages are printed when mounting a CIFS filesystem.
This information is valuable when troubleshooting and/or forensic
analyzing a system and finding out if was a CIFS endpoint mount
attempted.
Other filesystems such as XFS, EXT* does issue a printk() when mounting
their filesystems.

Sample output:

[root@ll-rhel7 ~]# mount -o user=administrator //172.25.250.18/c$ /mnt
(non-existent system)

[root@ll-rhel7 ~]# mount -o user=administrator //172.25.250.19/c$ /mnt
(Valid system)

Kernel message log:

[  450.464543] CIFS VFS: Attempting to mount //172.25.250.18/c$
[  456.478186] CIFS VFS: Error connecting to socket. Aborting operation.
[  456.478381] CIFS VFS: cifs_mount failed w/return code = -113
[  467.688866] CIFS VFS: Attempting to mount //172.25.250.19/c$

Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
---
 fs/cifs/cifsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 7065426..3f5a31e 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -707,6 +707,7 @@ static int cifs_set_super(struct super_block *sb, void *data)
 	struct cifs_mnt_data mnt_data;
 	struct dentry *root;
 
+	cifs_dbg(VFS, "Attempting to mount %s\n", dev_name);
 	cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);
 
 	volume_info = cifs_get_volume_info((char *)data, dev_name, is_smb3);
-- 
1.8.3.1

