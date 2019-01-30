Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD09C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5BF21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfA3I0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:26:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730249AbfA3IZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:25:58 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0827A44E62DB6304100;
        Wed, 30 Jan 2019 16:25:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 16:25:48 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>,
        <tj@kernel.org>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH v2 4/7] scsi: libsas: split the replacement of sas disks in two steps
Date:   Wed, 30 Jan 2019 16:24:09 +0800
Message-ID: <20190130082412.9357-5-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190130082412.9357-1-yanaijie@huawei.com>
References: <20190130082412.9357-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now if a new device replaced a old device, the sas address will change.
We unregister the old device and discover the new device in one
revalidation process. But after we deferred the sas_port_delete(), the
sas port is not deleted when we registering the new port and device.
The sas port cannot be added because the name of the new port is the
same as the old.

Fix this by doing the replacement in two steps. The first revalidation
only delete the old device and trigger a new revalidation. The second
revalidation discover the new device. To keep the event processing
synchronised to the original event, we wrapped a loop and added a new
parameter to see if we should revalidate again.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: chenxiang <chenxiang66@hisilicon.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/libsas/sas_discover.c | 20 +++++++++++++++-----
 drivers/scsi/libsas/sas_expander.c | 20 ++++++++++++++------
 include/scsi/libsas.h              |  2 +-
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index ffc571a12916..c825c89fbddd 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -498,12 +498,10 @@ static void sas_discover_domain(struct work_struct *work)
 		 task_pid_nr(current), error);
 }
 
-static void sas_revalidate_domain(struct work_struct *work)
+static void sas_do_revalidate_domain(struct asd_sas_port *port, bool *retry)
 {
-	struct sas_discovery_event *ev = to_sas_discovery_event(work);
-	struct asd_sas_port *port = ev->port;
-	struct sas_ha_struct *ha = port->ha;
 	struct domain_device *ddev = port->port_dev;
+	struct sas_ha_struct *ha = port->ha;
 
 	/* prevent revalidation from finding sata links in recovery */
 	mutex_lock(&ha->disco_mutex);
@@ -520,7 +518,7 @@ static void sas_revalidate_domain(struct work_struct *work)
 
 	if (ddev && (ddev->dev_type == SAS_FANOUT_EXPANDER_DEVICE ||
 		     ddev->dev_type == SAS_EDGE_EXPANDER_DEVICE))
-		sas_ex_revalidate_domain(ddev);
+		sas_ex_revalidate_domain(ddev, retry);
 
 	pr_debug("done REVALIDATING DOMAIN on port %d, pid:%d\n",
 		 port->id, task_pid_nr(current));
@@ -532,6 +530,18 @@ static void sas_revalidate_domain(struct work_struct *work)
 	sas_probe_devices(port);
 }
 
+static void sas_revalidate_domain(struct work_struct *work)
+{
+	struct sas_discovery_event *ev = to_sas_discovery_event(work);
+	struct asd_sas_port *port = ev->port;
+	bool retry;
+
+	do {
+		retry = false;
+		sas_do_revalidate_domain(port, &retry);
+	} while (retry);
+}
+
 /* ---------- Events ---------- */
 
 static void sas_chain_work(struct sas_ha_struct *ha, struct sas_work *sw)
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 5cd720f93f96..cdbf8d8a28bf 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1994,7 +1994,8 @@ static bool dev_type_flutter(enum sas_device_type new, enum sas_device_type old)
 	return false;
 }
 
-static int sas_rediscover_dev(struct domain_device *dev, int phy_id, bool last)
+static int sas_unregister(struct domain_device *dev, int phy_id, bool last,
+			      bool *retry)
 {
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *phy = &ex->ex_phy[phy_id];
@@ -2045,7 +2046,12 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id, bool last)
 		SAS_ADDR(phy->attached_sas_addr));
 	sas_unregister_devs_sas_addr(dev, phy_id, last);
 
-	return sas_discover_new(dev, phy_id);
+	/* force the next revalidation find this phy and bring it up */
+	phy->phy_change_count = -1;
+	ex->ex_change_count = -1;
+	*retry = true;
+
+	return 0;
 }
 
 /**
@@ -2062,7 +2068,8 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id, bool last)
  * first phy,for other phys in this port, we add it to the port to
  * forming the wide-port.
  */
-static void sas_rediscover(struct domain_device *dev, const int phy_id)
+static void sas_rediscover(struct domain_device *dev, const int phy_id,
+			   bool *retry)
 {
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *changed_phy = &ex->ex_phy[phy_id];
@@ -2087,7 +2094,7 @@ static void sas_rediscover(struct domain_device *dev, const int phy_id)
 				break;
 			}
 		}
-		res = sas_rediscover_dev(dev, phy_id, last);
+		res = sas_unregister(dev, phy_id, last, retry);
 	} else
 		res = sas_discover_new(dev, phy_id);
 
@@ -2098,13 +2105,14 @@ static void sas_rediscover(struct domain_device *dev, const int phy_id)
 /**
  * sas_ex_revalidate_domain - revalidate the domain
  * @port_dev: port domain device.
+ * @retry: do we need to revalidate again
  *
  * NOTE: this process _must_ quit (return) as soon as any connection
  * errors are encountered.  Connection recovery is done elsewhere.
  * Discover process only interrogates devices in order to discover the
  * domain.
  */
-void sas_ex_revalidate_domain(struct domain_device *port_dev)
+void sas_ex_revalidate_domain(struct domain_device *port_dev, bool *retry)
 {
 	int res;
 	struct domain_device *dev = NULL;
@@ -2119,7 +2127,7 @@ void sas_ex_revalidate_domain(struct domain_device *port_dev)
 			res = sas_find_bcast_phy(dev, &phy_id, i, true);
 			if (phy_id == -1)
 				break;
-			sas_rediscover(dev, phy_id);
+			sas_rediscover(dev, phy_id, retry);
 			i = phy_id + 1;
 		} while (i < ex->num_phys);
 	}
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index e557bcb0c266..deb75765e555 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -692,7 +692,7 @@ int  sas_discover_root_expander(struct domain_device *);
 
 void sas_init_ex_attr(void);
 
-void sas_ex_revalidate_domain(struct domain_device *);
+void sas_ex_revalidate_domain(struct domain_device *port_dev, bool *retry);
 
 void sas_unregister_domain_devices(struct asd_sas_port *port, int gone);
 void sas_init_disc(struct sas_discovery *disc, struct asd_sas_port *);
-- 
2.14.4

