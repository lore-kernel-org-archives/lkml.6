Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E6120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E6120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeINQEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:04:23 -0400
Received: from www.osadl.org ([62.245.132.105]:57482 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeINQEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:04:23 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w8EAoApa032592;
        Fri, 14 Sep 2018 12:50:10 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] scsi: core: drop excess unlikely() from BUG_ON()
Date:   Fri, 14 Sep 2018 12:48:27 +0200
Message-Id: <1536922107-2649-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 include/asm-generic/bug.h defines BUG_ON(condition) as
do { if (unlikely(condition)) BUG(); } while (0).
So BUG_ON already provides unlikely() to the condition so there is no point
in having a unlikely(unlikely(condition)) - drop the excess unlikely()

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Found during code review

Patch was compile tested with: x86_64_defconfig (implies CONFIG_SCSI)
SCSI_LOWLEVE=y, SCSI_HISI_SAS=y, COMPILE_TEST=y
(with some unrelated sparse warnings and some pending coccinelle findings)

Patch is against 4.19-rc3 (localversion-next is next-20180913)

 drivers/scsi/scsi_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index eb97d2d..0b4132f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1201,8 +1201,8 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 
 		count = blk_rq_map_integrity_sg(rq->q, rq->bio,
 						prot_sdb->table.sgl);
-		BUG_ON(unlikely(count > ivecs));
-		BUG_ON(unlikely(count > queue_max_integrity_segments(rq->q)));
+		BUG_ON(count > ivecs);
+		BUG_ON(count > queue_max_integrity_segments(rq->q));
 
 		cmd->prot_sdb = prot_sdb;
 		cmd->prot_sdb->table.nents = count;
-- 
2.1.4

