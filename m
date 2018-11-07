Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB56EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA822081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA822081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeKHEYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:24:24 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:46311 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeKHEYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:24:24 -0500
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 1F053629BC;
        Wed,  7 Nov 2018 18:52:45 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 4F5C0B9;
        Wed,  7 Nov 2018 18:52:44 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.81.122])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id A5AFA48;
        Wed,  7 Nov 2018 18:52:43 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, elliott@hpe.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>, stable@vger.kernel.org
Subject: [PATCH] libnvdimm: Fix __nd_ioctl() to check error in cmd_rc
Date:   Wed,  7 Nov 2018 11:52:41 -0700
Message-Id: <20181107185241.26982-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ndctl zero-labels completes with a large number of zeroed nmems when
it fails to do zeroing on a protected NVDIMM.

  # ndctl zero-labels nmem1
  zeroed 65504 nmems

When an ACPI call completes with error, xlat_status() called from
acpi_nfit_ctl() sets error to *cmd_rc.  __nd_ioctl(), however, does
not check this error and returns with success.

Fix __nd_ioctl() to check this error in cmd_rc.

Fixes: 006358b35c73a ("libnvdimm: add support for clear poison list and badblocks for device dax")
Reported-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/nvdimm/bus.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index f1fb39921236..af12817d8a02 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -1050,6 +1050,10 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	rc = nd_desc->ndctl(nd_desc, nvdimm, cmd, buf, buf_len, &cmd_rc);
 	if (rc < 0)
 		goto out_unlock;
+	if (cmd_rc < 0) {
+		rc = cmd_rc;
+		goto out_unlock;
+	}
 
 	if (!nvdimm && cmd == ND_CMD_CLEAR_ERROR && cmd_rc >= 0) {
 		struct nd_cmd_clear_error *clear_err = buf;
