Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163538AbeBOVdx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:33:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163497AbeBOVdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:50 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v15 09/11] fw_cfg: add DMA register
Date: Thu, 15 Feb 2018 22:33:10 +0100
Message-Id: <20180215213312.29234-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180215213312.29234-1-marcandre.lureau@redhat.com>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional <dma_off> kernel module (or command line) parameter
using the following syntax:

      [qemu_fw_cfg.]ioport=<size>@<base>[:<ctrl_off>:<data_off>[:<dma_off>]]
 or
      [qemu_fw_cfg.]mmio=<size>@<base>[:<ctrl_off>:<data_off>[:<dma_off>]]

and initializes the register address using given or default offset.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gabriel Somlo <somlo@cmu.edu>
---
 drivers/firmware/qemu_fw_cfg.c | 53 ++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 5e6e5ac71dab..c28bec4b5663 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -10,20 +10,21 @@
  * and select subsets of aarch64), a Device Tree node (on arm), or using
  * a kernel module (or command line) parameter with the following syntax:
  *
- *      [qemu_fw_cfg.]ioport=<size>@<base>[:<ctrl_off>:<data_off>]
+ *      [qemu_fw_cfg.]ioport=<size>@<base>[:<ctrl_off>:<data_off>[:<dma_off>]]
  * or
- *      [qemu_fw_cfg.]mmio=<size>@<base>[:<ctrl_off>:<data_off>]
+ *      [qemu_fw_cfg.]mmio=<size>@<base>[:<ctrl_off>:<data_off>[:<dma_off>]]
  *
  * where:
  *      <size>     := size of ioport or mmio range
  *      <base>     := physical base address of ioport or mmio range
  *      <ctrl_off> := (optional) offset of control register
  *      <data_off> := (optional) offset of data register
+ *      <dma_off> := (optional) offset of dma register
  *
  * e.g.:
- *      qemu_fw_cfg.ioport=2@0x510:0:1		(the default on x86)
+ *      qemu_fw_cfg.ioport=12@0x510:0:1:4	(the default on x86)
  * or
- *      qemu_fw_cfg.mmio=0xA@0x9020000:8:0	(the default on arm)
+ *      qemu_fw_cfg.mmio=16@0x9020000:8:0:16	(the default on arm)
  */
 
 #include <linux/module.h>
@@ -45,6 +46,7 @@ static resource_size_t fw_cfg_p_size;
 static void __iomem *fw_cfg_dev_base;
 static void __iomem *fw_cfg_reg_ctrl;
 static void __iomem *fw_cfg_reg_data;
+static void __iomem *fw_cfg_reg_dma;
 
 /* atomic access to fw_cfg device (potentially slow i/o, so using mutex) */
 static DEFINE_MUTEX(fw_cfg_dev_lock);
@@ -104,12 +106,14 @@ static void fw_cfg_io_cleanup(void)
 # if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
 #  define FW_CFG_CTRL_OFF 0x08
 #  define FW_CFG_DATA_OFF 0x00
+#  define FW_CFG_DMA_OFF 0x10
 # elif (defined(CONFIG_PPC_PMAC) || defined(CONFIG_SPARC32)) /* ppc/mac,sun4m */
 #  define FW_CFG_CTRL_OFF 0x00
 #  define FW_CFG_DATA_OFF 0x02
 # elif (defined(CONFIG_X86) || defined(CONFIG_SPARC64)) /* x86, sun4u */
 #  define FW_CFG_CTRL_OFF 0x00
 #  define FW_CFG_DATA_OFF 0x01
+#  define FW_CFG_DMA_OFF 0x04
 # else
 #  error "QEMU FW_CFG not available on this architecture!"
 # endif
