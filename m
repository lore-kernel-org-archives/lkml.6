Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226xn8UmPfqDvF6WGgcdStOGJG2RvTNvVq3XRkj+G0z2m/2d9ZHDO44WhKfs2zAXlLq3nf0y
ARC-Seal: i=1; a=rsa-sha256; t=1518708712; cv=none;
        d=google.com; s=arc-20160816;
        b=RT8fT4dnVIiuji0Ar9mB2by5odvcWm7s6SegrnnPhmWXNjlKm6M6B7eEgt3CVAuN+w
         QZRMoHQ/382reQgGjNcm1Fmmm8vZCrUY2xwQUX0sijZDPK6rd+ZKURVAZkhtAMOPAqAu
         e618xl6rCqeRN3LSy8xgbuvZSH5j/5m1nLHhaMuT1dLuxAPYz0qjZrInR/Xl9d+PMcxq
         2WabigaO9aHDW6DRIaaR756zk4ucqgjvriIo9ebKG3XKJev/6atkJbWSY7eO2zos4MEh
         36a1ZM2xdLpIse57EsMo9bUK3jTov45QkFj1c7RfBBLZnug32LdAIzfsbpK4Xfx9nlZi
         Tb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ph6Vri+t+gFXyYCfLM+JqFjmi00UUKgEJsaGX4MJBIc=;
        b=bXgy/XB6500G0F71s/4C0TxZIyb13vYIC73M3hPFpgv48cukJ37JL49uCDpVFb/e5+
         FhcYtUJ48f/beyfuTFDiKANWy1oh1dl22YFz+lzfWa8X49OM6XQjywXda5aGtMXLRzDP
         EtuKL7TPS6rzVYCKMjSlHD1WzkDXxDdqlhzKb4nlxLZA0ilS75rfPbVg879WJb1hDK2Q
         1CcFmuKTjj4Y7T7sMRrtQVTZCCLZbhWx3XGCowsEj8eXDybKKj2QFQ+IM/rhjNymtoqX
         0TllhOjz4OpZghS4E1XLuW9O9/4ubGHOQDjbjRg5kfAnMTDG6PMVfQP2Xk+fZ3ZTq9u8
         GMKg==
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
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.14 015/195] drm/i915: Add .get_hw_state() method for planes
Date: Thu, 15 Feb 2018 16:15:06 +0100
Message-Id: <20180215151706.497389653@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481506389246440?=
X-GMAIL-MSGID: =?utf-8?q?1592481506389246440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit d87ce76402950b8e4d5117276d44465658e886a4 upstream.

Add a .get_hw_state() method for planes, returning true or false
depending on whether the plane is enabled. Use it to rewrite the
plane enabled/disabled asserts in platform agnostic fashion.

We do lose the pre-gen4 plane<->pipe mapping checks, but since we're
supposed sanitize that anyway it doesn't really matter.

v2: Reoder patches to not depend on enum old_plane_id
    Just call assert_plane_disabled() from assert_planes_disabled()
v3: Deal with disabled power wells in .get_hw_state()
v4: Rebase due skl primary plane code removal

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alex Villacís Lasso <alexvillacislasso@hotmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch> #v2
Tested-by: Thierry Reding <thierry.reding@gmail.com> #v2
Link: https://patchwork.freedesktop.org/patch/msgid/20171117191917.11506-2-ville.syrjala@linux.intel.com
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
(cherry picked from commit 51f5a096398433a881e845d3685a2c1dac756019)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/gpu/drm/i915/intel_display.c |  188 ++++++++++++++++-------------------
 drivers/gpu/drm/i915/intel_drv.h     |    2 
 drivers/gpu/drm/i915/intel_sprite.c  |   83 +++++++++++++++
 3 files changed, 175 insertions(+), 98 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -1211,23 +1211,6 @@ void assert_panel_unlocked(struct drm_i9
 	     pipe_name(pipe));
 }
 
