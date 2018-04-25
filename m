Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49QV3nZlPNetfwaprKsSD/IutzszHB6IWULTsK9grWpVPyd/32k9S/HUy0TrmQBj5fxnAMB
ARC-Seal: i=1; a=rsa-sha256; t=1524652447; cv=none;
        d=google.com; s=arc-20160816;
        b=WVhKwJvsbt+1OD1McdqALGMlJhpp6LxmMkHooid77jGrp8baCIFE9Da2c9GZ/MjYIC
         KMb45WJWsVuLSbZmRLLPDIcYfKzftO3d+4qyrpFKkktJ8rYikHFHNy5SPcCRzZmNjoSy
         SmHB3divQ9McLfUAEZWitHjbSYsd6xtF/3zbIlBzAu/w01IAUF2PHhjeGVfg8UUCXKSh
         oLzQ05TErXr5eGNuAdrems/+KZMgCu28Lb++KmR1xeeLsZ3E8Quo7l9Ig//7nOn7rhk6
         9h2Qv+Jb3xWoNi88FUlXu1B/n4viXD+WkBANhWWA77qnSGQWuuPIrzYgWJ5LdYGP693U
         rLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=70u3bU3QuJ0tt3IJRgMN+AHf3JxUG8yow7CRqGi+1eo=;
        b=mPTHPIskkY/qAbauYOHO6+f4Gl/dmCe3LmnfDKPfUAoRm5nHwj6hz7kfCHXj2yk6BR
         Wm2s945uK4D7OD0sMV4YX5tQ+VMXbThddhg04olAn8J61Iph1zElV59abo6OJjJrLs4/
         Qe8fR0izKKb+nccWdj9VNjYCTdTMQJJmg2Y2c71NoZn8Rjat/vl9+AIt4GLTTn+Ljm1O
         azFKkgNvMxn20aiVl4mN6A5+mdiAgHHlWoHoj5MkqTXNPA5SZ7n7RwYzGhGGUvV4n8W5
         KfOENx69lUBrC3W+01f2d4xgeS7j+i/fHgxXfNJh/RUJMIK8V+3cRBs0rmmCx+pxAhCX
         HE8w==
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
Subject: [PATCH 4.16 15/26] drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state
Date: Wed, 25 Apr 2018 12:33:24 +0200
Message-Id: <20180425103315.455304110@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598713965492793611?=
X-GMAIL-MSGID: =?utf-8?q?1598713965492793611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
