Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoIa88hVPDdknLWn3c9dgJ3Unu91svPNqPirjYVapGfQPrRKJM5y3N34Cnhpkn7hj+q11g/
ARC-Seal: i=1; a=rsa-sha256; t=1526281175; cv=none;
        d=google.com; s=arc-20160816;
        b=Q+yRCj9aF/I9/Lnc88Z0XQvTw8+V95/azpJJMZ9o2GhRmJ3a4PGajd8N+BjxzTFhFo
         BHLNagksk5zF1VMfhr3KLtxvRuDA9myU6nrpeDjnDKFi+wSBc/O8TF9jqOqau07iQf0a
         hV/3dr6+SQZDkbJwj72RzHBEK+77tx00u4GrrbPcSBVJU+bankYFsG4llpjHRvGMbVyj
         ubAZ4bcOJ9HJK2azMd4rqF2hVQJDEJDAlgEZVDJuUWz2p5QbvIMw9ydIWjyJM7SAilLK
         FO+7ZZhhV+u90tbUPaTtCsRGfUBIL1I3JYevyGT0AP+h5GmBWv4eK26nMo0onaYkWwfQ
         pmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=8VEGeX9xyfDTXy9WlT8ef209rP8Qb2BUSY9k1NkESAA=;
        b=yQIGgnv/0Pv8pFZI3QD6C75tgka56As0fNnmVIf1uY2OU49RaqySZTPwQz76+PeUHf
         yfZogwOXhjHgO2WJWNtLxwBR9wjAqIqhPNT/+DOdBxHUJuJKkn8IZRlrPTVxBb5rbfn0
         XvbWb1Vbc+cL6H76bwHQOFtDulWdiF2v3Lltu9GkwhMBOpGU/nkZV2u2XvSRblL3PozL
         6F3ESmMcXlYIQ08OBceUVKNHfEOaKY7rWJfM5Z1ahgIKx7CcXbtmZq2T6Yw3hk2c3SUS
         Oi7ueVCGbWtXWlS08WYUSh9HmqYp+uuR8nEPhEgWprIUICEwiy4XXKDLogsgP8cYhTcx
         Lkuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zHC9fUDF;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zHC9fUDF;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 45/72] drm/i915: Adjust eDPs logical vco in a reliable place.
Date: Mon, 14 May 2018 08:49:02 +0200
Message-Id: <20180514064825.108511394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421810433517549?=
X-GMAIL-MSGID: =?utf-8?q?1600421810433517549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

commit 9d219554d9bf59875b4e571a0392d620e8954879 upstream.

On intel_dp_compute_config() we were calculating the needed vco
for eDP on gen9 and we stashing it in
intel_atomic_state.cdclk.logical.vco

However few moments later on intel_modeset_checks() we fully
replace entire intel_atomic_state.cdclk.logical with
dev_priv->cdclk.logical fully overwriting the logical desired
vco for eDP on gen9.

So, with wrong VCO value we end up with wrong desired cdclk, but
also it will raise a lot of WARNs: On gen9, when we read
CDCLK_CTL to verify if we configured properly the desired
frequency the CD Frequency Select bits [27:26] == 10b can mean
337.5 or 308.57 MHz depending on the VCO. So if we have wrong
VCO value stashed we will believe the frequency selection didn't
stick and start to raise WARNs of cdclk mismatch.

[   42.857519] [drm:intel_dump_cdclk_state [i915]] Changing CDCLK to 308571 kHz, VCO 8640000 kHz, ref 24000 kHz, bypass 24000 kHz, voltage level 0
[   42.897269] cdclk state doesn't match!
[   42.901052] WARNING: CPU: 5 PID: 1116 at drivers/gpu/drm/i915/intel_cdclk.c:2084 intel_set_cdclk+0x5d/0x110 [i915]
[   42.938004] RIP: 0010:intel_set_cdclk+0x5d/0x110 [i915]
[   43.155253] WARNING: CPU: 5 PID: 1116 at drivers/gpu/drm/i915/intel_cdclk.c:2084 intel_set_cdclk+0x5d/0x110 [i915]
[   43.170277] [drm:intel_dump_cdclk_state [i915]] [hw state] 337500 kHz, VCO 8100000 kHz, ref 24000 kHz, bypass 24000 kHz, voltage level 0
[   43.182566] [drm:intel_dump_cdclk_state [i915]] [sw state] 308571 kHz, VCO 8640000 kHz, ref 24000 kHz, bypass 24000 kHz, voltage level 0

