Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49opHejLxLDpjwG1MeD2yHhtARJUbVwEuX85Z7jjuSlZ76CG7kXCSnPoBL9dOv/YIaCs5QR
ARC-Seal: i=1; a=rsa-sha256; t=1522168299; cv=none;
        d=google.com; s=arc-20160816;
        b=RMpcNpwby3DeABSzNx8qAp+LBSea8foRTkYQu5YQTObm4dabtEFB1DxWQEOPx9YZqE
         lMPkEmlGw0Y5zk1Nv5/8EnkMfX/Pqg5uarGNB4xFJ/GQvY9ZDaBcDnV/n5j41sNV2LXA
         1vKJne6xZIkqjOVlAmL4lmhrkZxw4jAkLkoLLSIBbBIzZGWv8VtbrxhId3CI7yiY6E6h
         tJB37LWt8AgToTbjHuJUNF3l6w3fqmaQRG1i4FOm461BW6BMraLD0GGmK+hXnPpgR4pV
         EEQpO7SJol5kF+6fiQPAD1i/JINQ1Dxm8GgTbmEH6ZS8+coe8K8qZEmvvn2PH2ZlbjNL
         UENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CHhvBSVvqdnC1ogPHFic6mUh6+M7JM6JHJC5wrjQg9U=;
        b=s0be57DjnU07GM/AaDCqQOG9MpM1t6LVe6AUNtv3/XdfV3I36QHjBSXIXLI4KBrBA4
         p0iK8GPNiK2U2S9lH/ZXAaGh4d8iHm/si9G6b3FY+Ex2em15NEmCCL+D0B0kB6N6Yllq
         dH8TD1dpNe4EQglbawsPq2V9H0VjNq68Bv0St255GEVSgJJ6d8PUxykzbVSjSVLqo122
         4yOFTZWU1bBbEH/0H44FE5YtC3Nm2Ha+BPOVQaub0HlU7nVaCbgp9W7xKnJeHnUN88r6
         v2y3rNTfU4uqabEWXSQZPDQ/HpLG+r85VO1A8bHzPG9l30x9xdoaowOBE1CqAawwxJlU
         TW5w==
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
Subject: [PATCH 4.9 30/67] drm/radeon: Dont turn off DP sink when disconnected
Date: Tue, 27 Mar 2018 18:27:22 +0200
Message-Id: <20180327162728.664435754@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108997827947853?=
X-GMAIL-MSGID: =?utf-8?q?1596109146443959968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
