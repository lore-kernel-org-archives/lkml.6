Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D2AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A83120880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675575;
	bh=LePkWrP1k5na/uQiWHYpZzCOC8oezxLDOL1s2ijSOHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0BWeRMBRNFUZ4oqO3Z5Qzm5Xp4Npel2a+3BBF5u/rwf3h7qyJJsGCRjuLH7dty6a
	 1JCLk5vRz/L39eYsNLONeJRBIXQk4zgZmwVGLUxqTCElYbDqtPiI0zQpIF+B3ArBOq
	 k6BpdDvZoheTfYsRTVaiDToZ3HN4Jq8eYTGZR3W8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A83120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeLMEcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbeLMEct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887BE20880;
        Thu, 13 Dec 2018 04:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675569;
        bh=LePkWrP1k5na/uQiWHYpZzCOC8oezxLDOL1s2ijSOHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxawUUc/O3lICw6LvE+f/H6odle+gsVYP5FaQjtMiIWJhA72gQLG9vJ16FEwePbvX
         ObWhZ6UL89MVw8/ouDrJGS3IhtIfJk416NGs3qNj2QQYPIn4/87C4P7N+O0GUifAyj
         W8YRUt+FeCirh+tv2+JJqwznRtQCnIbhU+fUysGI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 28/34] drm/ast: Fix connector leak during driver unload
Date:   Wed, 12 Dec 2018 23:31:54 -0500
Message-Id: <20181213043200.76295-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

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

