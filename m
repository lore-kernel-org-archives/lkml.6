Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935955AbeEYMy3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:54:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:40260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753104AbeEYMxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:53:38 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: [PATCH 2/3] nvme multipath: added SUBSYS_ATTR_RW
Date: Fri, 25 May 2018 14:53:21 +0200
Message-Id: <20180525125322.15398-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180525125322.15398-1-jthumshirn@suse.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

Prep for adding dev_attr in addition to subsys_attr for 'mpath_personality'.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3a1c70bd9008..7105980dde3f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2082,13 +2082,15 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 	return NULL;
 }
 
-#define SUBSYS_ATTR_RW(_name)			      \
-	struct device_attribute subsys_attr_##_name = \
-		__ATTR_RW(_name)
+#define SUBSYS_ATTR(_name, _mode, _show, _store)		\
+	struct device_attribute subsys_attr_##_name =		\
+		__ATTR(_name, _mode, _show, _store)
 
-#define SUBSYS_ATTR_RO(_name, _mode, _show)			\
-	struct device_attribute subsys_attr_##_name = \
-		__ATTR(_name, _mode, _show, NULL)
+#define SUBSYS_ATTR_RO(_name, _show)		\
+	SUBSYS_ATTR(_name, 0444, _show, NULL)
+
+#define SUBSYS_ATTR_RW(_name, _show, _store)	\
+	SUBSYS_ATTR(_name, 0644, _show, _store)
 
 static ssize_t nvme_subsys_show_nqn(struct device *dev,
 				    struct device_attribute *attr,
@@ -2099,7 +2101,7 @@ static ssize_t nvme_subsys_show_nqn(struct device *dev,
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", subsys->subnqn);
 }
-static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
+static SUBSYS_ATTR_RO(subsysnqn, nvme_subsys_show_nqn);
 
 #define nvme_subsys_show_str_function(field)				\
 static ssize_t subsys_##field##_show(struct device *dev,		\
@@ -2110,17 +2112,16 @@ static ssize_t subsys_##field##_show(struct device *dev,		\
 	return sprintf(buf, "%.*s\n",					\
 		       (int)sizeof(subsys->field), subsys->field);	\
 }									\
-static SUBSYS_ATTR_RO(field, S_IRUGO, subsys_##field##_show);
+static SUBSYS_ATTR_RO(field, subsys_##field##_show);
 
 nvme_subsys_show_str_function(model);
 nvme_subsys_show_str_function(serial);
 nvme_subsys_show_str_function(firmware_rev);
 
-
 #ifdef CONFIG_NVME_MULTIPATH
-static ssize_t mpath_personality_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
+static ssize_t nvme_subsys_show_mpath_personality(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
 {
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
@@ -2134,9 +2135,9 @@ static ssize_t mpath_personality_show(struct device *dev,
 	return ret;
 }
 
-static ssize_t mpath_personality_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t nvme_subsys_store_mpath_personality(struct device *dev,
+						   struct device_attribute *attr,
+						   const char *buf, size_t count)
 {
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
@@ -2161,7 +2162,8 @@ static ssize_t mpath_personality_store(struct device *dev,
 out:
 	return ret ? ret : count;
 }
-static SUBSYS_ATTR_RW(mpath_personality);
+static SUBSYS_ATTR_RW(mpath_personality, nvme_subsys_show_mpath_personality,
+		      nvme_subsys_store_mpath_personality);
 #endif
 
 static struct attribute *nvme_subsys_attrs[] = {
-- 
2.16.3
