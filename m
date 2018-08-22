Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60638214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="V4r8lN4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60638214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeHVMSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:18:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36894 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbeHVMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:18:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so908900eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tC3XOATppghwn4IS9OYXqFuyuqFooxnRd+35pFM+rQQ=;
        b=V4r8lN4eHm3yDCbOsgKTsXjBPMDGBLbUjbYFAy+Re46juyVINw51ijCY511i5slJOQ
         2j/WtXVo1KxxCiY485QK653e539uYMzy76htr3xcSbNCd8sqUcFemNejNKNhrYiwBsZR
         22FjR/EZe9AeuMy+LrHTy5JYg/zwjUJRYT3a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tC3XOATppghwn4IS9OYXqFuyuqFooxnRd+35pFM+rQQ=;
        b=KYkaLOk+KxpPTElCyjPWDwP2vjMlMYouxq3k0wOC5Nb+6+U0Wi97GSB0Mm8rQBoIif
         QQCvcQYmuXlZxpgHa4Gv5IT4PQ2huRmW9whjdrAFMHNWxfasdA+hBlyTGGpbme1vu82y
         px1V5qel3QukU6NS+fxRcLlZ0ycCzZ+3sfswARAGpHOKn5cnAegetMXiiEDW30Qa0fX/
         lSdqxrBkGsn5q9J9HYovTQnFUzfmMKDRMyxAgnTmLm2j1ueqfr/cT6QbiZfzNzhiL1mu
         831PLPYI3WIh5rFCoxH6wHt0OALqea15lh92dBD7tANmKbCjjGZEhh1pAKySMmQZoSWZ
         kK4w==
X-Gm-Message-State: AOUpUlG3/uGYVGnXV5+jRG4DDYLXpIaYvc8OVPDmrLNgJYcwQenJPwu6
        GHvslfRuezEj0lAY0OwynWeVNw==
X-Google-Smtp-Source: ANB0VdZtJDRr3KCy9Hh9eaXTQ855MGDwccZsNLNRCm4dpFO+HWCN5ZGHfwDgeqMt7aLdjFqMeOZ2kQ==
X-Received: by 2002:a50:aca3:: with SMTP id x32-v6mr16646537edc.41.1534928057769;
        Wed, 22 Aug 2018 01:54:17 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id r21-v6sm636418eds.7.2018.08.22.01.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 01:54:16 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        John Stultz <john.stultz@linaro.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 4/4] drm/fb: Stop leaking physical address
Date:   Wed, 22 Aug 2018 10:54:05 +0200
Message-Id: <20180822085405.10787-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For buffer sharing, use dma-buf instead. We can't set smem_start to 0
unconditionally since that's used by the fbdev mmap default
implementation. And we have plenty of userspace which would like to
keep that working.

This might break legit userspace - if it does we need to look at a
case-by-cases basis how to handle that. Worst case I expect overrides
for only specific drivers, since anything remotely modern should be
using dma-buf/prime now (which is about 7 years old now for DRM
drivers).

This issue was uncovered because Noralf's rework to implement a
generic fb_probe also implements it's own fb_mmap callback. Which
means smem_start didn't have to be set anymore, which blew up some
blob in userspace rather badly.

Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 4b0dd20bccb8..bcb78693c4f7 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2673,6 +2673,8 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
 
 	info = fb_helper->fbdev;
 	info->var.pixclock = 0;
+	/* don't leak any physical addresses to userspace */
+	info->flags |= FBINFO_HIDE_SMEM_START;
 
 	/* Need to drop locks to avoid recursive deadlock in
 	 * register_framebuffer. This is ok because the only thing left to do is
-- 
2.18.0

