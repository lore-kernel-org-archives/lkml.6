Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48wZDtxHkjMnCCUMwffxM7xVm3k0v40iXKoyKNVvwVhCJ+2t/MMYf1QS80YcN7pSjSEC8LU
ARC-Seal: i=1; a=rsa-sha256; t=1524405756; cv=none;
        d=google.com; s=arc-20160816;
        b=cKDGs289EbtHa0vEMVp8ZJyTYw7sTZ4kkXdo/OfpOc1DVHRLLHIOFqK4WCfZgns41E
         U+9K08RxtoVzh2Lw0sKNlAukl0iGsnq0gmZ8n7dPDRm7PMXpGiPBCUaEhYYM5xFtKkbU
         cTnVWn53hpsDg+F3wlne0a3FTnc3GKuCf97c+ach30FKily5vtnuHuk2l/V/8nMUOMH4
         qRIc/SvAvfBMJ5DXbYE5vfIgiD4oq+FtHac2Z9OVHrajOa8sT7WLJwJNydXP2Yc6+Gh7
         MWYG89eQqdPdvTTQ4kuuPhHWftY9nVvB7PWKmgQLFhL3QOPlxN3mWWEvsO2vjl+KXj9Q
         1ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Khay+P5O36Ke2CsKpH4OI5q0ZtOoKEW6QtmdellJNP0=;
        b=xorM1QEp8iL2VNzIiXgkp8BqnibWqndxn36QWvORXqpniqcjvX6LQxRRDBAKXEwJ+3
         IZsT9Oil0JYLB/JauhQfI2/2FxlYRsFW9RgKMT/wtliNwKxQb0fyGqpa/9b3i/mXnss2
         OGXO87z1Hk1R1HI7KyhX6SUx2x/TEGMrUVHkycReutT5ABpZU4VvFJWwm/q0izXm8VMr
         DQL9YF21F18oHyKJFGFFmJIdbJK1iWgygVlBclLAtYWmkyq3tbulz4OkFUBs1c8FbRUP
         V6KE2zLVnxpTsca2vEvrZRTEv5Ys/PMg6C2E0IyWnvLzYi9mbTmxHtq/qKuiHChBoGSl
         qA9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	amn-bas@hotmail.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 183/196] drm/i915: Fix hibernation with ACPI S0 target state
Date: Sun, 22 Apr 2018 15:53:23 +0200
Message-Id: <20180422135113.713805818@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455290923924834?=
X-GMAIL-MSGID: =?utf-8?q?1598455290923924834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit 300efa9eea451bdcf3b5a1eb292222e06e85bb2c upstream.

After

commit dd9f31c7a3887950cbd0d49eb9d43f7a1518a356
Author: Imre Deak <imre.deak@intel.com>
Date:   Wed Aug 16 17:46:07 2017 +0300

    drm/i915/gen9+: Set same power state before hibernation image
    save/restore

during hibernation/suspend the power domain functionality got disabled,
after which resume could leave it incorrectly disabled if the ACPI
target state was S0 during suspend and i915 was not loaded by the loader
kernel.

This was caused by not considering if we resumed from hibernation as the
condition for power domains reiniting.

Fix this by simply tracking if we suspended power domains during system
suspend and reinit power domains accordingly during resume. This will
result in reiniting power domains always when resuming from hibernation,
regardless of the platform and whether or not i915 is loaded by the
loader kernel.

