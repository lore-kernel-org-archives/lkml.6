Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED731C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D7120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169792;
	bh=T/4wqXFPMGbTlBiMa7bOcw0yjzp9WL78NGTBlnd3q2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yp8bbRPC83SaZSzWu+RTwuCByLPbOByQo7DhqVcsfQu42YHIczbOD/mFj2ryCm234
	 mnIf+TBNYY6UJfMbhjLFbFBriImg/tb6U7sBDLUN4T2KHfl1+uuBt0EiHgfbnUkBB7
	 AhaR8+G4g3RPFbhdin9RkGEtrYSUfgX2A+H1LysY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfAVPJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbfAVPJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:09:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD5621726;
        Tue, 22 Jan 2019 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169767;
        bh=T/4wqXFPMGbTlBiMa7bOcw0yjzp9WL78NGTBlnd3q2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHaKroUJo2/iC5DPhvsf85pbViFRFZl5f3lMjyXtNHsfEN5yUQnyxRDHAoOIVVhXk
         3udfaxh1Y5ynI8CouNVLt5qYyr3u+eJtPOZgdJFpKQ/IqHWwBEKosIqW+ZMAhLuPwt
         k4eGBc5Xmj4SoqsWncdFmv6uYpHGm35yLn/+9sbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>
Subject: [PATCH 4/7] scsi: snic: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:09:03 +0100
Message-Id: <20190122150906.12470-5-gregkh@linuxfoundation.org>
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

Cc: Karan Tilak Kumar <kartilak@cisco.com>
Cc: Sesidhar Baddela <sebaddel@cisco.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/snic/snic_debugfs.c | 133 ++++++-------------------------
 drivers/scsi/snic/snic_main.c    |  14 +---
 drivers/scsi/snic/snic_stats.h   |   2 +-
 drivers/scsi/snic/snic_trc.c     |  12 +--
 drivers/scsi/snic/snic_trc.h     |   4 +-
 5 files changed, 32 insertions(+), 133 deletions(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 0abe17c1a73b..2b349365592f 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -30,33 +30,13 @@
  * fnic directory and statistics directory for trace buffer and
  * stats logging
  */
-
-int
-snic_debugfs_init(void)
+void snic_debugfs_init(void)
 {
-	int rc = -1;
-	struct dentry *de = NULL;
-
-	de = debugfs_create_dir("snic", NULL);
-	if (!de) {
-		SNIC_DBG("Cannot create debugfs root\n");
-
-		return rc;
-	}
-	snic_glob->trc_root = de;
-
-	de = debugfs_create_dir("statistics", snic_glob->trc_root);
-	if (!de) {
-		SNIC_DBG("Cannot create Statistics directory\n");
+	snic_glob->trc_root = debugfs_create_dir("snic", NULL);
 
-		return rc;
-	}
-	snic_glob->stats_root = de;
-
-	rc = 0;
-
-	return rc;
-} /* end of snic_debugfs_init */
+	snic_glob->stats_root = debugfs_create_dir("statistics",
+						   snic_glob->trc_root);
+}
 
 /*
  * snic_debugfs_term - Tear down debugfs intrastructure
@@ -391,56 +371,23 @@ static const struct file_operations snic_reset_stats_fops = {
  * It will create file stats and reset_stats under statistics/host# directory
  * to log per snic stats
  */
-int
-snic_stats_debugfs_init(struct snic *snic)
+void snic_stats_debugfs_init(struct snic *snic)
 {
-	int rc = -1;
 	char name[16];
-	struct dentry *de = NULL;
 
 	snprintf(name, sizeof(name), "host%d", snic->shost->host_no);
-	if (!snic_glob->stats_root) {
-		SNIC_DBG("snic_stats root doesn't exist\n");
-
-		return rc;
-	}
-
-	de = debugfs_create_dir(name, snic_glob->stats_root);
-	if (!de) {
-		SNIC_DBG("Cannot create host directory\n");
-
-		return rc;
-	}
-	snic->stats_host = de;
-
-	de = debugfs_create_file("stats",
-				S_IFREG|S_IRUGO,
-				snic->stats_host,
-				snic,
-				&snic_stats_fops);
-	if (!de) {
-		SNIC_DBG("Cannot create host's stats file\n");
-
-		return rc;
-	}
-	snic->stats_file = de;
-
-	de = debugfs_create_file("reset_stats",
-				S_IFREG|S_IRUGO|S_IWUSR,
-				snic->stats_host,
-				snic,
-				&snic_reset_stats_fops);
 
-	if (!de) {
-		SNIC_DBG("Cannot create host's reset_stats file\n");
+	snic->stats_host = debugfs_create_dir(name, snic_glob->stats_root);
 
-		return rc;
-	}
-	snic->reset_stats_file = de;
-	rc = 0;
+	snic->stats_file = debugfs_create_file("stats", S_IFREG|S_IRUGO,
+					       snic->stats_host, snic,
+					       &snic_stats_fops);
 
-	return rc;
-} /* end of snic_stats_debugfs_init */
+	snic->reset_stats_file = debugfs_create_file("reset_stats",
+						     S_IFREG|S_IRUGO|S_IWUSR,
+						     snic->stats_host, snic,
+						     &snic_reset_stats_fops);
+}
 
 /*
  * snic_stats_debugfs_remove - Tear down debugfs infrastructure of stats
@@ -517,46 +464,18 @@ static const struct file_operations snic_trc_fops = {
  * snic_trc_debugfs_init : creates trace/tracing_enable files for trace
  * under debugfs
  */
