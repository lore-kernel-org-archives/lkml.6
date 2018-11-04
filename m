Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95833ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BCD20870
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk/Pk74H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BCD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbeKDXT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbeKDXHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468F62082E;
        Sun,  4 Nov 2018 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339558;
        bh=DVOqA5WRc/zHJeSM5KhVyYGdAl/ooRom5MjT0mS6FCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pk/Pk74HqrHR1G5spT/nPOaPmUU1A4c6l/OWDkjW5S2i/KQj0BmRxA5S0zJiFJROi
         N/3zrngbVy+5KVxtYFa7kLeF3zKZCEwRna7Zp3C0sRDSvVE9OLaLwGure1jJzssYyT
         HxfsuIbNSY3P2Bg2nMTA4vXRHGuHRvzFN1yWbduI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 56/57] drm/amdgpu: fix integer overflow test in amdgpu_bo_list_create()
Date:   Sun,  4 Nov 2018 08:51:43 -0500
Message-Id: <20181104135144.88324-56-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ff30e9e8509cb877dc7cbc776b36c70f5bdd290f ]

We accidentally left out the size of the amdgpu_bo_list struct.  It
could lead to memory corruption on 32 bit systems.  You'd have to
pick the absolute maximum and set "num_entries == 59652323" then size
would wrap to 16 bytes.

Fixes: 920990cb080a ("drm/amdgpu: allocate the bo_list array after the list")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Bas Nieuwenhuizen <basni@chromium.org>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index d472a2c8399f..b80243d3972e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -67,7 +67,8 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	unsigned i;
 	int r;
 
-	if (num_entries > SIZE_MAX / sizeof(struct amdgpu_bo_list_entry))
+	if (num_entries > (SIZE_MAX - sizeof(struct amdgpu_bo_list))
+				/ sizeof(struct amdgpu_bo_list_entry))
 		return -EINVAL;
 
 	size = sizeof(struct amdgpu_bo_list);
-- 
2.17.1

