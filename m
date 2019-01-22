Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A52C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844EE21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169762;
	bh=iwvUfANj9ZdUXnqI5YFac13msViq02pGlOpAL7qJLG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PluJvzwI9hn4pAVwSMYy1oNk7oBSGTrD/HyBAszM+ycqHGz2qKnoAwrqoOh/TKx0H
	 uAAAPKNY8jDlUof7uR9T0ZDvBNGW+6uz3S7mrN8gFikEC2zUcYOm2nsi135GY0DbGm
	 tUMwFDWzZhxzBJmK942DJTdEQ2sAkiTMioakm7xM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfAVPJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbfAVPJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:09:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1DE20879;
        Tue, 22 Jan 2019 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169760;
        bh=iwvUfANj9ZdUXnqI5YFac13msViq02pGlOpAL7qJLG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MITcLvRGgKm+ocULIS1sHM+tQ0nzcDIl8HwCfjcEMR+tPslvYU0rHRWo9XK1YQOfN
         rTHzkqcdLtx9G0aRLdygwLDl0Lnbk3a3mISDGkeK9kv8BPUJAhxaUOxM6voUowCGFo
         BYbsIs4y8hN8WrMCS427C0xYjYCHBe/aJ1Au5Kko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Subject: [PATCH 1/7] scsi: bfa: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:09:00 +0100
Message-Id: <20190122150906.12470-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122150906.12470-1-gregkh@linuxfoundation.org>
References: <20190122150906.12470-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/bfa/bfad_debugfs.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index 349cfe7d055e..ece165851cf6 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -460,11 +460,6 @@ bfad_debugfs_init(struct bfad_port_s *port)
 	if (!bfa_debugfs_root) {
 		bfa_debugfs_root = debugfs_create_dir("bfa", NULL);
 		atomic_set(&bfa_debugfs_port_count, 0);
-		if (!bfa_debugfs_root) {
-			printk(KERN_WARNING
-				"BFA debugfs root dir creation failed\n");
-			goto err;
-		}
 	}
 
 	/* Setup the pci_dev debugfs directory for the port */
@@ -472,12 +467,6 @@ bfad_debugfs_init(struct bfad_port_s *port)
 	if (!port->port_debugfs_root) {
 		port->port_debugfs_root =
 			debugfs_create_dir(name, bfa_debugfs_root);
-		if (!port->port_debugfs_root) {
-			printk(KERN_WARNING
-				"bfa %s: debugfs root creation failed\n",
-				bfad->pci_name);
-			goto err;
-		}
 
 		atomic_inc(&bfa_debugfs_port_count);
 
@@ -489,12 +478,6 @@ bfad_debugfs_init(struct bfad_port_s *port)
 							port->port_debugfs_root,
 							port,
 							file->fops);
-			if (!bfad->bfad_dentry_files[i]) {
-				printk(KERN_WARNING
-					"bfa %s: debugfs %s creation failed\n",
-					bfad->pci_name, file->name);
-				goto err;
-			}
 		}
 	}
 
-- 
2.20.1

