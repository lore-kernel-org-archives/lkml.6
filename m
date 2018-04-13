Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754183AbeDMJlS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:41:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754053AbeDMJlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:41:03 -0400
From: Thomas Huth <thuth@redhat.com>
To: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Farhan Ali <alifm@linux.ibm.com>, borntraeger@de.ibm.com
Subject: [PATCH 2/2] drm: Make the DRM code compilable without CONFIG_I2C
Date: Fri, 13 Apr 2018 11:40:56 +0200
Message-Id: <1523612456-14827-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1523612456-14827-1-git-send-email-thuth@redhat.com>
References: <1523612456-14827-1-git-send-email-thuth@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting CONFIG_HDMI for S390 is inappropriate - there is no real
graphic hardware on this architecture. The drm subsystem is only
enabled here for using the virtual graphics card "virtio-gpu". So
it should be possible to compile the drm subsystem also without
CONFIG_I2C. Tweak the Makefile to only compile the affected files
with CONFIG_I2C=y and disable some I2C-related code in drm_edid.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 drivers/gpu/drm/Kconfig    |  4 ++--
 drivers/gpu/drm/Makefile   | 16 +++++++++-------
 drivers/gpu/drm/drm_edid.c | 10 +++++++---
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 298a518..c9df67f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -10,8 +10,8 @@ menuconfig DRM
 	select DRM_PANEL_ORIENTATION_QUIRKS
 	select HDMI if !S390
 	select FB_CMDLINE
-	select I2C
-	select I2C_ALGOBIT
+	select I2C if !S390
+	select I2C_ALGOBIT if !S390
 	select DMA_SHARED_BUFFER
 	select SYNC_FILE
 	help
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 16fd8e3..4cf53ba 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -7,10 +7,9 @@ drm-y       :=	drm_auth.o drm_bufs.o drm_cache.o \
 		drm_context.o drm_dma.o \
 		drm_file.o drm_gem.o drm_ioctl.o drm_irq.o \
 		drm_lock.o drm_memory.o drm_drv.o \
-		drm_scatter.o drm_pci.o \
+		drm_scatter.o drm_pci.o drm_info.o \
 		drm_sysfs.o drm_hashtab.o drm_mm.o \
 		drm_crtc.o drm_fourcc.o drm_modes.o drm_edid.o \
-		drm_info.o drm_encoder_slave.o \
 		drm_trace_points.o drm_global.o drm_prime.o \
 		drm_rect.o drm_vma_manager.o drm_flip_work.o \
 		drm_modeset_lock.o drm_atomic.o drm_bridge.o \
@@ -20,6 +19,7 @@ drm-y       :=	drm_auth.o drm_bufs.o drm_cache.o \
 		drm_dumb_buffers.o drm_mode_config.o drm_vblank.o \
 		drm_syncobj.o drm_lease.o
 
+drm-$(CONFIG_I2C) += drm_encoder_slave.o
 drm-$(CONFIG_HDMI) += drm_hdmi.o
 drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
 drm-$(CONFIG_DRM_VM) += drm_vm.o
@@ -32,11 +32,13 @@ drm-$(CONFIG_AGP) += drm_agpsupport.o
 drm-$(CONFIG_DEBUG_FS) += drm_debugfs.o drm_debugfs_crc.o
 drm-$(CONFIG_DRM_LOAD_EDID_FIRMWARE) += drm_edid_load.o
 
-drm_kms_helper-y := drm_crtc_helper.o drm_dp_helper.o drm_probe_helper.o \
-		drm_plane_helper.o drm_dp_mst_topology.o drm_atomic_helper.o \
-		drm_kms_helper_common.o drm_dp_dual_mode_helper.o \
-		drm_simple_kms_helper.o drm_modeset_helper.o \
-		drm_scdc_helper.o drm_gem_framebuffer_helper.o
+drm_kms_helper-y := drm_crtc_helper.o drm_probe_helper.o \
+		drm_plane_helper.o drm_atomic_helper.o \
+		drm_gem_framebuffer_helper.o drm_kms_helper_common.o \
+		drm_simple_kms_helper.o drm_modeset_helper.o
+
+drm_kms_helper-$(CONFIG_I2C) += drm_dp_helper.o drm_dp_mst_topology.o \
+		drm_dp_dual_mode_helper.o drm_scdc_helper.o
 
 drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
 drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 3820763..0d0d5af 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1467,11 +1467,14 @@ bool drm_edid_is_valid(struct edid *edid)
 static int
 drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
 {
-	struct i2c_adapter *adapter = data;
-	unsigned char start = block * EDID_LENGTH;
 	unsigned char segment = block >> 1;
 	unsigned char xfers = segment ? 3 : 2;
-	int ret, retries = 5;
+	int ret = -1;
+
+#if IS_ENABLED(CONFIG_I2C)
+	struct i2c_adapter *adapter = data;
+	unsigned char start = block * EDID_LENGTH;
+	int retries = 5;
 
 	/*
 	 * The core I2C driver will automatically retry the transfer if the
@@ -1512,6 +1515,7 @@ bool drm_edid_is_valid(struct edid *edid)
 			break;
 		}
 	} while (ret != xfers && --retries);
+#endif	/* CONFIG_I2C */
 
 	return ret == xfers ? 0 : -1;
 }
-- 
1.8.3.1
