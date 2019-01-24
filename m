Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C57C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AF421726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359791;
	bh=75g0BUS1nc8EjgWasU0ZZnBca7psQMZ/W7dD8JtLPWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7iTqghl1Q6W+1zgVj6joIO1DV2O7+4Ctz7GAzjjfchBw4FADKPGS1kPz+ewzr3UM
	 YFjeuGynLO/6+XLxhd4FkCpYRbrH0sngDjvRE9N4P1ih2wfB/Dac9XDzzc9YYAiJmG
	 vJSZHcNIKmsidTU9ZcIiHboKxgEc7nRez0hVZLdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfAXTgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:36:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732062AbfAXTgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9484921903;
        Thu, 24 Jan 2019 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358599;
        bh=75g0BUS1nc8EjgWasU0ZZnBca7psQMZ/W7dD8JtLPWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PH6r/5cy/YTZADqgqX7W9E+4Ol4g7Dxl/xCr4YrDCEp/Jzht3HSn98MOZlbtXDyTN
         WGjqZi/3EIkmBdVlagUIOnShb9MzKm1m8S/Fy1vRz5l75+k7tFJY6Ihep0tASwpatZ
         c0Ot7KTMe8rNJe7dBjcxBoZxcJgY0HEAhADa/x78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/106] drm/atomic-helper: Complete fake_commit->flip_done potentially earlier
Date:   Thu, 24 Jan 2019 20:19:45 +0100
Message-Id: <20190124190208.142718604@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2de42f79bb21a412f40ade8831eb6fc445cb78a4 ]

Consider the following scenario:
1. nonblocking enable crtc
2. wait for the event
3. nonblocking disable crtc

On i915 this can lead to a spurious -EBUSY from step 3 on
account of non-enabled planes getting the fake_commit in step 1
and we don't complete the fake_commit-> flip_done until
drm_atomic_helper_commit_hw_done() which can happen a long
time after the flip event was sent out.

This will become somewhat easy to hit on SKL+ once we start
to add all the planes for the crtc to every modeset commit
for the purposes of forcing a watermark register programming
[1].

To make the race a little less pronounced let's complete
fake_commit->flip_done after drm_atomic_helper_wait_for_flip_done().
For the single crtc case this should make the race quite
theoretical, assuming drm_atomic_helper_wait_for_flip_done()
actually has to wait for the real commit flip_done. In case
the real commit flip_done gets completed singificantly before
drm_atomic_helper_wait_for_flip_done(), or we are dealing with
multiple crtcs whose vblanks don't line up nicely the race still
exists.

[1] https://patchwork.freedesktop.org/patch/262670/

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: 080de2e5be2d ("drm/atomic: Check for busy planes/connectors before setting the commit")
Testcase: igt/kms_cursor_legacy/*nonblocking-modeset-vs-cursor-atomic
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181122143412.11655-1-ville.syrjala@linux.intel.com
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 1bb4c318bdd4..f77bff5aa307 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1425,6 +1425,9 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
 			DRM_ERROR("[CRTC:%d:%s] flip_done timed out\n",
 				  crtc->base.id, crtc->name);
 	}
+
+	if (old_state->fake_commit)
+		complete_all(&old_state->fake_commit->flip_done);
 }
 EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
 
-- 
2.19.1



