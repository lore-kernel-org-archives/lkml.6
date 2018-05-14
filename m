Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrxQAp4Ngz82K3RQKGO9w3vvSuet6h0KEjBf/W00O2XvA4S/drbBupUElLjfVCQ8PHUO643
ARC-Seal: i=1; a=rsa-sha256; t=1526280993; cv=none;
        d=google.com; s=arc-20160816;
        b=HC24bwKNsADMPIzupaiCn0gPp+CNfkkEXxKARn5s2b4S+yykBifi64x0QZwGLreFsL
         idYKZzH4dVGY4eBArR2l2PZbcm8kKETHehbkWWUcCXHcqwjpD/19xCImSCkUVwEnYta3
         N0lg7X7lyIwuwCsBPBBbKoBH9qsqpCIKSlRPVwS2NNF5O+7hlXTzMfFmsx56Zmzfh18N
         Ih4MkwD7LoeXqhU+343+gWlRWQ2Zjrd1zw0UgNbSWj3YtifbjJJ1xtpxNecRNIX4v9m6
         omKwvXbgIkAoDsoOAQm6lgLHHIJHOhpWr2UlDpCg24keAaielyZeOFYy3nqaoLe0s4DP
         qsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PCoi3fckJrgV6iQULRLBP48Yr2qtPAz57w5+8+xLiak=;
        b=Zw2In08acJP4o0lIj7Ob1EqkQTgY+HSS2Imcq5MMRDOwXp+0/OCQV3E0tFXBb9I7Oj
         CR/vaU4leoksu2Ti0pNIu1gxo7wlCdZbgdDyqxdu5RFZMQZUmW6JfbJPolPYp3GFmuTy
         adwgVJtx8gWqqtB5IPtUJK9PZpWLj8GvLcDrLQ2y9+rZ1IM5RmodDWkyVvOX3Mu6MroN
         O7Pbr+GrplAxlhkk0VhsvTCVZzM492JabTBBXn2dAVOABLfVTRNAzhi1odJwc1jbMe2z
         LIXwBvdXw4XtlY/DfSu5QaejDS6do+7Moc0f3cXP/VhgfsS1UEeQvqmnQqNOfWHIKuZA
         Xxkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zrBTSVwP;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zrBTSVwP;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Abhay Kumar <abhay.kumar@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.14 40/62] drm/atomic: Clean old_state/new_state in drm_atomic_state_default_clear()
Date: Mon, 14 May 2018 08:48:56 +0200
Message-Id: <20180514064818.600513541@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421619250429245?=
X-GMAIL-MSGID: =?utf-8?q?1600421619250429245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit f0b408eebc993310bea3f2daae286c40bd3f063b upstream.

Clear the old_state and new_state pointers for every object in
drm_atomic_state_default_clear(). Otherwise
drm_atomic_get_{new,old}_*_state() will hand out stale pointers to
anyone who hasn't first confirmed that the object is in fact part of
the current atomic transcation, if they are called after we've done
the ww backoff dance while hanging on to the same drm_atomic_state.

For example, handle_conflicting_encoders() looks like it could hit
this since it iterates the full connector list and just calls
drm_atomic_get_new_connector_state() for each.

And I believe we have now witnessed this happening at least once in
i915 check_digital_port_conflicts(). Commit 8b69449d2663 ("drm/i915:
Remove last references to drm_atomic_get_existing* macros") changed
the safe drm_atomic_get_existing_connector_state() to the unsafe
drm_atomic_get_new_connector_state(), which opened the doors for
this particular bug there as well.

v2: Split private objs out to a separate patch (Daniel)

Cc: stable@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Abhay Kumar <abhay.kumar@intel.com>
Fixes: 581e49fe6b41 ("drm/atomic: Add new iterators over all state, v3.")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180502183247.5746-1-ville.syrjala@linux.intel.com
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -151,6 +151,8 @@ void drm_atomic_state_default_clear(stru
 						       state->connectors[i].state);
 		state->connectors[i].ptr = NULL;
 		state->connectors[i].state = NULL;
+		state->connectors[i].old_state = NULL;
+		state->connectors[i].new_state = NULL;
 		drm_connector_put(connector);
 	}
 
@@ -172,6 +174,8 @@ void drm_atomic_state_default_clear(stru
 		state->crtcs[i].commit = NULL;
 		state->crtcs[i].ptr = NULL;
 		state->crtcs[i].state = NULL;
+		state->crtcs[i].old_state = NULL;
+		state->crtcs[i].new_state = NULL;
 	}
 
 	for (i = 0; i < config->num_total_plane; i++) {
@@ -184,6 +188,8 @@ void drm_atomic_state_default_clear(stru
 						   state->planes[i].state);
 		state->planes[i].ptr = NULL;
 		state->planes[i].state = NULL;
+		state->planes[i].old_state = NULL;
+		state->planes[i].new_state = NULL;
 	}
 
 	for (i = 0; i < state->num_private_objs; i++) {
