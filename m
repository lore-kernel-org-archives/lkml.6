Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0271C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A844820876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A844820876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJNXri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:47:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35603 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbeJNXLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:40 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cF-D7; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-00008a-5A; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Francisco Jerez" <currojerez@riseup.net>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Zhigang Gong" <zhigang.gong@linux.intel.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.767399504@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 003/366] drm/i915: Fix command parser to validate
 multiple register access with the same command.
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Francisco Jerez <currojerez@riseup.net>

commit 6a65c5b9326c9dd391afb1b3df75cbedffbaccdb upstream.

Until now the software command checker assumed that commands could
read or write at most a single register per packet.  This is not
necessarily the case, MI_LOAD_REGISTER_IMM expects a variable-length
list of offset/value pairs and writes them in sequence.  The previous
code would only check whether the first entry was valid, effectively
allowing userspace to write unrestricted registers of the MMIO space
by sending a multi-register write with a legal first register, with
potential security implications on Gen6 and 7 hardware.

Fix it by extending the drm_i915_cmd_descriptor table to represent
multi-register access and making validate_cmd() iterate for all
register offsets present in the command packet.

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
Reviewed-by: Zhigang Gong <zhigang.gong@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/i915_cmd_parser.c | 74 +++++++++++++++-----------
 drivers/gpu/drm/i915/i915_drv.h        |  5 ++
 2 files changed, 48 insertions(+), 31 deletions(-)

--- a/drivers/gpu/drm/i915/i915_cmd_parser.c
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
@@ -123,7 +123,7 @@ static const struct drm_i915_cmd_descrip
 	CMD(  MI_SEMAPHORE_MBOX,                SMI,   !F,  0xFF,   R  ),
 	CMD(  MI_STORE_DWORD_INDEX,             SMI,   !F,  0xFF,   R  ),
 	CMD(  MI_LOAD_REGISTER_IMM(1),          SMI,   !F,  0xFF,   W,
-	      .reg = { .offset = 1, .mask = 0x007FFFFC }               ),
+	      .reg = { .offset = 1, .mask = 0x007FFFFC, .step = 2 }    ),
 	CMD(  MI_STORE_REGISTER_MEM(1),         SMI,   !F,  0xFF,   W | B,
 	      .reg = { .offset = 1, .mask = 0x007FFFFC },
 	      .bits = {{
@@ -859,7 +859,7 @@ bool i915_needs_cmd_parser(struct intel_
 
 static bool check_cmd(const struct intel_engine_cs *ring,
 		      const struct drm_i915_cmd_descriptor *desc,
-		      const u32 *cmd,
+		      const u32 *cmd, u32 length,
 		      const bool is_master,
 		      bool *oacontrol_set)
 {
@@ -875,38 +875,49 @@ static bool check_cmd(const struct intel
 	}
 
 	if (desc->flags & CMD_DESC_REGISTER) {
-		u32 reg_addr = cmd[desc->reg.offset] & desc->reg.mask;
-
 		/*
-		 * OACONTROL requires some special handling for writes. We
-		 * want to make sure that any batch which enables OA also
-		 * disables it before the end of the batch. The goal is to
-		 * prevent one process from snooping on the perf data from
-		 * another process. To do that, we need to check the value
-		 * that will be written to the register. Hence, limit
-		 * OACONTROL writes to only MI_LOAD_REGISTER_IMM commands.
+		 * Get the distance between individual register offset
+		 * fields if the command can perform more than one
+		 * access at a time.
 		 */
-		if (reg_addr == OACONTROL) {
-			if (desc->cmd.value == MI_LOAD_REGISTER_MEM) {
-				DRM_DEBUG_DRIVER("CMD: Rejected LRM to OACONTROL\n");
-				return false;
-			}
+		const u32 step = desc->reg.step ? desc->reg.step : length;
+		u32 offset;
 
-			if (desc->cmd.value == MI_LOAD_REGISTER_IMM(1))
-				*oacontrol_set = (cmd[2] != 0);
-		}
+		for (offset = desc->reg.offset; offset < length;
+		     offset += step) {
+			const u32 reg_addr = cmd[offset] & desc->reg.mask;
+
+			/*
+			 * OACONTROL requires some special handling for
+			 * writes. We want to make sure that any batch which
+			 * enables OA also disables it before the end of the
+			 * batch. The goal is to prevent one process from
+			 * snooping on the perf data from another process. To do
+			 * that, we need to check the value that will be written
+			 * to the register. Hence, limit OACONTROL writes to
+			 * only MI_LOAD_REGISTER_IMM commands.
+			 */
+			if (reg_addr == OACONTROL) {
+				if (desc->cmd.value == MI_LOAD_REGISTER_MEM) {
+					DRM_DEBUG_DRIVER("CMD: Rejected LRM to OACONTROL\n");
+					return false;
+				}
 
-		if (!valid_reg(ring->reg_table,
-			       ring->reg_count, reg_addr)) {
-			if (!is_master ||
-			    !valid_reg(ring->master_reg_table,
-				       ring->master_reg_count,
-				       reg_addr)) {
-				DRM_DEBUG_DRIVER("CMD: Rejected register 0x%08X in command: 0x%08X (ring=%d)\n",
-						 reg_addr,
-						 *cmd,
-						 ring->id);
-				return false;
+				if (desc->cmd.value == MI_LOAD_REGISTER_IMM(1))
+					*oacontrol_set = (cmd[offset + 1] != 0);
+			}
+
+			if (!valid_reg(ring->reg_table,
+				       ring->reg_count, reg_addr)) {
+				if (!is_master ||
+				    !valid_reg(ring->master_reg_table,
+					       ring->master_reg_count,
+					       reg_addr)) {
+					DRM_DEBUG_DRIVER("CMD: Rejected register 0x%08X in command: 0x%08X (ring=%d)\n",
+							 reg_addr, *cmd,
+							 ring->id);
+					return false;
+				}
 			}
 		}
 	}
@@ -1020,7 +1031,8 @@ int i915_parse_cmds(struct intel_engine_
 			break;
 		}
 
-		if (!check_cmd(ring, desc, cmd, is_master, &oacontrol_set)) {
+		if (!check_cmd(ring, desc, cmd, length, is_master,
+			       &oacontrol_set)) {
 			ret = -EINVAL;
 			break;
 		}
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1828,10 +1828,15 @@ struct drm_i915_cmd_descriptor {
 	 * Describes where to find a register address in the command to check
 	 * against the ring's register whitelist. Only valid if flags has the
 	 * CMD_DESC_REGISTER bit set.
+	 *
+	 * A non-zero step value implies that the command may access multiple
+	 * registers in sequence (e.g. LRI), in that case step gives the
+	 * distance in dwords between individual offset fields.
 	 */
 	struct {
 		u32 offset;
 		u32 mask;
+		u32 step;
 	} reg;
 
 #define MAX_CMD_DESC_BITMASKS 3

