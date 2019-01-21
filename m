Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F924C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB3F20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078593;
	bh=iNVnNxpfeo3ByFL8eOXJofTcKhfmNRWl+w3xK9mmnBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b0Qh3vjJTl1rj9lv/WaApzJ08Ew7E+B3iQMzWDFvszeFuQyPDVAPxXyLx8j9sGI3c
	 PTQ9OPRW8U08NwmFpSTXkaMFjuRq5ZnjYOghvb+XaipWh1YlScqEBdgttwcPyQM08m
	 VVExz7P+W0ftFpC614HpbSBgYn9YeRb40XARU83s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfAUNtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbfAUNts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:49:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FD720861;
        Mon, 21 Jan 2019 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078587;
        bh=iNVnNxpfeo3ByFL8eOXJofTcKhfmNRWl+w3xK9mmnBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLYo6/DlNYTuVQQjn/Szwt35ARN5NVGiL6Wk6a8rxwzXnWpO5wBeUCLUkzc3e4SLm
         g7qoouZ7BIVEWpAtMsL5JxSPnNXP5K+qlSOcsb8BDrh59id5aHsRmLzqawRioXFYmT
         jHOYcUeF065ViI/h0ZKu4jViMZw57J20uy2onL0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.20 083/111] gpu/drm: Fix lock held when returning to user space.
Date:   Mon, 21 Jan 2019 14:43:17 +0100
Message-Id: <20190121122505.377836532@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 4089e272ac61603931beb024d4d640de2cb390e0 upstream.

We need to call drm_modeset_acquire_fini() when drm_atomic_state_alloc()
failed or call drm_modeset_acquire_init() after drm_atomic_state_alloc()
succeeded.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1547115571-21219-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic_uapi.c |    3 +--
 drivers/gpu/drm/drm_mode_object.c |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1275,12 +1275,11 @@ int drm_mode_atomic_ioctl(struct drm_dev
 			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
 		return -EINVAL;
 
-	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
-
 	state = drm_atomic_state_alloc(dev);
 	if (!state)
 		return -ENOMEM;
 
+	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 	state->acquire_ctx = &ctx;
 	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
 
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -458,11 +458,11 @@ static int set_property_atomic(struct dr
 	struct drm_modeset_acquire_ctx ctx;
 	int ret;
 
-	drm_modeset_acquire_init(&ctx, 0);
-
 	state = drm_atomic_state_alloc(dev);
 	if (!state)
 		return -ENOMEM;
+
+	drm_modeset_acquire_init(&ctx, 0);
 	state->acquire_ctx = &ctx;
 retry:
 	if (prop == state->dev->mode_config.dpms_property) {


