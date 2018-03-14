Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeCNSZy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:25:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55037 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751700AbeCNSZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:25:51 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/3] libnvdimm: provide module_nd_driver wrapper
Date: Wed, 14 Mar 2018 19:25:06 +0100
Message-Id: <20180314182508.10351-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180314182508.10351-1-jthumshirn@suse.de>
References: <20180314182508.10351-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a module_nd_driver() wrapper over simple nd_driver_register()
nd_driver_unregister() combinations in module_init() and module_exit()
respectively.

Note an explicit nd_driver_unregister() had to be implemented as nd
bus drivers did call device_unregister() direcly in the module_exit()
function.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/linux/nd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nd.h b/include/linux/nd.h
index 5dc6b695437d..43c181a6add5 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -180,6 +180,12 @@ struct nd_region;
 void nvdimm_region_notify(struct nd_region *nd_region, enum nvdimm_event event);
 int __must_check __nd_driver_register(struct nd_device_driver *nd_drv,
 		struct module *module, const char *mod_name);
+static inline void nd_driver_unregister(struct nd_device_driver *drv)
+{
+	driver_unregister(&drv->drv);
+}
 #define nd_driver_register(driver) \
 	__nd_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
+#define module_nd_driver(driver) \
+	module_driver(driver, nd_driver_register, nd_driver_unregister)
 #endif /* __LINUX_ND_H__ */
-- 
2.13.6
