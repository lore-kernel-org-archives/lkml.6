Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F6FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9B720651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfAOCJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:09:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:51831 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfAOCJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:09:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 18:09:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="118457103"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2019 18:09:51 -0800
Subject: [PATCH v2 2/2] acpi/nfit: Fix command-supported detection
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com
Date:   Mon, 14 Jan 2019 17:57:14 -0800
Message-ID: <154751743447.1617064.15326609523389400890.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _DSM function number validation only happens to succeed when the
generic Linux command number translation corresponds with a
DSM-family-specific function number. This breaks NVDIMM-N
implementations that correctly implement _LSR, _LSW, and _LSI, but do
not happen to publish support for DSM function numbers 4, 5, and 6.

Recall that the support for _LS{I,R,W} family of methods results in the
DIMM being marked as supporting those command numbers at
acpi_nfit_register_dimms() time. The DSM function mask is only used for
ND_CMD_CALL support of non-NVDIMM_FAMILY_INTEL devices.

Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command...")
Cc: <stable@vger.kernel.org>
Link: https://github.com/pmem/ndctl/issues/78
Cc: Jeff Moyer <jmoyer@redhat.com>
Reported-by: Sujith Pandel <sujith_pandel@dell.com>
Tested-by: Sujith Pandel <sujith_pandel@dell.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 67aef1a793d5..f770758f5063 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -409,6 +409,32 @@ static bool payload_dumpable(struct nvdimm *nvdimm, unsigned int func)
 	return true;
 }
 
+static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
+		struct nd_cmd_pkg *call_pkg)
+{
+	if (cmd == ND_CMD_CALL) {
+		int i;
+
+		if (call_pkg && nfit_mem->family != call_pkg->nd_family)
+			return -ENOTTY;
+
+		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
+			if (call_pkg->nd_reserved2[i])
+				return -EINVAL;
+		return call_pkg->nd_command;
+	}
+
+	/* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
+	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
+		return cmd;
+
+	/*
+	 * Force function number validation to fail since 0 is never
+	 * published as a valid function in dsm_mask.
+	 */
+	return 0;
+}
+
 int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
 {
@@ -422,30 +448,21 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	unsigned long cmd_mask, dsm_mask;
 	u32 offset, fw_status = 0;
 	acpi_handle handle;
-	unsigned int func;
 	const guid_t *guid;
-	int rc, i;
+	int func, rc, i;
 
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
-	func = cmd;
-	if (cmd == ND_CMD_CALL) {
-		call_pkg = buf;
-		func = call_pkg->nd_command;
-
-		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
-			if (call_pkg->nd_reserved2[i])
-				return -EINVAL;
-	}
 
 	if (nvdimm) {
 		struct acpi_device *adev = nfit_mem->adev;
 
 		if (!adev)
 			return -ENOTTY;
-		if (call_pkg && nfit_mem->family != call_pkg->nd_family)
-			return -ENOTTY;
 
+		func = cmd_to_func(nfit_mem, cmd, buf);
+		if (func < 0)
+			return func;
 		dimm_name = nvdimm_name(nvdimm);
 		cmd_name = nvdimm_cmd_name(cmd);
 		cmd_mask = nvdimm_cmd_mask(nvdimm);
@@ -456,6 +473,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	} else {
 		struct acpi_device *adev = to_acpi_dev(acpi_desc);
 
+		func = cmd;
 		cmd_name = nvdimm_bus_cmd_name(cmd);
 		cmd_mask = nd_desc->cmd_mask;
 		dsm_mask = cmd_mask;
@@ -470,7 +488,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	if (!desc || (cmd && (desc->out_num + desc->in_num == 0)))
 		return -ENOTTY;
 
-	if (!test_bit(cmd, &cmd_mask) || !test_bit(func, &dsm_mask))
+	if (!test_bit(cmd, &cmd_mask) && !test_bit(func, &dsm_mask))
 		return -ENOTTY;
 
 	in_obj.type = ACPI_TYPE_PACKAGE;

