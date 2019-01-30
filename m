Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C8C282D6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBF121473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfA3IZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:25:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728191AbfA3IZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:25:54 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CAC2DE3ADE173F8FFBA1;
        Wed, 30 Jan 2019 16:25:51 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 16:25:44 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>,
        <tj@kernel.org>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 0/7] libsas: fix issue of swapping or replacing disks
Date:   Wed, 30 Jan 2019 16:24:05 +0800
Message-ID: <20190130082412.9357-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The work flow of revalidation now is scanning expander phy by the
sequence of the phy and check if the phy have changed. This will leads
to some issues of swapping disks or replacing a disk with a new one.

This patchset addresses the issues above by these main changes:
1. Let the revalidation first scan all phys, mark all changed phys, then
revalidate in two steps. First check if we need to unregister some devices.
if we need to unregister some devices, tell the upper revalidation that we
need to revalidate again. Second, if no devices need to be unregistered,
discover new devices.
2. For sata disk, checking the ata devices class and id to ensure
the same device after flutter.

v1->v2:
1. Do not raise a new bcast but use a loop in sas_revalidate_domain() to
retry revalidation if we need to revalidate again. So that we can do the 
bcast event processing synchronised to the original event
2. Drop some patches splitted from this patchset:
   https://lkml.org/lkml/2018/9/25/153
3. Drop the SATA PHY connection rate matching patch since John had a better
solution for the device discovery phase.
   https://lkml.org/lkml/2019/1/4/340
4. Re-init negotiated_linkrate when PHY is down.
5. Fix an issue when event in queue reached the limit.

Jason Yan (7):
  scsi: libsas: reset the negotiated_linkrate when phy is down
  scsi: libsas: only clear phy->in_shutdown after shutdown event done
  scsi: libsas: optimize the debug print of the revalidate process
  scsi: libsas: split the replacement of sas disks in two steps
  scsi: libsas: check if the same device when flutter
  scsi: libsas: reset the phy address if discover failed
  scsi: libsas: fix issue of swapping two sas disks

 drivers/ata/libata-core.c          |   3 +-
 drivers/scsi/libsas/sas_ata.c      |  18 +++
 drivers/scsi/libsas/sas_discover.c |  25 ++--
 drivers/scsi/libsas/sas_expander.c | 239 +++++++++++++++++++++++++++----------
 drivers/scsi/libsas/sas_phy.c      |   3 +-
 include/linux/libata.h             |   2 +
 include/scsi/libsas.h              |   6 +-
 7 files changed, 224 insertions(+), 72 deletions(-)

-- 
2.14.4

