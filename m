Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5624CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B99D20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky91l1EB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B99D20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJHWEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:04:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45243 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeJHWEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:04:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id m8-v6so12202184qka.12;
        Mon, 08 Oct 2018 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=i3VL7enVUB8mmUR8iuBXBuDcOmQd/t6YsKyhYNxMpxE=;
        b=Ky91l1EBiQzjvRdVgNTn8s2iUhlQqN4dYHJmP+rWZvVaN3GsPiqZA1NlS8hdSY2Fiu
         9U7dnbkQsjtbWVmMixchrz0PoHvbM8sQjRXpXBFmbbaQBJCRsebcrT+me4T8lbVs0RNS
         MbwvV/TGR3yWa3cUjl5Lhz3tSrL/I4KwS+X2VHP0eiP3H4fI4894eiI12KJtSE/mOam5
         wLGB3xWZsjLbrmF/VkrMlbqTw3nssjCyCnQNCBAXnxVVkThkNi8fXtPntryBrkbemHbx
         OTsojCmNlA3jNB6xuW8wgx6E4pbRchFa1dgLMMguGI85kYbNe2Hlc1H170CHIp0d9No/
         tUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=i3VL7enVUB8mmUR8iuBXBuDcOmQd/t6YsKyhYNxMpxE=;
        b=nfWTTbwVf+ZjirD9hwL7gTlYhVQmxs9VOPKBz7YBdamOGUmBpbKJofHL1ZOP6EkhtL
         5FjaH3BvrA6x/oOFTuTVLbtfUCBxST3+olXTOCMT6Qqmn7+93Z7Rs5aOMMWp+OVXI1bR
         kXvIWBdohLAm6jiTq91arjwG2+703HyWi0DoW3+QwCvYWdHZJ/b3rj5GeJ3lkvrVCg6i
         KZ4+iCXvGMxScqwIQsMJutMmEVZs4dKwVnlT+E3VziZ1yWR9BQO+usqb10XRrK8bVM21
         N9DKG0fzqP4oCtc1TpLcaRZvGDxaLqxxjkYWZugLMNap1ulp5rwW9jFjUfs0yt4j3SlE
         yw0w==
X-Gm-Message-State: ABuFfoih7CvD2nb6NtzMhWDtVpJW3cXdhwd61XNZVx1qxJJazmhhucCb
        84SaL5e+F53EUrwMv5SVQb8=
X-Google-Smtp-Source: ACcGV62OQyzwTqg067hnjclUlglCwh6o0qarFHJ7KD32zB1yRH6kBNAOWAGJrqnYxjer0dj42qQOzg==
X-Received: by 2002:ae9:e507:: with SMTP id w7-v6mr18760728qkf.246.1539010344305;
        Mon, 08 Oct 2018 07:52:24 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m54-v6sm4045414qtb.97.2018.10.08.07.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 07:52:23 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:52:20 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181008145220.p34dllgsiw6rlpod@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For historical reason, the function drm_wait_vblank_ioctl always return
-EINVAL if something gets wrong. This scenario limits the flexibility
for the userspace make detailed verification of the problem and take
some action. In particular, the validation of “if (!dev->irq_enabled)”
in the drm_wait_vblank_ioctl is responsible for checking if the driver
support vblank or not. If the driver does not support VBlank, the
function drm_wait_vblank_ioctl returns EINVAL which does not represent
the real issue; this patch changes this behavior by return ENOTTY
(Inappropriate ioctl for device). Additionally, some operations are
unsupported by this function, and returns EINVAL; this patch changes the
return value to EOPNOTSUPP (Operation not supported). Lastly, the
function drm_wait_vblank_ioctl is invoked by libdrm, which is used by
many compositors; because of this, it is important to check if this
change breaks any compositor. In this sense, the following projects were
examined:

* Drm-hwcomposer
* Kwin
* Sway
* Wlroots
* Wayland-core
* Weston
* Xorg (67 different drivers)

For each repository the verification happened in three steps:

* Update the main branch
* Look for any occurrence "drmWaitVBlank" with the command:
  git grep -n "drmWaitVBlank"
* Look in the git history of the project with the command:
  git log -SdrmWaitVBlank

Finally, none of the above projects validate the use of EINVAL which
make safe, at least for these projects, to change the return values.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 98e091175921..88ec6fb49afb 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 	unsigned int flags, pipe, high_pipe;
 
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -ENOTTY;
 
 	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (vblwait->request.type &
 	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
@@ -1545,7 +1545,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 			  vblwait->request.type,
 			  (_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
 			   _DRM_VBLANK_HIGH_CRTC_MASK));
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	flags = vblwait->request.type & _DRM_VBLANK_FLAGS_MASK;
-- 
2.19.0

