Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4141C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28A120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170526;
	bh=uu9nOUkYkUHRSVgVtQxih4MFE2sCqDu4q79zDKWCcME=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Hmfwu7XlCG+JqDxaKQEzXeY5PlQQwNRgeCf2mPUiGB08fEUQqzkK1g1cVv28jY21a
	 VMATJLvUa6YBq3MN1vPg5T+VMr4WTuqZvhtqvs8Ka4bkNcEGgVQffhXy9YfbSB9Xlp
	 yoW6qKb2olRHP+8oj+8CIZFHppssCeF0lPQiF4+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfAVPWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbfAVPWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FDB120879;
        Tue, 22 Jan 2019 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170523;
        bh=uu9nOUkYkUHRSVgVtQxih4MFE2sCqDu4q79zDKWCcME=;
        h=From:To:Cc:Subject:Date:From;
        b=Q758FMofF3STP9a6CmwoKA//0kNzCTYdAc0vNDlFWhRoJx+j9fXWTSeGzisC5qSBV
         iGgkki/dRGVU0+UU2O5prcagLmrvZf65vr3qyXZ1zCwae8KQAaUydzTu/WSVS++Hg/
         a2bCUPKXCGHBCEJalwQLA91drqozxdGbarzKbp6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: pci: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:01 +0100
Message-Id: <20190122152151.16139-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/pci.h |  1 -
 arch/s390/pci/pci_debug.c   | 15 ++++-----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 10fe982f2b4b..4e0efebc56a9 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -148,7 +148,6 @@ struct zpci_dev {
 	enum pci_bus_speed max_bus_speed;
 
 	struct dentry	*debugfs_dev;
-	struct dentry	*debugfs_perf;
 
 	struct s390_domain *s390_domain; /* s390 IOMMU domain data */
 };
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 04388a254ffb..6b48ca7760a7 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -172,21 +172,14 @@ static const struct file_operations debugfs_pci_perf_fops = {
 void zpci_debug_init_device(struct zpci_dev *zdev, const char *name)
 {
 	zdev->debugfs_dev = debugfs_create_dir(name, debugfs_root);
-	if (IS_ERR(zdev->debugfs_dev))
-		zdev->debugfs_dev = NULL;
-
-	zdev->debugfs_perf = debugfs_create_file("statistics",
-				S_IFREG | S_IRUGO | S_IWUSR,
-				zdev->debugfs_dev, zdev,
-				&debugfs_pci_perf_fops);
-	if (IS_ERR(zdev->debugfs_perf))
-		zdev->debugfs_perf = NULL;
+
+	debugfs_create_file("statistics", S_IFREG | S_IRUGO | S_IWUSR,
+			    zdev->debugfs_dev, zdev, &debugfs_pci_perf_fops);
 }
 
 void zpci_debug_exit_device(struct zpci_dev *zdev)
 {
-	debugfs_remove(zdev->debugfs_perf);
-	debugfs_remove(zdev->debugfs_dev);
+	debugfs_remove_recursive(zdev->debugfs_dev);
 }
 
 int __init zpci_debug_init(void)
-- 
2.20.1

