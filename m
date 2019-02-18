Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C50C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF37217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4ePGW2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfBRLA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:00:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35117 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfBRLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:00:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id v7so11978506lfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 03:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+M4m7Q6d5WbVv4iV2+Qj1NKtADofA721rqptMpTGNQ=;
        b=w4ePGW2E2n+/9kZlF29uJmnec2v+5sC5znzIhsgTBJBsQGwPYv6QgmfwOxK5R+kIs+
         DK+tfZ6IaMOPFsGYSLF+BfBVPL2Ur8vQfENrcgWCia/hnvtGXGAsQ2yTt2B67EQaoG3/
         d4nPwkAwhCqD/wVbTVXmzhn4VZ7ut5WV8DTSztlLiByjI5oxUhNzItYBLqM77PSjcnQ6
         +MB6hNq+s4ylEk7T6tOFTZMeTZ19Bdn6Q8DS36dACr6VKZa4cmZwTjfrQo7ZV+Qlk5S2
         4LX3uAWPQ8ubCJKYjkhKNtNdwo9f7tSEjllWxWLHhG30shby/e9QXPRCC5f6bDm7EOQE
         /J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+M4m7Q6d5WbVv4iV2+Qj1NKtADofA721rqptMpTGNQ=;
        b=MWwuOstcWOQqK3bN3Iw8a9PyoPY3kEK0FEjrUBe2I/oIMVyUcj/MPNcLa4iwuZCFpc
         1J8enorgNEEpF1YQhR+SxX4YfyaQzNuRDdfK0KXGeuU8jTl5NMeSt8irXrEv4gK+hJ2X
         jINacKik6deD+2UU4ew8wi/RUw8wOfRvkxx2rolxMKp2ZVpKrZahcovubcdCh19E1TKK
         nDP2dfiGd5Knb0rlRxyhEiyw4CmdJ9NltbEyMxhzZcHV8NHmQRiEU84bn/2opDUgUJaW
         i5nD0zosnPNLyoE+n15iOJc7OmEU2nWiDfEbxLTJfa9F6wGgeVHSdtAxB2/OluEoUgcC
         aqCA==
X-Gm-Message-State: AHQUAuY6mEaXH3cYcYqrytBBqkgt2cJW+hhcpp9ksiHF0T/IBnVEVx/U
        T9ED88T/8sZ8ddxVlhmM/tEu4w==
X-Google-Smtp-Source: AHgI3IblLlacuMY+bbPqHXuI6+sd3yadtSubaZf3OsfiMP+FldozVW+norsopfqCFX3dUS1tlUuRuw==
X-Received: by 2002:ac2:555d:: with SMTP id l29mr13280152lfk.38.1550487653418;
        Mon, 18 Feb 2019 03:00:53 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id y30sm3321340ljd.12.2019.02.18.03.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 03:00:52 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drm/tegra: vic: fix implicit function declaration warning
Date:   Mon, 18 Feb 2019 12:00:50 +0100
Message-Id: <20190218110050.10589-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_IOMMU_API isn't set the following warnings pops up:

drivers/gpu/drm/tegra/vic.c: In function ‘vic_boot’:
drivers/gpu/drm/tegra/vic.c:110:31: error: implicit declaration of function ‘dev_iommu_fwspec_get’; did you mean ‘iommu_fwspec_free’? [-Werror=implicit-function-declaration]
   struct iommu_fwspec *spec = dev_iommu_fwspec_get(vic->dev);
                               ^~~~~~~~~~~~~~~~~~~~
                               iommu_fwspec_free
drivers/gpu/drm/tegra/vic.c:110:31: warning: initialization of ‘struct iommu_fwspec *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
drivers/gpu/drm/tegra/vic.c:117:19: error: ‘struct iommu_fwspec’ has no member named ‘num_ids’
   if (spec && spec->num_ids > 0) {
                   ^~
drivers/gpu/drm/tegra/vic.c:118:16: error: ‘struct iommu_fwspec’ has no member named ‘ids’
    value = spec->ids[0] & 0xffff;
                ^~

Rework so that its inside a '#ifdef CONFIG_IOMMU_API' block.

Fixes: f3779cb190a5 ("drm/tegra: vic: Support stream ID register programming")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/tegra/vic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 39bfed9623de..982ce37ecde1 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -106,6 +106,7 @@ static int vic_boot(struct vic *vic)
 	if (vic->booted)
 		return 0;
 
+#ifdef CONFIG_IOMMU_API
 	if (vic->config->supports_sid) {
 		struct iommu_fwspec *spec = dev_iommu_fwspec_get(vic->dev);
 		u32 value;
@@ -121,6 +122,7 @@ static int vic_boot(struct vic *vic)
 			vic_writel(vic, value, VIC_THI_STREAMID1);
 		}
 	}
+#endif
 
 	/* setup clockgating registers */
 	vic_writel(vic, CG_IDLE_CG_DLY_CNT(4) |
-- 
2.19.2

