Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A421221904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfBSHwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:52:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:23147 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfBSHwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:52:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:52:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147958539"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 23:52:12 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Yulei Zhang <yulei.zhang@intel.com>
Subject: [PATCH 8/8] drm/i915/gvt: VFIO device states interfaces
Date:   Tue, 19 Feb 2019 02:46:56 -0500
Message-Id: <20190219074656.14395-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219074242.14015-1-yan.y.zhao@intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch registers 3 VFIO device state regiones of type
VFIO_REGION_TYPE_DEVICE_STATE, and subtype
VFIO_REGION_SUBTYPE_DEVICE_STATE_CTL,
VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_CONFIG,
VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_DIRTYBITMAP.

userspace VFIO will check the existence of those regions to get/set
vGPU's device states.

region of subtype VFIO_REGION_SUBTYPE_DEVICE_STATE_CTL is the control
region, its layout is defined in struct vfio_device_state_ctl.
Reading from userspace into this region will get device state interace's
version and device data caps.

As Intel vGPU does not have device memory, so it does not support cap
VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY.

But Intel vGPU will produce dirty page in system memory, cap
VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is reported.

through writing to the control region, vGPU's state can also be set to
one of VFIO_DEVICE_STATE_RUNNING, VFIO_DEVICE_STATE_STOP,
VFIO_DEVICE_STATE_RUNNING & VFIO_DEVICE_STATE_LOGGING,
VFIO_DEVICE_STATE_STOP & VFIO_DEVICE_STATE_LOGGING.
state VFIO_DEVICE_STATE_LOGGING is set to notify logging dirty page in
system memory, but since vGPU's dirty page logging now is implemented by
cache of dma pages for guest gfns in vggtt and ppgtt,
nothing special needs to be done in the two LOGGING states, like
start/stop logging threads...

vGPU's device config data (including vreg, vggtt, vcfg space, workloads,
ppgtt, execlist, which are saved/restored through gvt interface
intel_gvt_save_restore) is hold in region of subtype
VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_CONFIG.
This region is mmaped into userspace VFIO.

Therefore userspace VFIO's reading from this config data
region requires it first write GET_BUFFER to device_config.action in the
above control region, so that GVT can load config data of vGPU into
config data region first;
And after userspace VFIO's writing to config data region, SET_BUFFER
is also needed to write to device_config.action in control region, so
GVT can restore config data into vGPU.
(Also, if device config data region failed to be mmaped into userspace
VFIO, read/write handlers are also provided).

vGPU's region for dirty bitmap logging in system memory is of subtype
VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_DIRTYBITMAP. It's also mmaped into
userspace VFIO. By writing start_addr and page count of a range of
system memory, dirty pages' bitmap produced by vGPU is saved in this
region dirty bitmap. Userspace VFIO can directly read dirty bitmap from
mmaped region or through this region's read/write handlers.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/gvt.h   |   3 +
 drivers/gpu/drm/i915/gvt/kvmgt.c | 412 +++++++++++++++++++++++++++++--
 include/uapi/linux/vfio.h        |  38 +++
 3 files changed, 437 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index cfde510e9d77..b0580169f595 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -227,6 +227,9 @@ struct intel_vgpu {
 		struct work_struct release_work;
 		atomic_t released;
 		struct vfio_device *vfio_device;
+		struct vfio_device_state_ctl *state_ctl;
+		void *state_config;
+		void *state_bitmap;
 	} vdev;
 #endif
 
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 223c67e87680..02df2ebaa3f4 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -65,6 +65,8 @@ struct intel_vgpu_regops {
 			size_t count, loff_t *ppos, bool iswrite);
 	void (*release)(struct intel_vgpu *vgpu,
 			struct vfio_region *region);
