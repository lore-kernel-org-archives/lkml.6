Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A76DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F98D2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZTOmQ0Qs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JK1xGisM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F98D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeLEQWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:22:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbeLEQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:22:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AF1E960C1C; Wed,  5 Dec 2018 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544026920;
        bh=kvCt3SuTMuZdWz/uLsRJirecDdhJBovv4uJKG7NipNw=;
        h=From:To:Cc:Subject:Date:From;
        b=ZTOmQ0QsAfOwP7C+qPgDtX+y++0xM6BnYhmFw+iXb2X6ykX50EwXSsPWiuK/1ek+t
         ategsB7hcTiOm6m8R2F3a1+ex/fzIF4RGJP3X9rJ2j6gF73umja488hOgJPbbZJ5ws
         mSyKlRynwRl3CkxdmlqSjlSs5nwycNrthriaOQPU=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18E42613D3;
        Wed,  5 Dec 2018 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544026919;
        bh=kvCt3SuTMuZdWz/uLsRJirecDdhJBovv4uJKG7NipNw=;
        h=From:To:Cc:Subject:Date:From;
        b=JK1xGisMV10MCcHa8uj8XyqbdhPhcSaDg31efu7Q5lX5sckIGueC3UQ8ehH7hstYn
         gSPpio6hg56ZV6m9BeJozwGJmCxfkBfw66Sh0HysdAL1qUgBsCbiMLDUUqDpQiF3A1
         9wkM6p0F5gbsv6eQa7CzxwazXQaMgDDX6PoBV6XA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18E42613D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: =?UTF-8?q?=5BDPU=20PATCH=C2=A0=5D=20drm/msm/dpu=3A=20Fix=20clock=20issue=20after=20bind=20failure?=
Date:   Wed,  5 Dec 2018 21:51:47 +0530
Message-Id: <1544026907-24267-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of msm drm bind failure, pm runtime put sync
is called from dsi driver which issues an asynchronous
put on mdss device. Subsequently when dpu_mdss_destroy
is triggered the change will make sure to put the mdss
device in suspend and clearing pending work if not
scheduled.

Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index 2d66025..030229a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -191,6 +191,7 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	struct dss_module_power *mp = &dpu_mdss->mp;
 	int i;
 
+	pm_runtime_suspend(dev->dev);
 	pm_runtime_disable(dev->dev);
 	_dpu_mdss_irq_domain_fini(dpu_mdss);
 	free_irq(platform_get_irq(pdev, 0), dpu_mdss);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

