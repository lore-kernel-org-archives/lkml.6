Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10FCC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904DB2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904DB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeJBEFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:05:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:28133 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbeJBEFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:05:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 14:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="75349784"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2018 14:25:49 -0700
Subject: [PATCH v2] libnvdimm, dimm: Maximize label transfer size
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Oct 2018 14:14:01 -0700
Message-ID: <153842839852.2679462.16816747305002065908.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvzalloc() to bypass the arbitrary PAGE_SIZE limit of label transfer
operations. Given the expense of calling into firmware, maximize the
amount of label data we transfer per call to be up to the total label
space if allowed by the firmware, or 256K whichever is smaller.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v2:
* clamp the max allocation size at 256K in case large label areas with
  unlimited transfer sizes appear in the future.

 drivers/nvdimm/dimm_devs.c       |   14 ++++++++------
 tools/testing/nvdimm/test/nfit.c |    2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 863cabc35215..3616e2e47788 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -111,8 +111,9 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
 	if (!ndd->data)
 		return -ENOMEM;
 
-	max_cmd_size = min_t(u32, PAGE_SIZE, ndd->nsarea.max_xfer);
-	cmd = kzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
+	max_cmd_size = min_t(u32, ndd->nsarea.config_size, SZ_256K);
+	max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
+	cmd = kvzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -134,7 +135,7 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
 		memcpy(ndd->data + offset, cmd->out_buf, cmd->in_length);
 	}
 	dev_dbg(ndd->dev, "len: %zu rc: %d\n", offset, rc);
-	kfree(cmd);
+	kvfree(cmd);
 
 	return rc;
 }
@@ -157,9 +158,10 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 	if (offset + len > ndd->nsarea.config_size)
 		return -ENXIO;
 
-	max_cmd_size = min_t(u32, PAGE_SIZE, len);
+	max_cmd_size = min_t(u32, ndd->nsarea.config_size, SZ_256K);
 	max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
-	cmd = kzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
+	max_cmd_size = min_t(u32, max_cmd_size, len);
+	cmd = kvzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -183,7 +185,7 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 			break;
 		}
 	}
-	kfree(cmd);
+	kvfree(cmd);
 
 	return rc;
 }
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index cffc2c5a778d..caa58d8533f5 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -448,7 +448,7 @@ static int nfit_test_cmd_get_config_size(struct nd_cmd_get_config_size *nd_cmd,
 
 	nd_cmd->status = 0;
 	nd_cmd->config_size = LABEL_SIZE;
-	nd_cmd->max_xfer = SZ_4K;
+	nd_cmd->max_xfer = LABEL_SIZE;
 
 	return 0;
 }