@@ -119,7 +123,7 @@ static void fw_cfg_io_cleanup(void)
 static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 {
 	char sig[FW_CFG_SIG_SIZE];
-	struct resource *range, *ctrl, *data;
+	struct resource *range, *ctrl, *data, *dma;
 
 	/* acquire i/o range details */
 	fw_cfg_is_mmio = false;
@@ -156,6 +160,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 	/* were custom register offsets provided (e.g. on the command line)? */
 	ctrl = platform_get_resource_byname(pdev, IORESOURCE_REG, "ctrl");
 	data = platform_get_resource_byname(pdev, IORESOURCE_REG, "data");
+	dma = platform_get_resource_byname(pdev, IORESOURCE_REG, "dma");
 	if (ctrl && data) {
 		fw_cfg_reg_ctrl = fw_cfg_dev_base + ctrl->start;
 		fw_cfg_reg_data = fw_cfg_dev_base + data->start;
@@ -165,6 +170,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 		fw_cfg_reg_data = fw_cfg_dev_base + FW_CFG_DATA_OFF;
 	}
 
+	if (dma)
+		fw_cfg_reg_dma = fw_cfg_dev_base + dma->start;
+#ifdef FW_CFG_DMA_OFF
+	else
+		fw_cfg_reg_dma = fw_cfg_dev_base + FW_CFG_DMA_OFF;
+#endif
+
 	/* verify fw_cfg device signature */
 	if (fw_cfg_read_blob(FW_CFG_SIGNATURE, sig,
 				0, FW_CFG_SIG_SIZE) < 0 ||
@@ -630,6 +642,7 @@ static struct platform_device *fw_cfg_cmdline_dev;
 /* use special scanf/printf modifier for phys_addr_t, resource_size_t */
 #define PH_ADDR_SCAN_FMT "@%" __PHYS_ADDR_PREFIX "i%n" \
 			 ":%" __PHYS_ADDR_PREFIX "i" \
+			 ":%" __PHYS_ADDR_PREFIX "i%n" \
 			 ":%" __PHYS_ADDR_PREFIX "i%n"
 
 #define PH_ADDR_PR_1_FMT "0x%" __PHYS_ADDR_PREFIX "x@" \
@@ -639,12 +652,15 @@ static struct platform_device *fw_cfg_cmdline_dev;
 			 ":%" __PHYS_ADDR_PREFIX "u" \
 			 ":%" __PHYS_ADDR_PREFIX "u"
 
+#define PH_ADDR_PR_4_FMT PH_ADDR_PR_3_FMT \
+			 ":%" __PHYS_ADDR_PREFIX "u"
+
 static int fw_cfg_cmdline_set(const char *arg, const struct kernel_param *kp)
 {
-	struct resource res[3] = {};
+	struct resource res[4] = {};
 	char *str;
 	phys_addr_t base;
-	resource_size_t size, ctrl_off, data_off;
+	resource_size_t size, ctrl_off, data_off, dma_off;
 	int processed, consumed = 0;
 
 	/* only one fw_cfg device can exist system-wide, so if one
@@ -660,19 +676,20 @@ static int fw_cfg_cmdline_set(const char *arg, const struct kernel_param *kp)
 	/* consume "<size>" portion of command line argument */
 	size = memparse(arg, &str);
 
-	/* get "@<base>[:<ctrl_off>:<data_off>]" chunks */
+	/* get "@<base>[:<ctrl_off>:<data_off>[:<dma_off>]]" chunks */
 	processed = sscanf(str, PH_ADDR_SCAN_FMT,
 			   &base, &consumed,
-			   &ctrl_off, &data_off, &consumed);
+			   &ctrl_off, &data_off, &consumed,
+			   &dma_off, &consumed);
 
-	/* sscanf() must process precisely 1 or 3 chunks:
+	/* sscanf() must process precisely 1, 3 or 4 chunks:
 	 * <base> is mandatory, optionally followed by <ctrl_off>
-	 * and <data_off>;
+	 * and <data_off>, and <dma_off>;
 	 * there must be no extra characters after the last chunk,
 	 * so str[consumed] must be '\0'.
 	 */
 	if (str[consumed] ||
-	    (processed != 1 && processed != 3))
+	    (processed != 1 && processed != 3 && processed != 4))
 		return -EINVAL;
 
 	res[0].start = base;
@@ -689,6 +706,11 @@ static int fw_cfg_cmdline_set(const char *arg, const struct kernel_param *kp)
 		res[2].start = data_off;
 		res[2].flags = IORESOURCE_REG;
 	}
+	if (processed > 3) {
+		res[3].name = "dma";
+		res[3].start = dma_off;
+		res[3].flags = IORESOURCE_REG;
+	}
 
 	/* "processed" happens to nicely match the number of resources
 	 * we need to pass in to this platform device.
@@ -721,6 +743,13 @@ static int fw_cfg_cmdline_get(char *buf, const struct kernel_param *kp)
 				fw_cfg_cmdline_dev->resource[0].start,
 				fw_cfg_cmdline_dev->resource[1].start,
 				fw_cfg_cmdline_dev->resource[2].start);
+	case 4:
+		return snprintf(buf, PAGE_SIZE, PH_ADDR_PR_4_FMT,
+				resource_size(&fw_cfg_cmdline_dev->resource[0]),
+				fw_cfg_cmdline_dev->resource[0].start,
+				fw_cfg_cmdline_dev->resource[1].start,
+				fw_cfg_cmdline_dev->resource[2].start,
+				fw_cfg_cmdline_dev->resource[3].start);
 	}
 
 	/* Should never get here */
-- 
2.16.1.73.g5832b7e9f2
