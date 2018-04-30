Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpDBV8zdl3Z1AI+xgdLBsxaQbCWZ11MiwlMJLdy7/CUoFtAZhmCi9lHduvF+QgfRCTGO0xR
ARC-Seal: i=1; a=rsa-sha256; t=1525116460; cv=none;
        d=google.com; s=arc-20160816;
        b=uh5gjR6aXWo9sli4N92rOqAqKoFW53gnP15hpB4MN/CffrrNoNsWL3nGdy816YQopf
         e61D/5dj5k+fR8Rc+cE9iY4V+E6jL5yCGPP3AHEGEIe3DWmOXZUXrElsrTFKKhH5jrra
         V5OC5IQW2kbFOGsK+px/PeoRYnYs+p6JqYf+7n+dZQFYwCmsd0/cbgxRpZZQ4xcpuXa5
         O5oOfo6jhgG0UBi7UYwoHsvn4ZvqeNqW3yxWKagJ6gSQ/ru4F8cLimh6ESQCr5W7cnAf
         tGmjlkRaB/HOmvFKoIQQWizFWwJ/2Ujey3iR4yJz3ZM9sjq4EdtcnxTBF2C09M+l4SHq
         W0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YYGte99Ab2J7b1ZHzoXTdTqR9XX0aqzjxJgoia2MD4Q=;
        b=zRwhSnzqmvf5RvjILfDMFp6DIktLWKjU7mFoc1bjeKJdbF70+HaL5ZVpVs7GyyPjOY
         klkgt21Yq5xQKL6dDnjQANyHGOXaon9LntNnID0a0WaiZP/eWMaIp7yzI8Tl/19VBBFV
         ysok72+vNYTUxlIiqBLsyfUapfVUsfNM9aMT7k1BrxoNufMJzW2qJ06aCwW3afiTCT+v
         xP2Js3iuVFEF0/rjS/f475U5eY0Ds+ZegkywVvvnQcmF268xI/qny0Ywj7pby6ssFt+Z
         MxKq2UqPvd5OJOvZbt5KA5bzlxp1m6O0dFEUM/vY8TKxJauo4SG5nsrXq28IpH5RSrgT
         Frng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B012322E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Imre Deak <imre.deak@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.14 81/91] drm/i915: Enable display WA#1183 from its correct spot
Date: Mon, 30 Apr 2018 12:25:03 -0700
Message-Id: <20180430184008.521454352@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200517538425005?=
X-GMAIL-MSGID: =?utf-8?q?1599200517538425005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit ac315c621f01d4b8a53dec317c7ae322fd26ff38 upstream.

The DMC FW specific part of display WA#1183 is supposed to be enabled
whenever enabling DC5 or DC6, so move it to the DC6 enable function
from the DC6 disable function.

I noticed this after Daniel's patch to remove the unused
skl_disable_dc6() function.

Fixes: 53421c2fe99c ("drm/i915: Apply Display WA #1183 on skl, kbl, and cfl")
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180419155109.29451-1-imre.deak@intel.com
(cherry picked from commit b49be6622f08187129561cff0409f7b06b33de57)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_runtime_pm.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -622,19 +622,18 @@ void skl_enable_dc6(struct drm_i915_priv
 
 	DRM_DEBUG_KMS("Enabling DC6\n");
 
-	gen9_set_dc_state(dev_priv, DC_STATE_EN_UPTO_DC6);
+	/* Wa Display #1183: skl,kbl,cfl */
+	if (IS_GEN9_BC(dev_priv))
+		I915_WRITE(GEN8_CHICKEN_DCPR_1, I915_READ(GEN8_CHICKEN_DCPR_1) |
+			   SKL_SELECT_ALTERNATE_DC_EXIT);
 
+	gen9_set_dc_state(dev_priv, DC_STATE_EN_UPTO_DC6);
 }
 
 void skl_disable_dc6(struct drm_i915_private *dev_priv)
 {
 	DRM_DEBUG_KMS("Disabling DC6\n");
 
-	/* Wa Display #1183: skl,kbl,cfl */
-	if (IS_GEN9_BC(dev_priv))
-		I915_WRITE(GEN8_CHICKEN_DCPR_1, I915_READ(GEN8_CHICKEN_DCPR_1) |
-			   SKL_SELECT_ALTERNATE_DC_EXIT);
-
 	gen9_set_dc_state(dev_priv, DC_STATE_DISABLE);
 }
 
