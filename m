Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E10EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A9921479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bdYteH5R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lynlJm2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBSSkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:40:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:40:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B62D6074F; Tue, 19 Feb 2019 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550601624;
        bh=4WeQi5pHEagIekTpfofuvsBh5mLfS6PKxqY7YzpnRjE=;
        h=From:To:Cc:Subject:Date:From;
        b=bdYteH5R3Xcn3ODruBvwZhV9ear62mbSjSpGk57YCgiKeNjGy54Iv0NuPERkIor4W
         dbkThPdSxlnC6NN2GryxLA1cl1mkf6P6qd7Wksz/WaVzZ3lWvgLGhsFfwoJk1IHQ+n
         zRdak6QzEOeFkw9kqhH4NIxbffnYDzc2Ra910smI=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 149B76071A;
        Tue, 19 Feb 2019 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550601623;
        bh=4WeQi5pHEagIekTpfofuvsBh5mLfS6PKxqY7YzpnRjE=;
        h=From:To:Cc:Subject:Date:From;
        b=lynlJm2+Ykvq0O2tLeavfYTkUj9cqftU/Upnw6EWMtKFw+0H/7wV5Tp7mSJFIRZ64
         zxfuZ2WKTLIbK3+ORFEZZs+U/O5JBXOWOtpKc0JW1IqwrlQh14fhMIPXsldT89xJ5h
         LOG82islAS4Uc85u7j3bA1fTR3YEkxiE2eXCan04=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 149B76071A
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
Subject: [PATCH RESEND] drm/msm: Truncate the buffer object name if the copy from user failed
Date:   Tue, 19 Feb 2019 11:40:19 -0700
Message-Id: <1550601619-31051-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend since there was a compile error that I forgot to commit before sending)

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
index 87eae44..906b2bb 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -852,8 +852,11 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 			break;
 		}
 		if (copy_from_user(msm_obj->name, u64_to_user_ptr(args->value),
-				   args->len))
+				   args->len)) {
+			msm_obj->name[0] = '\0';
 			ret = -EFAULT;
+			break;
+		}
 		msm_obj->name[args->len] = '\0';
 		for (i = 0; i < args->len; i++) {
 			if (!isprint(msm_obj->name[i])) {
-- 
2.7.4