-int
-snic_trc_debugfs_init(void)
+void snic_trc_debugfs_init(void)
 {
-	struct dentry *de = NULL;
-	int ret = -1;
-
-	if (!snic_glob->trc_root) {
-		SNIC_ERR("Debugfs root directory for snic doesn't exist.\n");
-
-		return ret;
-	}
-
-	de = debugfs_create_bool("tracing_enable",
-				 S_IFREG | S_IRUGO | S_IWUSR,
-				 snic_glob->trc_root,
-				 &snic_glob->trc.enable);
-
-	if (!de) {
-		SNIC_ERR("Can't create trace_enable file.\n");
-
-		return ret;
-	}
-	snic_glob->trc.trc_enable = de;
-
-	de = debugfs_create_file("trace",
-				 S_IFREG | S_IRUGO | S_IWUSR,
-				 snic_glob->trc_root,
-				 NULL,
-				 &snic_trc_fops);
-
-	if (!de) {
-		SNIC_ERR("Cannot create trace file.\n");
-
-		return ret;
-	}
-	snic_glob->trc.trc_file = de;
-	ret = 0;
-
-	return ret;
-} /* end of snic_trc_debugfs_init */
+	snic_glob->trc.trc_enable = debugfs_create_bool("tracing_enable",
+							S_IFREG | S_IRUGO | S_IWUSR,
+							snic_glob->trc_root,
+							&snic_glob->trc.enable);
+
+	snic_glob->trc.trc_file = debugfs_create_file("trace",
+						      S_IFREG | S_IRUGO | S_IWUSR,
+						      snic_glob->trc_root, NULL,
+						      &snic_trc_fops);
+}
 
 /*
  * snic_trc_debugfs_term : cleans up the files created for trace under debugfs
diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.c
index 5e824fd6047a..14f4ce665e58 100644
--- a/drivers/scsi/snic/snic_main.c
+++ b/drivers/scsi/snic/snic_main.c
@@ -397,12 +397,7 @@ snic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
 #ifdef CONFIG_SCSI_SNIC_DEBUG_FS
 	/* Per snic debugfs init */
-	ret = snic_stats_debugfs_init(snic);
-	if (ret) {
-		SNIC_HOST_ERR(snic->shost,
-			      "Failed to initialize debugfs stats\n");
-		snic_stats_debugfs_remove(snic);
-	}
+	snic_stats_debugfs_init(snic);
 #endif
 
 	/* Setup PCI Resources */
@@ -850,12 +845,7 @@ snic_global_data_init(void)
 #ifdef CONFIG_SCSI_SNIC_DEBUG_FS
 	/* Debugfs related Initialization */
 	/* Create debugfs entries for snic */
-	ret = snic_debugfs_init();
-	if (ret < 0) {
-		SNIC_ERR("Failed to create sysfs dir for tracing and stats.\n");
-		snic_debugfs_term();
-		/* continue even if it fails */
-	}
+	snic_debugfs_init();
 
 	/* Trace related Initialization */
 	/* Allocate memory for trace buffer */
diff --git a/drivers/scsi/snic/snic_stats.h b/drivers/scsi/snic/snic_stats.h
index fd1066b1cad5..faf0cb601954 100644
--- a/drivers/scsi/snic/snic_stats.h
+++ b/drivers/scsi/snic/snic_stats.h
@@ -99,7 +99,7 @@ struct snic_stats {
 	atomic64_t io_cmpl_skip;
 };
 
-int snic_stats_debugfs_init(struct snic *);
+void snic_stats_debugfs_init(struct snic *);
 void snic_stats_debugfs_remove(struct snic *);
 
 /* Auxillary function to update active IO counter */
diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
index 458eaba24c78..f23fe2f88438 100644
--- a/drivers/scsi/snic/snic_trc.c
+++ b/drivers/scsi/snic/snic_trc.c
@@ -138,12 +138,7 @@ snic_trc_init(void)
 	trc->buf = (struct snic_trc_data *) tbuf;
 	spin_lock_init(&trc->lock);
 
-	ret = snic_trc_debugfs_init();
-	if (ret) {
-		SNIC_ERR("Failed to create Debugfs Files.\n");
-
-		goto error;
-	}
+	snic_trc_debugfs_init();
 
 	trc->max_idx = (tbuf_sz / SNIC_TRC_ENTRY_SZ);
 	trc->rd_idx = trc->wr_idx = 0;
@@ -152,11 +147,6 @@ snic_trc_init(void)
 		  tbuf_sz / PAGE_SIZE);
 	ret = 0;
 
-	return ret;
-
-error:
-	snic_trc_free();
-
 	return ret;
 } /* end of snic_trc_init */
 
diff --git a/drivers/scsi/snic/snic_trc.h b/drivers/scsi/snic/snic_trc.h
index b37f8867bfde..87dcc7457d15 100644
--- a/drivers/scsi/snic/snic_trc.h
+++ b/drivers/scsi/snic/snic_trc.h
@@ -53,12 +53,12 @@ struct snic_trc {
 
 int snic_trc_init(void);
 void snic_trc_free(void);
-int snic_trc_debugfs_init(void);
+void snic_trc_debugfs_init(void);
 void snic_trc_debugfs_term(void);
 struct snic_trc_data *snic_get_trc_buf(void);
 int snic_get_trc_data(char *buf, int buf_sz);
 
-int snic_debugfs_init(void);
+void snic_debugfs_init(void);
 void snic_debugfs_term(void);
 
 static inline void
-- 
2.20.1

