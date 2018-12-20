Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97979C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6406B20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298819;
	bh=+K9N8WY+o2E0JSv9JPWTAs+R/Nxlya7/UA2ThUhe458=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MoLSewK8tiQmUnr6H1wyaTEGsfFBV1dT8XkNU0H+FbWvai1xfahybjrvc59D4onZY
	 kAri8Zdx+YmZyLViGyAM1UUahzvDdXiEZlXA184clX8WlZgqecFp1wAqW7/NgTadv2
	 Fwq7OiUHp7sZpG6I6zhMxkcU8y4KLqsp/rhXItC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbeLTJkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbeLTJYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:24:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F7E20656;
        Thu, 20 Dec 2018 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297890;
        bh=+K9N8WY+o2E0JSv9JPWTAs+R/Nxlya7/UA2ThUhe458=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=or4+zmwy/YfDL+ZKqpMc+Z2QuvcvUfOMwEYugAX7/YyxQ+KnsOzZd63kKzY0hL7Kt
         y0VhmWeOXRV6eH7TuWyTNh8qNKebHH27E9a+sIcxXMzsIVTk1Z8QkzBbCFt+uDJDtY
         x6DVYhYlWpN5Ma5KTScfpFaA6hy2C0Gxf+1SAZtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 54/61] drm/ast: Fix connector leak during driver unload
Date:   Thu, 20 Dec 2018 10:18:54 +0100
Message-Id: <20181220085845.944338047@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e594a5e349ddbfdaca1951bb3f8d72f3f1660d73 ]

When unloading the ast driver, a warning message is printed by
drm_mode_config_cleanup() because a reference is still held to one of
the drm_connector structs.

Correct this by calling drm_crtc_force_disable_all() in
ast_fbdev_destroy().

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1e613f3c630c7bbc72e04a44b178259b9164d2f6.1543798395.git.sbobroff@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
index 7a86e24e2687..5e0d3e561b04 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -286,6 +286,7 @@ static void ast_fbdev_destroy(struct drm_device *dev,
 {
 	struct ast_framebuffer *afb = &afbdev->afb;
 
+	drm_crtc_force_disable_all(dev);
 	drm_fb_helper_unregister_fbi(&afbdev->helper);
 	drm_fb_helper_release_fbi(&afbdev->helper);
 
-- 
2.19.1



