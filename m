Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A852C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D4E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="j6oX8m47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D4E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeJSBPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:15:41 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36496 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbeJSBPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:15:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 2512A93E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 17:13:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NND8GAZ1Hd8D for <linux-kernel@vger.kernel.org>;
        Thu, 18 Oct 2018 12:13:44 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id EDCC3840
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:13:43 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id f64-v6so27926196ioa.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6X41x1WOSrR/PHS+TM0deloWXZ8Btniw+NwQ6nXkReI=;
        b=j6oX8m47TbvPQoK+tsYF/8Coqs+IhtpcJDf5blqmHKeoHTkqoWHM14uxQpRTIfeFMY
         An/HQ9ieEQNE8CQewu5fFnLLJSWCBFu9pZyUBgCqhXGeWw/BwnViu2m2HPW4PdsoLaS5
         +/ykO4vHy3SL0UOn4WhFqiANThEhySta5Xpahnd9qW4o68W+Z0Dyk0cnpMkTTbsUckNY
         DFSyB7LUlZwmrKQAILrzq1VR5y1KdEhBHGARIs74QM97pJyQI4QPjRaijrpii4PqQhIf
         WD/yn/uqji/9n9GmNWwpuQQgVPuHsBvOziVJMoCsyGW0Zo77YOdmwJVNBj8CLPwB4Xje
         y6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6X41x1WOSrR/PHS+TM0deloWXZ8Btniw+NwQ6nXkReI=;
        b=OK0G3fbkA7BfBzUa1qSeX0DyGt1Tmg4yUemhyZ3NrOa1g6ZbYP6I1LsewdrlTf+8w7
         H31IVT5mvhRtW8p49Je7vuQ/KjHqQ8jH9FsUqKmoSo2ygHgJ6lUBVA7GTo1hjrYn0fTh
         Qyh9HxKMALTB6tvH8RUPBu6WXDIMeFuFT4PJeL8/UDlKnd4S2uyj561DIkTpdIR4htCX
         rxZ7HkK6e+gb/SL8YaT2ZbsEYjDWd4+PjMBzHnGkHqmf4EdZeEGu1a50mz5wqv5k6u+h
         StNBi8Q1eQRjYmakE7l2C5echdPE9JRsLHeMh4SYGPBXSUi2Y5EzsoIGnxoPRlTa5UBU
         zyMw==
X-Gm-Message-State: ABuFfogSekPr2zLaDejVH+nrGPmrVmBMZUZxr7cZ27oj3TMuFmzWk8CC
        1p8+2m2xgYSfq1bKoTil1+jJgf2I48jaY6FKodWtIQ/tbQIPeyKpWLDM2K5wO1RfRm9iLVLca8H
        EYeq5F9NkLHFLaypp2de0Tbre6Irf
X-Received: by 2002:a02:85a3:: with SMTP id d32-v6mr24842416jai.69.1539882823585;
        Thu, 18 Oct 2018 10:13:43 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61xq22IQBjTjsf5/wglFSx2f/akGrKA66FZTTE5O51xMIKcK557X0ySIihgYkeYNO18eo407Q==
X-Received: by 2002:a02:85a3:: with SMTP id d32-v6mr24842405jai.69.1539882823341;
        Thu, 18 Oct 2018 10:13:43 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id v82-v6sm6812911iod.14.2018.10.18.10.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 10:13:42 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/radeon: fix a missing-check bug
Date:   Thu, 18 Oct 2018 12:13:29 -0500
Message-Id: <1539882809-7189-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In radeon_read_bios(), the bios rom is firstly mapped to the IO memory
region 'bios' through pci_map_rom(). Then the first two bytes of 'bios' are
copied to 'val1' and 'val2' respectively through readb(). After that,
'val1' and 'val2' are checked to see whether they have expected values,
i.e., 0x55 and 0xaa, respectively. If yes, the whole data in 'bios' is then
copied to 'rdev->bios' through memcpy_fromio(). Obviously, the first two
bytes in 'bios' are copied twice. More importantly, no check is enforced on
the first two bytes of 'rdev->bios' after memcpy_fromio(). Given that the
IO memory region can also be accessed by the device, it is possible that a
malicious device can race to modify these two bytes between the two copies
and thus after memcpy_fromio(), the first two bytes in 'rdev->bios' can
have unexpected values.  This can cause undefined behavior of the kernel
and introduce potential security risk, if the device can be controlled by
attackers.

This patch rewrites the first two bytes of 'rdev->bios' after
memcpy_fromio() with expected values. Through this way, the above issue can
be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 04c0ed4..f336719 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -98,6 +98,8 @@ static bool radeon_read_bios(struct radeon_device *rdev)
 		return false;
 	}
 	memcpy_fromio(rdev->bios, bios, size);
+	rdev->bios[0] = val1;
+	rdev->bios[1] = val2;
 	pci_unmap_rom(rdev->pdev, bios);
 	return true;
 }
-- 
2.7.4

