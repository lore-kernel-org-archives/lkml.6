Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89ABC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84BD218F0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="Zrdy/8Yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404343AbeLWAzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 19:55:17 -0500
Received: from lekensteyn.nl ([178.21.112.251]:45979 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387711AbeLWAzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 19:55:16 -0500
X-Greylist: delayed 705 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Dec 2018 19:55:14 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=5uUnM+MaNN9iLp3gnOrWEqvYAk+XSVGQm6uYqpP+lpE=;
        b=Zrdy/8YlHSjSuNkk0XYZjcNY643JH9lYM5YIPhMzX2LOycdjcZRsi4BCZrKuKX/awvv5w+o5OV565zS6QhcJLSehwUP13TCt3NUMQ4wBApcKh3YOA9IKbbTDFx5BEomiZZCMAbaJtSOlZjNz4QbcxdUHNbq5BeLwl6HA7rP8hyYpjWJtGLxht+q7JFVSu1Wq+TpGLBFCcioKPduqktWCcE3I6kM6wrMVQQtybIqf5LZp2yrFQpNUB4gCEiSq1ALGg7Qj8z2AaSBd758kyPcnUMkjjvfgNG85gMRPfpP6cnxYeMwKKzOY2r3RihovHiPvTBDxtg6zG0F0fhhJaHrk1g==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1gas2u-0004I9-V9; Sun, 23 Dec 2018 01:55:09 +0100
From:   Peter Wu <peter@lekensteyn.nl>
To:     dri-devel@lists.freedesktop.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rong.a.chen@intel.com, kraxel@redhat.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        lkp@01.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH] drm/fb-helper: fix leaks in error path of drm_fb_helper_fbdev_setup
Date:   Sun, 23 Dec 2018 01:55:07 +0100
Message-Id: <20181223005507.28328-1-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181223004315.GA11455@al>
References: <20181223004315.GA11455@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After drm_fb_helper_fbdev_setup calls drm_fb_helper_init,
"dev->fb_helper" will be initialized (and thus drm_fb_helper_fini will
have some effect). After that, drm_fb_helper_initial_config is called
which may call the "fb_probe" driver callback.

This driver callback may call drm_fb_helper_defio_init (as is done by
drm_fb_helper_generic_probe) or set a framebuffer (as is done by bochs)
as documented. These are normally cleaned up on exit by
drm_fb_helper_fbdev_teardown which also calls drm_fb_helper_fini.

If an error occurs after "fb_probe", but before setup is complete, then
calling just drm_fb_helper_fini will leak resources. This was triggered
by df2052cc922 ("bochs: convert to drm_fb_helper_fbdev_setup/teardown"):

    [   50.008030] bochsdrmfb: enable CONFIG_FB_LITTLE_ENDIAN to support this framebuffer
    [   50.009436] bochs-drm 0000:00:02.0: [drm:drm_fb_helper_fbdev_setup] *ERROR* fbdev: Failed to set configuration (ret=-38)
    [   50.011456] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 2
    [   50.013604] WARNING: CPU: 1 PID: 1 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x280/0x2a0
    [   50.016175] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 4.20.0-rc7 #1
    [   50.017732] EIP: drm_mode_config_cleanup+0x280/0x2a0
    ...
    [   50.023155] Call Trace:
    [   50.023155]  ? bochs_kms_fini+0x1e/0x30
    [   50.023155]  ? bochs_unload+0x18/0x40

This can be reproduced with QEMU and CONFIG_FB_LITTLE_ENDIAN=n.

Link: https://lkml.kernel.org/r/20181221083226.GI23332@shao2-debian
Link: https://lkml.kernel.org/r/20181223004315.GA11455@al
Fixes: 8741216396b2 ("drm/fb-helper: Add drm_fb_helper_fbdev_setup/teardown()")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 9d64f874f965..432e0f3b9267 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2860,7 +2860,7 @@ int drm_fb_helper_fbdev_setup(struct drm_device *dev,
 	return 0;
 
 err_drm_fb_helper_fini:
-	drm_fb_helper_fini(fb_helper);
+	drm_fb_helper_fbdev_teardown(dev);
 
 	return ret;
 }
-- 
2.20.0