-static void assert_cursor(struct drm_i915_private *dev_priv,
-			  enum pipe pipe, bool state)
-{
-	bool cur_state;
-
-	if (IS_I845G(dev_priv) || IS_I865G(dev_priv))
-		cur_state = I915_READ(CURCNTR(PIPE_A)) & CURSOR_ENABLE;
-	else
-		cur_state = I915_READ(CURCNTR(pipe)) & CURSOR_MODE;
-
-	I915_STATE_WARN(cur_state != state,
-	     "cursor on pipe %c assertion failure (expected %s, current %s)\n",
-			pipe_name(pipe), onoff(state), onoff(cur_state));
-}
-#define assert_cursor_enabled(d, p) assert_cursor(d, p, true)
-#define assert_cursor_disabled(d, p) assert_cursor(d, p, false)
-
 void assert_pipe(struct drm_i915_private *dev_priv,
 		 enum pipe pipe, bool state)
 {
@@ -1255,77 +1238,25 @@ void assert_pipe(struct drm_i915_private
 			pipe_name(pipe), onoff(state), onoff(cur_state));
 }
 
-static void assert_plane(struct drm_i915_private *dev_priv,
-			 enum plane plane, bool state)
+static void assert_plane(struct intel_plane *plane, bool state)
 {
-	u32 val;
-	bool cur_state;
+	bool cur_state = plane->get_hw_state(plane);
 
-	val = I915_READ(DSPCNTR(plane));
-	cur_state = !!(val & DISPLAY_PLANE_ENABLE);
 	I915_STATE_WARN(cur_state != state,
-	     "plane %c assertion failure (expected %s, current %s)\n",
-			plane_name(plane), onoff(state), onoff(cur_state));
+			"%s assertion failure (expected %s, current %s)\n",
+			plane->base.name, onoff(state), onoff(cur_state));
 }
 
-#define assert_plane_enabled(d, p) assert_plane(d, p, true)
-#define assert_plane_disabled(d, p) assert_plane(d, p, false)
-
-static void assert_planes_disabled(struct drm_i915_private *dev_priv,
-				   enum pipe pipe)
-{
-	int i;
-
-	/* Primary planes are fixed to pipes on gen4+ */
-	if (INTEL_GEN(dev_priv) >= 4) {
-		u32 val = I915_READ(DSPCNTR(pipe));
-		I915_STATE_WARN(val & DISPLAY_PLANE_ENABLE,
-		     "plane %c assertion failure, should be disabled but not\n",
-		     plane_name(pipe));
-		return;
-	}
-
-	/* Need to check both planes against the pipe */
-	for_each_pipe(dev_priv, i) {
-		u32 val = I915_READ(DSPCNTR(i));
-		enum pipe cur_pipe = (val & DISPPLANE_SEL_PIPE_MASK) >>
-			DISPPLANE_SEL_PIPE_SHIFT;
-		I915_STATE_WARN((val & DISPLAY_PLANE_ENABLE) && pipe == cur_pipe,
-		     "plane %c assertion failure, should be off on pipe %c but is still active\n",
-		     plane_name(i), pipe_name(pipe));
-	}
-}
+#define assert_plane_enabled(p) assert_plane(p, true)
+#define assert_plane_disabled(p) assert_plane(p, false)
 
-static void assert_sprites_disabled(struct drm_i915_private *dev_priv,
-				    enum pipe pipe)
+static void assert_planes_disabled(struct intel_crtc *crtc)
 {
-	int sprite;
+	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
+	struct intel_plane *plane;
 
-	if (INTEL_GEN(dev_priv) >= 9) {
-		for_each_sprite(dev_priv, pipe, sprite) {
-			u32 val = I915_READ(PLANE_CTL(pipe, sprite));
-			I915_STATE_WARN(val & PLANE_CTL_ENABLE,
-			     "plane %d assertion failure, should be off on pipe %c but is still active\n",
-			     sprite, pipe_name(pipe));
-		}
-	} else if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
-		for_each_sprite(dev_priv, pipe, sprite) {
-			u32 val = I915_READ(SPCNTR(pipe, PLANE_SPRITE0 + sprite));
-			I915_STATE_WARN(val & SP_ENABLE,
-			     "sprite %c assertion failure, should be off on pipe %c but is still active\n",
-			     sprite_name(pipe, sprite), pipe_name(pipe));
-		}
-	} else if (INTEL_GEN(dev_priv) >= 7) {
-		u32 val = I915_READ(SPRCTL(pipe));
-		I915_STATE_WARN(val & SPRITE_ENABLE,
-		     "sprite %c assertion failure, should be off on pipe %c but is still active\n",
-		     plane_name(pipe), pipe_name(pipe));
-	} else if (INTEL_GEN(dev_priv) >= 5 || IS_G4X(dev_priv)) {
-		u32 val = I915_READ(DVSCNTR(pipe));
-		I915_STATE_WARN(val & DVS_ENABLE,
-		     "sprite %c assertion failure, should be off on pipe %c but is still active\n",
-		     plane_name(pipe), pipe_name(pipe));
-	}
+	for_each_intel_plane_on_crtc(&dev_priv->drm, crtc, plane)
+		assert_plane_disabled(plane);
 }
 
 static void assert_vblank_disabled(struct drm_crtc *crtc)
