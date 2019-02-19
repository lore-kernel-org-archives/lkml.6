Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7873C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C9921848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfBSHv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:51:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:10107 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfBSHv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:51:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:51:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147958464"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 23:51:54 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Yulei Zhang <yulei.zhang@intel.com>,
        Xiao Zheng <xiao.zheng@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 7/8] drm/i915/gvt: vGPU device config data save/restore interface
Date:   Tue, 19 Feb 2019 02:46:32 -0500
Message-Id: <20190219074632.14350-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219074242.14015-1-yan.y.zhao@intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch implments the gvt interface intel_gvt_save_restore to
save/restore vGPU's device config data for live migration.

vGPU device config data includes vreg, vggtt, vcfg space, workloads, ppgtt,
execlist.
It does not include dirty pages in system memory produced by vGPU.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
Signed-off-by: Xiao Zheng <xiao.zheng@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/gpu/drm/i915/gvt/Makefile   |   2 +-
 drivers/gpu/drm/i915/gvt/execlist.c |   2 +-
 drivers/gpu/drm/i915/gvt/gtt.c      |   2 +-
 drivers/gpu/drm/i915/gvt/gtt.h      |   3 +
 drivers/gpu/drm/i915/gvt/gvt.c      |   1 +
 drivers/gpu/drm/i915/gvt/gvt.h      |   9 +
 drivers/gpu/drm/i915/gvt/migrate.c  | 863 ++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/gvt/migrate.h  |  97 ++++
 drivers/gpu/drm/i915/gvt/mmio.c     |  13 +
 drivers/gpu/drm/i915/gvt/mmio.h     |   1 +
 drivers/gpu/drm/i915/gvt/vgpu.c     |   1 +
 11 files changed, 991 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gvt/migrate.c
 create mode 100644 drivers/gpu/drm/i915/gvt/migrate.h

diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index b016dc753db9..f863fbed1792 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -3,7 +3,7 @@ GVT_DIR := gvt
 GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
 	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
-	fb_decoder.o dmabuf.o page_track.o
+	fb_decoder.o dmabuf.o page_track.o migrate.o
 
 ccflags-y				+= -I$(src) -I$(src)/$(GVT_DIR)
 i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
diff --git a/drivers/gpu/drm/i915/gvt/execlist.c b/drivers/gpu/drm/i915/gvt/execlist.c
index 70494e394d2c..992e2260eec9 100644
--- a/drivers/gpu/drm/i915/gvt/execlist.c
+++ b/drivers/gpu/drm/i915/gvt/execlist.c
@@ -437,7 +437,7 @@ static int complete_execlist_workload(struct intel_vgpu_workload *workload)
 	return ret;
 }
 
