Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A647C4646A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0703D20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0703D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405377AbeHATHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:07:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403967AbeHATHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:07:01 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8308BD1F;
        Wed,  1 Aug 2018 17:20:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 171/246] drm/atomic: Handling the case when setting old crtc for plane
Date:   Wed,  1 Aug 2018 18:51:21 +0200
Message-Id: <20180801165019.913757375@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Satendra Singh Thakur <satendra.t@samsung.com>

[ Upstream commit fc2a69f3903dfd97cd47f593e642b47918c949df ]

In the func drm_atomic_set_crtc_for_plane, with the current code,
if crtc of the plane_state and crtc passed as argument to the func
are same, entire func will executed in vein.
It will get state of crtc and clear and set the bits in plane_mask.
All these steps are not required for same old crtc.
Ideally, we should do nothing in this case, this patch handles the same,
and causes the program to return without doing anything in such scenario.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1525326572-25854-1-git-send-email-satendra.t@samsung.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_atomic.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1355,7 +1355,9 @@ drm_atomic_set_crtc_for_plane(struct drm
 {
 	struct drm_plane *plane = plane_state->plane;
 	struct drm_crtc_state *crtc_state;
-
+	/* Nothing to do for same crtc*/
+	if (plane_state->crtc == crtc)
+		return 0;
 	if (plane_state->crtc) {
 		crtc_state = drm_atomic_get_crtc_state(plane_state->state,
 						       plane_state->crtc);


