Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 95BDEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4D520896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4D520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965452AbeFOArc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:47:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:19081 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965325AbeFOAr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:47:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 17:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="67127746"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2018 17:47:27 -0700
Subject: [PATCH 3/3] tools/testing/nvdimm: Make DSM failure code injection
 an override
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Jun 2018 17:37:30 -0700
Message-ID: <152902305016.10541.6695000206945040942.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to emulate the behavior of the NVDIMM_FAMILY_INTEL DSMs
nfit_test needs the ability to execute the DSM and then override the
return code.

Split the current return code injection from get_dimm() and apply at
after the function has executed to override the return status.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   49 +++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 4ea385be528f..6f19d6e28f5f 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -882,6 +882,16 @@ static int nd_intel_test_cmd_set_lss_status(struct nfit_test *t,
 	return 0;
 }
 
+static int override_return_code(int dimm, unsigned int func, int rc)
+{
+	if ((1 << func) & dimm_fail_cmd_flags[dimm]) {
+		if (dimm_fail_cmd_code[dimm])
+			return dimm_fail_cmd_code[dimm];
+		return -EIO;
+	}
+	return rc;
+}
+
 static int get_dimm(struct nfit_mem *nfit_mem, unsigned int func)
 {
 	int i;
@@ -892,13 +902,6 @@ static int get_dimm(struct nfit_mem *nfit_mem, unsigned int func)
 			break;
 	if (i >= ARRAY_SIZE(handle))
 		return -ENXIO;
-
-	if ((1 << func) & dimm_fail_cmd_flags[i]) {
-		if (dimm_fail_cmd_code[i])
-			return dimm_fail_cmd_code[i];
-		return -EIO;
-	}
-
 	return i;
 }
 
@@ -937,48 +940,59 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 
 			switch (func) {
 			case ND_INTEL_ENABLE_LSS_STATUS:
-				return nd_intel_test_cmd_set_lss_status(t,
+				rc = nd_intel_test_cmd_set_lss_status(t,
 						buf, buf_len);
+				break;
 			case ND_INTEL_FW_GET_INFO:
-				return nd_intel_test_get_fw_info(t, buf,
+				rc = nd_intel_test_get_fw_info(t, buf,
 						buf_len, i - t->dcr_idx);
+				break;
 			case ND_INTEL_FW_START_UPDATE:
-				return nd_intel_test_start_update(t, buf,
+				rc = nd_intel_test_start_update(t, buf,
 						buf_len, i - t->dcr_idx);
+				break;
 			case ND_INTEL_FW_SEND_DATA:
-				return nd_intel_test_send_data(t, buf,
+				rc = nd_intel_test_send_data(t, buf,
 						buf_len, i - t->dcr_idx);
+				break;
 			case ND_INTEL_FW_FINISH_UPDATE:
-				return nd_intel_test_finish_fw(t, buf,
+				rc = nd_intel_test_finish_fw(t, buf,
 						buf_len, i - t->dcr_idx);
+				break;
 			case ND_INTEL_FW_FINISH_QUERY:
-				return nd_intel_test_finish_query(t, buf,
+				rc = nd_intel_test_finish_query(t, buf,
 						buf_len, i - t->dcr_idx);
+				break;
 			case ND_INTEL_SMART:
-				return nfit_test_cmd_smart(buf, buf_len,
+				rc = nfit_test_cmd_smart(buf, buf_len,
 						&t->smart[i - t->dcr_idx]);
+				break;
 			case ND_INTEL_SMART_THRESHOLD:
-				return nfit_test_cmd_smart_threshold(buf,
+				rc = nfit_test_cmd_smart_threshold(buf,
 						buf_len,
 						&t->smart_threshold[i -
 							t->dcr_idx]);
+				break;
 			case ND_INTEL_SMART_SET_THRESHOLD:
-				return nfit_test_cmd_smart_set_threshold(buf,
+				rc = nfit_test_cmd_smart_set_threshold(buf,
 						buf_len,
 						&t->smart_threshold[i -
 							t->dcr_idx],
 						&t->smart[i - t->dcr_idx],
 						&t->pdev.dev, t->dimm_dev[i]);
+				break;
 			case ND_INTEL_SMART_INJECT:
-				return nfit_test_cmd_smart_inject(buf,
+				rc = nfit_test_cmd_smart_inject(buf,
 						buf_len,
 						&t->smart_threshold[i -
 							t->dcr_idx],
 						&t->smart[i - t->dcr_idx],
 						&t->pdev.dev, t->dimm_dev[i]);
+				break;
 			default:
 				return -ENOTTY;
 			}
+			return override_return_code(i, func, rc);
 		}
 
 		if (!test_bit(cmd, &cmd_mask)
@@ -1004,6 +1018,7 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		default:
 			return -ENOTTY;
 		}
+		return override_return_code(i, func, rc);
 	} else {
 		struct ars_state *ars_state = &t->ars_state;
 		struct nd_cmd_pkg *call_pkg = buf;