@@ -1926,9 +1857,7 @@ static void intel_enable_pipe(struct int
 
 	DRM_DEBUG_KMS("enabling pipe %c\n", pipe_name(pipe));
 
-	assert_planes_disabled(dev_priv, pipe);
-	assert_cursor_disabled(dev_priv, pipe);
-	assert_sprites_disabled(dev_priv, pipe);
+	assert_planes_disabled(crtc);
 
 	/*
 	 * A pipe without a PLL won't actually be able to drive bits from
@@ -1997,9 +1926,7 @@ static void intel_disable_pipe(struct in
 	 * Make sure planes won't keep trying to pump pixels to us,
 	 * or we might hang the display.
 	 */
-	assert_planes_disabled(dev_priv, pipe);
-	assert_cursor_disabled(dev_priv, pipe);
-	assert_sprites_disabled(dev_priv, pipe);
+	assert_planes_disabled(crtc);
 
 	reg = PIPECONF(cpu_transcoder);
 	val = I915_READ(reg);
@@ -3397,6 +3324,31 @@ static void i9xx_disable_primary_plane(s
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
+static bool i9xx_plane_get_hw_state(struct intel_plane *primary)
+{
+
+	struct drm_i915_private *dev_priv = to_i915(primary->base.dev);
+	enum intel_display_power_domain power_domain;
+	enum plane plane = primary->plane;
+	enum pipe pipe = primary->pipe;
+	bool ret;
+
+	/*
+	 * Not 100% correct for planes that can move between pipes,
+	 * but that's only the case for gen2-4 which don't have any
+	 * display power wells.
+	 */
+	power_domain = POWER_DOMAIN_PIPE(pipe);
+	if (!intel_display_power_get_if_enabled(dev_priv, power_domain))
+		return false;
+
+	ret = I915_READ(DSPCNTR(plane)) & DISPLAY_PLANE_ENABLE;
+
+	intel_display_power_put(dev_priv, power_domain);
+
+	return ret;
+}
+
 static u32
 intel_fb_stride_alignment(const struct drm_framebuffer *fb, int plane)
 {
@@ -4973,7 +4925,8 @@ void hsw_enable_ips(struct intel_crtc *c
 	 * a vblank wait.
 	 */
 
-	assert_plane_enabled(dev_priv, crtc->plane);
+	assert_plane_enabled(to_intel_plane(crtc->base.primary));
+
 	if (IS_BROADWELL(dev_priv)) {
 		mutex_lock(&dev_priv->rps.hw_lock);
 		WARN_ON(sandybridge_pcode_write(dev_priv, DISPLAY_IPS_CONTROL, 0xc0000000));
@@ -5005,7 +4958,8 @@ void hsw_disable_ips(struct intel_crtc *
 	if (!crtc->config->ips_enabled)
 		return;
 
-	assert_plane_enabled(dev_priv, crtc->plane);
+	assert_plane_enabled(to_intel_plane(crtc->base.primary));
+
 	if (IS_BROADWELL(dev_priv)) {
 		mutex_lock(&dev_priv->rps.hw_lock);
 		WARN_ON(sandybridge_pcode_write(dev_priv, DISPLAY_IPS_CONTROL, 0));
@@ -9577,6 +9531,23 @@ static void i845_disable_cursor(struct i
 	i845_update_cursor(plane, NULL, NULL);
 }
 
+static bool i845_cursor_get_hw_state(struct intel_plane *plane)
+{
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	enum intel_display_power_domain power_domain;
+	bool ret;
+
+	power_domain = POWER_DOMAIN_PIPE(PIPE_A);
+	if (!intel_display_power_get_if_enabled(dev_priv, power_domain))
+		return false;
+
+	ret = I915_READ(CURCNTR(PIPE_A)) & CURSOR_ENABLE;
+
+	intel_display_power_put(dev_priv, power_domain);
+
+	return ret;
+}
+
 static u32 i9xx_cursor_ctl(const struct intel_crtc_state *crtc_state,
 			   const struct intel_plane_state *plane_state)
 {
@@ -9770,6 +9741,28 @@ static void i9xx_disable_cursor(struct i
 	i9xx_update_cursor(plane, NULL, NULL);
 }
 
+static bool i9xx_cursor_get_hw_state(struct intel_plane *plane)
+{
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	enum intel_display_power_domain power_domain;
+	enum pipe pipe = plane->pipe;
+	bool ret;
+
+	/*
+	 * Not 100% correct for planes that can move between pipes,
+	 * but that's only the case for gen2-3 which don't have any
+	 * display power wells.
+	 */
+	power_domain = POWER_DOMAIN_PIPE(pipe);
+	if (!intel_display_power_get_if_enabled(dev_priv, power_domain))
+		return false;
+
+	ret = I915_READ(CURCNTR(pipe)) & CURSOR_MODE;
+
+	intel_display_power_put(dev_priv, power_domain);
+
+	return ret;
+}
 
 /* VESA 640x480x72Hz mode to set on the pipe */
 static struct drm_display_mode load_detect_mode = {
@@ -13240,6 +13233,7 @@ intel_primary_plane_create(struct drm_i9
 
 		primary->update_plane = skylake_update_primary_plane;
 		primary->disable_plane = skylake_disable_primary_plane;
+		primary->get_hw_state = skl_plane_get_hw_state;
 	} else if (INTEL_GEN(dev_priv) >= 9) {
 		intel_primary_formats = skl_primary_formats;
 		num_formats = ARRAY_SIZE(skl_primary_formats);
@@ -13250,6 +13244,7 @@ intel_primary_plane_create(struct drm_i9
 
 		primary->update_plane = skylake_update_primary_plane;
 		primary->disable_plane = skylake_disable_primary_plane;
+		primary->get_hw_state = skl_plane_get_hw_state;
 	} else if (INTEL_GEN(dev_priv) >= 4) {
 		intel_primary_formats = i965_primary_formats;
 		num_formats = ARRAY_SIZE(i965_primary_formats);
@@ -13257,6 +13252,7 @@ intel_primary_plane_create(struct drm_i9
 
 		primary->update_plane = i9xx_update_primary_plane;
 		primary->disable_plane = i9xx_disable_primary_plane;
+		primary->get_hw_state = i9xx_plane_get_hw_state;
 	} else {
 		intel_primary_formats = i8xx_primary_formats;
 		num_formats = ARRAY_SIZE(i8xx_primary_formats);
@@ -13264,6 +13260,7 @@ intel_primary_plane_create(struct drm_i9
 
 		primary->update_plane = i9xx_update_primary_plane;
 		primary->disable_plane = i9xx_disable_primary_plane;
+		primary->get_hw_state = i9xx_plane_get_hw_state;
 	}
 
 	if (INTEL_GEN(dev_priv) >= 9)
@@ -13353,10 +13350,12 @@ intel_cursor_plane_create(struct drm_i91
 	if (IS_I845G(dev_priv) || IS_I865G(dev_priv)) {
 		cursor->update_plane = i845_update_cursor;
 		cursor->disable_plane = i845_disable_cursor;
+		cursor->get_hw_state = i845_cursor_get_hw_state;
 		cursor->check_plane = i845_check_cursor;
 	} else {
 		cursor->update_plane = i9xx_update_cursor;
 		cursor->disable_plane = i9xx_disable_cursor;
+		cursor->get_hw_state = i9xx_cursor_get_hw_state;
 		cursor->check_plane = i9xx_check_cursor;
 	}
 
@@ -14704,8 +14703,8 @@ void i830_disable_pipe(struct drm_i915_p
 	DRM_DEBUG_KMS("disabling pipe %c due to force quirk\n",
 		      pipe_name(pipe));
 
-	assert_plane_disabled(dev_priv, PLANE_A);
-	assert_plane_disabled(dev_priv, PLANE_B);
+	assert_planes_disabled(intel_get_crtc_for_pipe(dev_priv, PIPE_A));
+	assert_planes_disabled(intel_get_crtc_for_pipe(dev_priv, PIPE_B));
 
 	I915_WRITE(PIPECONF(pipe), 0);
 	POSTING_READ(PIPECONF(pipe));
@@ -14918,20 +14917,13 @@ void i915_redisable_vga(struct drm_i915_
 	intel_display_power_put(dev_priv, POWER_DOMAIN_VGA);
 }
 
-static bool primary_get_hw_state(struct intel_plane *plane)
-{
-	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
-
-	return I915_READ(DSPCNTR(plane->plane)) & DISPLAY_PLANE_ENABLE;
-}
-
 /* FIXME read out full plane state for all planes */
 static void readout_plane_state(struct intel_crtc *crtc)
 {
 	struct intel_plane *primary = to_intel_plane(crtc->base.primary);
 	bool visible;
 
-	visible = crtc->active && primary_get_hw_state(primary);
+	visible = crtc->active && primary->get_hw_state(primary);
 
 	intel_set_plane_visible(to_intel_crtc_state(crtc->base.state),
 				to_intel_plane_state(primary->base.state),
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -863,6 +863,7 @@ struct intel_plane {
 			     const struct intel_plane_state *plane_state);
 	void (*disable_plane)(struct intel_plane *plane,
 			      struct intel_crtc *crtc);
+	bool (*get_hw_state)(struct intel_plane *plane);
 	int (*check_plane)(struct intel_plane *plane,
 			   struct intel_crtc_state *crtc_state,
 			   struct intel_plane_state *state);
@@ -1885,6 +1886,7 @@ int intel_sprite_set_colorkey(struct drm
 			      struct drm_file *file_priv);
 void intel_pipe_update_start(struct intel_crtc *crtc);
 void intel_pipe_update_end(struct intel_crtc *crtc);
+bool skl_plane_get_hw_state(struct intel_plane *plane);
 
 /* intel_tv.c */
 void intel_tv_init(struct drm_i915_private *dev_priv);
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -324,6 +324,26 @@ skl_disable_plane(struct intel_plane *pl
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
+bool
+skl_plane_get_hw_state(struct intel_plane *plane)
+{
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	enum intel_display_power_domain power_domain;
+	enum plane_id plane_id = plane->id;
+	enum pipe pipe = plane->pipe;
+	bool ret;
+
+	power_domain = POWER_DOMAIN_PIPE(pipe);
+	if (!intel_display_power_get_if_enabled(dev_priv, power_domain))
+		return false;
+
+	ret = I915_READ(PLANE_CTL(pipe, plane_id)) & PLANE_CTL_ENABLE;
+
+	intel_display_power_put(dev_priv, power_domain);
+
+	return ret;
+}
+
 static void
 chv_update_csc(struct intel_plane *plane, uint32_t format)
 {
@@ -501,6 +521,26 @@ vlv_disable_plane(struct intel_plane *pl
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
+static bool
+vlv_plane_get_hw_state(struct intel_plane *plane)
+{
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	enum intel_display_power_domain power_domain;
+	enum plane_id plane_id = plane->id;
+	enum pipe pipe = plane->pipe;
+	bool ret;
+
+	power_domain = POWER_DOMAIN_PIPE(pipe);
+	if (!intel_display_power_get_if_enabled(dev_priv, power_domain))
+		return false;
+
+	ret = I915_READ(SPCNTR(pipe, plane_id)) & SP_ENABLE;
+
+	intel_display_power_put(dev_priv, power_domain);
+
+	return ret;
+}
+
 static u32 ivb_sprite_ctl(const struct intel_crtc_state *crtc_state,
 			  const struct intel_plane_state *plane_state)
 {
@@ -641,6 +681,25 @@ ivb_disable_plane(struct intel_plane *pl
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
+static bool
+ivb_plane_get_hw_state(struct intel_plane *plane)
+{
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	enum intel_display_power_domain power_domain;
+	enum pipe pipe = plane->pipe;
+	bool ret;
+
+	power_domain = POWER_DOMAIN_PIPE(pipe);
+	if (!intel_display_power_get_if_enabled(dev_priv, power_domain))
+		return false;
+
+	ret =  I915_READ(SPRCTL(pipe)) & SPRITE_ENABLE;
+
+	intel_display_power_put(dev_priv, power_domain);
+
+	return ret;
+}
+
 static u32 g4x_sprite_ctl(const struct intel_crtc_state *crtc_state,
 			  const struct intel_plane_state *plane_state)
 {
@@ -772,6 +831,25 @@ g4x_disable_plane(struct intel_plane *pl
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
+static bool
+g4x_plane_get_hw_state(struct intel_plane *plane)
+{
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	enum intel_display_power_domain power_domain;
+	enum pipe pipe = plane->pipe;
+	bool ret;
+
+	power_domain = POWER_DOMAIN_PIPE(pipe);
+	if (!intel_display_power_get_if_enabled(dev_priv, power_domain))
+		return false;
+
+	ret = I915_READ(DVSCNTR(pipe)) & DVS_ENABLE;
+
+	intel_display_power_put(dev_priv, power_domain);
+
+	return ret;
+}
+
 static int
 intel_check_sprite_plane(struct intel_plane *plane,
 			 struct intel_crtc_state *crtc_state,
@@ -1227,6 +1305,7 @@ intel_sprite_plane_create(struct drm_i91
 
 		intel_plane->update_plane = skl_update_plane;
 		intel_plane->disable_plane = skl_disable_plane;
+		intel_plane->get_hw_state = skl_plane_get_hw_state;
 
 		plane_formats = skl_plane_formats;
 		num_plane_formats = ARRAY_SIZE(skl_plane_formats);
@@ -1237,6 +1316,7 @@ intel_sprite_plane_create(struct drm_i91
 
 		intel_plane->update_plane = skl_update_plane;
 		intel_plane->disable_plane = skl_disable_plane;
+		intel_plane->get_hw_state = skl_plane_get_hw_state;
 
 		plane_formats = skl_plane_formats;
 		num_plane_formats = ARRAY_SIZE(skl_plane_formats);
@@ -1247,6 +1327,7 @@ intel_sprite_plane_create(struct drm_i91
 
 		intel_plane->update_plane = vlv_update_plane;
 		intel_plane->disable_plane = vlv_disable_plane;
+		intel_plane->get_hw_state = vlv_plane_get_hw_state;
 
 		plane_formats = vlv_plane_formats;
 		num_plane_formats = ARRAY_SIZE(vlv_plane_formats);
@@ -1262,6 +1343,7 @@ intel_sprite_plane_create(struct drm_i91
 
 		intel_plane->update_plane = ivb_update_plane;
 		intel_plane->disable_plane = ivb_disable_plane;
+		intel_plane->get_hw_state = ivb_plane_get_hw_state;
 
 		plane_formats = snb_plane_formats;
 		num_plane_formats = ARRAY_SIZE(snb_plane_formats);
@@ -1272,6 +1354,7 @@ intel_sprite_plane_create(struct drm_i91
 
 		intel_plane->update_plane = g4x_update_plane;
 		intel_plane->disable_plane = g4x_disable_plane;
+		intel_plane->get_hw_state = g4x_plane_get_hw_state;
 
 		modifiers = i9xx_plane_format_modifiers;
 		if (IS_GEN6(dev_priv)) {
