Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48UlxVvik2vFK2NzwgYh1+kFM4lbQ3eMJEiIJBlWDiIsS8R36JcdnSskURV5HzkS9VFtIHA
ARC-Seal: i=1; a=rsa-sha256; t=1524406260; cv=none;
        d=google.com; s=arc-20160816;
        b=A9aGWZ3wyeBab3O2E3sdUM8u5SRv7syqyxCEMjPq8OCjAM60qmwAGMfxIieef/Njsd
         ddl8TnaDZ3Pi8cVQ8yHu3ssiG4+vF4TJUeWfA2ve9/RPaGkBn5ui8hzjlUIb5pVF2thg
         F6HIXlzsj2Q1ZVXOLqeFvL5z34nA481oDX4pbDfXxKkgeu6CQVH4E/KNnJPFr9EDcXsr
         iZCxIoBe5W2ihowYLMEI6hjqIBRKQCxjCYVfDND7zJApLgAqjFF0fNEfGPZhOReRRXZA
         +qoQFjVUyvyH/OIRAXVZxiLabceXovOTp8nr1UHJyLeAvU5w879wze0cA/cJlFZm9Hjo
         H00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FGBhNDj1sFbH9P9Oz3Y6gU+HHwGyhdMkk8KE2MWuFbc=;
        b=e4IKIGlZfVtlj67PsB/Zrz3SY5QPNoIk/tKoHeBbyf95EB6cXARu890kwVuAq7HlR5
         u4ZUWYnQaIWtlhnAHWGVmyAGsg6kbueGehZoEg+0lk4N7gzOlvUUoqNuwqNzCnevCjG2
         uF/QaAvDdFWoUVXkyao5Ok/gNCRjABmgbUoZTRG94ip7Hsdrjovzzxe8+4zI9JhQZLbO
         gJaB5XyN8Um4QMj7A47Iy0MlQFxwzCMsQl0yk9fCSWhCHxEMdFHrhGnFhW3vAbX3HX93
         fwCc+ZPUgBMm0SQOBW+lvZtM4N5btVVo/i/TjqI/eYsw3vZIDyFR+nbaDYqFdr7s+Pve
         2eOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Harry Wentland <harry.wentland@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Ilia Mirkin <imirkin@alum.mit.edu>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Shashank Sharma <shashank.sharma@intel.com>,
	Uma Shankar <uma.shankar@intel.com>,
	Jyri Sarha <jsarha@ti.com>,
	"Tang, Jun" <jun.tang@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 4.14 151/164] drm/i915: Correctly handle limited range YCbCr data on VLV/CHV
Date: Sun, 22 Apr 2018 15:53:38 +0200
Message-Id: <20180422135141.729401331@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455293611521894?=
X-GMAIL-MSGID: =?utf-8?q?1598455818365664299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 5deae9191130db6b617c94fb261804597cf9b508 upstream.

Turns out the VLV/CHV fixed function sprite CSC expects full range
data as input. We've been feeding it limited range data to it all
along. To expand the data out to full range we'll use the color
correction registers (brightness, contrast, and saturation).

On CHV pipe B we were actually doing the right thing already because we
progammed the custom CSC matrix to do expect limited range input. Now
that well pre-expand the data out with the color correction unit, we
need to change the CSC matrix to operate with full range input instead.

This should make the sprite output of the other pipes match the sprite
output of pipe B reasonably well. Looking at the resulting pipe CRCs,
there can be a slight difference in the output, but as I don't know
the formula used by the fixed function CSC of the other pipes, I don't
think it's worth the effort to try to match the output exactly. It
might not even be possible due to difference in internal precision etc.

One slight caveat here is that the color correction registers are single
bufferred, so we should really be updating them during vblank, but we
still don't have a mechanism for that, so just toss in another FIXME.

