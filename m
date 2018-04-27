Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpzEbcp3uiQ7VRj+dfy56z2Z75vly984LuQ9CNd/G1E4PywL14pclaqFLRHk3E6ocXZ+dfa
ARC-Seal: i=1; a=rsa-sha256; t=1524837801; cv=none;
        d=google.com; s=arc-20160816;
        b=VPzqM3CkELHmF6Q4XlqeFk+LeuJEsI9p5wBup79x0wyk1BdnGkuFCTBhRv/79+AhHQ
         jwQySlA/9pYOkAgkkSTfU/uYZpq3xsIzx420wLScrCTp45kGr66tPX7dav250JBSxVKP
         RIt/kvFAZE/0hAxNHW6U3hwuAwXC8uaYEafrEblkCwaBTv7xZYESmPHglfnK/5dYn8ij
         gLfw8KXZM5Giaw3LrmXgcjEA9OlXAfiSoHVvAz6c/RVeaYvgf5Fryfz5ZJYpJZ6Z9mSi
         fTa7WcBUyvegINy3GA2xFx+RMXiC2vVBYNEuarIxI7gMpZXIQ4QbEu1Otj+3BVElUPgJ
         rGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xPklQwIDHrdvTNFM/xYeVAbNgblpywQ3XkWGPN0Tpg4=;
        b=Qxoa1Vr/Li7oljXtLivK/VvLbTcUkfq5WI4neQlCgOh8mqJezyKK+8hjNI9CSH8RAv
         ITIXzLKwvplQmSOWPAUvrVk+ngfcdiSRAE5IKxGFad+fiYUaIxuVtr1EyzzeE8PMDcPb
         CSuyqdPQlpXmOmFhNxbppmcYoKspnSk7y/swnUzRb13F9TsLj0BJFVcXhboA4OhKqJ8O
         ROXLRjFH1JZiPS6b2itulaYeuOjWsg6usRwxOw7JIC1ao2En9QPEI/sQYEVgjDZ+Nd8D
         lghQI0J8D1fOwzF32RQURVmW+GBMQWwiS3wYufuIYzaUVXApUQ5Dbl+6wgMh5N1QzOjy
         ONsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA50218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.9 22/74] drm/i915/bxt, glk: Increase PCODE timeouts during CDCLK freq changing
Date: Fri, 27 Apr 2018 15:58:12 +0200
Message-Id: <20180427135710.815787579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908322890592201?=
X-GMAIL-MSGID: =?utf-8?q?1598908322890592201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org> # v4.9
Acked-by: Chris Wilson <chris@chris-wilson.co.uk> (v1)
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103326
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180130142939.17983-1-imre.deak@intel.com
(cherry picked from commit e76019a81921e87a4d9e7b3d86102bc708a6c227)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(Rebased for v4.9 stable tree due to upstream intel_cdclk.c, cdclk_state and pcu_lock change)
Signed-off-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_drv.h      |    6 +++++-
 drivers/gpu/drm/i915/intel_display.c |    9 +++++----
 drivers/gpu/drm/i915/intel_pm.c      |    6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -3681,7 +3681,11 @@ extern void intel_display_print_error_st
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
 
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -6012,8 +6012,8 @@ static void bxt_set_cdclk(struct drm_i91
 
 	/* Inform power controller of upcoming frequency change */
 	mutex_lock(&dev_priv->rps.hw_lock);
-	ret = sandybridge_pcode_write(dev_priv, HSW_PCODE_DE_WRITE_FREQ_REQ,
-				      0x80000000);
+	ret = sandybridge_pcode_write_timeout(dev_priv, HSW_PCODE_DE_WRITE_FREQ_REQ,
+					      0x80000000, 2000);
 	mutex_unlock(&dev_priv->rps.hw_lock);
 
 	if (ret) {
@@ -6044,8 +6044,9 @@ static void bxt_set_cdclk(struct drm_i91
 	I915_WRITE(CDCLK_CTL, val);
 
 	mutex_lock(&dev_priv->rps.hw_lock);
-	ret = sandybridge_pcode_write(dev_priv, HSW_PCODE_DE_WRITE_FREQ_REQ,
-				      DIV_ROUND_UP(cdclk, 25000));
+	ret = sandybridge_pcode_write_timeout(dev_priv,
+					      HSW_PCODE_DE_WRITE_FREQ_REQ,
+					      DIV_ROUND_UP(cdclk, 25000), 2000);
 	mutex_unlock(&dev_priv->rps.hw_lock);
 
 	if (ret) {
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -7913,8 +7913,8 @@ int sandybridge_pcode_read(struct drm_i9
 	return 0;
 }
 
-int sandybridge_pcode_write(struct drm_i915_private *dev_priv,
-			    u32 mbox, u32 val)
+int sandybridge_pcode_write_timeout(struct drm_i915_private *dev_priv,
+				    u32 mbox, u32 val, int timeout_us)
 {
 	int status;
 
@@ -7935,7 +7935,7 @@ int sandybridge_pcode_write(struct drm_i
 
 	if (intel_wait_for_register_fw(dev_priv,
 				       GEN6_PCODE_MAILBOX, GEN6_PCODE_READY, 0,
-				       500)) {
+				       timeout_us)) {
 		DRM_ERROR("timeout waiting for pcode write (%d) to finish\n", mbox);
 		return -ETIMEDOUT;
 	}
