Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A078BC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFF420876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFF420876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeJNXX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36955 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:56 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM0-0004cY-Jf; Sun, 14 Oct 2018 16:30:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLT-0000Ns-VI; Sun, 14 Oct 2018 16:30:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        "Pavel Shilovsky" <pshilov@microsoft.com>,
        "Steve French" <smfrench@gmail.com>,
        "Eryu Guan" <eguan@redhat.com>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.36818024@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 180/366] cifs: do not allow creating sockets except
 with SMB1 posix exensions
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <smfrench@gmail.com>

commit 1d0cffa674cfa7d185a302c8c6850fc50b893bed upstream.

RHBZ: 1453123

Since at least the 3.10 kernel and likely a lot earlier we have
not been able to create unix domain sockets in a cifs share
when mounted using the SFU mount option (except when mounted
with the cifs unix extensions to Samba e.g.)
Trying to create a socket, for example using the af_unix command from
xfstests will cause :
BUG: unable to handle kernel NULL pointer dereference at 00000000
00000040

Since no one uses or depends on being able to create unix domains sockets
on a cifs share the easiest fix to stop this vulnerability is to simply
not allow creation of any other special files than char or block devices
when sfu is used.

Added update to Ronnie's patch to handle a tcon link leak, and
to address a buf leak noticed by Gustavo and Colin.

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
CC:  Colin Ian King <colin.king@canonical.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Reported-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <smfrench@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/dir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -665,6 +665,9 @@ int cifs_mknod(struct inode *inode, stru
 		goto mknod_out;
 	}
 
+	if (!S_ISCHR(mode) && !S_ISBLK(mode))
+		goto mknod_out;
+
 	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL))
 		goto mknod_out;
 
@@ -673,10 +676,8 @@ int cifs_mknod(struct inode *inode, stru
 
 	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
 	if (buf == NULL) {
-		kfree(full_path);
 		rc = -ENOMEM;
-		free_xid(xid);
-		return rc;
+		goto mknod_out;
 	}
 
 	if (backup_cred(cifs_sb))
@@ -718,7 +719,7 @@ int cifs_mknod(struct inode *inode, stru
 		pdev->minor = cpu_to_le64(MINOR(device_number));
 		rc = CIFSSMBWrite(xid, &io_parms, &bytes_written, (char *)pdev,
 				  NULL, 0);
-	} /* else if (S_ISFIFO) */
+	}
 	CIFSSMBClose(xid, tcon, fid.netfid);
 	d_drop(direntry);
 

