Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeE3LrC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:47:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60660 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751772AbeE3LG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:57 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "chenqilin" <chenqilin2@huawei.com>,
        "Hannes Reinecke" <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "chenxiang" <chenxiang66@hisilicon.com>,
        "Jason Yan" <yanaijie@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.298555599@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 019/153] scsi: libsas: fix memory leak in
 sas_smp_get_phy_events()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>

commit 4a491b1ab11ca0556d2fda1ff1301e862a2d44c4 upstream.

We've got a memory leak with the following producer:

while true;
do cat /sys/class/sas_phy/phy-1:0:12/invalid_dword_count >/dev/null;
done

The buffer req is allocated and not freed after we return. Fix it.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: chenqilin <chenqilin2@huawei.com>
CC: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/libsas/sas_expander.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -566,6 +566,7 @@ int sas_smp_get_phy_events(struct sas_ph
 	phy->phy_reset_problem_count = scsi_to_u32(&resp[24]);
 
  out:
+	kfree(req);
 	kfree(resp);
 	return res;
 
