Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/gvK6F7hmlFlByu9N4fAk/DmLIJgRUoK6pva+Au7U+ZrfNPCKlOYI1M8zCtv+kqrRMrA9r
ARC-Seal: i=1; a=rsa-sha256; t=1524652628; cv=none;
        d=google.com; s=arc-20160816;
        b=y0KbBIBPj9svd4Gbcrb7EK+8nN4PJgbWyopw7SqpjHL3vRwuAySOxM/JuUqoJVwZYB
         3YR++mayifBlTXrll9sEXhOhzi0JwmwgIBvpmic2Q4GtArKGUtU0Ruuzd3Yfps61jA+v
         yYwWE/hLNy2ynPuFqA7Z6iXc7VMhQ18/zV336BenYqkyTsWYV9i0/QpAggQ68e50hcSh
         QepK5AGmb7OKW+r1m2BCBgtF92rFOSCWhavV9fYWE/IobMILG9nHFnc0q6nYpWDKD2W5
         gRKDR+/06ritNTPAB16OXFzuV43QPQ71FxOU6U5xdrIhXcpTB2yJ7dvUzjjTxgt68AFu
         K57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7b3jqnffnNjnZ933BFpfZlLIHjuIXSYS6NypEu07OLw=;
        b=Iw5lLJWm1lGkfqTRXY4DVUnfbrmPJT0N32dG6rOYMI6yj+BYsBOPqMBlq8e51g9f3U
         Mr8MTLA2Z5DFggMe+MLqBvIvWVKKk1ozyUvWCKdXxMM/45xuP969VFzkUR422Lvkd+h6
         MfY07rMthGbA/iIVNIXZzHOJO/TwHTzpGY87AXYFQL7xd4OyddEoyOhxpztTe9XpYxlp
         h4Beh30dLxyeKLNoGynYCa+TjQebM4mo1HQazOaf+auCXl06/O5DU7WPVGPbkiPHbs7s
         hOWVyPj8JZ4mkEN8CyM9MpxPQP/Ccvklm6WblQq5wI02IrSnkMjmHeyTM4YbjgR8XS6s
         HS9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.14 011/183] drm/i915/bxt, glk: Increase PCODE timeouts during CDCLK freq changing
Date: Wed, 25 Apr 2018 12:33:51 +0200
Message-Id: <20180425103243.069772056@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714154514105089?=
X-GMAIL-MSGID: =?utf-8?q?1598714154514105089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit 5e1df40f40ee45a97bb1066c3d71f0ae920a9672 upstream.

Currently we see sporadic timeouts during CDCLK changing both on BXT and
GLK as reported by the Bugzilla: ticket. It's easy to reproduce this by
changing the frequency in a tight loop after blanking the display. The
upper bound for the completion time is 800us based on my tests, so
increase it from the current 500us to 2ms; with that I couldn't trigger
the problem either on BXT or GLK.

Note that timeouts happened during both the change notification and the
voltage level setting PCODE request. (For the latter one BSpec doesn't
require us to wait for completion before further HW programming.)

This issue is similar to
commit 2c7d0602c815 ("drm/i915/gen9: Fix PCODE polling during CDCLK
change notification")
but there the PCODE request does complete (as shown by the mbox
busy flag), only the reply we get from PCODE indicates a failure.
So there we keep resending the request until a success reply, here we
just have to increase the timeout for the one PCODE request we send.

v2:
- s/snb_pcode_request/sandybridge_pcode_write_timeout/ (Ville)

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.4+
Acked-by: Chris Wilson <chris@chris-wilson.co.uk> (v1)
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103326
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180130142939.17983-1-imre.deak@intel.com
(cherry picked from commit e76019a81921e87a4d9e7b3d86102bc708a6c227)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(Rebased for v4.14 stable tree due to upstream cdclk_state and pcu_lock change)
Signed-off-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_drv.h    |    6 +++++-
 drivers/gpu/drm/i915/intel_cdclk.c |   22 +++++++++++++++++-----
 drivers/gpu/drm/i915/intel_pm.c    |    6 +++---
 3 files changed, 25 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -3995,7 +3995,11 @@ extern void intel_display_print_error_st
 					    struct intel_display_error_state *error);
 
 int sandybridge_pcode_read(struct drm_i915_private *dev_priv, u32 mbox, u32 *val);
