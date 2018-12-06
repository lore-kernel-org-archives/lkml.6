Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE46B2146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFopDaaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE46B2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeLFXtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:49:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45889 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeLFXtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:49:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so947120pfd.12;
        Thu, 06 Dec 2018 15:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QLrm4SHc02GI3zDMsSJUVjRbsRuR/xOuwMacYyI6Yjc=;
        b=IFopDaaU7PSx5MJt3x6nR+zJQeC/kh9b9JGGvrbP+71FIWG+j9tMAyT+KDYfZni6Wb
         e6kTihuUVjbfcxRY5optAv5wE5S38ZWnrwXpjhj/xrOx0eNXLafRo62gda5mZZs+K5QF
         +U+/fES6waRV4V1J2y/gyKIP1HHmDKFwViehRsyjhBBJQEogPB5HDE/rs9iWpnqkgIR+
         COaS65ErPCFUJgcFvFt2uwt9lc0KzLh9lNm4lCv/nmxDeJ/WNPHMIofL5ZtWZsl318eZ
         aAwzwwdFdqdI5O6RTwyjgBXvcZOzBxAZxiZuBQDZV3dZEH5hy4P+7ddCJ/+f2Dntr6Xh
         VNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QLrm4SHc02GI3zDMsSJUVjRbsRuR/xOuwMacYyI6Yjc=;
        b=plH2ZR2LD45dRgCM589oGt5eHdUnmq5wUvHt4ukJIqwBnNjVc+gAnFwik3AFkVfwf/
         SeIWJRCN6e34uLfQQbSOyoMpRZbjZDyFFCQzkZFJWuYiDwbds8Pb/6VtJCTNWeZDurZY
         2Ll4xs1tnJk4qERt1THQzRPgsqspQGuOZihakAh8JrJuNqN54Bw6N8dHW/XMSKeH8oU/
         JUxbyttr5h96rB/R8hnle2t4eTT4XjCrdp7zF5ZkBFklYF1kLoaYZhy3qZmskxE40bCZ
         +hbPp/i4q5pcZRDpc2/pr3k8Lo4qhftrbRUf5N94q7TCR3LL23y7fE+qgtNg/ytTPUHH
         VchA==
X-Gm-Message-State: AA+aEWZ2ER2TEjAf/4AzM3SGvzBmIQNiOnjciKrSJISOw+zsT84QIxGS
        bXRBtmG1DUs8Y5derH4lFNA=
X-Google-Smtp-Source: AFSGD/WxaMBf8KtmS602GUpe4Cge3G7tWhrVpMAE9JsxhZxaGPRX/R2H+6W5NxpyzCyXGhk9vV/2Zg==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr26257315pgp.263.1544140156447;
        Thu, 06 Dec 2018 15:49:16 -0800 (PST)
Received: from dev-aglagolev.dev.purestorage.com ([192.30.188.252])
        by smtp.googlemail.com with ESMTPSA id y5sm4212107pge.49.2018.12.06.15.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 15:49:15 -0800 (PST)
From:   Anatoliy Glagolev <glagolig@gmail.com>
To:     aglagolev@purestorage.com, adailey@purestorage.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Anatoliy Glagolev <glagolig@gmail.com>
Subject: [PATCH] scsi: qla2xxx: deadlock by configfs_depend_item
Date:   Thu,  6 Dec 2018 16:48:45 -0700
Message-Id: <1544140125-3060-1-git-send-email-glagolig@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent of invoking configfs_depend_item in commit 7474f52a82d51
("tcm_qla2xxx: Perform configfs depend/undepend for base_tpg")
was to prevent a physical Fibre Channel port removal when
virtual (NPIV) ports announced through that physical port are active.
The change does not work as expected: it makes enabled physical port
dependent on target configfs subsystem (the port's parent), something
the configfs guarantees anyway.

Besides, scheduling work in a worker thread and waiting for the work's
completion is not really a valid workaround for the requirement not
to call configfs_depend_item from a configfs callback: the call
occasionally deadlocks.

Thus, removing configfs_depend_item calls does not break anything
and fixes the deadlock problem.

Signed-off-by: Anatoliy Glagolev <glagolig@gmail.com>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 48 +++++++-------------------------------
 drivers/scsi/qla2xxx/tcm_qla2xxx.h |  3 ---
 2 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 7732e93..1c7ca84 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -929,38 +929,14 @@ static ssize_t tcm_qla2xxx_tpg_enable_show(struct config_item *item,
 			atomic_read(&tpg->lport_tpg_enabled));
 }
 