The reason we didn't catch this earlier is that the enabled/disabled
state of power domains during PMSG_FREEZE/PMSG_QUIESCE is platform
and kernel config dependent: on my SKL the target state is S4
during PMSG_FREEZE and (with the driver loaded in the loader kernel)
S0 during PMSG_QUIESCE. On the reporter's machine it's S0 during
PMSG_FREEZE but (contrary to this) power domains are not initialized
during PMSG_QUIESCE since i915 is not loaded in the loader kernel, or
it's loaded but without the DMC firmware being available.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105196
Reported-and-tested-by: amn-bas@hotmail.com
Fixes: dd9f31c7a388 ("drm/i915/gen9+: Set same power state before hibernation image save/restore")
Cc: amn-bas@hotmail.com
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180322143642.26883-1-imre.deak@intel.com
(cherry picked from commit 0f90603c33bdf6575cfdc81edd53f3f13ba166fb)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_drv.c |   22 ++++++++++------------
 drivers/gpu/drm/i915/i915_drv.h |    2 +-
 2 files changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1599,15 +1599,12 @@ static int i915_drm_suspend_late(struct
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct pci_dev *pdev = dev_priv->drm.pdev;
-	bool fw_csr;
 	int ret;
 
 	disable_rpm_wakeref_asserts(dev_priv);
 
 	intel_display_set_init_power(dev_priv, false);
 
-	fw_csr = !IS_GEN9_LP(dev_priv) && !hibernation &&
-		suspend_to_idle(dev_priv) && dev_priv->csr.dmc_payload;
 	/*
 	 * In case of firmware assisted context save/restore don't manually
 	 * deinit the power domains. This also means the CSR/DMC firmware will
@@ -1615,8 +1612,11 @@ static int i915_drm_suspend_late(struct
 	 * also enable deeper system power states that would be blocked if the
 	 * firmware was inactive.
 	 */
-	if (!fw_csr)
+	if (IS_GEN9_LP(dev_priv) || hibernation || !suspend_to_idle(dev_priv) ||
+	    dev_priv->csr.dmc_payload == NULL) {
 		intel_power_domains_suspend(dev_priv);
+		dev_priv->power_domains_suspended = true;
+	}
 
 	ret = 0;
 	if (IS_GEN9_LP(dev_priv))
@@ -1628,8 +1628,10 @@ static int i915_drm_suspend_late(struct
 
 	if (ret) {
 		DRM_ERROR("Suspend complete failed: %d\n", ret);
-		if (!fw_csr)
+		if (dev_priv->power_domains_suspended) {
 			intel_power_domains_init_hw(dev_priv, true);
+			dev_priv->power_domains_suspended = false;
+		}
 
 		goto out;
 	}
@@ -1650,8 +1652,6 @@ static int i915_drm_suspend_late(struct
 	if (!(hibernation && INTEL_GEN(dev_priv) < 6))
 		pci_set_power_state(pdev, PCI_D3hot);
 
-	dev_priv->suspended_to_idle = suspend_to_idle(dev_priv);
-
 out:
 	enable_rpm_wakeref_asserts(dev_priv);
 
@@ -1818,8 +1818,7 @@ static int i915_drm_resume_early(struct
 	intel_uncore_resume_early(dev_priv);
 
 	if (IS_GEN9_LP(dev_priv)) {
-		if (!dev_priv->suspended_to_idle)
-			gen9_sanitize_dc_state(dev_priv);
+		gen9_sanitize_dc_state(dev_priv);
 		bxt_disable_dc9(dev_priv);
 	} else if (IS_HASWELL(dev_priv) || IS_BROADWELL(dev_priv)) {
 		hsw_disable_pc8(dev_priv);
@@ -1827,8 +1826,7 @@ static int i915_drm_resume_early(struct
 
 	intel_uncore_sanitize(dev_priv);
 
-	if (IS_GEN9_LP(dev_priv) ||
-	    !(dev_priv->suspended_to_idle && dev_priv->csr.dmc_payload))
+	if (dev_priv->power_domains_suspended)
 		intel_power_domains_init_hw(dev_priv, true);
 	else
 		intel_display_set_init_power(dev_priv, true);
@@ -1838,7 +1836,7 @@ static int i915_drm_resume_early(struct
 	enable_rpm_wakeref_asserts(dev_priv);
 
 out:
-	dev_priv->suspended_to_idle = false;
+	dev_priv->power_domains_suspended = false;
 
 	return ret;
 }
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2099,7 +2099,7 @@ struct drm_i915_private {
 	u32 bxt_phy_grc;
 
 	u32 suspend_count;
-	bool suspended_to_idle;
+	bool power_domains_suspended;
 	struct i915_suspend_saved_registers regfile;
 	struct vlv_s0ix_state vlv_s0ix_state;
 
