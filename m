Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvPx9l+MyKZTRx8nG4u+6xoln9MAd3EOWNvnSogOM0pZ8nOBViU45NchB2ytPH11REPSH74
ARC-Seal: i=1; a=rsa-sha256; t=1521484085; cv=none;
        d=google.com; s=arc-20160816;
        b=GnY2vzwXC5XUxW6GL95tkNdK9ZgGEQsIRvaHG1oqJKoa0nI+1SGiZaY67o2oqO7d5o
         xupyVeMMWeJ3lAOPHQit+ep2BfMtLUPtAG0lVzBwA8AFcUNhwZRT/eda6SMizwkdzIYv
         xPbfigKQ3U9EFFMiYXvdvhn3KL0eY+j5RQ11UUYYW+WU2z7sgx2vpDGoOpJ2SnzXe1NU
         6qaAgwkzlwuFqagRx8MHLMHWcdEY3CVeBdrdi290I4ZzVIkRmMyZwkxnonBj12LqNnOG
         3nJvox2APP7FN9BkZOVi6ki2emWcQycvXZqfwqnsQZP4QXe7sqIqpG7mX4vh5At7bVmJ
         NT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ThwJFwjFmYUAGGlNQqvRbwPik+BbB2xsNGAmOsVoHDM=;
        b=i57TnS8urGQh4GEPjysYOat4Nt35roOGa66yxpm0q4ltFvDKzRDBqGr+cE1WhtPI5N
         ZI9LDPki44AfholV9N103d9DnpJL9OnrTAcYQIX4FBCabnRVg8rK2hzx+4KMlefXKtb6
         FxrBxv6xHyK5Ix/L0ZhpnO9mWbCuLz5f/PnZGVSMWLgqk9NJWpyiVEkbOx5YlRelvdtT
         NyLrXKFPx5bFXfoPlfUaoFw2rvEfrKRZsp75dzLvB/QmZ6ruu8rNa68ZSeiI/kXXwsmL
         VBSriGRvwB/3/YCz+AHPRdMhSZCZbffk/iu9DY8/SeZu4VTPGSnjlh0xwmS8y9MKgTm0
         je/g==
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
Subject: [PATCH 4.9 227/241] drm/amdgpu/dce: Dont turn off DP sink when disconnected
Date: Mon, 19 Mar 2018 19:08:12 +0100
Message-Id: <20180319180800.571303374@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391004323792945?=
X-GMAIL-MSGID: =?utf-8?q?1595391696559501687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <michel.daenzer@amd.com>

commit 7d617264eb22b18d979eac6e85877a141253034e upstream.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |   29 +++++++++----------------
 1 file changed, 11 insertions(+), 18 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -69,25 +69,18 @@ void amdgpu_connector_hotplug(struct drm
 		/* don't do anything if sink is not display port, i.e.,
 		 * passive dp->(dvi|hdmi) adaptor
 		 */
-		if (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT) {
-			int saved_dpms = connector->dpms;
-			/* Only turn off the display if it's physically disconnected */
-			if (!amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd)) {
-				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
-			} else if (amdgpu_atombios_dp_needs_link_train(amdgpu_connector)) {
-				/* Don't try to start link training before we
-				 * have the dpcd */
-				if (amdgpu_atombios_dp_get_dpcd(amdgpu_connector))
-					return;
+		if (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT &&
+		    amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd) &&
+		    amdgpu_atombios_dp_needs_link_train(amdgpu_connector)) {
+			/* Don't start link training before we have the DPCD */
+			if (amdgpu_atombios_dp_get_dpcd(amdgpu_connector))
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
