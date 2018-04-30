Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqP8a++mgzEY/RGNjhx9ecsvSsZw51JF57WlCbbaJ/T0nJtGQ8Xr2HoGXY6Y1j8ZKH/clgV
ARC-Seal: i=1; a=rsa-sha256; t=1525116528; cv=none;
        d=google.com; s=arc-20160816;
        b=gzRzdostpawCxGkLY690ENNbbSYPhVIhn42cfGhEydd6zWfSIijWknr8dw5hI7w5L/
         j5rKY/lY2v/5rT1bSa/ZtUM6MTo8p37j3Cuo64wGzdZU5gpUhEs/NA67mhasdF42+C7C
         vAbgf6LDcxD44tT9CJm+BAw8D66Mr9Sh5GpiKWGtmT6CE7Zvb9LkyrUZzn/LTnTJJFB3
         Q00uBikYP8tITA3jbYF7v5uE79VJz2U1yVezfQ3d71NiqOTG6YYFcBtCZl4PePg5gmJs
         +bEf8Yj9pRBChcVFvCcBK4KF8+f3DRdzfNVBBpfUsJoxsVMbgxXNRmQ4CJRvqXvs8xlV
         O6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kHA3CSaVBlhgx2jEtBQu43gvXLQL88i/IUUn7GEoPg0=;
        b=XjKSkAgAH/rhHz1AgXJxBmD3ECFpUjbFIrVB6w437PsMzRQJMTasuYAjIwhFHkW4K6
         nVO3jVo7aRHVsQPD4x8Fo0rzaEtyM/Q2hFuEbMhuW7GsIMEZE3PNKpXIjj/JflkB0Z46
         TUk9ZMAFWpkA25n+hy6w6fpB7ICv9UxfrkSnYIdgjIwwbXrqxeynMRgqGA1cnjJL61Vg
         YWpa67O9UzfV5TuUHn87rIxRGGvPdxBhR/3hbCHvOvMahoxvX3I/IQXNsRoNfm/sVJVx
         scBEfCEztkbzTND3lZnHAIGGIZlghP+wAOjiA+qTvlb/RKVE9MmjrgCLxTHMypPQu4ii
         a9ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2657B22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antony Chen <antonychen@qnap.com>,
	Shashank Sharma <shashank.sharma@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.16 098/113] drm/edid: Reset more of the display info
Date: Mon, 30 Apr 2018 12:25:09 -0700
Message-Id: <20180430184019.356054933@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200589049664988?=
X-GMAIL-MSGID: =?utf-8?q?1599200589049664988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 1f6b8eef11c3d097bc8a6b2bbb868eb47ec6f7d8 upstream.

We're currently failing to reset everything in display_info.hdmi
which will potentially cause us to use stale information when
swapping monitors. Eg. if the user replaces a HDMI 2.0 monitor
with a HDMI 1.x monitor we will continue to think that the monitor
supports scrambling. That will lead to a black screen since the
HDMI 1.x monitor won't understand the scrambled signal.

Fix the problem by clearing display_info.hdmi fully. And while at
eliminate some duplicated code by calling drm_reset_display_info()
in drm_add_display_info().

Cc: stable@vger.kernel.org
Cc: Antony Chen <antonychen@qnap.com>
Cc: Shashank Sharma <shashank.sharma@intel.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105655
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180424130250.7028-1-ville.syrjala@linux.intel.com
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Tested-by: Antony Chen <antonychen@qnap.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4450,6 +4450,7 @@ drm_reset_display_info(struct drm_connec
 	info->max_tmds_clock = 0;
 	info->dvi_dual = false;
 	info->has_hdmi_infoframe = false;
+	memset(&info->hdmi, 0, sizeof(info->hdmi));
 
 	info->non_desktop = 0;
 }
@@ -4461,17 +4462,11 @@ u32 drm_add_display_info(struct drm_conn
 
 	u32 quirks = edid_get_quirks(edid);
 
+	drm_reset_display_info(connector);
+
 	info->width_mm = edid->width_cm * 10;
 	info->height_mm = edid->height_cm * 10;
 
-	/* driver figures it out in this case */
-	info->bpc = 0;
-	info->color_formats = 0;
-	info->cea_rev = 0;
-	info->max_tmds_clock = 0;
-	info->dvi_dual = false;
-	info->has_hdmi_infoframe = false;
-
 	info->non_desktop = !!(quirks & EDID_QUIRK_NON_DESKTOP);
 
 	DRM_DEBUG_KMS("non_desktop set to %d\n", info->non_desktop);
