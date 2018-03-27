Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Uoogr92mL5qkrZ+CO+yd9jrijzVumFeZ96bauoxhbIky+uS/lbLrve1xpsFPpG4xDSuNY
ARC-Seal: i=1; a=rsa-sha256; t=1522168569; cv=none;
        d=google.com; s=arc-20160816;
        b=kB4SfwIM6dz0fyieePvIg4JUj3gUkHAtsy5egYuVlxKal1rGVmg9UEs9Xenu2AwAt2
         icEvM+o5jZp/C+0mLFr9U3rNRpEcVyd2StW3CV1hVV6VATwHLtrSiy5Axqd/zNDBNLQA
         Wd7Lmxheq/Z904Fn1d9H1uQsd82dSkR5X4TPdgM3c+HY5Vxvqm1TqRbt/bjommaeiqTy
         mlfkP1ak8YTJ13NSGDSxyZOZ2zbWHpe2wQFliH3M13mdqMWv5m1FnZ0H6az9aiFV70J1
         RupnURME29UnqQ4eYH2jCNvDsEn81GEj7m6JzVWQSUYwVrDFmCT2rvhoCanOWrwl0RPw
         ++JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UH2mzza7yuhwk/J9PpTMTPqLfJ1/70N5Y2Xs2av7yv4=;
        b=Nflc1hMuHhBRyDgpUY77obf48/m6gwAvy/32zKizmYfSpP/Q6UIcsq5yvGSFu73Bh4
         XwUsL4CQEW5AmeTIyhaKNXSPrJu1l468UkUGYQT4tYSlrk/x+P7aLrRZxv+ZmmIIXkBD
         VKYcMizt3gsEaf08bdZTrtaVibM75KJ2TKUaDqHDdxUKLNmyU1FD1liWDBuATO9WHSwJ
         7dQSwZ+CjCXAID7JbNntLHs92XPuoE17ZY3DoKWLW8Z5Fl8FVVjuD1TltQmPZTE9QBrS
         awshE9bji2f3MMSXRBpZK7zfmeLASm/9r+mRtH2hacl0fdecMZ1AysrhwPwtoEIH2hBT
         /XZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>
Subject: [PATCH 4.14 055/101] drm/radeon: Dont turn off DP sink when disconnected
Date: Tue, 27 Mar 2018 18:27:27 +0200
Message-Id: <20180327162753.378215973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108997827947853?=
X-GMAIL-MSGID: =?utf-8?q?1596109429914299382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <michel.daenzer@amd.com>

commit 2681bc79eeb640562c932007bfebbbdc55bf6a7d upstream.

Turning off the sink in this case causes various issues, because
userspace expects it to stay on until it turns it off explicitly.

Instead, turn the sink off and back on when a display is connected
again. This dance seems necessary for link training to work correctly.

Bugzilla: https://bugs.freedesktop.org/105308
Cc: stable@vger.kernel.org
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_connectors.c |   29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -90,25 +90,18 @@ void radeon_connector_hotplug(struct drm
 		/* don't do anything if sink is not display port, i.e.,
 		 * passive dp->(dvi|hdmi) adaptor
 		 */
-		if (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT) {
-			int saved_dpms = connector->dpms;
-			/* Only turn off the display if it's physically disconnected */
-			if (!radeon_hpd_sense(rdev, radeon_connector->hpd.hpd)) {
-				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
-			} else if (radeon_dp_needs_link_train(radeon_connector)) {
-				/* Don't try to start link training before we
-				 * have the dpcd */
-				if (!radeon_dp_getdpcd(radeon_connector))
-					return;
+		if (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT &&
+		    radeon_hpd_sense(rdev, radeon_connector->hpd.hpd) &&
+		    radeon_dp_needs_link_train(radeon_connector)) {
+			/* Don't start link training before we have the DPCD */
+			if (!radeon_dp_getdpcd(radeon_connector))
+				return;
 
-				/* set it to OFF so that drm_helper_connector_dpms()
-				 * won't return immediately since the current state
-				 * is ON at this point.
-				 */
-				connector->dpms = DRM_MODE_DPMS_OFF;
-				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
-			}
-			connector->dpms = saved_dpms;
+			/* Turn the connector off and back on immediately, which
+			 * will trigger link training
+			 */
+			drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
+			drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
 		}
 	}
 }
