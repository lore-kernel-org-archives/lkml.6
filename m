Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64BEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F8920878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhWvLw/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F8920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJBMEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:04:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43071 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:04:38 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so1094831ioa.10;
        Mon, 01 Oct 2018 22:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ae8sSpM0vQ0WX6UMuR6yY2DIJEC73vMziqohwF/+LoM=;
        b=GhWvLw/F5O+lvRRGFrlGYMs7jc8qQ9xLd5qKqlOI7WRDmbKdItuzR3y0FTys511z+U
         HGaBHTrtz/Y8IzzcR5UvYAVeUCzeNcMonxaA8V4N32xZ7O2cj4iRfXY8zLiDV0MeGLKn
         kDR8VFbsQ2d8QAlXBd/n1EsbDQVk0FMZLIwgSF6lBNxCr4rJJjEIPrjDoRGy0wk1hW1o
         6JkYsxMF6+d0N8cXsJXw04DBb0kkwhXcEV4XH7XPw6keRVjUNic0igz3lTBJjkSIGPAG
         oCWri99pVG+ISCvBtcLnvP9bTCNOUcu4dtSqvf9ZS996BmQfdz0ao2w4+hnk//Ej+obS
         UMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ae8sSpM0vQ0WX6UMuR6yY2DIJEC73vMziqohwF/+LoM=;
        b=qn4hlChx48XE/Avvy/Iiq2eHMqFc8S3Cbv96vmtlQrDFqFSyQgCGACbQyDMZ+aXJXC
         7yN6c9gpe8j/VUlCBnmuMEpq9Ti5LZkpTuq3jp/ZyooIZus8AwZEJPGVx4BmabYjSQax
         xWKF+0Px5L7e0eB+odAHE2t2WM7+lOJKdOBmIE9N8vJ0/Kf+UoRphfj4qgj/lhO8wd2o
         UDBrLtrT+PMLKLg2Zv+PcWYtK7d5VVBTihKBEeWGf7+HTe7wLeGkIXYBu9luPPXuh9P6
         218JZHfGOvPYdn2MchZhJZIug6RarZ+6uN1hwdWdFEkHzuFeOf+VaIwXrD7p7lDn32gQ
         4zfQ==
X-Gm-Message-State: ABuFfoigphJeDDLd52lHHBqCeFyHLxx3JXR4OXbPIakRAo3KQ/WSJH2j
        G6s1EnB+ei2s3SN/zLNUs9ci6hKf
X-Google-Smtp-Source: ACcGV602qJaYeG1FOGzRVAU9QIOxLGiRkJA4bqFjq+wM778RbET3FJ8jPlAy4/dqoqwcP20kasgfsA==
X-Received: by 2002:a62:63c2:: with SMTP id x185-v6mr14619663pfb.13.1538457795231;
        Mon, 01 Oct 2018 22:23:15 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.217.11])
        by smtp.gmail.com with ESMTPSA id u9-v6sm22710041pfi.104.2018.10.01.22.23.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 22:23:14 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:56:32 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        sabyasachi.linux@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi/pmcraid.c: Use dma_pool_zalloc
Message-ID: <20181002052631.GA2853@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_pool_alloc + memset with dma_pool_zalloc.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/scsi/pmcraid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 4e86994..84a2734 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4681,7 +4681,7 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 
 	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
 		pinstance->cmd_list[i]->ioa_cb =
-			dma_pool_alloc(
+			dma_pool_zalloc(
 				pinstance->control_pool,
 				GFP_KERNEL,
 				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
@@ -4690,8 +4690,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 			pmcraid_release_control_blocks(pinstance, i);
 			return -ENOMEM;
 		}
-		memset(pinstance->cmd_list[i]->ioa_cb, 0,
-			sizeof(struct pmcraid_control_block));
 	}
 	return 0;
 }
-- 
1.9.1