-int sandybridge_pcode_write(struct drm_i915_private *dev_priv, u32 mbox, u32 val);
+int sandybridge_pcode_write_timeout(struct drm_i915_private *dev_priv, u32 mbox,
+				    u32 val, int timeout_us);
+#define sandybridge_pcode_write(dev_priv, mbox, val)	\
+	sandybridge_pcode_write_timeout(dev_priv, mbox, val, 500)
+
 int skl_pcode_request(struct drm_i915_private *dev_priv, u32 mbox, u32 request,
 		      u32 reply_mask, u32 reply, int timeout_base_ms);
 
--- a/drivers/gpu/drm/i915/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/intel_cdclk.c
@@ -1289,10 +1289,15 @@ static void bxt_set_cdclk(struct drm_i91
 		break;
 	}
 
-	/* Inform power controller of upcoming frequency change */
 	mutex_lock(&dev_priv->rps.hw_lock);
-	ret = sandybridge_pcode_write(dev_priv, HSW_PCODE_DE_WRITE_FREQ_REQ,
-				      0x80000000);
+	/*
+	 * Inform power controller of upcoming frequency change. BSpec
+	 * requires us to wait up to 150usec, but that leads to timeouts;
+	 * the 2ms used here is based on experiment.
+	 */
+	ret = sandybridge_pcode_write_timeout(dev_priv,
+					      HSW_PCODE_DE_WRITE_FREQ_REQ,
+					      0x80000000, 2000);
 	mutex_unlock(&dev_priv->rps.hw_lock);
 
 	if (ret) {
@@ -1323,8 +1328,15 @@ static void bxt_set_cdclk(struct drm_i91
 	I915_WRITE(CDCLK_CTL, val);
 
 	mutex_lock(&dev_priv->rps.hw_lock);
-	ret = sandybridge_pcode_write(dev_priv, HSW_PCODE_DE_WRITE_FREQ_REQ,
-				      DIV_ROUND_UP(cdclk, 25000));
+	/*
+	 * The timeout isn't specified, the 2ms used here is based on
+	 * experiment.
+	 * FIXME: Waiting for the request completion could be delayed until
+	 * the next PCODE request based on BSpec.
+	 */
+	ret = sandybridge_pcode_write_timeout(dev_priv,
+					      HSW_PCODE_DE_WRITE_FREQ_REQ,
+					      DIV_ROUND_UP(cdclk, 25000), 2000);
 	mutex_unlock(&dev_priv->rps.hw_lock);
 
 	if (ret) {
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -8941,8 +8941,8 @@ int sandybridge_pcode_read(struct drm_i9
 	return 0;
 }
 
-int sandybridge_pcode_write(struct drm_i915_private *dev_priv,
-			    u32 mbox, u32 val)
+int sandybridge_pcode_write_timeout(struct drm_i915_private *dev_priv,
+				    u32 mbox, u32 val, int timeout_us)
 {
 	int status;
 
@@ -8965,7 +8965,7 @@ int sandybridge_pcode_write(struct drm_i
 
 	if (__intel_wait_for_register_fw(dev_priv,
 					 GEN6_PCODE_MAILBOX, GEN6_PCODE_READY, 0,
-					 500, 0, NULL)) {
+					 timeout_us, 0, NULL)) {
 		DRM_ERROR("timeout waiting for pcode write of 0x%08x to mbox %x to finish for %ps\n",
 			  val, mbox, __builtin_return_address(0));
 		return -ETIMEDOUT;
