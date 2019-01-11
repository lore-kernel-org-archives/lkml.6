Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDE0218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSjiSK1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfAKOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:02:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37615 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfAKOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:02:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id g125so6562515qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDBJgxxbY2NrWHhBFQ+tGTwnQKhAzl68PFStSFa0F7A=;
        b=dSjiSK1gX3sungWxyzDzKb1aOU1lKMhUtKwsYtKTaHjcowk/XUXihvhu1Cqpd8prmJ
         pDNpG5vrVoVhfBnjxP4XlENftUFOPOoPo88sk4Erthtc+dpWnnQOQP7vNK0PHbdA0jR7
         nL8wldtfSvv7V8go14VulRhVg509BtwQ/XYycRQGeB8t7//3CUWUk3nT+Aa6y2Lasqf1
         sar3q7p4p8zn1OswCernromkWOif4Y7BuNA7A4vDJ1Hxu3vU1/MS/19tlm15LsLftplK
         SWZ7/PagdVLRxCDmppgz842/lxaTjHXiImK46g9x/Ml6lrWrrB5jyoS4lmO8fX+z0gZw
         hWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDBJgxxbY2NrWHhBFQ+tGTwnQKhAzl68PFStSFa0F7A=;
        b=i51D28R3MIFixj2k5NleuGnz+F4x0XJokPCa3ga7v30spE14OcSZOo2Ro4XheexcV6
         HNaxX5R4Pbb+cTZapATrQ2MBrvwbufOaz2/F6KYQ7jo2SMe1l1fk/ZOwICo8s1ZHdNpU
         TurSKCeG6VUd4a4WOJ8fPU3ecXRnauKgbXlAt+biZIdB4F8wM9O90vOrg4gejzFVTfr8
         jIrSWieGA7a9CGutrHvRFFPXt9+hzwHDFMROC9oUtotay0ahva7Bozk3xQv/cDALPeuC
         jZEhYw3uKSnNS/mMRXjx/bTpZWw3rePKSAPpUQf0XFRnGSZlRGF5st4Zkg75oKZmxEcB
         DEFA==
X-Gm-Message-State: AJcUukf1rm1pEyx9OuMhZqJVq7nl8XBMmF4zk2h/ZHNZB+9qWBvAzvYu
        EqxhIS4gQln0sFryA29UoXg=
X-Google-Smtp-Source: ALg8bN5DHOcg9/FdbGWQfK71mOO+yogDFzc3UHVdGL4gbCIVFZuUaWJ0cgmMtNPzhH8WPIJ0i+XIyw==
X-Received: by 2002:a37:9442:: with SMTP id w63mr12697333qkd.109.1547215367911;
        Fri, 11 Jan 2019 06:02:47 -0800 (PST)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id f19sm45081835qtf.1.2019.01.11.06.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:02:46 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <treding@nvidia.com>,
        Daniel Stone <daniels@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Rob Clark <rclark@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/cirrus: fix connector leak at unload
Date:   Fri, 11 Jan 2019 09:02:34 -0500
Message-Id: <20190111140242.29002-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an '*ERROR* connector VGA-2 leaked!' splat at driver unload.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
Similar case to the issue that was fixed recently in drm/ast

 drivers/gpu/drm/cirrus/cirrus_fbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 4dd499c7d1ba..bb379ec4c182 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -256,6 +256,8 @@ static int cirrus_fbdev_destroy(struct drm_device *dev,
 {
 	struct drm_framebuffer *gfb = gfbdev->gfb;
 
+	drm_crtc_force_disable_all(dev);
+
 	drm_fb_helper_unregister_fbi(&gfbdev->helper);
 
 	vfree(gfbdev->sysram);
-- 
2.20.1

