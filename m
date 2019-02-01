Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85959C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513B320844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5xlfrjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfBAUND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:13:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36141 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBAUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:13:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so6479678edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4pay4XeW+oogi+CzejAnHBYw0nfnymIcC7dpDfzr1mY=;
        b=Q5xlfrjJJd9/CgS3ltUPdzfY5BZg8c/fk3wZgzJqz8Pmhhv9rdc92KytmkOoSNHu4o
         esn3kLywcmfjCwAuO+t+/ONtbqQkGM4GfUjt1wG8tREaBxK8CVEGF2f6pred7sdsMkLC
         0xbj7+leSIshIGJDQIuCsBcnGm/yvHS11TJklQBeBRqy3otgZMDgwG+Qi4dqpBfKPHB1
         LlVsyVChpXB+7HBKlOVOlDUX6s8RLtppqlacS6pZV/TR/R9OOVCYHXCU761wy1I/bcUF
         xjXFkzcDCAzamwa2suk7GyxoVR4UBiGKIcQ52rPLCkjAz4tc08KkKY6iRkCzw948liLj
         uA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4pay4XeW+oogi+CzejAnHBYw0nfnymIcC7dpDfzr1mY=;
        b=PjNM+cm4wqwyvYRGAs/aWTPAJaE2Qabe+nIus6UnuCNe2HVjQ510EtWVK1puv5wSr6
         ProW1NgAfDdYgwM3nCeUOgoz9ny8wFhszQ/Evy1/SZDqbMkVV+H86wQy8BQegOZqPu8L
         oedV67yzK9S6gLa4LCwwHxXh22JvPhEGxEkXZJ8WDV9NE9/y91SXgVz6L2SqcTx5JpkW
         52NB4d21sr4Lov3Lvfyl/2jFODF0Kle6zG+nMO6I45Jm1nwlxcBNk/6B7OCC65+m7nnh
         lafav+cgjz+UKi+X1j9XwBG+2qJf9aQIf3PN0TmBt2N0BhUjhRd9grLcPEjZJNrCnSoF
         BvzQ==
X-Gm-Message-State: AJcUukeHXGqFyayq5q9AECA8kbbZTWRL/5lgJBjoNExQFjP/mhnkqJRj
        g0rRlrbWe8NqtClpcPm2G9E=
X-Google-Smtp-Source: ALg8bN7g/HjniQfJNUElU5nZx7wv4IiJaw1zs4z7jn1qdcQWDPPVBGYMgQWrlQItb/Kjw8XDF8zuGA==
X-Received: by 2002:a50:d311:: with SMTP id g17mr39349781edh.187.1549051980479;
        Fri, 01 Feb 2019 12:13:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id q4sm2256995eda.50.2019.02.01.12.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 12:12:59 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Use memset to initialize variables in fill_plane_dcc_attributes
Date:   Fri,  1 Feb 2019 13:12:26 -0700
Message-Id: <20190201201226.12812-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2314:38:
warning: suggest braces around initialization of subobject
[-Wmissing-braces]
        struct dc_surface_dcc_cap output = {0};
                                            ^
                                            {}

Previous efforts to fix this type of warning by adding or removing
braces have been met with some pushback in favor of using memset [1][2].
Do that here, mirroring commit 05794eff1aa6 ("drm/amdgpu/gmc: fix
compiler errors [-Werror,-Wmissing-braces] (V2)") in this tree.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/

Fixes: 7df7e505e82a ("drm/amd/display: Set requested plane state DCC params for GFX9")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dccad2d207ce..1c1c162c4eee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2310,12 +2310,15 @@ static bool fill_plane_dcc_attributes(struct amdgpu_device *adev,
 				      uint64_t info)
 {
 	struct dc *dc = adev->dm.dc;
-	struct dc_dcc_surface_param input = {0};
-	struct dc_surface_dcc_cap output = {0};
+	struct dc_dcc_surface_param input;
+	struct dc_surface_dcc_cap output;
 	uint32_t offset = AMDGPU_TILING_GET(info, DCC_OFFSET_256B);
 	uint32_t i64b = AMDGPU_TILING_GET(info, DCC_INDEPENDENT_64B) != 0;
 	uint64_t dcc_address;
 
+	memset(&input, 0, sizeof(input));
+	memset(&output, 0, sizeof(output));
+
 	if (!offset)
 		return false;
 
-- 
2.20.1

