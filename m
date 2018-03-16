Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuxPHPzVKPElYFTQYusbaQsAE2EZC56vnO9kM7IMnqaTfy0oemI7eSrA4SVjDIPcTAsSXwv
ARC-Seal: i=1; a=rsa-sha256; t=1521214517; cv=none;
        d=google.com; s=arc-20160816;
        b=j/VC7QJohLJAXIlhrl+vzCHvneLFfi2OTn6uLi6jRxMN7CeF3NivkESEC8KorGVUo2
         n8atMl341/rqAhPlbi9VNPAqHAjIPm1J/sOKaQpIpONmDJ2jiwtc/AkaqP9aqkboxGMY
         N9/rYxnuTpyaWc8USST7CMcuZig5fXq3e5QAj317lburWtmzgzcnYSSIqsDG/JUjVWYF
         gcjN0F7NZ6ybPa3hSkoDoQ3A1xhfazVvakX+SgCVN/gsfpWfJnQLdTiZfEackbquyO3p
         09AOfHJh7q5YHO7/AE3VL8pdDlNsGUHkXECoGSCq96owlE7r5LvhpqFW96GhPJIytRNM
         PtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rRg61HXCYUrB4/wkIhALbQKi2we5zLtyfXnteoHbkZg=;
        b=PYOQkrq2ar5clL1lcEZRL2A254V9cOHAeSwm7b0aGmtPqCAiXhMvtjTmP6c4/yX83/
         6z+5pB2dhU4YZr2OT6xv3tyCcOOrBNM851cD8IC5jqBnvzLmBNYilsjY6wHFYbrrmzCS
         eJgAb17STd8MXbNnzpd6+ulf9azr3iuUHTa+vMzM4RzR/Hl74QEZsyvwzTD1BU52wkq7
         1VblWpb20hrthD0Gu/6AbghNogLZav/v2ojOknYoNcywR4/T2ax/yGrG80fslQW20lzd
         VpiMt5xetBMT49GpW6rUK0rBE52C6XLlhJWljmBLngMqvnzx2Ty5l9V8us1afIMmIEzK
         jOpw==
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
Subject: [PATCH 4.14 027/109] drm/edid: set ELD connector type in drm_edid_to_eld()
Date: Fri, 16 Mar 2018 16:22:56 +0100
Message-Id: <20180316152331.439090371@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109033394870150?=
X-GMAIL-MSGID: =?utf-8?q?1595109033394870150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3823,8 +3823,7 @@ EXPORT_SYMBOL(drm_edid_get_monitor_name)
  * @edid: EDID to parse
  *
  * Fill the ELD (EDID-Like Data) buffer for passing to the audio driver. The
- * Conn_Type, HDCP and Port_ID ELD fields are left for the graphics driver to
- * fill in.
+ * HDCP and Port_ID ELD fields are left for the graphics driver to fill in.
  */
 void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 {
@@ -3905,6 +3904,12 @@ void drm_edid_to_eld(struct drm_connecto
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
 
