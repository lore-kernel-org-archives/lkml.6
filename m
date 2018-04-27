Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZryvJAVD1KU/y4nxQq2Ggun2iHXvhQHQti3DBYc0rkpZxpO9QkJmpyBawoqZ81sw5DqMcRI
ARC-Seal: i=1; a=rsa-sha256; t=1524837780; cv=none;
        d=google.com; s=arc-20160816;
        b=fYltU/pGr9Tw2N8+UG8zVc07BMqnChWVzw7m8waO8rzfTi12+fMJMxTUqufjwdFiFh
         ++Lx9N8u6dCl2lW4L3pue1BBztK8DKgYbx0L2DAwauBnmVS3N5COB3hQ22gUjluY9cgY
         mDVxuZa8Qr+KP4OQ3ObQ6lJJ5Bj4ji3KUnzhe1/RJVTQEhUcCFIbINarFiYmk2ySFRYR
         gSvZW1xgFLLY1OSK5PnbUk/JkCXimz5Yb21fh/JF8PmpUzeCEBZyZEmpTFp+EL2eHsHC
         o3pT3oLizstn1ZgJK4zTzyFg/ctfzDktRsUojTZLWlqMgd9etKJlN9YwKneq72sbxgqC
         MSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ZQPtcy4zMn+MYhYt4WBWUEEvlXSMwyq62UPF+YPeD3Y=;
        b=GDCkgu6FTU2Pv5J1znh0fLXmvrsHzMCYGhvN/7CZ4xq3ifRN8PvudyH+psHe1DBIpP
         vy/y3rEMW3ZMdnezrO5viVysdW1RZ52hNihk1B6wvNQvt0CCTXLjiRRHeZjimyPauYw3
         pKPPpMJ6aPi0GOQrLqcVsos1uso/OhImBfJfDpyHqPIfhVOrUzjfax/ZerP+OJQshUea
         Q4aHrkv5EoxnHfuIzTUnNna6Zuo8QOyN9KruFkRmWM3aUibH3Qd0GbMr4QJcQVqN4qSg
         QN/yHC9SgVq8CAMTeRpSShI0/aXIUW1Sry5ukvxQqZ9IKGd7rwhAy1bl9yAR78MmoDuh
         5oPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB8B21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Clinton Taylor <clinton.a.taylor@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.9 04/74] drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state
Date: Fri, 27 Apr 2018 15:57:54 +0200
Message-Id: <20180427135710.078316161@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908300592414118?=
X-GMAIL-MSGID: =?utf-8?q?1598908300592414118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -322,19 +322,44 @@ int drm_dp_dual_mode_set_tmds_output(enu
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
 
