Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeDEKtZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:49:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751312AbeDEKtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:49:23 -0400
From: Pankaj Gupta <pagupta@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com,
        david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org,
        marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com,
        imammedo@redhat.com, pagupta@redhat.com
Subject: [RFC 2/2] pmem: device flush over VIRTIO
Date: Thu,  5 Apr 2018 16:18:33 +0530
Message-Id: <20180405104834.10457-3-pagupta@redhat.com>
In-Reply-To: <20180405104834.10457-1-pagupta@redhat.com>
References: <20180405104834.10457-1-pagupta@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch adds functionality to perform flush
 from guest to host over VIRTIO when 'ND_REGION_VIRTIO' 
 flag is set on nd_negion. This flag is set by 'virtio-pmem' 
 driver for virtio flush operation. 

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/nvdimm/region_devs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index abaf38c..1c6cd2a 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -20,6 +20,7 @@
 #include <linux/nd.h>
 #include "nd-core.h"
 #include "nd.h"
+#include <linux/virtio_pmem.h>
 
 /*
  * For readq() and writeq() on 32-bit builds, the hi-lo, lo-hi order is
@@ -1043,6 +1044,12 @@ void nvdimm_flush(struct nd_region *nd_region)
 	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
 	int i, idx;
 
+       /* call PV device flush */
+	if (test_bit(ND_REGION_VIRTIO, &nd_region->flags)) {
+		virtio_pmem_flush(&nd_region->dev);
+		return;
+	}
+
 	/*
 	 * Try to encourage some diversity in flush hint addresses
 	 * across cpus assuming a limited number of flush hints.
-- 
2.9.3
