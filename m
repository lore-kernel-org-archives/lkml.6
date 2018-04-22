Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+e7z1vVJ3QaHfwa8EoHemPbsAyha9EQKL2mwhT8h5JIpQTg6Gotjx7D2dnpk8vUNfqfpXU
ARC-Seal: i=1; a=rsa-sha256; t=1524405624; cv=none;
        d=google.com; s=arc-20160816;
        b=s2eq6F3f34tWW9kGS6ioN2VoMJE3DF47U4RqM/atqekeZ6EsBX72vX5quCZ2/ksn5A
         C76FVnBY1RVw//A0fD5aEA1MxyCbeSnXLE7r2+afPLEK/39QfKMgm9amlXdubgH1V9/3
         HY8SFBo+00BwMnoyBr4CS5R4KtRjhx6+NtMEV4WNuUC91CoU/8jLoRRQoSzWxsLNOk2+
         qqlQTN5SSkZPMuRs9gWBtPu1BFzFJyfLlUDn3Dt3gW7jMfE0Fj2p6rS3NkwHYltqx6Gp
         LfUhM9vsvu4KRmQ2MEWu+Gu7EABJvUabssiK5a7xCcAw11dbz1nwuBJ9z3ZHievkkGoR
         aNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uL8ZxzhHdZNBt3hRGr82L2SrPJ1o4M/T0ims9aQrYag=;
        b=vIg25Is4PCL2YKR08wkYRJWAkfxRxxgiBaP82ZMJG1MN1SunoFPE1yZJuXweI83yhJ
         O6dd1nm2BNOZksDzGH7hK9B5o2Xc9SMsluyHiYNo7VYu9eTlwjJlbPaGewgWURyVGV/R
         XPIdvhcbDfCreFA2+xTb2S8nwh6KrypnFficYhjlE+TJHQ7OJp18zLvGV/L7AhJcZmZz
         zgFxVyX/t4Gj0lpooiT5St/orGqIBy1SUqu7ldz1GigawLXxerimyEBVFGh//I7p5SdT
         t7iLmRv1pfDFonVxbRF7ckJa36eIaKph4Z/i8maYvvRLqSnwMIPeM5+r+xmKU/aO091d
         oZSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shirish S <shirish.s@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 4.16 135/196] Revert "drm/amd/display: disable CRTCs with NULL FB on their primary plane (V2)"
Date: Sun, 22 Apr 2018 15:52:35 +0200
Message-Id: <20180422135111.241541727@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455151596062633?=
X-GMAIL-MSGID: =?utf-8?q?1598455151596062633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit 1cb19e8267a57c5174da09e0d52d1477baceccca upstream.

This seems to cause flickering and lock-ups for a wide range of users.
Revert until we've found a proper fix for the flickering and lock-ups.

This reverts commit 36cc549d59864b7161f0e23d710c1c4d1b9cf022.

Cc: Shirish S <shirish.s@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   28 ----------------------
 1 file changed, 28 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4776,30 +4776,6 @@ static int dm_update_planes_state(struct
 	return ret;
 }
 
-static int dm_atomic_check_plane_state_fb(struct drm_atomic_state *state,
-					  struct drm_crtc *crtc)
-{
-	struct drm_plane *plane;
-	struct drm_crtc_state *crtc_state;
-
-	WARN_ON(!drm_atomic_get_new_crtc_state(state, crtc));
-
-	drm_for_each_plane_mask(plane, state->dev, crtc->state->plane_mask) {
-		struct drm_plane_state *plane_state =
-			drm_atomic_get_plane_state(state, plane);
-
-		if (IS_ERR(plane_state))
-			return -EDEADLK;
-
-		crtc_state = drm_atomic_get_crtc_state(plane_state->state, crtc);
-		if (crtc->primary == plane && crtc_state->active) {
-			if (!plane_state->fb)
-				return -EINVAL;
-		}
-	}
-	return 0;
-}
-
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state)
 {
@@ -4823,10 +4799,6 @@ static int amdgpu_dm_atomic_check(struct
 		goto fail;
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-		ret = dm_atomic_check_plane_state_fb(state, crtc);
-		if (ret)
-			goto fail;
-
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state) &&
 		    !new_crtc_state->color_mgmt_changed)
 			continue;
