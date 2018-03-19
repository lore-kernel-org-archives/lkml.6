Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtXTbxU1WxCMJn793zzFr9smyAiZmdGeJEh+xQ41mpq3YI4iJya9T/6TMp4lQ0it71ttTKA
ARC-Seal: i=1; a=rsa-sha256; t=1521483917; cv=none;
        d=google.com; s=arc-20160816;
        b=YqjY9100HuW32BB/KtOZFV5h2ts3O0EC3MqvhtM/0Jc2NnSkuWFbmCeTS/N3eq/TT4
         cV6xjCN5jdM1A28hd17vKK4ERTn6+18u+ll2KLRVYh0ZRIG6KMgHvWwikV8qNscdY0cQ
         /iTtMzTL6Ik8i+l7v/FlbrIIxod7qy5ub65VMekYWCGYdc6wRklsSNeRWYM6Szu8wQeE
         i5FfGedrp9fkG6qmJvPL3i7Jk96Z4knvJBkiEmZvjBDEaFNiRvpj+i6oSZq8qDuHskju
         TScAeL9UYlYSPk46JyUsPJfQ15u7i22jmaHoXhl4U8cizE2XydoAeTj8C+HaNzXHpw1B
         hgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6GkJlY/CIte7SV0dzfDqcszL3BNuDLezzD+LM8vhwrI=;
        b=W3IjYVdt6W6PMfWi6DiCrnJzZfie4xpf9ZjYDom8UUDOcwe9VB9epQkgpod2bBbHmg
         A8ET3Us4XOLPQIx+boK+eSJ9uNpehE0N66h1s7NImGq34nzDj6oQ1mKe8jN0MOauP48O
         3s5yKBHy3VhTuFcgioh2nU9RPxXXAXPIVWSmIWIhg0SfyBCXTfZ6jtTZtl6u2DU1iMoV
         +V///du2KWQgtyXVF6H+3fA8uAsjYvguv60V2NMuETnYTyH9c2Q18PkV1jz/EoTKoIIh
         hWbvELnJtta7ca/mhouM4X1Sgk/4wh4LujzwBX9LOXJn7tXr7faeRX3snTvaZO1uckL4
         WthA==
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
Subject: [PATCH 4.9 164/241] drm/edid: set ELD connector type in drm_edid_to_eld()
Date: Mon, 19 Mar 2018 19:07:09 +0100
Message-Id: <20180319180757.951712093@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390988028544718?=
X-GMAIL-MSGID: =?utf-8?q?1595391519768727143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3347,8 +3347,7 @@ EXPORT_SYMBOL(drm_edid_get_monitor_name)
  * @edid: EDID to parse
  *
  * Fill the ELD (EDID-Like Data) buffer for passing to the audio driver. The
- * Conn_Type, HDCP and Port_ID ELD fields are left for the graphics driver to
- * fill in.
+ * HDCP and Port_ID ELD fields are left for the graphics driver to fill in.
  */
 void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 {
@@ -3426,6 +3425,12 @@ void drm_edid_to_eld(struct drm_connecto
 	}
 	eld[5] |= total_sad_count << 4;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_eDP)
+		eld[DRM_ELD_SAD_COUNT_CONN_TYPE] |= DRM_ELD_CONN_TYPE_DP;
+	else
+		eld[DRM_ELD_SAD_COUNT_CONN_TYPE] |= DRM_ELD_CONN_TYPE_HDMI;
+
 	eld[DRM_ELD_BASELINE_ELD_LEN] =
 		DIV_ROUND_UP(drm_eld_calc_baseline_block_size(eld), 4);
 
