Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8839AECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518482081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVU5ou1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518482081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbeKDXHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbeKDXHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69982086D;
        Sun,  4 Nov 2018 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339526;
        bh=RI5oVhD0Cs6orNqDDP6Ld15M79bSS/OlPbkUQ0VhZfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVU5ou1ZORn6FDMPghd6v9cC4Ri/Xcwl/3BH4XFwf+pb0hMhkYY2jT0YxPTX3QyN+
         mMLKlQ+36VYFB0cYdFvZEm6rDDJIeegIllglt/QdRW2RaS88EG4UlOs6+IamxJ4ArD
         CvmAVXkI9sLbGTVb4ECN30Wmr0coVeu0Pi3VkxYo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 20/57] drm/nouveau/secboot/acr: fix memory leak
Date:   Sun,  4 Nov 2018 08:51:07 -0500
Message-Id: <20181104135144.88324-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 74a07c0a59fa372b069d879971ba4d9e341979cf ]

In case memory resources for *bl_desc* were allocated, release
them before return.

Addresses-Coverity-ID: 1472021 ("Resource leak")
Fixes: 0d466901552a ("drm/nouveau/secboot/acr: Remove VLA usage")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
index d02e183717dc..5c14d6ac855d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
@@ -801,6 +801,7 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
 		bl = acr->hsbl_unload_blob;
 	} else {
 		nvkm_error(_acr->subdev, "invalid secure boot blob!\n");
+		kfree(bl_desc);
 		return -EINVAL;
 	}
 
-- 
2.17.1

