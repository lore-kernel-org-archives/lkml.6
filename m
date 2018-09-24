Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846542064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846542064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbeIXVMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:12:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40827 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728816AbeIXVMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:12:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3467646EAA2F5;
        Mon, 24 Sep 2018 23:09:40 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Mon, 24 Sep 2018 23:09:31 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
Date:   Mon, 24 Sep 2018 23:06:27 +0800
Message-ID: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces mostly more minor/obscure bugfixes for the
driver.

Also included is an optimisation to use the block layer tag for the IPTT
indexing. This quite a nice optimisation as it means we don't have to
evaluate this in the driver - it was a bit of a bottle-neck.

However it does block us in future from enabling SCSI MQ in the driver.
This is because the IPTT index must be a unique value per HBA. However,
if we switched to SCSI MQ, the block layer tag becomes unique per queue,
and not per HBA.

Having said this, testing has shown that performance is better by using
this block layer tag instead of enabling SCSI MQ in the driver.

Luo Jiaxing (2):
  scsi: hisi_sas: Feed back linkrate(max/min) when re-attached
  scsi: hisi_sas: Move evaluation of hisi_hba in hisi_sas_task_prep()

Xiang Chen (5):
  scsi: hisi_sas: Fix the race between IO completion and timeout for
    SMP/internal IO
  scsi: hisi_sas: Free slot later in slot_complete_vx_hw()
  scsi: hisi_sas: unmask interrupts ent72 and ent74
  scsi: hisi_sas: Use block layer tag instead for IPTT
  scsi: hisi_sas: Update v3 hw AIP_LIMIT and CFG_AGING_TIME register
    values

 drivers/scsi/hisi_sas/hisi_sas.h       |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 154 ++++++++++++++++++++++++---------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  11 +--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  15 ++--
 5 files changed, 130 insertions(+), 54 deletions(-)

-- 
1.9.1

