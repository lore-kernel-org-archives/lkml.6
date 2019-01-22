Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F372C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D315120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169781;
	bh=WLQwn8ifWH9LBps1DAAf8nxz/jyI09snSY9z5Yapczs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AJm3yg4GqID+0gm91eHY6CbNsslCary69K9UEXXQO8BJSuwOS2iPh4/cj/kg7/vjs
	 KW9k6DvekcZKN18P5L5AU6FSWL+T4q0MgWHpn/0dtlbqGPQLWBVouWeWLaWm0WhOZU
	 T/O2/sIU5jYfnBrnTsOMiTM4TvVys596XNSwlOQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfAVPJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfAVPJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:09:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380C420879;
        Tue, 22 Jan 2019 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169776;
        bh=WLQwn8ifWH9LBps1DAAf8nxz/jyI09snSY9z5Yapczs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmbmzoxDKYCddNzsjXIfKlXmqekQ4ekAXBwXaNWH95RglhqqA02MrFE5SSxIA8s5K
         sIiNrjh3UwRu3N+5peZWvmvfxglruuKWtfiRhszck0D3kitaS0xaiRjtl0hC+fr0RM
         U7MxmZYoUsvYrNfeFCUAL48SigSEhGDPw7W9tGxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        qla2xxx-upstream@qlogic.com
Subject: [PATCH 7/7] scsi: qla2xxx: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:09:06 +0100
Message-Id: <20190122150906.12470-8-gregkh@linuxfoundation.org>
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

Cc: qla2xxx-upstream@qlogic.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_dfs.c | 43 +---------------------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 0b190082aa8d..ead17288e2a7 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -446,11 +446,6 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 
 	atomic_set(&qla2x00_dfs_root_count, 0);
 	qla2x00_dfs_root = debugfs_create_dir(QLA2XXX_DRIVER_NAME, NULL);
-	if (!qla2x00_dfs_root) {
-		ql_log(ql_log_warn, vha, 0x00f7,
-		    "Unable to create debugfs root directory.\n");
-		goto out;
-	}
 
 create_dir:
 	if (ha->dfs_dir)
@@ -458,64 +453,28 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 
 	mutex_init(&ha->fce_mutex);
 	ha->dfs_dir = debugfs_create_dir(vha->host_str, qla2x00_dfs_root);
-	if (!ha->dfs_dir) {
-		ql_log(ql_log_warn, vha, 0x00f8,
-		    "Unable to create debugfs ha directory.\n");
-		goto out;
-	}
 
 	atomic_inc(&qla2x00_dfs_root_count);
 
 create_nodes:
 	ha->dfs_fw_resource_cnt = debugfs_create_file("fw_resource_count",
 	    S_IRUSR, ha->dfs_dir, vha, &dfs_fw_resource_cnt_ops);
-	if (!ha->dfs_fw_resource_cnt) {
-		ql_log(ql_log_warn, vha, 0x00fd,
-		    "Unable to create debugFS fw_resource_count node.\n");
-		goto out;
-	}
 
 	ha->dfs_tgt_counters = debugfs_create_file("tgt_counters", S_IRUSR,
 	    ha->dfs_dir, vha, &dfs_tgt_counters_ops);
-	if (!ha->dfs_tgt_counters) {
-		ql_log(ql_log_warn, vha, 0xd301,
-		    "Unable to create debugFS tgt_counters node.\n");
-		goto out;
-	}
 
 	ha->tgt.dfs_tgt_port_database = debugfs_create_file("tgt_port_database",
 	    S_IRUSR,  ha->dfs_dir, vha, &dfs_tgt_port_database_ops);
-	if (!ha->tgt.dfs_tgt_port_database) {
-		ql_log(ql_log_warn, vha, 0xd03f,
-		    "Unable to create debugFS tgt_port_database node.\n");
-		goto out;
-	}
 
 	ha->dfs_fce = debugfs_create_file("fce", S_IRUSR, ha->dfs_dir, vha,
 	    &dfs_fce_ops);
-	if (!ha->dfs_fce) {
-		ql_log(ql_log_warn, vha, 0x00f9,
-		    "Unable to create debugfs fce node.\n");
-		goto out;
-	}
 
 	ha->tgt.dfs_tgt_sess = debugfs_create_file("tgt_sess",
 		S_IRUSR, ha->dfs_dir, vha, &dfs_tgt_sess_ops);
-	if (!ha->tgt.dfs_tgt_sess) {
-		ql_log(ql_log_warn, vha, 0xd040,
-		    "Unable to create debugFS tgt_sess node.\n");
-		goto out;
-	}
 
-	if (IS_QLA27XX(ha) || IS_QLA83XX(ha)) {
+	if (IS_QLA27XX(ha) || IS_QLA83XX(ha))
 		ha->tgt.dfs_naqp = debugfs_create_file("naqp",
 		    0400, ha->dfs_dir, vha, &dfs_naqp_ops);
-		if (!ha->tgt.dfs_naqp) {
-			ql_log(ql_log_warn, vha, 0xd011,
-			    "Unable to create debugFS naqp node.\n");
-			goto out;
-		}
-	}
 out:
 	return 0;
 }
-- 
2.20.1

