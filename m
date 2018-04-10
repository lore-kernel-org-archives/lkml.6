Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756253AbeDJWtU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 18:49:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:44371 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752865AbeDJWtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:49:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="42334982"
Subject: [PATCH 2/5] tools/testing/nvdimm: allow custom error code injection
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 15:39:19 -0700
Message-ID: <152339995956.16061.8063508678567328863.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that libnvdimm driver stack takes specific actions on DIMM command
error codes like -EACCES, provide a facility to inject custom failures.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index cb166be4918d..dc6cf5630280 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -138,6 +138,7 @@ static u32 handle[] = {
 };
 
 static unsigned long dimm_fail_cmd_flags[NUM_DCR];
+static int dimm_fail_cmd_code[NUM_DCR];
 
 struct nfit_test_fw {
 	enum intel_fw_update_state state;
@@ -892,8 +893,11 @@ static int get_dimm(struct nfit_mem *nfit_mem, unsigned int func)
 	if (i >= ARRAY_SIZE(handle))
 		return -ENXIO;
 
-	if ((1 << func) & dimm_fail_cmd_flags[i])
+	if ((1 << func) & dimm_fail_cmd_flags[i]) {
+		if (dimm_fail_cmd_code[i])
+			return dimm_fail_cmd_code[i];
 		return -EIO;
+	}
 
 	return i;
 }
@@ -1225,8 +1229,40 @@ static ssize_t fail_cmd_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(fail_cmd);
 
+static ssize_t fail_cmd_code_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int dimm = dimm_name_to_id(dev);
+
+	if (dimm < 0)
+		return dimm;
+
+	return sprintf(buf, "%d\n", dimm_fail_cmd_code[dimm]);
+}
+
+static ssize_t fail_cmd_code_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int dimm = dimm_name_to_id(dev);
+	unsigned long val;
+	ssize_t rc;
+
+	if (dimm < 0)
+		return dimm;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	dimm_fail_cmd_code[dimm] = val;
+	return size;
+}
+static DEVICE_ATTR_RW(fail_cmd_code);
+
+
 static struct attribute *nfit_test_dimm_attributes[] = {
 	&dev_attr_fail_cmd.attr,
+	&dev_attr_fail_cmd_code.attr,
 	&dev_attr_handle.attr,
 	NULL,
 };