+	int (*mmap)(struct intel_vgpu *vgpu,
+			struct vm_area_struct *vma);
 };
 
 struct vfio_region {
@@ -414,7 +416,7 @@ static size_t intel_vgpu_reg_rw_opregion(struct intel_vgpu *vgpu, char *buf,
 	count = min(count, (size_t)(vgpu->vdev.region[i].size - pos));
 	memcpy(buf, base + pos, count);
 
-	return count;
+	return 0;
 }
 
 static void intel_vgpu_reg_release_opregion(struct intel_vgpu *vgpu,
@@ -427,6 +429,272 @@ static const struct intel_vgpu_regops intel_vgpu_regops_opregion = {
 	.release = intel_vgpu_reg_release_opregion,
 };
 
+static size_t set_device_state(struct intel_vgpu *vgpu, u32 state)
+{
+	int rc = 0;
+
+	switch (state) {
+	case VFIO_DEVICE_STATE_STOP:
+		intel_gvt_ops->vgpu_deactivate(vgpu);
+		break;
+	case VFIO_DEVICE_STATE_RUNNING:
+		intel_gvt_ops->vgpu_activate(vgpu);
+		break;
+	case VFIO_DEVICE_STATE_LOGGING | VFIO_DEVICE_STATE_RUNNING:
+	case VFIO_DEVICE_STATE_LOGGING | VFIO_DEVICE_STATE_STOP:
+		break;
+	default:
+		rc = -EFAULT;
+	}
+
+	return rc;
+}
+
+static void intel_vgpu_get_dirty_bitmap(struct intel_vgpu *vgpu,
+		u64 start_addr, u64 npage, void *bitmap)
+{
+	u64 gfn = start_addr >> PAGE_SHIFT;
+	int i;
+
+	memset(bitmap, 0, MIGRATION_DIRTY_BITMAP_SIZE);
+
+	for (i = 0; i < npage; i++) {
+		mutex_lock(&vgpu->vdev.cache_lock);
+		if (__gvt_cache_find_gfn(vgpu, gfn))
+			set_bit(i, bitmap);
+
+		mutex_unlock(&vgpu->vdev.cache_lock);
+		gfn++;
+	}
+}
+
+static size_t intel_vgpu_reg_rw_state_ctl(struct intel_vgpu *vgpu,
+		char *buf, size_t count, loff_t *ppos, bool iswrite)
+{
+	struct vfio_device_state_ctl *state_ctl;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	unsigned int i;
+	int rc = 0;
+	__u64 len;
+
+	state_ctl = vgpu->vdev.state_ctl;
+	if (!state_ctl) {
+		gvt_vgpu_err("invalid rw of state ctl region\n");
+		rc = -EFAULT;
+		goto exit;
+	}
+
+	i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
+	if (pos >= vgpu->vdev.region[i].size) {
+		gvt_vgpu_err("invalid offset for Intel vgpu state ctl region\n");
+		rc = -EINVAL;
+		goto exit;
+	}
+
+#define CTL_OFFSET(x) offsetof(struct vfio_device_state_ctl, x)
+	switch (pos) {
+	case CTL_OFFSET(version):
+		if (!iswrite)
+			rc = copy_to_user(buf,
+				&state_ctl->version,
+				sizeof(state_ctl->version));
+		break;
+	case CTL_OFFSET(device_state):
+		if (!iswrite)
+			rc = copy_to_user(buf,
+				&state_ctl->device_state,
+				sizeof(state_ctl->device_state));
+		else {
+			u32 state;
+
+			if (copy_from_user(&state, buf, sizeof(state))) {
+				rc = -EFAULT;
+				goto exit;
+			}
+			set_device_state(vgpu, state);
+		}
+		break;
+	case CTL_OFFSET(caps):
+		if (!iswrite)
+			rc = copy_to_user(buf,
+				&state_ctl->caps,
+				sizeof(state_ctl->caps));
+		break;
+	case CTL_OFFSET(device_config.action):
+		if (iswrite) {
+			u32 action;
+			bool isset;
+
+			if (copy_from_user(&action, buf, sizeof(action))) {
+				rc = -EFAULT;
+				goto exit;
+			}
+			isset = (action ==
+				VFIO_DEVICE_DATA_ACTION_SET_BUFFER);
+			rc = intel_gvt_ops->vgpu_save_restore(vgpu,
+					NULL,
+					MIGRATION_IMG_MAX_SIZE,
+					vgpu->vdev.state_config,
+					0,
+					isset);
+		} else {
+			/* action read is not valid */
+			rc = -EINVAL;
+		}
+		break;
+	case CTL_OFFSET(device_config.size):
+		len = MIGRATION_IMG_MAX_SIZE;
+		if (!iswrite)
+			rc = copy_to_user(buf, &len, sizeof(len));
+		break;
+	case CTL_OFFSET(system_memory):
+		{
+			struct {
+				__u64 start_addr;
+				__u64 page_nr;
+			} system_memory;
+
+			void *bitmap = vgpu->vdev.state_bitmap;
+
+			if (count != sizeof(system_memory)) {
+				/* must write as a whole */
+				rc = -EINVAL;
+				goto exit;
+			}
+			if (!iswrite) {
+				/* action read is not valid */
+				rc = -EINVAL;
+				goto exit;
+			}
+			if (copy_from_user(&system_memory, buf,
+						sizeof(system_memory))) {
+				rc = -EFAULT;
+				goto exit;
+			}
+			intel_vgpu_get_dirty_bitmap(vgpu,
+				system_memory.start_addr,
+				system_memory.page_nr, bitmap);
+		}
+		break;
+	default:
+		break;
+	}
+exit:
+	return rc;
+}
+
+static void intel_vgpu_reg_release_state_ctl(struct intel_vgpu *vgpu,
+		struct vfio_region *region)
+{
+	vfree(region->data);
+}
+
+static size_t intel_vgpu_reg_rw_state_data_config(struct intel_vgpu *vgpu,
+		char *buf, size_t count, loff_t *ppos, bool iswrite)
+{
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
+	void *base = vgpu->vdev.region[i].data;
+	int rc = 0;
+
+	if (pos >= vgpu->vdev.region[i].size) {
+		gvt_vgpu_err("invalid offset to rw Intel vgpu state data region\n");
+		rc = -EINVAL;
+		goto exit;
+	}
+
+	if (iswrite) {
+		if (copy_from_user(base + pos, buf, count))
+			rc = -EFAULT;
+	} else {
+		if (copy_to_user(buf, base + pos, count))
+			rc = -EFAULT;
+	}
+
+exit:
+	return rc;
+}
+
+static
+void intel_vgpu_reg_release_state_data_config(struct intel_vgpu *vgpu,
+		struct vfio_region *region)
+{
+	vfree(region->data);
+}
+
+static
+int intel_vgpu_reg_mmap_state_data_config(struct intel_vgpu *vgpu,
+			struct vm_area_struct *vma)
+{
+	unsigned long pgoff = 0;
+	void *base = vgpu->vdev.state_config;
+
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	if (pgoff != 0)
+		return -EINVAL;
+
+	return remap_vmalloc_range(vma, base, 0);
+}
+
+static size_t intel_vgpu_reg_rw_state_bitmap(struct intel_vgpu *vgpu,
+		char *buf, size_t count, loff_t *ppos, bool iswrite)
+{
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) -
+			VFIO_PCI_NUM_REGIONS;
+	void *base = vgpu->vdev.region[i].data;
+	int rc = 0;
+
+	if (iswrite || pos != 0)
+		return -EINVAL;
+
+	if (copy_to_user(buf, base, count))
+		rc = -EFAULT;
+
+	return 0;
+}
+
+static
+void intel_vgpu_reg_release_state_bitmap(struct intel_vgpu *vgpu,
+		struct vfio_region *region)
+{
+	vfree(region->data);
+}
+
+static int intel_vgpu_reg_mmap_state_bitmap(struct intel_vgpu *vgpu,
+			struct vm_area_struct *vma)
+{
+	unsigned long pgoff = 0;
+	void *base = vgpu->vdev.state_bitmap;
+
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	if (pgoff != 0)
+		return -EINVAL;
+
+	return remap_vmalloc_range(vma, base, 0);
+}
+
+static const struct intel_vgpu_regops intel_vgpu_regops_state_ctl = {
+	.rw	 = intel_vgpu_reg_rw_state_ctl,
+	.release = intel_vgpu_reg_release_state_ctl,
+};
+
+static const struct intel_vgpu_regops intel_vgpu_regops_state_data_config = {
+	.rw	 = intel_vgpu_reg_rw_state_data_config,
+	.release = intel_vgpu_reg_release_state_data_config,
+	.mmap    = intel_vgpu_reg_mmap_state_data_config,
+};
+
+static const struct intel_vgpu_regops intel_vgpu_regops_state_bitmap = {
+	.rw	 = intel_vgpu_reg_rw_state_bitmap,
+	.release = intel_vgpu_reg_release_state_bitmap,
+	.mmap    = intel_vgpu_reg_mmap_state_bitmap,
+};
+
 static int intel_vgpu_register_reg(struct intel_vgpu *vgpu,
 		unsigned int type, unsigned int subtype,
 		const struct intel_vgpu_regops *ops,
@@ -493,6 +761,82 @@ static int kvmgt_set_opregion(void *p_vgpu)
 	return ret;
 }
 
+static int kvmgt_init_device_state(struct intel_vgpu *vgpu)
+{
+	void *bitmap_base, *config_base;
+	int ret;
+	struct vfio_device_state_ctl *state_ctl;
+
+	state_ctl = vzalloc(sizeof(struct vfio_device_state_ctl));
+	if (!state_ctl) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	state_ctl->version = VFIO_DEVICE_STATE_INTERFACE_VERSION;
+	state_ctl->caps = VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY;
+
+	ret = intel_vgpu_register_reg(vgpu,
+			VFIO_REGION_TYPE_DEVICE_STATE,
+			VFIO_REGION_SUBTYPE_DEVICE_STATE_CTL,
+			&intel_vgpu_regops_state_ctl,
+			sizeof(struct vfio_device_state_ctl),
+			VFIO_REGION_INFO_FLAG_READ |
+			VFIO_REGION_INFO_FLAG_WRITE,
+			state_ctl);
+	if (ret) {
+		vfree(state_ctl);
+		goto out;
+	}
+	vgpu->vdev.state_ctl = state_ctl;
+
+	config_base = vmalloc_user(MIGRATION_IMG_MAX_SIZE);
+	if (config_base == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = intel_vgpu_register_reg(vgpu,
+			VFIO_REGION_TYPE_DEVICE_STATE,
+			VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_CONFIG,
+			&intel_vgpu_regops_state_data_config,
+			MIGRATION_IMG_MAX_SIZE,
+			VFIO_REGION_INFO_FLAG_CAPS |
+			VFIO_REGION_INFO_FLAG_READ |
+			VFIO_REGION_INFO_FLAG_WRITE |
+			VFIO_REGION_INFO_FLAG_MMAP,
+			config_base);
+	if (ret) {
+		vfree(config_base);
+		goto out;
+	}
+	vgpu->vdev.state_config = config_base;
+
+
+	bitmap_base = vmalloc_user(MIGRATION_DIRTY_BITMAP_SIZE);
+	if (bitmap_base == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = intel_vgpu_register_reg(vgpu,
+			VFIO_REGION_TYPE_DEVICE_STATE,
+			VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_DIRTYBITMAP,
+			&intel_vgpu_regops_state_bitmap,
+			MIGRATION_DIRTY_BITMAP_SIZE,
+			VFIO_REGION_INFO_FLAG_CAPS |
+			VFIO_REGION_INFO_FLAG_READ |
+			VFIO_REGION_INFO_FLAG_WRITE |
+			VFIO_REGION_INFO_FLAG_MMAP,
+			bitmap_base);
+	if (ret) {
+		vfree(bitmap_base);
+		goto out;
+	}
+	vgpu->vdev.state_bitmap = bitmap_base;
+
+out:
+	return ret;
+}
+
 static void kvmgt_put_vfio_device(void *vgpu)
 {
 	if (WARN_ON(!((struct intel_vgpu *)vgpu)->vdev.vfio_device))
@@ -631,6 +975,8 @@ static int intel_vgpu_open(struct mdev_device *mdev)
 	if (ret)
 		goto undo_group;
 
+	kvmgt_init_device_state(vgpu);
+
 	intel_gvt_ops->vgpu_activate(vgpu);
 
 	atomic_set(&vgpu->vdev.released, 0);
@@ -662,6 +1008,7 @@ static void __intel_vgpu_release(struct intel_vgpu *vgpu)
 {
 	struct kvmgt_guest_info *info;
 	int ret;
+	int i;
 
 	if (!handle_valid(vgpu->handle))
 		return;
@@ -671,6 +1018,13 @@ static void __intel_vgpu_release(struct intel_vgpu *vgpu)
 
 	intel_gvt_ops->vgpu_release(vgpu);
 
+	for (i = 0; i < vgpu->vdev.num_regions; i++)
+		vgpu->vdev.region[i].ops->release(vgpu, &vgpu->vdev.region[i]);
+
+	vgpu->vdev.num_regions = 0;
+	kfree(vgpu->vdev.region);
+	vgpu->vdev.region = NULL;
+
 	ret = vfio_unregister_notifier(mdev_dev(vgpu->vdev.mdev), VFIO_IOMMU_NOTIFY,
 					&vgpu->vdev.iommu_notifier);
 	WARN(ret, "vfio_unregister_notifier for iommu failed: %d\n", ret);
@@ -816,11 +1170,11 @@ static ssize_t intel_vgpu_rw(struct mdev_device *mdev, char *buf,
 	case VFIO_PCI_ROM_REGION_INDEX:
 		break;
 	default:
-		if (index >= VFIO_PCI_NUM_REGIONS + vgpu->vdev.num_regions)
+		if (index < VFIO_PCI_NUM_REGIONS)
 			return -EINVAL;
 
 		index -= VFIO_PCI_NUM_REGIONS;
-		return vgpu->vdev.region[index].ops->rw(vgpu, buf, count,
+		ret = vgpu->vdev.region[index].ops->rw(vgpu, buf, count,
 				ppos, is_write);
 	}
 
@@ -851,6 +1205,10 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 {
 	unsigned int done = 0;
 	int ret;
+	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+
+	if (index >= VFIO_PCI_NUM_REGIONS)
+		return intel_vgpu_rw(mdev, (char *)buf, count, ppos, false);
 
 	while (count) {
 		size_t filled;
@@ -925,6 +1283,10 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 {
 	unsigned int done = 0;
 	int ret;
+	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+
+	if (index >= VFIO_PCI_NUM_REGIONS)
+		return intel_vgpu_rw(mdev, (char *)buf, count, ppos, true);
 
 	while (count) {
 		size_t filled;
@@ -999,24 +1361,42 @@ static int intel_vgpu_mmap(struct mdev_device *mdev, struct vm_area_struct *vma)
 	unsigned long req_size, pgoff = 0;
 	pgprot_t pg_prot;
 	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
+	int ret = 0;
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
-	if (index >= VFIO_PCI_ROM_REGION_INDEX)
-		return -EINVAL;
 
-	if (vma->vm_end < vma->vm_start)
-		return -EINVAL;
-	if ((vma->vm_flags & VM_SHARED) == 0)
-		return -EINVAL;
-	if (index != VFIO_PCI_BAR2_REGION_INDEX)
-		return -EINVAL;
+	if (vma->vm_end < vma->vm_start) {
+		ret = -EINVAL;
+		goto exit;
+	}
 
-	pg_prot = vma->vm_page_prot;
-	virtaddr = vma->vm_start;
-	req_size = vma->vm_end - vma->vm_start;
-	pgoff = vgpu_aperture_pa_base(vgpu) >> PAGE_SHIFT;
+	if ((vma->vm_flags & VM_SHARED) == 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (index == VFIO_PCI_BAR2_REGION_INDEX) {
+		pg_prot = vma->vm_page_prot;
+		virtaddr = vma->vm_start;
+		req_size = vma->vm_end - vma->vm_start;
+		pgoff = vgpu_aperture_pa_base(vgpu) >> PAGE_SHIFT;
+		ret = remap_pfn_range(vma, virtaddr, pgoff,
+				req_size, pg_prot);
+	} else if ((index >= VFIO_PCI_NUM_REGIONS +
+			vgpu->vdev.num_regions) ||
+			index < VFIO_PCI_NUM_REGIONS) {
+		ret = -EINVAL;
+	} else {
+		index -= VFIO_PCI_NUM_REGIONS;
+		if (vgpu->vdev.region[index].ops->mmap)
+			ret = vgpu->vdev.region[index].ops->mmap(vgpu,
+					vma);
+		else
+			ret = -EINVAL;
+	}
+exit:
+	return ret;
 
-	return remap_pfn_range(vma, virtaddr, pgoff, req_size, pg_prot);
 }
 
 static int intel_vgpu_get_irq_count(struct intel_vgpu *vgpu, int type)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 813102810f53..a577b242e3bd 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -303,6 +303,14 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
 
+
+/* Device State region type and sub-type */
+#define VFIO_REGION_TYPE_DEVICE_STATE           (1 << 1)
+#define VFIO_REGION_SUBTYPE_DEVICE_STATE_CTL       (1)
+#define VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_CONFIG      (2)
+#define VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_MEMORY      (3)
+#define VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_DIRTYBITMAP (4)
+
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
@@ -866,6 +874,36 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+#define VFIO_DEVICE_STATE_INTERFACE_VERSION 1
+#define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
+#define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2
+
+#define VFIO_DEVICE_STATE_RUNNING 0
+#define VFIO_DEVICE_STATE_STOP 1
+#define VFIO_DEVICE_STATE_LOGGING 2
+
+#define VFIO_DEVICE_DATA_ACTION_GET_BUFFER 1
+#define VFIO_DEVICE_DATA_ACTION_SET_BUFFER 2
+
+struct vfio_device_state_ctl {
+	__u32 version;		  /* ro */
+	__u32 device_state;       /* VFIO device state, wo */
+	__u32 caps;		 /* ro */
+	struct {
+		__u32 action;  /* wo, GET_BUFFER or SET_BUFFER */
+		__u64 size;    /*rw, total size of device config*/
+	} device_config;
+	struct {
+		__u32 action;    /* wo, GET_BUFFER or SET_BUFFER */
+		__u64 size;     /* rw, total size of device memory*/
+		__u64 pos;/*chunk offset in total buffer of device memory*/
+	} device_memory;
+	struct {
+		__u64 start_addr; /* wo */
+		__u64 page_nr;   /* wo */
+	} system_memory;
+} __attribute__((packed));
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.17.1

