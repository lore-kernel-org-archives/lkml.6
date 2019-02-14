Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2237821904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BreapajY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395494AbfBNEqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:46:35 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41659 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389631AbfBNEqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:46:35 -0500
Received: by mail-yb1-f195.google.com with SMTP id 18so273206ybf.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 20:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hO7DSwxzHlBBi4/zT5cSujpYWgbd+Avp3ABtw3OhI0o=;
        b=BreapajYsNYQ4iV53Cu619/9OrvYxaeKFZPOy635p/VrN8K1+22TgeMSXf9EEUXkQi
         a5jRZuCT0nC9LJB9s3MKkir9zogJEydr7v87Z7OqiWMC7D///ZGAkoEdY90c64mpEXEa
         UShekndl1sXnzblFFx/O0ApEePgmJpKO9Ti6MFdXMWuqt+gacAVoQMJ49wcpN+VbBNwS
         FIImT3DraDAJXjPZ3rtd2AcxMCegcdi8HU1ojEW5MCTl32poTF0Jk3XhgX8q3P299T39
         AYaclwCOlZvBz5dBzNUJ8bHYGJEHA5w2Yn4tS5AVtCqqTy25DsOLL6Ib5rutEjqtsm7B
         nEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hO7DSwxzHlBBi4/zT5cSujpYWgbd+Avp3ABtw3OhI0o=;
        b=CifaFUBnZz4oG6/Oa15xBfOV7mBtIceaWpsIyBe3QbLC/ITnGNbceBzGiI+4bKPeJg
         Pe9UXrGSALXCZ2YAnjfITUT9oAzKpBxbEQBJZ3ScJt6Wo0QBHX8hUyJP6rEV/ySpee7O
         NpMMlW72shoH8RyAVxArLDOD/8k24ijLO47AdgdAbpZTn+Sks7W4aQoCgrjDMOQKGPW+
         3iwQBsIz0F1/O7LcPh2lfmvMeUTQz4eyMO6qQ406ORXJSzZBFR2pfwNd+j6/+IsKG5YK
         czMFc9ljNpbi+buzuaH128YcXa387VcnydzQMF3U7t2CBPZbaaeireI8EKZMYPo9+GHU
         OVvQ==
X-Gm-Message-State: AHQUAuYJqmBww8ziudVpC7EiNQyZJEBYx8nQx6V3pKq2T049kUrR/udm
        p+9Ln1tH4a02U4MfKvmq4QE=
X-Google-Smtp-Source: AHgI3Ia0qW8d+5IAkOCsne/sb//c0YA5CTYhITiwzhkwsD67ys0jc9i5eOb9iRlOM4sbeXiMj4Lkeg==
X-Received: by 2002:a25:ab2a:: with SMTP id u39mr1550311ybi.0.1550119594493;
        Wed, 13 Feb 2019 20:46:34 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id s185sm876056yws.69.2019.02.13.20.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 20:46:33 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Rex.Zhu@amd.com, andrey.grodzovsky@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Bo Yu <tsu.yubo@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Error handling issues about CHECKED_RETURN
Date:   Wed, 13 Feb 2019 23:46:28 -0500
Message-Id: <20190214044628.26759-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Yu <tsu.yubo@gmail.com>

Calling "amdgpu_ring_test_helper" without checking return value

Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 57cb3a51bda7..48465a61516b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4728,7 +4728,9 @@ static int gfx_v8_0_cp_test_all_rings(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		amdgpu_ring_test_helper(ring);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return 0;
-- 
2.11.0

