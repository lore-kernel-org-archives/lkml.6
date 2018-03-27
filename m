Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49WRfXoEMXxnnNYragNYghkgji426neYb0VjW87nK4sXFKxb8lKlLoRsAQs0hBh+2y3knyv
ARC-Seal: i=1; a=rsa-sha256; t=1522168157; cv=none;
        d=google.com; s=arc-20160816;
        b=rTJ7bceMoCTCm9674j50Nut9o3G0M37YbZ/rss3vvUZ2kW6nNrMHgPMSTFFwHuIkyE
         DRw7O0LhTgXU4Fyhx8IBVSDd8DIVtqmrQecu20lo9HgHYjGP63mu62cRttTCHSZvWwYe
         4momeoCwrRivQWOghcmDuRaxuyKHhq8G13rCb1nvYmPIxfmLT95PrYIlMDhgyHBgyKsV
         QrBZ0cBfWS6cXlD3BQZMc1YoZVn4GznNOQdH7xnnCTbOuO4fN1KyNKYOmba/Z9i6PZEk
         mR+uXUMipppdqrI3K6ii4mO5VMTUG4/SyPH8Qtnp36vcVU9ErfeIqcM95Kp086Xtn/xD
         fHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L3r+7HUydGbayXSZ06CPTk+ExxdxTt+0zkSet4NVf4k=;
        b=ore0Y9IBscvSjVoq7/PKt9xfms0tPpYrmTWLESpXjjA64ze2WJMK84wobUaeEhfokX
         0Wnlq+Yga7dR24g9piiRbCjZTyML/4VXEVfW2mIDKJczSmf3JaJHni9jWmNAMHgWHBK/
         uVw1B5oGLXdyCrVjN2vAvuBrO0VL+AD2k6Ivdy8KMfJOcnWckaO3aLke5TJbHjGJolXE
         Ne/9TrogzthAPMO2gTKYYHCGmsa2VLrp4H0Uy3jnnkdh4iBMQF0shjE5VXzBs3EjWS7G
         MzVRmIxUi4zBM4mr3g7eZgRzHDjf2M+oMsK16tiDC3LygEzU30VneeANjxcB2MEij2ix
         M1+g==
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
Subject: [PATCH 4.4 23/43] drm/radeon: Dont turn off DP sink when disconnected
Date: Tue, 27 Mar 2018 18:27:27 +0200
Message-Id: <20180327162717.731750237@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108997827947853?=
X-GMAIL-MSGID: =?utf-8?q?1596108997827947853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -89,25 +89,18 @@ void radeon_connector_hotplug(struct drm
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
