Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96098C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577C720C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577C720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeIYIsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:48:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53470 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbeIYIsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:48:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45734E61B7F09;
        Tue, 25 Sep 2018 10:43:27 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Tue, 25 Sep 2018
 10:43:19 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH v3 4/5] scsi: libsas: check the ata device status by ata_dev_enabled()
Date:   Tue, 25 Sep 2018 10:56:53 +0800
Message-ID: <20180925025654.44053-5-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180925025654.44053-1-yanaijie@huawei.com>
References: <20180925025654.44053-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ata device IDENTIFY failed, the ata device status is
ATA_DEV_UNKNOWN. The libata reported like:

[113518.620433] ata5.00: qc timeout (cmd 0xec)
[113518.653646] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)

But libsas verifies the device status by ata_dev_disabled(), which
skipped ATA_DEV_UNKNOWN. This will make libsas think the ata device
probing succeed the device cannot be actually brought up. And even the
new bcast of this device will be considered as flutter and will not
probe this device again.

Change ata_dev_disabled() to !ata_dev_enabled() so that libsas can
deal with this if the ata device probe failed. New bcasts can let us
try to probe the device again and bring it up if it is fine to
IDENTIFY.

Tested-by: Zhou Yupeng <zhouyupeng1@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/libsas/sas_ata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 64a958a99f6a..4f6cdf53e913 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -654,7 +654,7 @@ void sas_probe_sata(struct asd_sas_port *port)
 		/* if libata could not bring the link up, don't surface
 		 * the device
 		 */
-		if (ata_dev_disabled(sas_to_ata_dev(dev)))
+		if (!ata_dev_enabled(sas_to_ata_dev(dev)))
 			sas_fail_probe(dev, __func__, -ENODEV);
 	}
 
-- 
2.14.4

