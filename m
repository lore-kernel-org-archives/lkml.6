Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B55CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3808320836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n5NooLxH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n5NooLxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfBUVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:54:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:54:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AF30D608CE; Thu, 21 Feb 2019 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550786074;
        bh=t1Wo67g3zmG34hoxKco1zuOm2XBuz0VbUZXozrjpAlE=;
        h=From:To:Cc:Subject:Date:From;
        b=n5NooLxHFMviq2Qsank2RDZwFExiEHzvTnWRD2aalDfKq/en+9gst8WDRBF4vXNtR
         l3Ar0UHUT+8g3XWvwye+DsuEpw9jqKbZfXJDsSRGVRRReGWxb20I6WdkZXmqAWDjzz
         VEWISUKD9Jzy8Zjbs/XqDC5Yj8ScM9mxspAzW+h4=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D79C6071B;
        Thu, 21 Feb 2019 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550786074;
        bh=t1Wo67g3zmG34hoxKco1zuOm2XBuz0VbUZXozrjpAlE=;
        h=From:To:Cc:Subject:Date:From;
        b=n5NooLxHFMviq2Qsank2RDZwFExiEHzvTnWRD2aalDfKq/en+9gst8WDRBF4vXNtR
         l3Ar0UHUT+8g3XWvwye+DsuEpw9jqKbZfXJDsSRGVRRReGWxb20I6WdkZXmqAWDjzz
         VEWISUKD9Jzy8Zjbs/XqDC5Yj8ScM9mxspAzW+h4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D79C6071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm: Fix incorrect struct size for memory allocation
Date:   Thu, 21 Feb 2019 14:54:29 -0700
Message-Id: <1550786069-18328-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation for the clock bulk data does a classic sizeof(pointer)
instead of sizeof(struct) so the array ends up incorrectly sized
for the clock data.

Cc: stable@vger.kernel.org
Fixes: 8e54eea ("drm/msm: Add a helper function to parse clock names")
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 906b2bb..31e1481 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -96,7 +96,7 @@ int msm_clk_bulk_get(struct device *dev, struct clk_bulk_data **bulk)
 	if (count < 1)
 		return 0;
 
-	local = devm_kcalloc(dev, sizeof(struct clk_bulk_data *),
+	local = devm_kcalloc(dev, sizeof(struct clk_bulk_data),
 		count, GFP_KERNEL);
 	if (!local)
 		return -ENOMEM;
-- 
2.7.4

