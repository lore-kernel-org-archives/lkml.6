Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBD320675
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfAHVMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:12:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbfAHVLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:11:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7143E3E1C;
        Tue,  8 Jan 2019 21:11:54 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3C2519492;
        Tue,  8 Jan 2019 21:11:52 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, stable@vger.kernel.org,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tony Cheng <Tony.Cheng@amd.com>,
        David Francis <David.Francis@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/amdgpu: Don't fail resume process if resuming atomic state fails
Date:   Tue,  8 Jan 2019 16:11:28 -0500
Message-Id: <20190108211133.32564-3-lyude@redhat.com>
In-Reply-To: <20190108211133.32564-1-lyude@redhat.com>
References: <20190108211133.32564-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 08 Jan 2019 21:11:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an ugly one unfortunately. Currently, all DRM drivers supporting
atomic modesetting will save the state that userspace had set before
suspending, then attempt to restore that state on resume. This probably
worked very well at one point, like many other things, until DP MST came
into the picture. While it's easy to restore state on normal display
connectors that were disconnected during suspend regardless of their
state post-resume, this can't really be done with MST because of the
fact that setting up a downstream sink requires performing sideband
transactions between the source and the MST hub, sending out the ACT
packets, etc.

Because of this, there isn't really a guarantee that we can restore the
atomic state we had before suspend once we've resumed. This sucks pretty
bad, but so far I haven't run into any compositors that this actually
causes serious issues with. Most compositors will notice the hotplug we
send afterwards, and then reprobe state.

Since nouveau and i915 also don't fail the suspend/resume process due to
failing to restore the atomic state, let's make amdgpu match this
behavior. Better to resume the GPU properly, then to stop the process
half way because of a potentially unavoidable atomic commit failure.

Eventually, we'll have a real fix for this problem on the DRM level. But
we've got some more important low-hanging fruit to deal with first.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
Cc: <stable@vger.kernel.org> # v4.15+
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3f326a2c513b..a3e65e457348 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -912,7 +912,6 @@ static int dm_resume(void *handle)
 	struct drm_plane_state *new_plane_state;
 	struct dm_plane_state *dm_new_plane_state;
 	enum dc_connection_type new_connection_type = dc_connection_none;
-	int ret;
 	int i;
 
 	/* power on hardware */
@@ -985,13 +984,13 @@ static int dm_resume(void *handle)
 		}
 	}
 
-	ret = drm_atomic_helper_resume(ddev, dm->cached_state);
+	drm_atomic_helper_resume(ddev, dm->cached_state);
 
 	dm->cached_state = NULL;
 
 	amdgpu_dm_irq_resume_late(adev);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.20.1

