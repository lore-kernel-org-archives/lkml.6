Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52DAC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9E221907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfBHAKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:10:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:27831 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfBHAKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:10:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 16:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,346,1544515200"; 
   d="scan'208";a="116119345"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2019 16:10:09 -0800
Subject: [PATCH] acpi/nfit: Fix bus command validation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Vishal Verma <vishal.verma@intel.com>,
        Grzegorz Burzynski <grzegorz.burzynski@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com
Date:   Thu, 07 Feb 2019 15:57:31 -0800
Message-ID: <154958385172.3932544.193235520333886200.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 11189c1089da "acpi/nfit: Fix command-supported detection" broke
ND_CMD_CALL for bus-level commands. The "func = cmd" assumption is only
valid for:

    ND_CMD_ARS_CAP
    ND_CMD_ARS_START
    ND_CMD_ARS_STATUS
    ND_CMD_CLEAR_ERROR

The function number otherwise needs to be pulled from the command
payload for:

    NFIT_CMD_TRANSLATE_SPA
    NFIT_CMD_ARS_INJECT_SET
    NFIT_CMD_ARS_INJECT_CLEAR
    NFIT_CMD_ARS_INJECT_GET

Update cmd_to_func() for the bus case and call it in the common path.

Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
Cc: <stable@vger.kernel.org>
Cc: Vishal Verma <vishal.verma@intel.com>
Reported-by: Grzegorz Burzynski <grzegorz.burzynski@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e18ade5d74e9..c34c595d6bb0 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -415,7 +415,7 @@ static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
 	if (call_pkg) {
 		int i;
 
-		if (nfit_mem->family != call_pkg->nd_family)
+		if (nfit_mem && nfit_mem->family != call_pkg->nd_family)
 			return -ENOTTY;
 
 		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
@@ -424,6 +424,10 @@ static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
 		return call_pkg->nd_command;
 	}
 
+	/* In the !call_pkg case, bus commands == bus functions */
+	if (!nfit_mem)
+		return cmd;
+
 	/* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
 	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
 		return cmd;
@@ -454,17 +458,18 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
 
+	if (cmd == ND_CMD_CALL)
+		call_pkg = buf;
+	func = cmd_to_func(nfit_mem, cmd, call_pkg);
+	if (func < 0)
+		return func;
+
 	if (nvdimm) {
 		struct acpi_device *adev = nfit_mem->adev;
 
 		if (!adev)
 			return -ENOTTY;
 
-		if (cmd == ND_CMD_CALL)
-			call_pkg = buf;
-		func = cmd_to_func(nfit_mem, cmd, call_pkg);
-		if (func < 0)
-			return func;
 		dimm_name = nvdimm_name(nvdimm);
 		cmd_name = nvdimm_cmd_name(cmd);
 		cmd_mask = nvdimm_cmd_mask(nvdimm);
@@ -475,12 +480,9 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	} else {
 		struct acpi_device *adev = to_acpi_dev(acpi_desc);
 
-		func = cmd;
 		cmd_name = nvdimm_bus_cmd_name(cmd);
 		cmd_mask = nd_desc->cmd_mask;
-		dsm_mask = cmd_mask;
-		if (cmd == ND_CMD_CALL)
-			dsm_mask = nd_desc->bus_dsm_mask;
+		dsm_mask = nd_desc->bus_dsm_mask;
 		desc = nd_cmd_bus_desc(cmd);
 		guid = to_nfit_uuid(NFIT_DEV_BUS);
 		handle = adev->handle;

