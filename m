Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv8osCFHvLkeDIpWQuuhC4EM0lcGNZaSndTjDxsQObdy5ox7cg6YNSuREAQFwBModzT76Be
ARC-Seal: i=1; a=rsa-sha256; t=1521214830; cv=none;
        d=google.com; s=arc-20160816;
        b=PR+zJQ1cD70K3gh5o2Rx9Yl+LJtL2ROGHgUsj717ZWls9gkZ1Ol91pPp2vPjZESOPI
         gQWD5eZ8ASQRaDP/9vXtETmKht6fm6wPbDKRu6JPTZMActYkNU1awab2Qpe0Zrin76Gj
         2RSBjNNRfrlzPqK03ge4R3vzmTJ/+85nVUsCCnM2SXiNCd8sBZDQaLMNBAOvtWY1uDJE
         XJDpGxVbq/In+z4SFCo/1MW49gvOaNJwY+yhYFs/XJB4u6q1q3lFzjgxBSQBnu89A7Fg
         fCo/gV4McWKVm7Nguxkcku26YAqNfTDNdx03TS0W5NQbBJYz3oFEht2b3U+PKCcpjW50
         iHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fQhvOfTrmf6g91UPzu1V6TkqXzDxjs0IhdC431ot1bs=;
        b=jP5RXav0+JD430X/oXDq2Rj4IU9Mu6uTcjO68KNgWdcELb6bcYXkXaCuDHY8M8uOSq
         DFkXyuDaQHHhJt26+qH5x8m+H2aWI1vk7zMMeH2Ev8L/tThKLUybhmhyTOI4KjbsRYJw
         tWxI7tshIYu/hjsgiv6sbnrX49+xqI2Em2n7pe6cvINlylKqFdurZAx/+DqACyzRFxMC
         VDhedrNvNkWbQbaVd7gXRQYo9GciOuVSWCmNeZdF00i6ERakfUol1l8jKVw58rLEjsie
         LKztTKghPZM2DdfITjW3Se644lnizkzzdfnahMyXqcg8Sf4AXHXmTnPpdaeOBG2dPCJV
         uPww==
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
Subject: [PATCH 4.15 032/128] drm/edid: set ELD connector type in drm_edid_to_eld()
Date: Fri, 16 Mar 2018 16:22:53 +0100
Message-Id: <20180316152338.170679480@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109033394870150?=
X-GMAIL-MSGID: =?utf-8?q?1595109361325474084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3843,8 +3843,7 @@ EXPORT_SYMBOL(drm_edid_get_monitor_name)
  * @edid: EDID to parse
  *
  * Fill the ELD (EDID-Like Data) buffer for passing to the audio driver. The
- * Conn_Type, HDCP and Port_ID ELD fields are left for the graphics driver to
- * fill in.
+ * HDCP and Port_ID ELD fields are left for the graphics driver to fill in.
  */
 void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 {
@@ -3925,6 +3924,12 @@ void drm_edid_to_eld(struct drm_connecto
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
 
