Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB7C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181DA217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975645;
	bh=dLHeRF3DnDi6sYm+vAhqjXeAt1fDLejieIq/2WhlCLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gtinPeNNR8Jy7MQLrNHAGXjBw2oPCz0Cvr7Cws9srdqGsV2Sv9i7HUFOdILpSPh4d
	 FFkQK/xG3g+JRumuBB8U4LBU7w07Y1XZMe5ggzej82Kq39kbrXJz3CQN6TC2/Avx0r
	 ZOiohXuJrsj1VnH9UITqwMKh03VO8AwXquRvNa1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfAHT1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbfAHT1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B242176F;
        Tue,  8 Jan 2019 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975640;
        bh=dLHeRF3DnDi6sYm+vAhqjXeAt1fDLejieIq/2WhlCLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXix5M1X7rWciplcTsqRgU3CWmG8rjjf7/k4EOUfBFBZDg8LgT1NRc1f4tdl+Nr0e
         yqN4LK5dYwVr5nh8ArOB7t3nNakEgZ2KApihU8WisyZZhU8emU5XLjHziTHPi9SoF0
         RsHd/fNGIvRX9yZf692CZzb+vK99hOtXFpr8ahJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 026/117] drm/atomic-helper: Complete fake_commit->flip_done potentially earlier
Date:   Tue,  8 Jan 2019 14:24:54 -0500
Message-Id: <20190108192628.121270-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

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
index d8b526b7932c..b4e292a56046 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1445,6 +1445,9 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
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

