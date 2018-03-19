Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsSOCQ7ZQfPsikLZmviKJTQyypcIPxgfRcZ2IIGoqh+qYYlLWdhsMOA31omyKS4gkOkhD7y
ARC-Seal: i=1; a=rsa-sha256; t=1521483409; cv=none;
        d=google.com; s=arc-20160816;
        b=tu22PgtsHzZ+zQnJsW4kQkoIULHuazfUvDkIJFpQTlqq+TQnt2rFZBzzXqK/u/h+jV
         NrzYh8LreXG3FpW1NEaVcIT1xHl3Td7eneclDUgPIE0BrOorCw5eHFC/1piHcEK+lIQr
         MyzvqrjMKV75AQ3f1yJP5uo4CeJupUq08/qmlXmpdDBxWaU3RkK2Xnc3IplNb+ms3sA+
         ZR2Vt8XQzwjNLWBEwdQMfnfMsPzVBYiyGUqwAMZ1lh0oZhZiZhiajDNZ0WtERda6/ZV6
         Nji7XwGp+IOho8k8AjXP/Bv2olggnXhPCzxArnv4iNjzY7s9pyq4JURzGKpkMv8tMxgb
         25Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Cw+PiUl22P6si0bpBZVRHRu1pdj/ahBmfLSfHyvP6M=;
        b=bZno/Qbxg0dr/x5emQ8218rKgqG0r1N1CkE//0YTsphU1fXZ0x1d6eZSIiPWW1bJ1p
         0ZkQj9CAXUKIA0Q5kJ6E+ALLB5eJh4pnxMk4liEOf17DVb0B6BXTnGgAhPAaGAJ0eZ5k
         1ny/90EpBegeB7dwZJqO4x5M2GtwkydPb5PbFYdZ+fcMoCk8dwTJu31ZZciEqaYEDl8O
         7lJEwYyfsGQ+csPMT7WzXaLo3qoMDRbMF6WdvP2nb7lndvGfCGwQtPA+3sfzZnE5M997
         au2+2EEvC4z4bxLghxZID52v9//5i6egGHqS6E5xA3GJTu2ulg8+tDYWIJNRkpP5Cbw+
         mKow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Archit Taneja <architt@codeaurora.org>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Russell King <linux@armlinux.org.uk>,
	CK Hu <ck.hu@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ben Skeggs <bskeggs@redhat.com>,
	Mark Yao <mark.yao@rock-chips.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Vincent Abriou <vincent.abriou@st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Thierry Reding <treding@nvidia.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 079/134] drm/edid: set ELD connector type in drm_edid_to_eld()
Date: Mon, 19 Mar 2018 19:06:02 +0100
Message-Id: <20180319171900.680724144@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390988028544718?=
X-GMAIL-MSGID: =?utf-8?q?1595390988028544718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>


[ Upstream commit 1d1c36650752b7fb81cee515a9bba4131cac4b7c ]

Since drm_edid_to_eld() knows the connector type, we can set the type in
ELD while at it. Most connectors this gets called on are not DP
encoders, and with the HDMI type being 0, this does not change behaviour
for non-DP.

For i915 having this in place earlier would have saved a considerable
amount of debugging that lead to the fix 2d8f63297b9f ("drm/i915: always
update ELD connector type after get modes"). I don't see other drivers,
even the ones calling drm_edid_to_eld() on DP connectors, setting the
connector type in ELD.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Mark Yao <mark.yao@rock-chips.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/d527b31619528c477c2c136f25cdf118bc0cfc1d.1509545641.git.jani.nikula@intel.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_edid.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3219,8 +3219,7 @@ monitor_name(struct detailed_timing *t,
  * @edid: EDID to parse
  *
  * Fill the ELD (EDID-Like Data) buffer for passing to the audio driver. The
- * Conn_Type, HDCP and Port_ID ELD fields are left for the graphics driver to
- * fill in.
+ * HDCP and Port_ID ELD fields are left for the graphics driver to fill in.
  */
 void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 {
@@ -3293,6 +3292,12 @@ void drm_edid_to_eld(struct drm_connecto
 	}
 	eld[5] |= sad_count << 4;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_eDP)
+		eld[DRM_ELD_SAD_COUNT_CONN_TYPE] |= DRM_ELD_CONN_TYPE_DP;
+	else
+		eld[DRM_ELD_SAD_COUNT_CONN_TYPE] |= DRM_ELD_CONN_TYPE_HDMI;
+
 	eld[DRM_ELD_BASELINE_ELD_LEN] =
 		DIV_ROUND_UP(drm_eld_calc_baseline_block_size(eld), 4);
 
