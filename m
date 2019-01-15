Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA337C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BDC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570578;
	bh=Yns1TSvy/djdMx361Zfc1HmznAmMiddcxCiYD8l3cBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u4qjF8nibFzfOhNvFRGoXtn+1AXucARQJRm3WdqbOWKvAEr7JL5ooC98R6RSpyLv2
	 tMjUo1gscSqOMj8M4EV8pJkNm0Yj8iIeXSVaUORXTMVoS7oqJQPsS1hImymRU3G8jo
	 ftnCaAPBC6BPmQm6IF99xoWy5UDZcGKyDSqPSyd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfAOQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbfAOQmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C014A20675;
        Tue, 15 Jan 2019 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570572;
        bh=Yns1TSvy/djdMx361Zfc1HmznAmMiddcxCiYD8l3cBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzCjNp2XUq9kpVZqs8KOpMwkUbJ6gfXK9EWS9uxKxGBFULCyNkKkvbIEX3HhqSIG0
         eGxzxvJ8F0duU2U+Rd22yXzylIcIzhxzdCfaObm/K6p0S2+aULZP53iOLvLNM3NkSl
         UYkyf66Ux92SiIYWWSd1MUGlUOs/1R1gpmierwDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 4.19 36/50] drm/amdgpu: Dont fail resume process if resuming atomic state fails
Date:   Tue, 15 Jan 2019 17:36:12 +0100
Message-Id: <20190115154911.992663844@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit 2d1af6a11cb9d88e0e3dd10258904c437fe1b315 upstream.

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
Link: https://patchwork.freedesktop.org/patch/msgid/20190108211133.32564-3-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -750,7 +750,6 @@ static int dm_resume(void *handle)
 	struct drm_plane_state *new_plane_state;
 	struct dm_plane_state *dm_new_plane_state;
 	enum dc_connection_type new_connection_type = dc_connection_none;
-	int ret;
 	int i;
 
 	/* power on hardware */
@@ -823,13 +822,13 @@ static int dm_resume(void *handle)
 		}
 	}
 
-	ret = drm_atomic_helper_resume(ddev, dm->cached_state);
+	drm_atomic_helper_resume(ddev, dm->cached_state);
 
 	dm->cached_state = NULL;
 
 	amdgpu_dm_irq_resume_late(adev);
 
-	return ret;
+	return 0;
 }
 
 static const struct amd_ip_funcs amdgpu_dm_funcs = {


