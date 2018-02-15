Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224hiLzmvBpi5jiz4vVkexLGIQCNBS34kumIL1mbL8/iFm1QGQU+w+pIvgXt7DjUM4lxgmLT
ARC-Seal: i=1; a=rsa-sha256; t=1518708714; cv=none;
        d=google.com; s=arc-20160816;
        b=UsGUDuXtgi5aVHrTU8Se51UCXVcX7lqV6Oi3lv/AZVvd/4cNatETC+TPX9ek0icHfW
         1tpbFxPZLzuiCvrhZo5bdp3Uo3yKM5jJE8g56uPDDF7LnZqZAW2OaKKO39XfGymJe988
         iHZZ/oFIORykQOqdmMEJyHe2T9wGV4RmCXGWwdRmzPDI/drRZt4egUIo5Lqf2dsNrOT+
         XEPiqKf6oSnjAI3YtWL09vP1x/YxP0sIlEBu8aDoCHYZeN3euRkP55E522ug5CbD6E+4
         fwBB5zKkUyAJVJt6Dbay0xt6ps5XI4If9LbUa0+dUFeRTofbcODDjuTqUGbAiPfe3fD3
         DzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1SExkRzzxv5XYLj4x8PobsnChQrDrEmJbV2uiytoOqc=;
        b=dqJVg8gsS8BwDpkibd7LAm1hSkGx3KjMsjfNQyLgNOrgx51/L8Tif3oaBGpcHMmpWY
         ocamZJ76Q9IHJrfmdSBjuszmARy/uBWezVL65e/VK75CjJagH0D2n5z1VQLS4w6u4pC2
         0BufpUaIDY+mBszIp0kaP06+e8tQPAKu343naxQ3teRcBtnxhJw6NlnTlE5fNohOIOgW
         Mm/oT+5omIE+0FNidBTffcWJwVnnr4P0B9YLh/bg1zjQ1+coUTTyBRCYLShbPoatM0af
         vtW+Hr6xCYqlr3QVhsQbe3/437kIWUFNvz1sHS88XMYo7OUan+/lMr4VZHTjCPnp4YDh
         x2dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Alex=20Villac=C3=ADs=20Lasso?= <alexvillacislasso@hotmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.14 016/195] drm/i915: Redo plane sanitation during readout
Date: Thu, 15 Feb 2018 16:15:07 +0100
Message-Id: <20180215151706.575228603@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481509133559698?=
X-GMAIL-MSGID: =?utf-8?q?1592481509133559698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 23ac12732825901b3fc6ac720958d8bff9a0d6ec upstream.

Unify the plane disabling during state readout by pulling the code into
a new helper intel_plane_disable_noatomic(). We'll also read out the
state of all planes, so that we know which planes really need to be
diabled.

Additonally we change the plane<->pipe mapping sanitation to work by
simply disabling the offending planes instead of entire pipes. And
we do it before we otherwise sanitize the crtcs, which means we don't
have to worry about misassigned planes during crtc sanitation anymore.

v2: Reoder patches to not depend on enum old_plane_id
v3: s/for_each_pipe/for_each_intel_crtc/

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alex Villacís Lasso <alexvillacislasso@hotmail.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103223
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Tested-by: Thierry Reding <thierry.reding@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171117191917.11506-3-ville.syrjala@linux.intel.com
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
(cherry picked from commit b1e01595a66dc206a2c75401ec4c285740537f3f)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |  114 +++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 49 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -2756,6 +2756,23 @@ intel_set_plane_visible(struct intel_crt
 		      crtc_state->active_planes);
 }
 
+static void intel_plane_disable_noatomic(struct intel_crtc *crtc,
+					 struct intel_plane *plane)
+{
+	struct intel_crtc_state *crtc_state =
+		to_intel_crtc_state(crtc->base.state);
+	struct intel_plane_state *plane_state =
+		to_intel_plane_state(plane->base.state);
+
+	intel_set_plane_visible(crtc_state, plane_state, false);
+
+	if (plane->id == PLANE_PRIMARY)
+		intel_pre_disable_primary_noatomic(&crtc->base);
+
+	trace_intel_disable_plane(&plane->base, crtc);
+	plane->disable_plane(plane, crtc);
+}
+
 static void
 intel_find_initial_plane_obj(struct intel_crtc *intel_crtc,
 			     struct intel_initial_plane_config *plane_config)
