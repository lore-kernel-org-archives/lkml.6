Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D355CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BBE206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BBE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeJEXc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:32:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:23209 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:32:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 09:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,345,1534834800"; 
   d="scan'208";a="78782250"
Received: from glacier.sc.intel.com ([10.3.62.55])
  by orsmga007.jf.intel.com with ESMTP; 05 Oct 2018 09:33:25 -0700
From:   Rajmohan Mani <rajmohan.mani@intel.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        tfiga@chromium.org
Cc:     Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH] media: dw9714: Fix error handling in probe function
Date:   Fri,  5 Oct 2018 09:22:17 -0700
Message-Id: <1538756537-35340-1-git-send-email-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the case where v4l2_async_unregister_subdev()
is called unnecessarily in the error handling path
in probe function.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
---
 drivers/media/i2c/dw9714.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index 91fae01..3dc2100 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -169,7 +169,8 @@ static int dw9714_probe(struct i2c_client *client)
 	return 0;
 
 err_cleanup:
-	dw9714_subdev_cleanup(dw9714_dev);
+	v4l2_ctrl_handler_free(&dw9714_dev->ctrls_vcm);
+	media_entity_cleanup(&dw9714_dev->sd.entity);
 	dev_err(&client->dev, "Probe failed: %d\n", rval);
 	return rval;
 }
-- 
2.7.4