v2: Rebase
v3: s/bri/brightness/ s/con/contrast/ (Shashank)
v4: Clarify the constants and math (Shashank)

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Stone <daniel@fooishbar.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Shashank Sharma <shashank.sharma@intel.com>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: "Tang, Jun" <jun.tang@intel.com>
Reported-by: "Tang, Jun" <jun.tang@intel.com>
Cc: stable@vger.kernel.org
Fixes: 7f1f3851feb0 ("drm/i915: sprite support for ValleyView v4")
Reviewed-by: Shashank Sharma <shashank.sharma@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180214192327.3250-5-ville.syrjala@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_reg.h     |   10 ++++
 drivers/gpu/drm/i915/intel_sprite.c |   83 +++++++++++++++++++++++++++---------
 2 files changed, 74 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -6159,6 +6159,12 @@ enum {
 #define _SPATILEOFF		(VLV_DISPLAY_BASE + 0x721a4)
 #define _SPACONSTALPHA		(VLV_DISPLAY_BASE + 0x721a8)
 #define   SP_CONST_ALPHA_ENABLE		(1<<31)
+#define _SPACLRC0		(VLV_DISPLAY_BASE + 0x721d0)
+#define   SP_CONTRAST(x)		((x) << 18) /* u3.6 */
+#define   SP_BRIGHTNESS(x)		((x) & 0xff) /* s8 */
+#define _SPACLRC1		(VLV_DISPLAY_BASE + 0x721d4)
+#define   SP_SH_SIN(x)			(((x) & 0x7ff) << 16) /* s4.7 */
+#define   SP_SH_COS(x)			(x) /* u3.7 */
 #define _SPAGAMC		(VLV_DISPLAY_BASE + 0x721f4)
 
 #define _SPBCNTR		(VLV_DISPLAY_BASE + 0x72280)
@@ -6172,6 +6178,8 @@ enum {
 #define _SPBKEYMAXVAL		(VLV_DISPLAY_BASE + 0x722a0)
 #define _SPBTILEOFF		(VLV_DISPLAY_BASE + 0x722a4)
 #define _SPBCONSTALPHA		(VLV_DISPLAY_BASE + 0x722a8)
+#define _SPBCLRC0		(VLV_DISPLAY_BASE + 0x722d0)
+#define _SPBCLRC1		(VLV_DISPLAY_BASE + 0x722d4)
 #define _SPBGAMC		(VLV_DISPLAY_BASE + 0x722f4)
 
 #define _MMIO_VLV_SPR(pipe, plane_id, reg_a, reg_b) \
@@ -6188,6 +6196,8 @@ enum {
 #define SPKEYMAXVAL(pipe, plane_id)	_MMIO_VLV_SPR((pipe), (plane_id), _SPAKEYMAXVAL, _SPBKEYMAXVAL)
 #define SPTILEOFF(pipe, plane_id)	_MMIO_VLV_SPR((pipe), (plane_id), _SPATILEOFF, _SPBTILEOFF)
 #define SPCONSTALPHA(pipe, plane_id)	_MMIO_VLV_SPR((pipe), (plane_id), _SPACONSTALPHA, _SPBCONSTALPHA)
+#define SPCLRC0(pipe, plane_id)		_MMIO_VLV_SPR((pipe), (plane_id), _SPACLRC0, _SPBCLRC0)
+#define SPCLRC1(pipe, plane_id)		_MMIO_VLV_SPR((pipe), (plane_id), _SPACLRC1, _SPBCLRC1)
 #define SPGAMC(pipe, plane_id)		_MMIO_VLV_SPR((pipe), (plane_id), _SPAGAMC, _SPBGAMC)
 
 /*
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -345,44 +345,87 @@ skl_plane_get_hw_state(struct intel_plan
 }
 
 static void
-chv_update_csc(struct intel_plane *plane, uint32_t format)
+chv_update_csc(const struct intel_plane_state *plane_state)
 {
+	struct intel_plane *plane = to_intel_plane(plane_state->base.plane);
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	const struct drm_framebuffer *fb = plane_state->base.fb;
 	enum plane_id plane_id = plane->id;
 
 	/* Seems RGB data bypasses the CSC always */
-	if (!format_is_yuv(format))
+	if (!format_is_yuv(fb->format->format))
 		return;
 
 	/*
-	 * BT.601 limited range YCbCr -> full range RGB
+	 * BT.601 full range YCbCr -> full range RGB
 	 *
-	 * |r|   | 6537 4769     0|   |cr  |
-	 * |g| = |-3330 4769 -1605| x |y-64|
-	 * |b|   |    0 4769  8263|   |cb  |
+	 * |r|   | 5743 4096     0|   |cr|
+	 * |g| = |-2925 4096 -1410| x |y |
+	 * |b|   |    0 4096  7258|   |cb|
 	 *
-	 * Cb and Cr apparently come in as signed already, so no
-	 * need for any offset. For Y we need to remove the offset.
+	 * Cb and Cr apparently come in as signed already,
+	 * and we get full range data in on account of CLRC0/1
 	 */
-	I915_WRITE_FW(SPCSCYGOFF(plane_id), SPCSC_OOFF(0) | SPCSC_IOFF(-64));
+	I915_WRITE_FW(SPCSCYGOFF(plane_id), SPCSC_OOFF(0) | SPCSC_IOFF(0));
 	I915_WRITE_FW(SPCSCCBOFF(plane_id), SPCSC_OOFF(0) | SPCSC_IOFF(0));
 	I915_WRITE_FW(SPCSCCROFF(plane_id), SPCSC_OOFF(0) | SPCSC_IOFF(0));
 
-	I915_WRITE_FW(SPCSCC01(plane_id), SPCSC_C1(4769) | SPCSC_C0(6537));
-	I915_WRITE_FW(SPCSCC23(plane_id), SPCSC_C1(-3330) | SPCSC_C0(0));
-	I915_WRITE_FW(SPCSCC45(plane_id), SPCSC_C1(-1605) | SPCSC_C0(4769));
-	I915_WRITE_FW(SPCSCC67(plane_id), SPCSC_C1(4769) | SPCSC_C0(0));
-	I915_WRITE_FW(SPCSCC8(plane_id), SPCSC_C0(8263));
-
-	I915_WRITE_FW(SPCSCYGICLAMP(plane_id), SPCSC_IMAX(940) | SPCSC_IMIN(64));
-	I915_WRITE_FW(SPCSCCBICLAMP(plane_id), SPCSC_IMAX(448) | SPCSC_IMIN(-448));
-	I915_WRITE_FW(SPCSCCRICLAMP(plane_id), SPCSC_IMAX(448) | SPCSC_IMIN(-448));
+	I915_WRITE_FW(SPCSCC01(plane_id), SPCSC_C1(4096) | SPCSC_C0(5743));
+	I915_WRITE_FW(SPCSCC23(plane_id), SPCSC_C1(-2925) | SPCSC_C0(0));
+	I915_WRITE_FW(SPCSCC45(plane_id), SPCSC_C1(-1410) | SPCSC_C0(4096));
+	I915_WRITE_FW(SPCSCC67(plane_id), SPCSC_C1(4096) | SPCSC_C0(0));
+	I915_WRITE_FW(SPCSCC8(plane_id), SPCSC_C0(7258));
+
+	I915_WRITE_FW(SPCSCYGICLAMP(plane_id), SPCSC_IMAX(1023) | SPCSC_IMIN(0));
+	I915_WRITE_FW(SPCSCCBICLAMP(plane_id), SPCSC_IMAX(512) | SPCSC_IMIN(-512));
+	I915_WRITE_FW(SPCSCCRICLAMP(plane_id), SPCSC_IMAX(512) | SPCSC_IMIN(-512));
 
 	I915_WRITE_FW(SPCSCYGOCLAMP(plane_id), SPCSC_OMAX(1023) | SPCSC_OMIN(0));
 	I915_WRITE_FW(SPCSCCBOCLAMP(plane_id), SPCSC_OMAX(1023) | SPCSC_OMIN(0));
 	I915_WRITE_FW(SPCSCCROCLAMP(plane_id), SPCSC_OMAX(1023) | SPCSC_OMIN(0));
 }
 
+#define SIN_0 0
+#define COS_0 1
+
+static void
+vlv_update_clrc(const struct intel_plane_state *plane_state)
+{
+	struct intel_plane *plane = to_intel_plane(plane_state->base.plane);
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	const struct drm_framebuffer *fb = plane_state->base.fb;
+	enum pipe pipe = plane->pipe;
+	enum plane_id plane_id = plane->id;
+	int contrast, brightness, sh_scale, sh_sin, sh_cos;
+
+	if (format_is_yuv(fb->format->format)) {
+		/*
+		 * Expand limited range to full range:
+		 * Contrast is applied first and is used to expand Y range.
+		 * Brightness is applied second and is used to remove the
+		 * offset from Y. Saturation/hue is used to expand CbCr range.
+		 */
+		contrast = DIV_ROUND_CLOSEST(255 << 6, 235 - 16);
+		brightness = -DIV_ROUND_CLOSEST(16 * 255, 235 - 16);
+		sh_scale = DIV_ROUND_CLOSEST(128 << 7, 240 - 128);
+		sh_sin = SIN_0 * sh_scale;
+		sh_cos = COS_0 * sh_scale;
+	} else {
+		/* Pass-through everything. */
+		contrast = 1 << 6;
+		brightness = 0;
+		sh_scale = 1 << 7;
+		sh_sin = SIN_0 * sh_scale;
+		sh_cos = COS_0 * sh_scale;
+	}
+
+	/* FIXME these register are single buffered :( */
+	I915_WRITE_FW(SPCLRC0(pipe, plane_id),
+		      SP_CONTRAST(contrast) | SP_BRIGHTNESS(brightness));
+	I915_WRITE_FW(SPCLRC1(pipe, plane_id),
+		      SP_SH_SIN(sh_sin) | SP_SH_COS(sh_cos));
+}
+
 static u32 vlv_sprite_ctl(const struct intel_crtc_state *crtc_state,
 			  const struct intel_plane_state *plane_state)
 {
@@ -476,8 +519,10 @@ vlv_update_plane(struct intel_plane *pla
 
 	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
+	vlv_update_clrc(plane_state);
+
 	if (IS_CHERRYVIEW(dev_priv) && pipe == PIPE_B)
-		chv_update_csc(plane, fb->format->format);
+		chv_update_csc(plane_state);
 
 	if (key->flags) {
 		I915_WRITE_FW(SPKEYMINVAL(pipe, plane_id), key->min_value);