@@ -2813,12 +2830,7 @@ intel_find_initial_plane_obj(struct inte
 	 * simplest solution is to just disable the primary plane now and
 	 * pretend the BIOS never had it enabled.
 	 */
-	intel_set_plane_visible(to_intel_crtc_state(crtc_state),
-				to_intel_plane_state(plane_state),
-				false);
-	intel_pre_disable_primary_noatomic(&intel_crtc->base);
-	trace_intel_disable_plane(primary, intel_crtc);
-	intel_plane->disable_plane(intel_plane, intel_crtc);
+	intel_plane_disable_noatomic(intel_crtc, intel_plane);
 
 	return;
 
@@ -5954,6 +5966,7 @@ static void intel_crtc_disable_noatomic(
 	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
 	struct drm_i915_private *dev_priv = to_i915(crtc->dev);
 	enum intel_display_power_domain domain;
+	struct intel_plane *plane;
 	u64 domains;
 	struct drm_atomic_state *state;
 	struct intel_crtc_state *crtc_state;
@@ -5962,11 +5975,12 @@ static void intel_crtc_disable_noatomic(
 	if (!intel_crtc->active)
 		return;
 
-	if (crtc->primary->state->visible) {
-		intel_pre_disable_primary_noatomic(crtc);
+	for_each_intel_plane_on_crtc(&dev_priv->drm, intel_crtc, plane) {
+		const struct intel_plane_state *plane_state =
+			to_intel_plane_state(plane->base.state);
 
-		intel_crtc_disable_planes(crtc, 1 << drm_plane_index(crtc->primary));
-		crtc->primary->state->visible = false;
+		if (plane_state->base.visible)
+			intel_plane_disable_noatomic(intel_crtc, plane);
 	}
 
 	state = drm_atomic_state_alloc(crtc->dev);
@@ -14715,22 +14729,36 @@ void i830_disable_pipe(struct drm_i915_p
 	POSTING_READ(DPLL(pipe));
 }
 
-static bool
-intel_check_plane_mapping(struct intel_crtc *crtc)
+static bool intel_plane_mapping_ok(struct intel_crtc *crtc,
+				   struct intel_plane *primary)
 {
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
-	u32 val;
+	enum plane plane = primary->plane;
+	u32 val = I915_READ(DSPCNTR(plane));
 
-	if (INTEL_INFO(dev_priv)->num_pipes == 1)
-		return true;
+	return (val & DISPLAY_PLANE_ENABLE) == 0 ||
+		(val & DISPPLANE_SEL_PIPE_MASK) == DISPPLANE_SEL_PIPE(crtc->pipe);
+}
 
-	val = I915_READ(DSPCNTR(!crtc->plane));
+static void
+intel_sanitize_plane_mapping(struct drm_i915_private *dev_priv)
+{
+	struct intel_crtc *crtc;
 
-	if ((val & DISPLAY_PLANE_ENABLE) &&
-	    (!!(val & DISPPLANE_SEL_PIPE_MASK) == crtc->pipe))
-		return false;
+	if (INTEL_GEN(dev_priv) >= 4)
+		return;
 
-	return true;
+	for_each_intel_crtc(&dev_priv->drm, crtc) {
+		struct intel_plane *plane =
+			to_intel_plane(crtc->base.primary);
+
+		if (intel_plane_mapping_ok(crtc, plane))
+			continue;
+
+		DRM_DEBUG_KMS("%s attached to the wrong pipe, disabling plane\n",
+			      plane->base.name);
+		intel_plane_disable_noatomic(crtc, plane);
+	}
 }
 
 static bool intel_crtc_has_encoders(struct intel_crtc *crtc)
@@ -14786,33 +14814,15 @@ static void intel_sanitize_crtc(struct i
 
 		/* Disable everything but the primary plane */
 		for_each_intel_plane_on_crtc(dev, crtc, plane) {
-			if (plane->base.type == DRM_PLANE_TYPE_PRIMARY)
-				continue;
+			const struct intel_plane_state *plane_state =
+				to_intel_plane_state(plane->base.state);
 
-			trace_intel_disable_plane(&plane->base, crtc);
-			plane->disable_plane(plane, crtc);
+			if (plane_state->base.visible &&
+			    plane->base.type != DRM_PLANE_TYPE_PRIMARY)
+				intel_plane_disable_noatomic(crtc, plane);
 		}
 	}
 
-	/* We need to sanitize the plane -> pipe mapping first because this will
-	 * disable the crtc (and hence change the state) if it is wrong. Note
-	 * that gen4+ has a fixed plane -> pipe mapping.  */
-	if (INTEL_GEN(dev_priv) < 4 && !intel_check_plane_mapping(crtc)) {
-		bool plane;
-
-		DRM_DEBUG_KMS("[CRTC:%d:%s] wrong plane connection detected!\n",
-			      crtc->base.base.id, crtc->base.name);
-
-		/* Pipe has the wrong plane attached and the plane is active.
-		 * Temporarily change the plane mapping and disable everything
-		 * ...  */
-		plane = crtc->plane;
-		crtc->base.primary->state->visible = true;
-		crtc->plane = !plane;
-		intel_crtc_disable_noatomic(&crtc->base, ctx);
-		crtc->plane = plane;
-	}
-
 	/* Adjust the state of the output pipe according to whether we
 	 * have active connectors/encoders. */
 	if (crtc->active && !intel_crtc_has_encoders(crtc))
@@ -14920,14 +14930,18 @@ void i915_redisable_vga(struct drm_i915_
 /* FIXME read out full plane state for all planes */
 static void readout_plane_state(struct intel_crtc *crtc)
 {
-	struct intel_plane *primary = to_intel_plane(crtc->base.primary);
-	bool visible;
+	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
+	struct intel_crtc_state *crtc_state =
+		to_intel_crtc_state(crtc->base.state);
+	struct intel_plane *plane;
 
-	visible = crtc->active && primary->get_hw_state(primary);
+	for_each_intel_plane_on_crtc(&dev_priv->drm, crtc, plane) {
+		struct intel_plane_state *plane_state =
+			to_intel_plane_state(plane->base.state);
+		bool visible = plane->get_hw_state(plane);
 
-	intel_set_plane_visible(to_intel_crtc_state(crtc->base.state),
-				to_intel_plane_state(primary->base.state),
-				visible);
+		intel_set_plane_visible(crtc_state, plane_state, visible);
+	}
 }
 
 static void intel_modeset_readout_hw_state(struct drm_device *dev)
@@ -15129,6 +15143,8 @@ intel_modeset_setup_hw_state(struct drm_
 	/* HW state is read out, now we need to sanitize this mess. */
 	get_encoder_power_domains(dev_priv);
 
+	intel_sanitize_plane_mapping(dev_priv);
+
 	for_each_intel_encoder(dev, encoder) {
 		intel_sanitize_encoder(encoder);
 	}
