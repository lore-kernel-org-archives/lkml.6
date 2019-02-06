Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD2C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283DD217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfBFKwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:52:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfBFKwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:52:32 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CDFC3132C20E48458067;
        Wed,  6 Feb 2019 18:52:30 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Feb 2019 18:52:23 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/6] hisi_sas: DIX support, performance optimisation, and misc patches
Date:   Wed, 6 Feb 2019 18:52:50 +0800
Message-ID: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces the following:
- DIX support for v3 hw

- Optimisation based on mapping CPUs to queues, much the same as other
  SCSI drivers do today, without exposing > 1 queue to upper layer.

  It is disabled by default and marked as experimental, due to ongoing
  discussion here:
  https://marc.info/?l=linux-scsi&m=154876335707751&w=2

  In addition, hopefully we can eventually expose > 1 queue to upper
  layer and remove the reply_map, if performance issue discussed here has
  a positive outcome:
  https://marc.info/?l=linux-scsi&m=154874776701343&w=2

- And some other minor tidying and a driver debugfs feature  

This series is based on Martin's 5.1 queue +
"scsi: hisi_sas: Set protection parameters prior to adding SCSI host"

John Garry (2):
  scsi: hisi_sas: Issue internal abort on all relevant queues
  scsi: hisi_sas: Do some more tidy-up

Luo Jiaxing (1):
  scsi: hisi_sas: Add manual trigger for debugfs dump

Xiang Chen (3):
  scsi: hisi_sas: Add support for DIX feature for v3 hw
  scsi: hisi_sas: change queue depth from 512 to 4096
  scsi: hisi_sas: Use pci_irq_get_affinity() for v3 hw as experimental

 drivers/scsi/hisi_sas/hisi_sas.h       |  48 +++--
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 237 +++++++++++++++++++++----
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   3 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 157 +++++++++++++---
 5 files changed, 377 insertions(+), 70 deletions(-)

-- 
2.17.1

