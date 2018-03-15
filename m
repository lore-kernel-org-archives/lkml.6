Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbeCOVbz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:31:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932451AbeCOVbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:31:53 -0400
Subject: [PATCH v2 2/3] vfio/pci: Use endian neutral helpers
From: Alex Williamson <alex.williamson@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        alex.williamson@redhat.com, peterx@redhat.com, eric.auger@redhat.com,
        aik@ozlabs.ru
Date: Thu, 15 Mar 2018 15:31:51 -0600
Message-ID: <20180315213151.15150.70257.stgit@gimli.home>
In-Reply-To: <20180315212634.15150.88094.stgit@gimli.home>
References: <20180315212634.15150.88094.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iowriteXX/ioreadXX functions assume little endian hardware and
convert to little endian on a write and from little endian on a read.
We currently do our own explicit conversion to negate this.  Instead,
add some endian dependent defines to avoid all byte swaps.  There
should be no functional change other than big endian systems aren't
penalized with wasted swaps.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 5f2b376dcebd..925419e0f459 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -21,6 +21,24 @@
 
 #include "vfio_pci_private.h"
 
+#ifdef __LITTLE_ENDIAN
+#define vfio_ioread64	ioread64
+#define vfio_iowrite64	iowrite64
+#define vfio_ioread32	ioread32
+#define vfio_iowrite32	iowrite32
+#define vfio_ioread16	ioread16
+#define vfio_iowrite16	iowrite16
+#else
+#define vfio_ioread64	ioread64be
+#define vfio_iowrite64	iowrite64be
+#define vfio_ioread32	ioread32be
+#define vfio_iowrite32	iowrite32be
+#define vfio_ioread16	ioread16be
+#define vfio_iowrite16	iowrite16be
+#endif
+#define vfio_ioread8	ioread8
+#define vfio_iowrite8	iowrite8
+
 /*
  * Read or write from an __iomem region (MMIO or I/O port) with an excluded
  * range which is inaccessible.  The excluded range drops writes and fills
@@ -44,15 +62,15 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 			fillable = 0;
 
 		if (fillable >= 4 && !(off % 4)) {
-			__le32 val;
+			u32 val;
 
 			if (iswrite) {
 				if (copy_from_user(&val, buf, 4))
 					return -EFAULT;
 
-				iowrite32(le32_to_cpu(val), io + off);
+				vfio_iowrite32(val, io + off);
 			} else {
-				val = cpu_to_le32(ioread32(io + off));
+				val = vfio_ioread32(io + off);
 
 				if (copy_to_user(buf, &val, 4))
 					return -EFAULT;
@@ -60,15 +78,15 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 
 			filled = 4;
 		} else if (fillable >= 2 && !(off % 2)) {
-			__le16 val;
+			u16 val;
 
 			if (iswrite) {
 				if (copy_from_user(&val, buf, 2))
 					return -EFAULT;
 
-				iowrite16(le16_to_cpu(val), io + off);
+				vfio_iowrite16(val, io + off);
 			} else {
-				val = cpu_to_le16(ioread16(io + off));
+				val = vfio_ioread16(io + off);
 
 				if (copy_to_user(buf, &val, 2))
 					return -EFAULT;
@@ -82,9 +100,9 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 				if (copy_from_user(&val, buf, 1))
 					return -EFAULT;
 
-				iowrite8(val, io + off);
+				vfio_iowrite8(val, io + off);
 			} else {
-				val = ioread8(io + off);
+				val = vfio_ioread8(io + off);
 
 				if (copy_to_user(buf, &val, 1))
 					return -EFAULT;
