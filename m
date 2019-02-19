Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76453C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D65721479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QiT56t5y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QiT56t5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfBSShJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:37:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41126 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:37:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E35E86071A; Tue, 19 Feb 2019 18:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550601427;
        bh=njH33rYKy3vFIb6fkipIu/vDpfkh75L2Bm9zaAix+ok=;
        h=From:To:Cc:Subject:Date:From;
        b=QiT56t5y6imWmLhW8YYwSQiacN44dV2wdwj5/a+/8Y2nJHxhb7uBW93+XKPSRkLdO
         k+kEacJYGmHH+3jUVbucch3Hjg7bk+ZnPB6ONNle1gUkaqb+qlrMkUxZeso4lbj2C1
         I2skXGCT+QvjMWbkze+bjDXe3dImDtOxDtO8+mro=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C0CC6071A;
        Tue, 19 Feb 2019 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550601427;
        bh=njH33rYKy3vFIb6fkipIu/vDpfkh75L2Bm9zaAix+ok=;
        h=From:To:Cc:Subject:Date:From;
        b=QiT56t5y6imWmLhW8YYwSQiacN44dV2wdwj5/a+/8Y2nJHxhb7uBW93+XKPSRkLdO
         k+kEacJYGmHH+3jUVbucch3Hjg7bk+ZnPB6ONNle1gUkaqb+qlrMkUxZeso4lbj2C1
         I2skXGCT+QvjMWbkze+bjDXe3dImDtOxDtO8+mro=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C0CC6071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm: Truncate the buffer object name if the copy from user failed
Date:   Tue, 19 Feb 2019 11:37:02 -0700
Message-Id: <1550601422-30651-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a error while doing a copy_from_user() for MSM_INFO_SET_NAME
make sure to truncate the object name so that there isn't a chance that
we'll have random data in the string.

This is on top of [1] reported and fixed by Dan Carpenter.

[1] https://patchwork.freedesktop.org/series/56656/

Fixes: f05c83e77460 ("drm/msm: add uapi to get/set debug name")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 87eae44..9ca558d 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -852,8 +852,11 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 			break;
 		}
 		if (copy_from_user(msm_obj->name, u64_to_user_ptr(args->value),
-				   args->len))
+				   args->len)) {
+			msm_obj->name[0] = '\0'
 			ret = -EFAULT;
+			break;
+		}
 		msm_obj->name[args->len] = '\0';
 		for (i = 0; i < args->len; i++) {
 			if (!isprint(msm_obj->name[i])) {
-- 
2.7.4