v2: Move the entire eDP's vco logical adjustment to inside
    the skl_modeset_calc_cdclk as suggested by Ville.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Fixes: bb0f4aab0e76 ("drm/i915: Track full cdclk state for the logical and actual cdclk frequencies")
Cc: <stable@vger.kernel.org> # v4.12+
Link: https://patchwork.freedesktop.org/patch/msgid/20180502175255.5344-1-rodrigo.vivi@intel.com
(cherry picked from commit 3297234a05ab1e90091b0574db4c397ef0e90d5f)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_cdclk.c |   41 +++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/i915/intel_dp.c    |   20 ------------------
 2 files changed, 37 insertions(+), 24 deletions(-)

--- a/drivers/gpu/drm/i915/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/intel_cdclk.c
@@ -2108,9 +2108,44 @@ static int bdw_modeset_calc_cdclk(struct
 	return 0;
 }
 
+static int skl_dpll0_vco(struct intel_atomic_state *intel_state)
+{
+	struct drm_i915_private *dev_priv = to_i915(intel_state->base.dev);
+	struct intel_crtc *crtc;
+	struct intel_crtc_state *crtc_state;
+	int vco, i;
+
+	vco = intel_state->cdclk.logical.vco;
+	if (!vco)
+		vco = dev_priv->skl_preferred_vco_freq;
+
+	for_each_new_intel_crtc_in_state(intel_state, crtc, crtc_state, i) {
+		if (!crtc_state->base.enable)
+			continue;
+
+		if (!intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP))
+			continue;
+
+		/*
+		 * DPLL0 VCO may need to be adjusted to get the correct
+		 * clock for eDP. This will affect cdclk as well.
+		 */
+		switch (crtc_state->port_clock / 2) {
+		case 108000:
+		case 216000:
+			vco = 8640000;
+			break;
+		default:
+			vco = 8100000;
+			break;
+		}
+	}
+
+	return vco;
+}
+
 static int skl_modeset_calc_cdclk(struct drm_atomic_state *state)
 {
-	struct drm_i915_private *dev_priv = to_i915(state->dev);
 	struct intel_atomic_state *intel_state = to_intel_atomic_state(state);
 	int min_cdclk, cdclk, vco;
 
@@ -2118,9 +2153,7 @@ static int skl_modeset_calc_cdclk(struct
 	if (min_cdclk < 0)
 		return min_cdclk;
 
-	vco = intel_state->cdclk.logical.vco;
-	if (!vco)
-		vco = dev_priv->skl_preferred_vco_freq;
+	vco = skl_dpll0_vco(intel_state);
 
 	/*
 	 * FIXME should also account for plane ratio
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -1794,26 +1794,6 @@ found:
 				reduce_m_n);
 	}
 
-	/*
-	 * DPLL0 VCO may need to be adjusted to get the correct
-	 * clock for eDP. This will affect cdclk as well.
-	 */
-	if (intel_dp_is_edp(intel_dp) && IS_GEN9_BC(dev_priv)) {
-		int vco;
-
-		switch (pipe_config->port_clock / 2) {
-		case 108000:
-		case 216000:
-			vco = 8640000;
-			break;
-		default:
-			vco = 8100000;
-			break;
-		}
-
-		to_intel_atomic_state(pipe_config->base.state)->cdclk.logical.vco = vco;
-	}
-
 	if (!HAS_DDI(dev_priv))
 		intel_dp_set_clock(encoder, pipe_config);
 
