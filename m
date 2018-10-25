Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E3020848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIpT5Vtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E3020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeJYXSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeJYWn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:58 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03CB92054F;
        Thu, 25 Oct 2018 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476663;
        bh=226aN9mZBFXH7rJIjAk2+e+Iv0fmnLYMuL9nyU2tCSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIpT5Vtc0W4oWSGDLP/qaHaWcXDQ08Sn6E/edst7fAXCrTBBeATXKagThX0no6Omx
         1jrqnyl6wSHSVMq17NvsO3ikSN/8vtVl1ZhVItlXU04R3BnkAr3yw2qfJvNAvxzmkK
         K8abyBgNB3FVJRJbUHT7sxYKigHqieuN23gCJp7g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 05/46] tools/testing/nvdimm: unit test clear-error commands
Date:   Thu, 25 Oct 2018 10:10:12 -0400
Message-Id: <20181025141053.213330-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit fb2a1748355161e050e9f49f1ea9a0ae707a148b ]

Validate command parsing in acpi_nfit_ctl for the clear error command.
This tests for a crash condition introduced by commit 4b27db7e26cd
"acpi, nfit: add support for the _LSI, _LSR, and _LSW label methods".

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/nvdimm/test/nfit.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index bef419d4266d..3ad0b3a3317b 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1589,6 +1589,7 @@ static int nfit_ctl_test(struct device *dev)
 	unsigned long mask, cmd_size, offset;
 	union {
 		struct nd_cmd_get_config_size cfg_size;
+		struct nd_cmd_clear_error clear_err;
 		struct nd_cmd_ars_status ars_stat;
 		struct nd_cmd_ars_cap ars_cap;
 		char buf[sizeof(struct nd_cmd_ars_status)
@@ -1767,6 +1768,23 @@ static int nfit_ctl_test(struct device *dev)
 		return -EIO;
 	}
 
+	/* test clear error */
+	cmd_size = sizeof(cmds.clear_err);
+	cmds.clear_err = (struct nd_cmd_clear_error) {
+		.length = 512,
+		.cleared = 512,
+	};
+	rc = setup_result(cmds.buf, cmd_size);
+	if (rc)
+		return rc;
+	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, NULL, ND_CMD_CLEAR_ERROR,
+			cmds.buf, cmd_size, &cmd_rc);
+	if (rc < 0 || cmd_rc) {
+		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
+				__func__, __LINE__, rc, cmd_rc);
+		return -EIO;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

