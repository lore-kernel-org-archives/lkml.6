Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A036C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A1720825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A1720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeKIXpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:45:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727941AbeKIXps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:48 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C79AE1B55FC4;
        Fri,  9 Nov 2018 22:04:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:04:54 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] hisi_sas: Interrupt aggregation support
Date:   Fri, 9 Nov 2018 22:06:31 +0800
Message-ID: <1541772396-161814-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds 2 forms of interrupt aggregation support to the
driver:
- Interrupt converge: Interrupts from all completion queues can be
		      reported through completion queue #0 interrupt only.
- Interrupt coalesce: Ability to set timeout period at which we report
		      completions on that queue (as an interrupt).
		      The HW report completion interrupt as either
		      happens:
		      - configurable threshold of completions occur
		      - a timeout, so we don't pend indefinitely until
			the threshold is reached

There is also 2 minor patches to fix some register setting and also
rearrange some code for proper condition checking.

Xiang Chen (5):
  scsi: hisi_sas: Create separate host attributes per HBA
  scsi: hisi_sas: Add support for interrupt converge for v3 hw
  scsi: hisi_sas: Add support for interrupt coalescing for v3 hw
  scsi: hisi_sas: Relocate some codes to avoid an unused check
  scsi: hisi_sas: change the time of SAS SSP connection

 drivers/scsi/hisi_sas/hisi_sas.h       |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  50 ++++++------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   7 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   7 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 138 +++++++++++++++++++++++++++++++--
 5 files changed, 168 insertions(+), 37 deletions(-)

-- 
1.9.1

