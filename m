Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD91C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C402D21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfBSHvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:51:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:22889 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfBSHvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:51:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:51:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147958309"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 23:51:09 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yulei Zhang <yulei.zhang@intel.com>
Subject: [PATCH 3/8] drm/i915/gvt: Patch the gma in gpu commands during command parser
Date:   Tue, 19 Feb 2019 02:45:53 -0500
Message-Id: <20190219074553.14170-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219074242.14015-1-yan.y.zhao@intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yulei Zhang <yulei.zhang@intel.com>

Adjust the graphics memory address in gpu commands according to
the shift offset in guests' aperture and hidden gm address, and patch
the commands before submit to execute.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/cmd_parser.c | 31 ++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cmd_parser.c b/drivers/gpu/drm/i915/gvt/cmd_parser.c
index 77ae634eb11c..90836756b235 100644
--- a/drivers/gpu/drm/i915/gvt/cmd_parser.c
+++ b/drivers/gpu/drm/i915/gvt/cmd_parser.c
@@ -984,7 +984,8 @@ static int cmd_handler_lrr(struct parser_exec_state *s)
 }
 
 static inline int cmd_address_audit(struct parser_exec_state *s,
-		unsigned long guest_gma, int op_size, bool index_mode);
+				    unsigned long guest_gma, int op_size,
+				    bool index_mode, int offset);
 
 static int cmd_handler_lrm(struct parser_exec_state *s)
 {
@@ -1006,7 +1007,8 @@ static int cmd_handler_lrm(struct parser_exec_state *s)
 			gma = cmd_gma(s, i + 1);
 			if (gmadr_bytes == 8)
 				gma |= (cmd_gma_hi(s, i + 2)) << 32;
-			ret |= cmd_address_audit(s, gma, sizeof(u32), false);
+			ret |= cmd_address_audit(s, gma, sizeof(u32),
+						 false, i + 1);
 			if (ret)
 				break;
 		}
@@ -1030,7 +1032,8 @@ static int cmd_handler_srm(struct parser_exec_state *s)
 			gma = cmd_gma(s, i + 1);
 			if (gmadr_bytes == 8)
 				gma |= (cmd_gma_hi(s, i + 2)) << 32;
-			ret |= cmd_address_audit(s, gma, sizeof(u32), false);
+			ret |= cmd_address_audit(s, gma, sizeof(u32),
+						 false, i + 1);
 			if (ret)
 				break;
 		}
@@ -1102,7 +1105,7 @@ static int cmd_handler_pipe_control(struct parser_exec_state *s)
 				if (cmd_val(s, 1) & (1 << 21))
 					index_mode = true;
 				ret |= cmd_address_audit(s, gma, sizeof(u64),
-						index_mode);
+						index_mode, 2);
 			}
 		}
 	}
@@ -1432,10 +1435,13 @@ static unsigned long get_gma_bb_from_cmd(struct parser_exec_state *s, int index)
 }
 
 static inline int cmd_address_audit(struct parser_exec_state *s,
-		unsigned long guest_gma, int op_size, bool index_mode)
+				    unsigned long guest_gma, int op_size,
+				    bool index_mode, int offset)
 {
 	struct intel_vgpu *vgpu = s->vgpu;
 	u32 max_surface_size = vgpu->gvt->device_info.max_surface_size;
+	int gmadr_bytes = vgpu->gvt->device_info.gmadr_bytes_in_cmd;
+	u64 host_gma;
 	int i;
 	int ret;
 
@@ -1453,6 +1459,14 @@ static inline int cmd_address_audit(struct parser_exec_state *s,
 	} else if (!intel_gvt_ggtt_validate_range(vgpu, guest_gma, op_size)) {
 		ret = -EFAULT;
 		goto err;
+	} else
+		intel_gvt_ggtt_gmadr_g2h(vgpu, guest_gma, &host_gma);
+
+	if (offset > 0) {
+		patch_value(s, cmd_ptr(s, offset), host_gma & GENMASK(31, 2));
+		if (gmadr_bytes == 8)
+			patch_value(s, cmd_ptr(s, offset + 1),
+				(host_gma >> 32) & GENMASK(15, 0));
 	}
 
 	return 0;
@@ -1497,7 +1511,7 @@ static int cmd_handler_mi_store_data_imm(struct parser_exec_state *s)
 		gma = (gma_high << 32) | gma_low;
 		core_id = (cmd_val(s, 1) & (1 << 0)) ? 1 : 0;
 	}
-	ret = cmd_address_audit(s, gma + op_size * core_id, op_size, false);
+	ret = cmd_address_audit(s, gma + op_size * core_id, op_size, false, 1);
 	return ret;
 }
 
@@ -1541,7 +1555,7 @@ static int cmd_handler_mi_op_2f(struct parser_exec_state *s)
 		gma_high = cmd_val(s, 2) & GENMASK(15, 0);
 		gma = (gma_high << 32) | gma;
 	}
-	ret = cmd_address_audit(s, gma, op_size, false);
+	ret = cmd_address_audit(s, gma, op_size, false, 1);
 	return ret;
 }
 
@@ -1581,7 +1595,8 @@ static int cmd_handler_mi_flush_dw(struct parser_exec_state *s)
 		/* Store Data Index */
 		if (cmd_val(s, 0) & (1 << 21))
 			index_mode = true;
-		ret = cmd_address_audit(s, gma, sizeof(u64), index_mode);
+		ret = cmd_address_audit(s, (gma | (1 << 2)),
+					sizeof(u64), index_mode, 1);
 	}
 	/* Check notify bit */
 	if ((cmd_val(s, 0) & (1 << 8)))
-- 
2.17.1

