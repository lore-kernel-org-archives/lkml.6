Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B4EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E1221905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyXMgn5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbeLUDLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:11:11 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35552 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732778AbeLUDLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:11:11 -0500
Received: by mail-io1-f67.google.com with SMTP id o13so1166634ioh.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+xX+MqEK7IDeX3e/VhfbhjprkZLCa8jN8mKsj/JF/w=;
        b=WyXMgn5NZ+K2ZjWD10DVqJiPu2XwUjEteRFhxG65cWSK7Qb10P1sb41EZE+uN4MGbQ
         4BQIlnTrPh/X6XdnfIuvjcfNvLeIIAXs3XxsdBzqwHx1iDFjHCrwN+5ekOoaQrOTy1vl
         jiECzWGgUOwUaNP/PWX3XlVNSHMKIAcIP9tAtCZdb7hIwx/mN/HrwehaIiZn2/Oxf84y
         fFsGqUqe9qVDG37f6vNT7e5r96GfotD+kk+7kwLnfaH7ONw+EaIFCrLUdqcfCZTnqdfp
         DgHNOplrWFbFTAcDsf/G3yr4+CuBR40/HLtuM6KLOHhGTDLNU+5+9lDxfYGnzYN9qQPf
         R4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+xX+MqEK7IDeX3e/VhfbhjprkZLCa8jN8mKsj/JF/w=;
        b=P5b7vrFxQ66SqOTHnJHeWUSeARnq+ccxc9dtk0i55AvKLjjM+WMHFkqPjO1WzGJGCr
         TRMJfs2yhZoOVilMHF2UrNvFASQZjqTZau9SPLNmz2zUdZIk7V4l0/e1YcOS9x6HY+ya
         KeK6UaiSEWdDJlIiEZexaPXUen2DUylNBE/JY/mfLBDUhgkbitNtvY0we9So5sXpMOMu
         DXGEZZ7Z8t0sZpzH9H7cjA29DD+QOjL3qCruL9ViAm9IgFh5aUcw5g6QNnTWkWlcpXir
         nacEGRaR/8ajCxBEYMGCHYs81pM1O2cNVWmZyBG4j6Mv2PlbMP/J5Y+tVT4U0WALZ6p5
         zMTg==
X-Gm-Message-State: AJcUukfGxsy147uND6EOCH5rgjfXSN57RAr3yRzciD5dsnz5u95Lh7T+
        8kc0V0LcJPszvhmyAf3qE0PtuA==
X-Google-Smtp-Source: ALg8bN6+INzwf7Am35jRiOBWKi+milD1PbYuPaAQEzNlhO1x+xH9+n4CkhRl+DpY3KsgaXxFvT2n6w==
X-Received: by 2002:a6b:ca04:: with SMTP id a4mr620646iog.254.1545361869102;
        Thu, 20 Dec 2018 19:11:09 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id d133sm5425783itd.1.2018.12.20.19.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 19:11:08 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     David Zhou <David1.Zhou@amd.com>, Samuel Li <Samuel.Li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH 1/3] drm/amd: fix race in page flip job
Date:   Thu, 20 Dec 2018 20:10:51 -0700
Message-Id: <20181221031053.240161-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix race between page flip job submission and completion. We invoke
page_flip callback to submit page flip job to GPU first and then set
pflip_status. If GPU fires page flip done irq in between, its handler
won't see the correct pflip_status thus will refuse to notify the job
completion. The job will eventually times out.

Reverse the order of calling page_flip and setting pflip_status to
fix the race.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 686a26de50f9..e309d26170db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -105,11 +105,11 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
 	/* We borrow the event spin lock for protecting flip_status */
 	spin_lock_irqsave(&crtc->dev->event_lock, flags);
 
+	/* Set the flip status */
+	amdgpu_crtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
 	/* Do the flip (mmio) */
 	adev->mode_info.funcs->page_flip(adev, work->crtc_id, work->base, work->async);
 
-	/* Set the flip status */
-	amdgpu_crtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
 	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 
 
-- 
2.20.1.415.g653613c723-goog

