Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA5C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F3920672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675444;
	bh=pPoYjaib85wJGJNjqi3xgTbDNgYvegN61UzG23fNtqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G+pJ+JctkzwOvhKpZ3DFvH3p1NJeWvdJUK9gocI0wgiHrPn2EGFCaHikcBj9p7Jv1
	 ECinsH/WrIerOcDu78XsjO1kqXAD8M3VjFrIHQ/AuTvgide18NYk++NvFVsQ/hrlFc
	 Wxj1TV00izQpjNiaGEAX05jMNuoGdv1bS0OaHZf4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F3920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeLMEan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbeLMEai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2484F20873;
        Thu, 13 Dec 2018 04:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675437;
        bh=pPoYjaib85wJGJNjqi3xgTbDNgYvegN61UzG23fNtqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyGfN4A7AjPaf++NYGklDxWERKzXHd0DDMlW49uT8D/kRHDL2y3uGRUoGgJ+P0yub
         SsNvDM4cUfyUCRNfz3SnBTI+VgkEtSGb0Y1dReIV31Nh10aU/IpKjyW9b3IWEMCjx9
         KiYQqQ/uqLWoALrnqv6PYuajojx3mbsFV1KLk/QU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 62/73] drm/ast: Fix connector leak during driver unload
Date:   Wed, 12 Dec 2018 23:28:27 -0500
Message-Id: <20181213042838.75160-62-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
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
index 0cd827e11fa2..de26df0c6044 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -263,6 +263,7 @@ static void ast_fbdev_destroy(struct drm_device *dev,
 {
 	struct ast_framebuffer *afb = &afbdev->afb;
 
+	drm_crtc_force_disable_all(dev);
 	drm_fb_helper_unregister_fbi(&afbdev->helper);
 
 	if (afb->obj) {
-- 
2.19.1

