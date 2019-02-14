Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B4AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F468222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407997AbfBNQho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:37:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405569AbfBNQhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:37:43 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2555249E69B7309B5828;
        Fri, 15 Feb 2019 00:37:33 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Feb 2019 00:37:24 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dann.frazier@canonical.com>,
        <yanaijie@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached
Date:   Fri, 15 Feb 2019 00:37:57 +0800
Message-ID: <1550162277-17615-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs phy_identifier attribute for a sas_end_device comes
from the rphy phy_identifier value.

Currently this is not being set for rphys with an end device attached,
so we see incorrect symlinks from systemd disk/by-path:

root@localhost:~# ls -l /dev/disk/by-path/
total 0
lrwxrwxrwx 1 root root  9 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0 -> ../../sdb
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part2 -> ../../sdb2
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part3 -> ../../sdc3

Indeed, each sas_end_device phy_identifier value is 0:

root@localhost:/# more sys/class/sas_device/end_device-0\:0\:2/phy_identifier
0
root@localhost:/# more sys/class/sas_device/end_device-0\:0\:10/phy_identifier
0

This patch fixes the discovery code to set the phy_identifier.
With this, we now get proper symlinks:

root@localhost:~# ls -l /dev/disk/by-path/
total 0
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy10-lun-0 -> ../../sdg
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy11-lun-0 -> ../../sdh
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy2-lun-0 -> ../../sda
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy2-lun-0-part1 -> ../../sda1
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0 -> ../../sdb
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0-part1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0-part2 -> ../../sdb2
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0 -> ../../sdc
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part1 -> ../../sdc1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part2 -> ../../sdc2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part3 -> ../../sdc3
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy5-lun-0 -> ../../sdd
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0 -> ../../sde
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part1 -> ../../sde1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part2 -> ../../sde2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part3 -> ../../sde3
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0 -> ../../sdf
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part1 -> ../../sdf1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part2 -> ../../sdf2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part3 -> ../../sdf3

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Reported-by: dann frazier <dann.frazier@canonical.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 17eb4185f29d..f21c93bbb35c 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -828,6 +828,7 @@ static struct domain_device *sas_ex_discover_end_dev(
 		rphy = sas_end_device_alloc(phy->port);
 		if (!rphy)
 			goto out_free;
+		rphy->identify.phy_identifier = phy_id;
 
 		child->rphy = rphy;
 		get_device(&rphy->dev);
@@ -854,6 +855,7 @@ static struct domain_device *sas_ex_discover_end_dev(
 
 		child->rphy = rphy;
 		get_device(&rphy->dev);
+		rphy->identify.phy_identifier = phy_id;
 		sas_fill_in_rphy(child, rphy);
 
 		list_add_tail(&child->disco_list_node, &parent->port->disco_list);
-- 
2.17.1

