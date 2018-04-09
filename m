Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754182AbeDITfJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753923AbeDITfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:35:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870AF217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 06/13] tools headers uapi: Synchronize i915_drm.h
Date: Mon,  9 Apr 2018 16:34:30 -0300
Message-Id: <20180409193437.14199-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  c822e0591855 drm/i915: expose rcs topology through query uAPI
  a446ae2c6e65 drm/i915: add query uAPI

This affects 'perf trace', that automagically gets the definition of the
new I915_QUERY DRM ioctl:

  --- /tmp/build/perf/trace/beauty/generated/ioctl/drm_ioctl_array.c.old 2018-04-05 14:38:33.660111995 -0300
  +++ /tmp/build/perf/trace/beauty/generated/ioctl/drm_ioctl_array.c 2018-04-05 14:40:17.923283914 -0300
  @@ -158,4 +158,5 @@
          [DRM_COMMAND_BASE + 0x36] = "I915_PERF_OPEN",
          [DRM_COMMAND_BASE + 0x37] = "I915_PERF_ADD_CONFIG",
          [DRM_COMMAND_BASE + 0x38] = "I915_PERF_REMOVE_CONFIG",
  +       [DRM_COMMAND_BASE + 0x39] = "I915_QUERY",
   };

I.e. on systems where this is used it will appear when, for instance,
one does a system wide 'perf trace' session looking for ioctl calls,
just like it does with the previously implemented DRM_I915 ioctls:

  # perf trace -e ioctl --filter-pids 2190
<SNIP>
  4346.232 ( 0.012 ms): gnome-shell/1455 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_BUSY, arg: 0x7fff3b0cd910) = 0
  4346.246 ( 0.002 ms): gnome-shell/1455 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_MADVISE, arg: 0x7fff3b0cd980) = 0
  4346.252 ( 0.002 ms): gnome-shell/1455 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_BUSY, arg: 0x7fff3b0cdb00) = 0
<SNIP>

This silences this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-5kxuvruuzdbojvf90f8j2wat@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 112 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 536ee4febd74..7f5634ce8e88 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -318,6 +318,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_I915_PERF_OPEN		0x36
 #define DRM_I915_PERF_ADD_CONFIG	0x37
 #define DRM_I915_PERF_REMOVE_CONFIG	0x38
+#define DRM_I915_QUERY			0x39
 
 #define DRM_IOCTL_I915_INIT		DRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_i915_init_t)
 #define DRM_IOCTL_I915_FLUSH		DRM_IO ( DRM_COMMAND_BASE + DRM_I915_FLUSH)
@@ -375,6 +376,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_PERF_OPEN	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_OPEN, struct drm_i915_perf_open_param)
 #define DRM_IOCTL_I915_PERF_ADD_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_ADD_CONFIG, struct drm_i915_perf_oa_config)
 #define DRM_IOCTL_I915_PERF_REMOVE_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_REMOVE_CONFIG, __u64)
+#define DRM_IOCTL_I915_QUERY			DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_QUERY, struct drm_i915_query)
 
 /* Allow drivers to submit batchbuffers directly to hardware, relying
  * on the security mechanisms provided by hardware.
@@ -1358,7 +1360,9 @@ struct drm_intel_overlay_attrs {
  * active on a given plane.
  */
 
-#define I915_SET_COLORKEY_NONE		(1<<0) /* disable color key matching */
+#define I915_SET_COLORKEY_NONE		(1<<0) /* Deprecated. Instead set
+						* flags==0 to disable colorkeying.
+						*/
 #define I915_SET_COLORKEY_DESTINATION	(1<<1)
 #define I915_SET_COLORKEY_SOURCE	(1<<2)
 struct drm_intel_sprite_colorkey {
@@ -1604,15 +1608,115 @@ struct drm_i915_perf_oa_config {
 	__u32 n_flex_regs;
 
 	/*
-	 * These fields are pointers to tuples of u32 values (register
-	 * address, value). For example the expected length of the buffer
-	 * pointed by mux_regs_ptr is (2 * sizeof(u32) * n_mux_regs).
+	 * These fields are pointers to tuples of u32 values (register address,
+	 * value). For example the expected length of the buffer pointed by
+	 * mux_regs_ptr is (2 * sizeof(u32) * n_mux_regs).
 	 */
 	__u64 mux_regs_ptr;
 	__u64 boolean_regs_ptr;
 	__u64 flex_regs_ptr;
 };
 
+struct drm_i915_query_item {
+	__u64 query_id;
+#define DRM_I915_QUERY_TOPOLOGY_INFO    1
+
+	/*
+	 * When set to zero by userspace, this is filled with the size of the
+	 * data to be written at the data_ptr pointer. The kernel sets this
+	 * value to a negative value to signal an error on a particular query
+	 * item.
+	 */
+	__s32 length;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 flags;
+
+	/*
+	 * Data will be written at the location pointed by data_ptr when the
+	 * value of length matches the length of the data to be written by the
+	 * kernel.
+	 */
+	__u64 data_ptr;
+};
+
+struct drm_i915_query {
+	__u32 num_items;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 flags;
+
+	/*
+	 * This points to an array of num_items drm_i915_query_item structures.
+	 */
+	__u64 items_ptr;
+};
+
+/*
+ * Data written by the kernel with query DRM_I915_QUERY_TOPOLOGY_INFO :
+ *
+ * data: contains the 3 pieces of information :
+ *
+ * - the slice mask with one bit per slice telling whether a slice is
+ *   available. The availability of slice X can be queried with the following
+ *   formula :
+ *
+ *           (data[X / 8] >> (X % 8)) & 1
+ *
+ * - the subslice mask for each slice with one bit per subslice telling
+ *   whether a subslice is available. The availability of subslice Y in slice
+ *   X can be queried with the following formula :
+ *
+ *           (data[subslice_offset +
+ *                 X * subslice_stride +
+ *                 Y / 8] >> (Y % 8)) & 1
+ *
+ * - the EU mask for each subslice in each slice with one bit per EU telling
+ *   whether an EU is available. The availability of EU Z in subslice Y in
+ *   slice X can be queried with the following formula :
+ *
+ *           (data[eu_offset +
+ *                 (X * max_subslices + Y) * eu_stride +
+ *                 Z / 8] >> (Z % 8)) & 1
+ */
+struct drm_i915_query_topology_info {
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u16 flags;
+
+	__u16 max_slices;
+	__u16 max_subslices;
+	__u16 max_eus_per_subslice;
+
+	/*
+	 * Offset in data[] at which the subslice masks are stored.
+	 */
+	__u16 subslice_offset;
+
+	/*
+	 * Stride at which each of the subslice masks for each slice are
+	 * stored.
+	 */
+	__u16 subslice_stride;
+
+	/*
+	 * Offset in data[] at which the EU masks are stored.
+	 */
+	__u16 eu_offset;
+
+	/*
+	 * Stride at which each of the EU masks for each subslice are stored.
+	 */
+	__u16 eu_stride;
+
+	__u8 data[];
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.14.3