-static void tcm_qla2xxx_depend_tpg(struct work_struct *work)
-{
-	struct tcm_qla2xxx_tpg *base_tpg = container_of(work,
-				struct tcm_qla2xxx_tpg, tpg_base_work);
-	struct se_portal_group *se_tpg = &base_tpg->se_tpg;
-	struct scsi_qla_host *base_vha = base_tpg->lport->qla_vha;
-
-	if (!target_depend_item(&se_tpg->tpg_group.cg_item)) {
-		atomic_set(&base_tpg->lport_tpg_enabled, 1);
-		qlt_enable_vha(base_vha);
-	}
-	complete(&base_tpg->tpg_base_comp);
-}
-
-static void tcm_qla2xxx_undepend_tpg(struct work_struct *work)
-{
-	struct tcm_qla2xxx_tpg *base_tpg = container_of(work,
-				struct tcm_qla2xxx_tpg, tpg_base_work);
-	struct se_portal_group *se_tpg = &base_tpg->se_tpg;
-	struct scsi_qla_host *base_vha = base_tpg->lport->qla_vha;
-
-	if (!qlt_stop_phase1(base_vha->vha_tgt.qla_tgt)) {
-		atomic_set(&base_tpg->lport_tpg_enabled, 0);
-		target_undepend_item(&se_tpg->tpg_group.cg_item);
-	}
-	complete(&base_tpg->tpg_base_comp);
-}
-
 static ssize_t tcm_qla2xxx_tpg_enable_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct se_portal_group *se_tpg = to_tpg(item);
+	struct se_wwn *se_wwn = se_tpg->se_tpg_wwn;
+	struct tcm_qla2xxx_lport *lport = container_of(se_wwn,
+			struct tcm_qla2xxx_lport, lport_wwn);
+	struct scsi_qla_host *vha = lport->qla_vha;
 	struct tcm_qla2xxx_tpg *tpg = container_of(se_tpg,
 			struct tcm_qla2xxx_tpg, se_tpg);
 	unsigned long op;
@@ -979,24 +955,16 @@ static ssize_t tcm_qla2xxx_tpg_enable_store(struct config_item *item,
 		if (atomic_read(&tpg->lport_tpg_enabled))
 			return -EEXIST;
 
-		INIT_WORK(&tpg->tpg_base_work, tcm_qla2xxx_depend_tpg);
+		atomic_set(&tpg->lport_tpg_enabled, 1);
+		qlt_enable_vha(vha);
 	} else {
 		if (!atomic_read(&tpg->lport_tpg_enabled))
 			return count;
 
-		INIT_WORK(&tpg->tpg_base_work, tcm_qla2xxx_undepend_tpg);
+		atomic_set(&tpg->lport_tpg_enabled, 0);
+		qlt_stop_phase1(vha->vha_tgt.qla_tgt);
 	}
-	init_completion(&tpg->tpg_base_comp);
-	schedule_work(&tpg->tpg_base_work);
-	wait_for_completion(&tpg->tpg_base_comp);
 
-	if (op) {
-		if (!atomic_read(&tpg->lport_tpg_enabled))
-			return -ENODEV;
-	} else {
-		if (atomic_read(&tpg->lport_tpg_enabled))
-			return -EPERM;
-	}
 	return count;
 }
 
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.h b/drivers/scsi/qla2xxx/tcm_qla2xxx.h
index 7550ba2..147cf6c 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.h
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.h
@@ -48,9 +48,6 @@ struct tcm_qla2xxx_tpg {
 	struct tcm_qla2xxx_tpg_attrib tpg_attrib;
 	/* Returned by tcm_qla2xxx_make_tpg() */
 	struct se_portal_group se_tpg;
-	/* Items for dealing with configfs_depend_item */
-	struct completion tpg_base_comp;
-	struct work_struct tpg_base_work;
 };
 
 struct tcm_qla2xxx_fc_loopid {
-- 
1.9.1

