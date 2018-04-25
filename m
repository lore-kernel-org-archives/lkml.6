Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZoePNy8vJ6opW13r4AdX6v5ST52oXMuRW5W6Z/I7pNxKDaHo03IxSzeYlTeSbnmCFxULeIY
ARC-Seal: i=1; a=rsa-sha256; t=1524652625; cv=none;
        d=google.com; s=arc-20160816;
        b=SRh22hcupoLyPv2lTPqnhPuGcxKAIm88XLQRmY2DS/J2dIlHZAWdv6gMk3bzKB0JRf
         f4nVtgRP+2nNi7/clJbyH81pJqcJTjkC+cY+IhNK8bjSlPJG5TZ3JBYe1V0Hsc9orCjo
         CbhrsHXQyZXpkyJzVoyrP4Xa5lqGhswsOFzz8Qq1xlvb+d5l5nFtgsPPYXlRViz10m+7
         FxxQ4wD+FhGlvAsib8BosZOfPmYFVeR+eGJTTIcc9v0M5ArL/mGeVmwLjLebNWGYziK+
         dQoJufWoOjW6voltSPvOYOOOBY92YAINUnPHt5xEwix1WncZhwxShH3rLdxoC+h2JnsS
         2pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w7ScVZXf6DidPQLzt0JOpJqaZRBlYo0IV4eP2tO4X94=;
        b=zdYsQ5889q4qmdNueKVzFqGircGa4thj+kAPoytExQs1vkAwIznMWRl4g83gLUb81Z
         20c0aoIhXSFg0sSsvH21YFvlSrETRhqcaKtqljwkcRmNHvn5bQOSn4hoJ3SWP19jFpKZ
         JpYpS5ZnGhD+8H69WSbJKuZSkCT8BD661ccR7sCXKbKJCBqmqWsJWkRqAW61cbZ91E/x
         1abDUkk25Q9MZ/555GgBAfEqHQiLXgAT4RbtujE705oH/x+KLnMPH+/0qKy8BBnSCrrD
         +nwkx+Qqdnjfctfn70P33NqH56h9WCuXzS0FbYNvncp5gswTIebIgvWuhiXBvU1LzYuI
         Nfog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Clinton Taylor <clinton.a.taylor@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.14 010/183] drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state
Date: Wed, 25 Apr 2018 12:33:50 +0200
Message-Id: <20180425103243.024256751@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598713965492793611?=
X-GMAIL-MSGID: =?utf-8?q?1598714151155832910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit 7eb2c4dd54ff841f2fe509a84973eb25fa20bda2 upstream.

LSPCON adapters in low-power state may ignore the first I2C write during
TMDS output buffer enabling, resulting in a blank screen even with an
otherwise enabled pipe. Fix this by reading back and validating the
written value a few times.

The problem was noticed on GLK machines with an onboard LSPCON adapter
after entering/exiting DC5 power state. Doing an I2C read of the adapter
ID as the first transaction - instead of the I2C write to enable the
TMDS buffers - returns the correct value. Based on this we assume that
the transaction itself is sent properly, it's only the adapter that is
not ready for some reason to accept this first write after waking from
low-power state. In my case the second I2C write attempt always
succeeded.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105854
Cc: Clinton Taylor <clinton.a.taylor@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180416155309.11100-1-imre.deak@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_dp_dual_mode_helper.c |   39 ++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
@@ -350,19 +350,44 @@ int drm_dp_dual_mode_set_tmds_output(enu
 {
 	uint8_t tmds_oen = enable ? 0 : DP_DUAL_MODE_TMDS_DISABLE;
 	ssize_t ret;
+	int retry;
 
 	if (type < DRM_DP_DUAL_MODE_TYPE2_DVI)
 		return 0;
 
-	ret = drm_dp_dual_mode_write(adapter, DP_DUAL_MODE_TMDS_OEN,
-				     &tmds_oen, sizeof(tmds_oen));
-	if (ret) {
-		DRM_DEBUG_KMS("Failed to %s TMDS output buffers\n",
-			      enable ? "enable" : "disable");
-		return ret;
+	/*
+	 * LSPCON adapters in low-power state may ignore the first write, so
+	 * read back and verify the written value a few times.
+	 */
+	for (retry = 0; retry < 3; retry++) {
+		uint8_t tmp;
+
+		ret = drm_dp_dual_mode_write(adapter, DP_DUAL_MODE_TMDS_OEN,
+					     &tmds_oen, sizeof(tmds_oen));
+		if (ret) {
+			DRM_DEBUG_KMS("Failed to %s TMDS output buffers (%d attempts)\n",
+				      enable ? "enable" : "disable",
+				      retry + 1);
+			return ret;
+		}
+
+		ret = drm_dp_dual_mode_read(adapter, DP_DUAL_MODE_TMDS_OEN,
+					    &tmp, sizeof(tmp));
+		if (ret) {
+			DRM_DEBUG_KMS("I2C read failed during TMDS output buffer %s (%d attempts)\n",
+				      enable ? "enabling" : "disabling",
+				      retry + 1);
+			return ret;
+		}
+
+		if (tmp == tmds_oen)
+			return 0;
 	}
 
-	return 0;
+	DRM_DEBUG_KMS("I2C write value mismatch during TMDS output buffer %s\n",
+		      enable ? "enabling" : "disabling");
+
+	return -EIO;
 }
 EXPORT_SYMBOL(drm_dp_dual_mode_set_tmds_output);
 
