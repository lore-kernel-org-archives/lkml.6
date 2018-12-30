Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00966C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C762620861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfYuxQIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeL3RtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40354 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeL3RtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so22346784lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=hOa7NRcYH2xAm7VLiUYiOlGgMbH6bsCARtlKvbMUtgI=;
        b=dfYuxQIOTR3TY8WZ4kiM3+H72Ux75yNtRVF8rybyK8OCefE4pnYLmu2TTc56RmUzk7
         xod/tysge+zvhYF4SZJgsPDo9DXOzzHWiQAvsfSx6lizoUF5ApsVnA2C/qoU4h0LDQtJ
         laEhdJVmvMnmBjED0MEOxVLD9NEljo4U1kDleU3LAj4vRW8z6KT/Ocd8CsdEMydm3iJL
         qrZXy6QY+Jumzpzmu3o2hHMBjkc7Q0FLLrnJ1n3Q99yZbJihrV8cldsCZuQqR7ThESq1
         fG9IBY+Opmnio6U7CzYEZVXvXqC3Y/FqQrDG5M8iMWKvqke68UFXBB/IFgkTbMV5g9M/
         Zu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=hOa7NRcYH2xAm7VLiUYiOlGgMbH6bsCARtlKvbMUtgI=;
        b=M/fENln1GqBwSWCdWvNqstbM8nWHtr6DwTxtMsqFCKVayFmtXbe17ZxBt3vDUI/Rta
         bLbwIjRwM2L46I8OfPJX5M8VPr1o6Buekpuxd+MsNb/YcXkn90gtUpbqSfe5HyCdxd3I
         sbPaJiMHAA49Q4F4F1kgli5sDWzobk45awdvGShKfo26JixuOO8B8JzpZJSHOdVknIhQ
         V77XCLhubx0Qgv70VNIgqwL7No0i9Zqf6UZ4L7vqmQ1oD1lJxdpwVSPwYjMt7OLvwFGU
         OHuUMTBp1vJb/VKkpsjdIRjKMcgv93CJ5nPe4aRj8rx0wX3i6Kz+2VIHF3Nlik0e6hAM
         Gntw==
X-Gm-Message-State: AJcUukc5rv38YpTtlX48B9lfZBhnHEi+WSud0bSDZmFeC/Gw2xP+lf80
        C+AC0MxS8ZzSJbZGZ42L80M=
X-Google-Smtp-Source: ALg8bN5CC95ue8QlfHsWI8qNGOxwQSgV84rGrJTIypbpo7wamr7YlopsU/9WZN+n2oCwK4d6YgQfsA==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr20127353lje.110.1546192140997;
        Sun, 30 Dec 2018 09:49:00 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:00 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 04/14] drm: make drm_framebuffer.h self contained
Date:   Sun, 30 Dec 2018 18:48:28 +0100
Message-Id: <20181230174838.32330-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add forward declaration and pull in include
file to make drm_framebuffer.h self contained.

While add it order include files alphabetically.

The use of TASK_COMM_LEN is the reason for including sched.h.
I could not see any good way to avoid this dependency,
and users of drm_framebuffer.comm already use
TASK_COMM_LEN to check for length etc.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drm_framebuffer.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index c94acedfb08e..f639ed527943 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -23,13 +23,16 @@
 #ifndef __DRM_FRAMEBUFFER_H__
 #define __DRM_FRAMEBUFFER_H__
 
-#include <linux/list.h>
 #include <linux/ctype.h>
+#include <linux/list.h>
+#include <linux/sched.h>
+
 #include <drm/drm_mode_object.h>
 
 struct drm_framebuffer;
 struct drm_file;
 struct drm_device;
+struct drm_clip_rect;
 
 /**
  * struct drm_framebuffer_funcs - framebuffer hooks
-- 
2.12.0

