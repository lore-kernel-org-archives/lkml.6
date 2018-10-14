Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68CC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04B420645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04B420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbeJNXnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:43:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35787 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbeJNXLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:46 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0004cI-Dq; Sun, 14 Oct 2018 16:30:26 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000ZO-W0; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Steve French" <smfrench@gmail.com>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Pavel Shilovsky" <pshilov@microsoft.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.69979078@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 278/366] smb3: directory sync should not return an error
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

commit 6e70c267e68d77679534dcf4aaf84e66f2cf1425 upstream.

As with NFS, which ignores sync on directory handles,
fsync on a directory handle is a noop for CIFS/SMB3.
Do not return an error on it.  It breaks some database
apps otherwise.

Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/cifsfs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -899,6 +899,18 @@ const struct inode_operations cifs_symli
 #endif
 };
 
+/*
+ * Directory operations under CIFS/SMB2/SMB3 are synchronous, so fsync()
+ * is a dummy operation.
+ */
+static int cifs_dir_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	cifs_dbg(FYI, "Sync directory - name: %pD datasync: 0x%x\n",
+		 file, datasync);
+
+	return 0;
+}
+
 const struct file_operations cifs_file_ops = {
 	.read = new_sync_read,
 	.write = new_sync_write,
@@ -1018,6 +1030,7 @@ const struct file_operations cifs_dir_op
 	.read    = generic_read_dir,
 	.unlocked_ioctl  = cifs_ioctl,
 	.llseek = generic_file_llseek,
+	.fsync = cifs_dir_fsync,
 };
 
 static void

