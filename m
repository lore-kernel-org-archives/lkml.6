Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CF2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7CC24EB7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Im+/lU1P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Im+/lU1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7CC24EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933063AbeGCGYN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:24:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeGCGYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:24:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B46E460B25; Tue,  3 Jul 2018 06:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530599051;
        bh=LfNdJIt6pzTNRXJmPb2LKUMFl7qx3gRraSWxSOMojpc=;
        h=From:To:Cc:Subject:Date:From;
        b=Im+/lU1PRDuZ2BDDdQi/Dy9PaeP47PNs2wxA/BRvdxEgr3Laiakvrg8Jr4sGzT4f3
         2JfFEzvMrWcaCEUISF7f1YaUaZL1S5RntLW2XTzUAR91al4QTI1xuK5UhoZeXxH2/0
         9bWcIjg6XwdvblFPaXKw9ZdfyZlUmSZSftnghIG4=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgoswami@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5156660274;
        Tue,  3 Jul 2018 06:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530599051;
        bh=LfNdJIt6pzTNRXJmPb2LKUMFl7qx3gRraSWxSOMojpc=;
        h=From:To:Cc:Subject:Date:From;
        b=Im+/lU1PRDuZ2BDDdQi/Dy9PaeP47PNs2wxA/BRvdxEgr3Laiakvrg8Jr4sGzT4f3
         2JfFEzvMrWcaCEUISF7f1YaUaZL1S5RntLW2XTzUAR91al4QTI1xuK5UhoZeXxH2/0
         9bWcIjg6XwdvblFPaXKw9ZdfyZlUmSZSftnghIG4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5156660274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
From:   bgoswami@codeaurora.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Banajit Goswami <bgoswami@codeaurora.org>
Subject: [PATCH][RESEND] component: enhance handling of devres group for master
Date:   Mon,  2 Jul 2018 23:24:09 -0700
Message-Id: <1530599049-16212-1-git-send-email-bgoswami@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Banajit Goswami <bgoswami@codeaurora.org>

The devres group opened for a master is left open-ended (without
devres_group_close) even after bind() is complete. Similarly, while
releasing the devres resources for master, the most recently opened
devres group is selected, and released without identifying the
targeted group. As the devres group opened before master bind was
never closed, there may have unintended consequences of releasing
devres resources that were allocated after master bind() function
was complete.

Change adds a devres_group_close() after bind() call to master, to
encapsulate the resources allocated during bind, and then use a
group ID to specifically identify the group in release, so that
during master unbind, only the resources that are part of that
specific devres group, are released.

Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 drivers/base/component.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 89b032f..f9ce937 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -155,17 +155,19 @@ static int try_to_bring_up_master(struct master *master,
 		return 0;
 	}
 
-	if (!devres_open_group(master->dev, NULL, GFP_KERNEL))
+	if (!devres_open_group(master->dev, master, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* Found all components */
 	ret = master->ops->bind(master->dev);
 	if (ret < 0) {
-		devres_release_group(master->dev, NULL);
+		devres_release_group(master->dev, master);
 		dev_info(master->dev, "master bind failed: %d\n", ret);
 		return ret;
 	}
 
+	devres_close_group(master->dev, master);
+
 	master->bound = true;
 	return 1;
 }
@@ -190,7 +192,7 @@ static void take_down_master(struct master *master)
 {
 	if (master->bound) {
 		master->ops->unbind(master->dev);
-		devres_release_group(master->dev, NULL);
+		devres_release_group(master->dev, master);
 		master->bound = false;
 	}
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