-static int submit_context(struct intel_vgpu *vgpu, int ring_id,
+int submit_context(struct intel_vgpu *vgpu, int ring_id,
 		struct execlist_ctx_descriptor_format *desc,
 		bool emulate_schedule_in)
 {
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 753ad975c958..18e3f08b0553 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -589,7 +589,7 @@ static inline void ppgtt_set_shadow_root_entry(struct intel_vgpu_mm *mm,
 	_ppgtt_set_root_entry(mm, entry, index, false);
 }
 
-static void ggtt_get_guest_entry(struct intel_vgpu_mm *mm,
+void ggtt_get_guest_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index)
 {
 	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index d8cb04cc946d..73709768b666 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -270,6 +270,9 @@ struct intel_vgpu_mm *intel_vgpu_get_ppgtt_mm(struct intel_vgpu *vgpu,
 
 int intel_vgpu_put_ppgtt_mm(struct intel_vgpu *vgpu, u64 pdps[]);
 
+void ggtt_get_guest_entry(struct intel_vgpu_mm *mm,
+		struct intel_gvt_gtt_entry *entry, unsigned long index);
+
 int intel_vgpu_emulate_ggtt_mmio_read(struct intel_vgpu *vgpu,
 	unsigned int off, void *p_data, unsigned int bytes);
 
diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index 733a2a0d0c30..3dd9e4ebd39b 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -185,6 +185,7 @@ static const struct intel_gvt_ops intel_gvt_ops = {
 	.vgpu_query_plane = intel_vgpu_query_plane,
 	.vgpu_get_dmabuf = intel_vgpu_get_dmabuf,
 	.write_protect_handler = intel_vgpu_page_track_handler,
+	.vgpu_save_restore = intel_gvt_save_restore,
 };
 
 /**
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 1f5ef59a36ac..cfde510e9d77 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -46,6 +46,7 @@
 #include "sched_policy.h"
 #include "mmio_context.h"
 #include "cmd_parser.h"
+#include "migrate.h"
 #include "fb_decoder.h"
 #include "dmabuf.h"
 #include "page_track.h"
@@ -510,6 +511,8 @@ void intel_gvt_reset_vgpu_locked(struct intel_vgpu *vgpu, bool dmlr,
 void intel_gvt_reset_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_activate_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_deactivate_vgpu(struct intel_vgpu *vgpu);
+int intel_gvt_save_restore(struct intel_vgpu *vgpu, char *buf,
+		size_t count, void *base, uint64_t off, bool restore);
 
 /* validating GM functions */
 #define vgpu_gmadr_is_aperture(vgpu, gmadr) \
@@ -609,6 +612,9 @@ struct intel_gvt_ops {
 	int (*vgpu_get_dmabuf)(struct intel_vgpu *vgpu, unsigned int);
 	int (*write_protect_handler)(struct intel_vgpu *, u64, void *,
 				     unsigned int);
+	int (*vgpu_save_restore)(struct intel_vgpu *vgpu, char *buf,
+					size_t count, void *base,
+					uint64_t off, bool restore);
 };
 
 
@@ -722,6 +728,9 @@ int intel_gvt_debugfs_add_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_debugfs_remove_vgpu(struct intel_vgpu *vgpu);
 int intel_gvt_debugfs_init(struct intel_gvt *gvt);
 void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
+int submit_context(struct intel_vgpu *vgpu, int ring_id,
+		struct execlist_ctx_descriptor_format *desc,
+		bool emulate_schedule_in);
 
 
 #include "trace.h"
diff --git a/drivers/gpu/drm/i915/gvt/migrate.c b/drivers/gpu/drm/i915/gvt/migrate.c
new file mode 100644
index 000000000000..dca6eae6f5c9
--- /dev/null
+++ b/drivers/gpu/drm/i915/gvt/migrate.c
@@ -0,0 +1,863 @@
+/*
+ * Copyright(c) 2011-2016 Intel Corporation. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Authors:
+ *    Yulei Zhang <yulei.zhang@intel.com>
+ *    Xiao Zheng <xiao.zheng@intel.com>
+ */
+
+#include "i915_drv.h"
+#include "gvt.h"
+#include "i915_pvinfo.h"
+
+#define INV (-1)
+#define RULES_NUM(x) (sizeof(x)/sizeof(gvt_migration_obj_t))
+#define FOR_EACH_OBJ(obj, rules) \
+	for (obj = rules; obj->region.type != GVT_MIGRATION_NONE; obj++)
+#define MIG_VREG_RESTORE(vgpu, off)					\
+	{								\
+		u32 data = vgpu_vreg(vgpu, (off));			\
+		u64 pa = intel_vgpu_mmio_offset_to_gpa(vgpu, off);	\
+		intel_vgpu_emulate_mmio_write(vgpu, pa, &data, 4);	\
+	}
+
+/* s - struct
+ * t - type of obj
+ * m - size of obj
+ * ops - operation override callback func
+ */
+#define MIGRATION_UNIT(_s, _t, _m, _ops) {		\
+.img		= NULL,					\
+.region.type	= _t,					\
+.region.size	= _m,				\
+.ops		= &(_ops),				\
+.name		= "["#_s":"#_t"]\0"			\
+}
+
+#define MIGRATION_END {		\
+	NULL, NULL, 0,		\
+	{GVT_MIGRATION_NONE, 0},\
+	NULL,	\
+	NULL	\
+}
+
+static DEFINE_MUTEX(gvt_migration);
+static int image_header_load(const struct gvt_migration_obj_t *obj, u32 size);
+static int image_header_save(const struct gvt_migration_obj_t *obj);
+static int vreg_load(const struct gvt_migration_obj_t *obj, u32 size);
+static int vreg_save(const struct gvt_migration_obj_t *obj);
+static int sreg_load(const struct gvt_migration_obj_t *obj, u32 size);
+static int sreg_save(const struct gvt_migration_obj_t *obj);
+static int vcfg_space_load(const struct gvt_migration_obj_t *obj, u32 size);
+static int vcfg_space_save(const struct gvt_migration_obj_t *obj);
+static int vggtt_load(const struct gvt_migration_obj_t *obj, u32 size);
+static int vggtt_save(const struct gvt_migration_obj_t *obj);
+static int workload_load(const struct gvt_migration_obj_t *obj, u32 size);
+static int workload_save(const struct gvt_migration_obj_t *obj);
+static int ppgtt_load(const struct gvt_migration_obj_t *obj, u32 size);
+static int ppgtt_save(const struct gvt_migration_obj_t *obj);
+static int execlist_load(const struct gvt_migration_obj_t *obj, u32 size);
+static int execlist_save(const struct gvt_migration_obj_t *obj);
+
+/***********************************************
+ * Internal Static Functions
+ ***********************************************/
+struct gvt_migration_operation_t vReg_ops = {
+	.pre_copy = NULL,
+	.pre_save = vreg_save,
+	.pre_load = vreg_load,
+	.post_load = NULL,
+};
+
+struct gvt_migration_operation_t sReg_ops = {
+	.pre_copy = NULL,
+	.pre_save = sreg_save,
+	.pre_load = sreg_load,
+	.post_load = NULL,
+};
+
+struct gvt_migration_operation_t vcfg_space_ops = {
+	.pre_copy = NULL,
+	.pre_save = vcfg_space_save,
+	.pre_load = vcfg_space_load,
+	.post_load = NULL,
+};
+
+struct gvt_migration_operation_t vgtt_info_ops = {
+	.pre_copy = NULL,
+	.pre_save = vggtt_save,
+	.pre_load = vggtt_load,
+	.post_load = NULL,
+};
+
+struct gvt_migration_operation_t image_header_ops = {
+	.pre_copy = NULL,
+	.pre_save = image_header_save,
+	.pre_load = image_header_load,
+	.post_load = NULL,
+};
+
+struct gvt_migration_operation_t workload_ops = {
+	.pre_copy = NULL,
+	.pre_save = workload_save,
+	.pre_load = workload_load,
+	.post_load = NULL,
+};
+
+struct gvt_migration_operation_t ppgtt_ops = {
+	.pre_copy = NULL,
+	.pre_save = ppgtt_save,
+	.pre_load = ppgtt_load,
+	.post_load = NULL,
+};
+
+struct gvt_migration_operation_t execlist_ops = {
+	.pre_copy = NULL,
+	.pre_save = execlist_save,
+	.pre_load = execlist_load,
+	.post_load = NULL,
+};
+
+/* gvt_device_objs[] are list of gvt_migration_obj_t objs
+ * Each obj has its operation method to save to qemu image
+ * and restore from qemu image during the migration.
+ *
+ * for each saved bject, it will have a region header
+ * struct gvt_region_t {
+ *   region_type;
+ *   region_size;
+ * }
+ *__________________  _________________   __________________
+ *|x64 (Source)    |  |image region    |  |x64 (Target)    |
+ *|________________|  |________________|  |________________|
+ *|    Region A    |  |   Region A     |  |   Region A     |
+ *|    Header      |  |   offset=0     |  | allocate a page|
+ *|    content     |  |                |  | copy data here |
+ *|----------------|  |     ...        |  |----------------|
+ *|    Region B    |  |     ...        |  |   Region B     |
+ *|    Header      |  |----------------|  |                |
+ *|    content        |   Region B     |  |                |
+ *|----------------|  |   offset=4096  |  |----------------|
+ *                    |                |
+ *                    |----------------|
+ *
+ * On the target side, it will parser the incoming data copy
+ * from Qemu image, and apply difference restore handlers depends
+ * on the region type.
+ */
+static struct gvt_migration_obj_t gvt_device_objs[] = {
+	MIGRATION_UNIT(struct intel_vgpu,
+			GVT_MIGRATION_HEAD,
+			sizeof(struct gvt_image_header_t),
+			image_header_ops),
+	MIGRATION_UNIT(struct intel_vgpu,
+			GVT_MIGRATION_CFG_SPACE,
+			PCI_CFG_SPACE_EXP_SIZE,
+			vcfg_space_ops),
+	MIGRATION_UNIT(struct intel_vgpu,
+			GVT_MIGRATION_SREG,
+			GVT_MMIO_SIZE, sReg_ops),
+	MIGRATION_UNIT(struct intel_vgpu,
+			GVT_MIGRATION_VREG,
+			GVT_MMIO_SIZE, vReg_ops),
+	MIGRATION_UNIT(struct intel_vgpu,
+			GVT_MIGRATION_GTT,
+			0, vgtt_info_ops),
+	MIGRATION_UNIT(struct intel_vgpu,
+			GVT_MIGRATION_PPGTT,
+			0, ppgtt_ops),
+	MIGRATION_UNIT(struct intel_vgpu,
+			GVT_MIGRATION_WORKLOAD,
+			0, workload_ops),
+	MIGRATION_UNIT(struct intel_vgpu,
+			GVT_MIGRATION_EXECLIST,
+			0, execlist_ops),
+	MIGRATION_END,
+};
+
+static inline void
+update_image_region_start_pos(struct gvt_migration_obj_t *obj, int pos)
+{
+	obj->offset = pos;
+}
+
+static inline void
+update_image_region_base(struct gvt_migration_obj_t *obj, void *base)
+{
+	obj->img = base;
+}
+
+static inline void
+update_status_region_base(struct gvt_migration_obj_t *obj, void *base)
+{
+	obj->vgpu = base;
+}
+
+static inline struct gvt_migration_obj_t *
+find_migration_obj(enum gvt_migration_type_t type)
+{
+	struct gvt_migration_obj_t *obj;
+
+	for (obj = gvt_device_objs;
+		obj->region.type != GVT_MIGRATION_NONE; obj++)
+		if (obj->region.type == type)
+			return obj;
+	return NULL;
+}
+
+static int image_header_save(const struct gvt_migration_obj_t *obj)
+{
+	struct gvt_region_t region;
+	struct gvt_image_header_t header;
+
+	region.type = GVT_MIGRATION_HEAD;
+	region.size = sizeof(struct gvt_image_header_t);
+	memcpy(obj->img, &region, sizeof(struct gvt_region_t));
+
+	header.version = GVT_MIGRATION_VERSION;
+	header.data_size = obj->offset;
+	header.crc_check = 0; /* CRC check skipped for now*/
+
+	memcpy(obj->img + sizeof(struct gvt_region_t), &header,
+			sizeof(struct gvt_image_header_t));
+
+	return sizeof(struct gvt_region_t) + sizeof(struct gvt_image_header_t);
+}
+
+static int image_header_load(const struct gvt_migration_obj_t *obj, u32 size)
+{
+	struct gvt_image_header_t header;
+
+	if (unlikely(size != sizeof(struct gvt_image_header_t))) {
+		gvt_err("migration obj size isn't match between target and image! memsize=%d imgsize=%d\n",
+		obj->region.size,
+		size);
+		return INV;
+	}
+
+	memcpy(&header, obj->img + obj->offset,
+		sizeof(struct gvt_image_header_t));
+
+	return header.data_size;
+}
+
+static int vcfg_space_save(const struct gvt_migration_obj_t *obj)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	int n_transfer = INV;
+	void *src = vgpu->cfg_space.virtual_cfg_space;
+	void *des = obj->img + obj->offset;
+
+	memcpy(des, &obj->region, sizeof(struct gvt_region_t));
+
+	des += sizeof(struct gvt_region_t);
+	n_transfer = obj->region.size;
+
+	memcpy(des, src, n_transfer);
+	return sizeof(struct gvt_region_t) + n_transfer;
+}
+
+static int vcfg_space_load(const struct gvt_migration_obj_t *obj, u32 size)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	void *dest = vgpu->cfg_space.virtual_cfg_space;
+	int n_transfer = INV;
+
+	if (unlikely(size != obj->region.size)) {
+		gvt_err("migration obj size isn't match between target and image! memsize=%d imgsize=%d\n",
+		obj->region.size,
+		size);
+	} else {
+		n_transfer = obj->region.size;
+		memcpy(dest, obj->img + obj->offset, n_transfer);
+	}
+
+	return n_transfer;
+}
+
+static int sreg_save(const struct gvt_migration_obj_t *obj)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	int n_transfer = INV;
+	void *src = vgpu->mmio.sreg;
+	void *des = obj->img + obj->offset;
+
+	memcpy(des, &obj->region, sizeof(struct gvt_region_t));
+
+	des += sizeof(struct gvt_region_t);
+	n_transfer = obj->region.size;
+
+	memcpy(des, src, n_transfer);
+	return sizeof(struct gvt_region_t) + n_transfer;
+}
+
+static int sreg_load(const struct gvt_migration_obj_t *obj, u32 size)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	void *dest = vgpu->mmio.sreg;
+	int n_transfer = INV;
+
+	if (unlikely(size != obj->region.size)) {
+		gvt_err("migration obj size isn't match between target and image! memsize=%d imgsize=%d\n",
+		obj->region.size,
+		size);
+	} else {
+		n_transfer = obj->region.size;
+		memcpy(dest, obj->img + obj->offset, n_transfer);
+	}
+
+	return n_transfer;
+}
+
+static int ppgtt_save(const struct gvt_migration_obj_t *obj)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	struct list_head *pos;
+	struct intel_vgpu_mm *mm;
+	struct gvt_ppgtt_entry_t entry;
+	struct gvt_region_t region;
+	int num = 0;
+	u32 sz = sizeof(struct gvt_ppgtt_entry_t);
+	void *des = obj->img + obj->offset;
+
+	list_for_each(pos, &vgpu->gtt.ppgtt_mm_list_head) {
+		mm = container_of(pos, struct intel_vgpu_mm, ppgtt_mm.list);
+		if (mm->type != INTEL_GVT_MM_PPGTT)
+			continue;
+
+		entry.page_table_level = mm->ppgtt_mm.root_entry_type;
+		memcpy(entry.pdp, mm->ppgtt_mm.guest_pdps, 32);
+
+		memcpy(des + sizeof(struct gvt_region_t) + (num * sz),
+			&entry, sz);
+		num++;
+	}
+
+	region.type = GVT_MIGRATION_PPGTT;
+	region.size = num * sz;
+	memcpy(des, &region, sizeof(struct gvt_region_t));
+
+	return sizeof(struct gvt_region_t) + region.size;
+}
+
+static int ppgtt_load(const struct gvt_migration_obj_t *obj, u32 size)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	int n_transfer = INV;
+	struct gvt_ppgtt_entry_t entry;
+	struct intel_vgpu_mm *mm;
+	void *src = obj->img + obj->offset;
+	int i;
+	u32 sz = sizeof(struct gvt_ppgtt_entry_t);
+
+	if (size == 0)
+		return size;
+
+	if (unlikely(size % sz) != 0) {
+		gvt_err("migration obj size isn't match between target and image! memsize=%d imgsize=%d\n",
+		obj->region.size,
+		size);
+		return n_transfer;
+	}
+
+	for (i = 0; i < size / sz; i++) {
+		memcpy(&entry, src + (i * sz), sz);
+		mm = intel_vgpu_create_ppgtt_mm(vgpu, entry.page_table_level,
+						entry.pdp);
+		if (IS_ERR(mm)) {
+			gvt_vgpu_err("fail to create mm object.\n");
+			return n_transfer;
+		}
+	}
+
+	n_transfer = size;
+
+	return n_transfer;
+}
+
+static int vreg_save(const struct gvt_migration_obj_t *obj)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	int n_transfer = INV;
+	void *src = vgpu->mmio.vreg;
+	void *des = obj->img + obj->offset;
+
+	memcpy(des, &obj->region, sizeof(struct gvt_region_t));
+
+	des += sizeof(struct gvt_region_t);
+	n_transfer = obj->region.size;
+
+	memcpy(des, src, n_transfer);
+	return sizeof(struct gvt_region_t) + n_transfer;
+}
+
+static int vreg_load(const struct gvt_migration_obj_t *obj, u32 size)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	void *dest = vgpu->mmio.vreg;
+	int n_transfer = INV;
+	struct drm_i915_private *dev_priv = vgpu->gvt->dev_priv;
+	struct intel_engine_cs *engine;
+	enum intel_engine_id id;
+	enum pipe pipe;
+
+	if (unlikely(size != obj->region.size)) {
+		gvt_err("migration obj size isn't match between target and image! memsize=%d imgsize=%d\n",
+		obj->region.size,
+		size);
+		goto exit;
+	} else {
+		n_transfer = obj->region.size;
+		memcpy(dest, obj->img + obj->offset, n_transfer);
+	}
+
+	//restore vblank emulation
+	for (pipe = PIPE_A; pipe < I915_MAX_PIPES; ++pipe)
+		MIG_VREG_RESTORE(vgpu, i915_mmio_reg_offset(PIPECONF(pipe)));
+
+	//restore ring mode register for execlist init
+	for_each_engine(engine, dev_priv, id)
+		MIG_VREG_RESTORE(vgpu,
+				i915_mmio_reg_offset(RING_MODE_GEN7(engine)));
+
+	for_each_engine(engine, dev_priv, id)
+		MIG_VREG_RESTORE(vgpu,
+			i915_mmio_reg_offset(RING_HWS_PGA(engine->mmio_base)));
+
+	memcpy(dest, obj->img + obj->offset, n_transfer);
+exit:
+	return n_transfer;
+}
+
+static int execlist_save(const struct gvt_migration_obj_t *obj)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	struct drm_i915_private *dev_priv = vgpu->gvt->dev_priv;
+	struct gvt_region_t region;
+	struct intel_engine_cs *engine;
+	u32 sz = sizeof(struct intel_vgpu_elsp_dwords);
+	unsigned int i;
+
+	void *des = obj->img + obj->offset;
+
+	for_each_engine(engine, dev_priv, i) {
+		memcpy(des + sizeof(struct gvt_region_t) + (i * sz),
+			&vgpu->submission.execlist[engine->id].elsp_dwords, sz);
+	}
+
+	region.type = GVT_MIGRATION_EXECLIST;
+	region.size = i * sz;
+	memcpy(des, &region, sizeof(struct gvt_region_t));
+	return sizeof(struct gvt_region_t) + region.size;
+}
+
+static int execlist_load(const struct gvt_migration_obj_t *obj, u32 size)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	struct drm_i915_private *dev_priv = vgpu->gvt->dev_priv;
+	struct intel_engine_cs *engine;
+	u32 sz = sizeof(struct intel_vgpu_elsp_dwords);
+	void *src = obj->img + obj->offset;
+	int n_transfer = INV;
+	unsigned int i;
+
+	if (size == 0)
+		return size;
+
+	if (unlikely(size % sz) != 0) {
+		gvt_err("migration obj size isn't match between target and image! memsize=%d imgsize=%d\n",
+		obj->region.size,
+		size);
+		return n_transfer;
+	}
+
+	for_each_engine(engine, dev_priv, i) {
+		memcpy(&vgpu->submission.execlist[engine->id].elsp_dwords,
+			src + (i * sz), sz);
+	}
+
+	n_transfer = size;
+
+	return n_transfer;
+}
+
+static int workload_save(const struct gvt_migration_obj_t *obj)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	struct drm_i915_private *dev_priv = vgpu->gvt->dev_priv;
+	struct gvt_region_t region;
+	struct intel_engine_cs *engine;
+	struct intel_vgpu_workload *pos, *n;
+	unsigned int i;
+	struct gvt_pending_workload_t workload;
+	void *des = obj->img + obj->offset;
+	unsigned int num = 0;
+	u32 sz = sizeof(struct gvt_pending_workload_t);
+
+	for_each_engine(engine, dev_priv, i) {
+		list_for_each_entry_safe(pos, n,
+			&vgpu->submission.workload_q_head[engine->id], list) {
+			workload.ring_id = pos->ring_id;
+			workload.ctx_desc = pos->ctx_desc;
+			workload.emulate_schedule_in = pos->emulate_schedule_in;
+			workload.elsp_dwords = pos->elsp_dwords;
+			list_del_init(&pos->list);
+			intel_vgpu_destroy_workload(pos);
+			memcpy(des + sizeof(struct gvt_region_t) + (num * sz),
+				&workload, sz);
+			num++;
+		}
+	}
+
+	region.type = GVT_MIGRATION_WORKLOAD;
+	region.size = num * sz;
+	memcpy(des, &region, sizeof(struct gvt_region_t));
+
+	return sizeof(struct gvt_region_t) + region.size;
+}
+
+static int workload_load(const struct gvt_migration_obj_t *obj, u32 size)
+{
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	int n_transfer = INV;
+	struct gvt_pending_workload_t workload;
+	void *src = obj->img + obj->offset;
+	u32 sz = sizeof(struct gvt_pending_workload_t);
+	int i;
+
+	if (size == 0)
+		return size;
+
+	if (unlikely(size % sz) != 0) {
+		gvt_err("migration obj size isn't match between target and image! memsize=%d imgsize=%d\n",
+		obj->region.size,
+		size);
+		return n_transfer;
+	}
+	for (i = 0; i < size / sz; i++) {
+		struct intel_vgpu_execlist *execlist;
+
+		execlist = &vgpu->submission.execlist[workload.ring_id];
+		memcpy(&workload, src + (i * sz), sz);
+		if (workload.emulate_schedule_in) {
+			execlist->elsp_dwords = workload.elsp_dwords;
+			execlist->elsp_dwords.index = 0;
+		}
+		submit_context(vgpu, workload.ring_id,
+			&workload.ctx_desc, workload.emulate_schedule_in);
+	}
+
+	n_transfer = size;
+
+	return n_transfer;
+}
+
+static int
+mig_ggtt_save_restore(struct intel_vgpu_mm *ggtt_mm,
+		void *data, u64 gm_offset,
+		u64 gm_sz,
+		bool save_to_image)
+{
+	struct intel_vgpu *vgpu = ggtt_mm->vgpu;
+	struct intel_gvt_gtt_gma_ops *gma_ops = vgpu->gvt->gtt.gma_ops;
+
+	void *ptable;
+	int sz;
+	int shift = vgpu->gvt->device_info.gtt_entry_size_shift;
+
+	ptable = ggtt_mm->ggtt_mm.virtual_ggtt +
+	    (gma_ops->gma_to_ggtt_pte_index(gm_offset) << shift);
+	sz = (gm_sz >> I915_GTT_PAGE_SHIFT) << shift;
+
+	if (save_to_image)
+		memcpy(data, ptable, sz);
+	else
+		memcpy(ptable, data, sz);
+
+	return sz;
+}
+
+static int vggtt_save(const struct gvt_migration_obj_t *obj)
+{
+	int ret = INV;
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	struct intel_vgpu_mm *ggtt_mm = vgpu->gtt.ggtt_mm;
+	void *des = obj->img + obj->offset;
+	struct gvt_region_t region;
+	int sz;
+
+	u64 aperture_offset = vgpu_guest_aperture_offset(vgpu);
+	u64 aperture_sz = vgpu_aperture_sz(vgpu);
+	u64 hidden_gm_offset = vgpu_guest_hidden_offset(vgpu);
+	u64 hidden_gm_sz = vgpu_hidden_sz(vgpu);
+
+	des += sizeof(struct gvt_region_t);
+
+	/*TODO:512MB GTT takes total 1024KB page table size, optimization here*/
+
+	gvt_dbg_core("Guest aperture=0x%llx (HW: 0x%llx),Guest Hidden=0x%llx (HW:0x%llx)\n",
+		aperture_offset, vgpu_aperture_offset(vgpu),
+		hidden_gm_offset, vgpu_hidden_offset(vgpu));
+
+	/*TODO:to be fixed after removal of address ballooning */
+	ret = 0;
+
+	/* aperture */
+	sz = mig_ggtt_save_restore(ggtt_mm, des,
+		aperture_offset, aperture_sz, true);
+	des += sz;
+	ret += sz;
+
+	/* hidden gm */
+	sz = mig_ggtt_save_restore(ggtt_mm, des,
+		hidden_gm_offset, hidden_gm_sz, true);
+	des += sz;
+	ret += sz;
+
+	/* Save the total size of this session */
+	region.type = GVT_MIGRATION_GTT;
+	region.size = ret;
+	memcpy(obj->img + obj->offset, &region, sizeof(struct gvt_region_t));
+
+	ret += sizeof(struct gvt_region_t);
+
+	return ret;
+}
+
+static int vggtt_load(const struct gvt_migration_obj_t *obj, u32 size)
+{
+	int ret;
+	u32 ggtt_index;
+	void *src;
+	int sz;
+
+	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
+	struct intel_vgpu_mm *ggtt_mm = vgpu->gtt.ggtt_mm;
+
+	int shift = vgpu->gvt->device_info.gtt_entry_size_shift;
+
+	/* offset to bar1 beginning */
+	u64 dest_aperture_offset = vgpu_guest_aperture_offset(vgpu);
+	u64 aperture_sz = vgpu_aperture_sz(vgpu);
+	u64 dest_hidden_gm_offset = vgpu_guest_hidden_offset(vgpu);
+	u64 hidden_gm_sz = vgpu_hidden_sz(vgpu);
+
+	gvt_dbg_core("Guest aperture=0x%llx (HW: 0x%llx), Guest Hidden=0x%llx (HW:0x%llx)\n",
+		dest_aperture_offset, vgpu_aperture_offset(vgpu),
+		dest_hidden_gm_offset, vgpu_hidden_offset(vgpu));
+
+	if ((size>>shift) !=
+			((aperture_sz + hidden_gm_sz) >> I915_GTT_PAGE_SHIFT)) {
+		gvt_err("ggtt restore failed due to page table size not match\n");
+		return INV;
+	}
+
+	ret = 0;
+	src = obj->img + obj->offset;
+
+	/* aperture */
+	sz = mig_ggtt_save_restore(ggtt_mm,
+		src, dest_aperture_offset, aperture_sz, false);
+	src += sz;
+	ret += sz;
+
+	/* hidden GM */
+	sz = mig_ggtt_save_restore(ggtt_mm, src,
+			dest_hidden_gm_offset, hidden_gm_sz, false);
+	ret += sz;
+
+	/* aperture/hidden GTT emulation from Source to Target */
+	for (ggtt_index = 0;
+	     ggtt_index < (gvt_ggtt_gm_sz(vgpu->gvt) >> I915_GTT_PAGE_SHIFT);
+	     ggtt_index++) {
+
+		if (vgpu_gmadr_is_valid(vgpu,
+					ggtt_index << I915_GTT_PAGE_SHIFT)) {
+			struct intel_gvt_gtt_pte_ops *ops =
+					vgpu->gvt->gtt.pte_ops;
+			struct intel_gvt_gtt_entry e;
+			u64 offset;
+			u64 pa;
+
+			/* TODO: hardcode to 64bit right now */
+			offset = vgpu->gvt->device_info.gtt_start_offset
+				+ (ggtt_index<<shift);
+
+			pa = intel_vgpu_mmio_offset_to_gpa(vgpu, offset);
+
+			/* read out virtual GTT entity and
+			 * trigger emulate write
+			 */
+			ggtt_get_guest_entry(ggtt_mm, &e, ggtt_index);
+			if (ops->test_present(&e)) {
+			/* same as gtt_emulate
+			 * _write(vgt, offset, &e.val64, 1<<shift);
+			 * Using vgt_emulate_write as to align with vReg load
+			 */
+				intel_vgpu_emulate_mmio_write(vgpu, pa,
+							&e.val64, 1<<shift);
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int vgpu_save(const void *img)
+{
+	struct gvt_migration_obj_t *node;
+	int n_img_actual_saved = 0;
+
+	/* go by obj rules one by one */
+	FOR_EACH_OBJ(node, gvt_device_objs) {
+		int n_img = INV;
+
+		/* obj will copy data to image file img.offset */
+		update_image_region_start_pos(node, n_img_actual_saved);
+		if (node->ops->pre_save == NULL) {
+			n_img = 0;
+		} else {
+			n_img = node->ops->pre_save(node);
+			if (n_img == INV) {
+				gvt_err("Save obj %s failed\n",
+						node->name);
+				n_img_actual_saved = INV;
+				break;
+			}
+		}
+		/* show GREEN on screen with colorred term */
+		gvt_dbg_core("Save obj %s success with %d bytes\n",
+			       node->name, n_img);
+		n_img_actual_saved += n_img;
+
+		if (n_img_actual_saved >= MIGRATION_IMG_MAX_SIZE) {
+			gvt_err("Image size overflow!!! data=%d MAX=%ld\n",
+				n_img_actual_saved,
+				MIGRATION_IMG_MAX_SIZE);
+			/* Mark as invalid */
+			n_img_actual_saved = INV;
+			break;
+		}
+	}
+	/* update the header with real image size */
+	node = find_migration_obj(GVT_MIGRATION_HEAD);
+	update_image_region_start_pos(node, n_img_actual_saved);
+	node->ops->pre_save(node);
+	return n_img_actual_saved;
+}
+
+static int vgpu_restore(void *img)
+{
+	struct gvt_migration_obj_t *node;
+	struct gvt_region_t region;
+	int n_img_actual_recv = 0;
+	u32 n_img_actual_size;
+
+	/* load image header at first to get real size */
+	memcpy(&region, img, sizeof(struct gvt_region_t));
+	if (region.type != GVT_MIGRATION_HEAD) {
+		gvt_err("Invalid image. Doesn't start with image_head\n");
+		return INV;
+	}
+
+	n_img_actual_recv += sizeof(struct gvt_region_t);
+	node = find_migration_obj(region.type);
+	update_image_region_start_pos(node, n_img_actual_recv);
+	n_img_actual_size = node->ops->pre_load(node, region.size);
+	if (n_img_actual_size == INV) {
+		gvt_err("Load img %s failed\n", node->name);
+		return INV;
+	}
+
+	if (n_img_actual_size >= MIGRATION_IMG_MAX_SIZE) {
+		gvt_err("Invalid image. magic_id offset = 0x%x\n",
+				n_img_actual_size);
+		return INV;
+	}
+
+	n_img_actual_recv += sizeof(struct gvt_image_header_t);
+
+	do {
+		int n_img = INV;
+		/* parse each region head to get type and size */
+		memcpy(&region, img + n_img_actual_recv,
+				sizeof(struct gvt_region_t));
+		node = find_migration_obj(region.type);
+		if (node == NULL)
+			break;
+		n_img_actual_recv += sizeof(struct gvt_region_t);
+		update_image_region_start_pos(node, n_img_actual_recv);
+
+		if (node->ops->pre_load == NULL) {
+			n_img = 0;
+		} else {
+			n_img = node->ops->pre_load(node, region.size);
+			if (n_img == INV) {
+				/* Error occurred. colored as RED */
+				gvt_err("Load obj %s failed\n",
+						node->name);
+				n_img_actual_recv = INV;
+				break;
+			}
+		}
+		/* show GREEN on screen with colorred term */
+		gvt_dbg_core("Load obj %s success with %d bytes.\n",
+			       node->name, n_img);
+		n_img_actual_recv += n_img;
+	} while (n_img_actual_recv < MIGRATION_IMG_MAX_SIZE);
+
+	return n_img_actual_recv;
+}
+
+int intel_gvt_save_restore(struct intel_vgpu *vgpu, char *buf, size_t count,
+			   void *base, uint64_t off, bool restore)
+{
+	struct gvt_migration_obj_t *node;
+	int ret = 0;
+
+	mutex_lock(&gvt_migration);
+
+	FOR_EACH_OBJ(node, gvt_device_objs) {
+		update_image_region_base(node, base + off);
+		update_image_region_start_pos(node, INV);
+		update_status_region_base(node, vgpu);
+	}
+
+	if (restore) {
+		vgpu->pv_notified = true;
+		if (vgpu_restore(base + off) == INV) {
+			ret = -EFAULT;
+			goto exit;
+		}
+	} else {
+		if (vgpu_save(base + off) == INV) {
+			ret = -EFAULT;
+			goto exit;
+		}
+
+	}
+
+exit:
+	mutex_unlock(&gvt_migration);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/i915/gvt/migrate.h b/drivers/gpu/drm/i915/gvt/migrate.h
new file mode 100644
index 000000000000..99ecb4eda553
--- /dev/null
+++ b/drivers/gpu/drm/i915/gvt/migrate.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright(c) 2011-2016 Intel Corporation. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Authors:
+ *    Yulei Zhang <yulei.zhang@intel.com>
+ *    Xiao Zheng <xiao.zheng@intel.com>
+ */
+
+#ifndef __GVT_MIGRATE_H__
+#define __GVT_MIGRATE_H__
+
+#define MIGRATION_DIRTY_BITMAP_SIZE (16*1024UL)
+
+/* Assume 9MB is enough to descript VM kernel state */
+#define MIGRATION_IMG_MAX_SIZE (9*1024UL*1024UL)
+#define GVT_MMIO_SIZE (2*1024UL*1024UL)
+#define GVT_MIGRATION_VERSION	0
+
+enum gvt_migration_type_t {
+	GVT_MIGRATION_NONE,
+	GVT_MIGRATION_HEAD,
+	GVT_MIGRATION_CFG_SPACE,
+	GVT_MIGRATION_VREG,
+	GVT_MIGRATION_SREG,
+	GVT_MIGRATION_GTT,
+	GVT_MIGRATION_PPGTT,
+	GVT_MIGRATION_WORKLOAD,
+	GVT_MIGRATION_EXECLIST,
+};
+
+struct gvt_ppgtt_entry_t {
+	int page_table_level;
+	u64 pdp[4];
+};
+
+struct gvt_pending_workload_t {
+	int ring_id;
+	bool emulate_schedule_in;
+	struct execlist_ctx_descriptor_format ctx_desc;
+	struct intel_vgpu_elsp_dwords elsp_dwords;
+};
+
+struct gvt_region_t {
+	enum gvt_migration_type_t type;
+	u32 size;		/* obj size of bytes to read/write */
+};
+
+struct gvt_migration_obj_t {
+	void *img;
+	void *vgpu;
+	u32 offset;
+	struct gvt_region_t region;
+	/* operation func defines how data save-restore */
+	struct gvt_migration_operation_t *ops;
+	char *name;
+};
+
+struct gvt_migration_operation_t {
+	/* called during pre-copy stage, VM is still alive */
+	int (*pre_copy)(const struct gvt_migration_obj_t *obj);
+	/* called before when VM was paused,
+	 * return bytes transferred
+	 */
+	int (*pre_save)(const struct gvt_migration_obj_t *obj);
+	/* called before load the state of device */
+	int (*pre_load)(const struct gvt_migration_obj_t *obj, u32 size);
+	/* called after load the state of device, VM already alive */
+	int (*post_load)(const struct gvt_migration_obj_t *obj, u32 size);
+};
+
+struct gvt_image_header_t {
+	int version;
+	int data_size;
+	u64 crc_check;
+	u64 global_data[64];
+};
+
+#endif
diff --git a/drivers/gpu/drm/i915/gvt/mmio.c b/drivers/gpu/drm/i915/gvt/mmio.c
index 43f65848ecd6..6221d2f274fc 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.c
+++ b/drivers/gpu/drm/i915/gvt/mmio.c
@@ -50,6 +50,19 @@ int intel_vgpu_gpa_to_mmio_offset(struct intel_vgpu *vgpu, u64 gpa)
 	return gpa - gttmmio_gpa;
 }
 
+/**
+ * intel_vgpu_mmio_offset_to_GPA - translate a MMIO offset to GPA
+ * @vgpu: a vGPU
+ *
+ * Returns:
+ * Zero on success, negative error code if failed
+ */
+int intel_vgpu_mmio_offset_to_gpa(struct intel_vgpu *vgpu, u64 offset)
+{
+	return offset + ((*(u64 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_0)) &
+		~GENMASK(3, 0));
+}
+
 #define reg_is_mmio(gvt, reg)  \
 	(reg >= 0 && reg < gvt->device_info.mmio_size)
 
diff --git a/drivers/gpu/drm/i915/gvt/mmio.h b/drivers/gpu/drm/i915/gvt/mmio.h
index 1ffc69eba30e..a2bddb0257cf 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.h
+++ b/drivers/gpu/drm/i915/gvt/mmio.h
@@ -82,6 +82,7 @@ void intel_vgpu_reset_mmio(struct intel_vgpu *vgpu, bool dmlr);
 void intel_vgpu_clean_mmio(struct intel_vgpu *vgpu);
 
 int intel_vgpu_gpa_to_mmio_offset(struct intel_vgpu *vgpu, u64 gpa);
+int intel_vgpu_mmio_offset_to_gpa(struct intel_vgpu *vgpu, u64 offset);
 
 int intel_vgpu_emulate_mmio_read(struct intel_vgpu *vgpu, u64 pa,
 				void *p_data, unsigned int bytes);
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index fcccda35a456..7676dcfdca09 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -213,6 +213,7 @@ void intel_gvt_activate_vgpu(struct intel_vgpu *vgpu)
 {
 	mutex_lock(&vgpu->gvt->lock);
 	vgpu->active = true;
+	intel_vgpu_start_schedule(vgpu);
 	mutex_unlock(&vgpu->gvt->lock);
 }
 
-- 
2.17.1

