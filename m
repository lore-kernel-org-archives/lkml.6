Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64747C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2262176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbeLTIZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:25:09 -0500
Received: from ozlabs.ru ([107.173.13.209]:54979 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731110AbeLTIZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:25:07 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id BE537AE80491;
        Thu, 20 Dec 2018 03:25:01 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH kernel v7 19/20] vfio_pci: Allow regions to add own capabilities
Date:   Thu, 20 Dec 2018 19:23:49 +1100
Message-Id: <20181220082350.58113-20-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFIO regions already support region capabilities with a limited set of
fields. However the subdriver might have to report to the userspace
additional bits.

This adds an add_capability() hook to vfio_pci_regops.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v3:
* removed confusing rationale for the patch, the next patch makes
use of it anyway
---
 drivers/vfio/pci/vfio_pci_private.h | 3 +++
 drivers/vfio/pci/vfio_pci.c         | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 86aab05..93c1738 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -62,6 +62,9 @@ struct vfio_pci_regops {
 	int	(*mmap)(struct vfio_pci_device *vdev,
 			struct vfio_pci_region *region,
 			struct vm_area_struct *vma);
+	int	(*add_capability)(struct vfio_pci_device *vdev,
+				  struct vfio_pci_region *region,
+				  struct vfio_info_cap *caps);
 };
 
 struct vfio_pci_region {
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 4a6f7c0..6cb70cf 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -763,6 +763,12 @@ static long vfio_pci_ioctl(void *device_data,
 			if (ret)
 				return ret;
 
+			if (vdev->region[i].ops->add_capability) {
+				ret = vdev->region[i].ops->add_capability(vdev,
+						&vdev->region[i], &caps);
+				if (ret)
+					return ret;
+			}
 		}
 		}
 
-- 
2.17.1

