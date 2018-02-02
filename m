Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2255f+MtAaZULXq6P5iPnygYlNZorJdnaGXzpmUwA9L/0+gOKnGTZd1BfwFLHoMJSwkNfvEi
ARC-Seal: i=1; a=rsa-sha256; t=1517591522; cv=none;
        d=google.com; s=arc-20160816;
        b=KSpIoZXwgelU6+LcKcJ7vqRFmEZmJnPdA2aimMhEKsXLjODKwbD22CmRVgVMid8SPi
         kBaMd/lMpUvbOJh9xZOeieQxtHdTaK0dD8L1EGU8AVW4nBjtrQ2lmeGurDi++7St5UfL
         ytNRthF1qICFFzkK+KHBKycnm+ESv2zpAZh7v8Ixk0gypHRBXRjnZx7Yc8tA+YuvC/BE
         eNPQ8p3/SioBPsz1KVXAzESn1znw5vI9g5nrTEqq7YWu+mMQ7IcoD+a3YGqwKvJ8rEJf
         Z+dKJgLzpqLlCy/7noVvDTbUiihRAt+nEy8ZwiqqsDxwScfwnmWypbyN5FZpq0CzftRm
         lzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kxOl2WHTaRK7aXIDbtyACZBIqAa2cEkRUT8krjx+hAo=;
        b=pi/oc9m5QvKZOH+4+6ZhpmpTXYdsxEW238EkzVKT0qmn4R4tYDbvPIl2XB5HjY7imo
         D5+VYfaV6dJfA/hTq5eM58jclSF3UHQTB5++2dZw1YlAGjYwf7Qm924k8f2GEPlMd7yz
         cjndpO41Wzsa9aL0z4miYQZEVZG2K/G1b4VHrqwAyE+vAAW+ZZpgjaATdN7kMhDNehbo
         4FmBRHg5IIWSqxm5x65jevr8hP91G7j0qwyu785XGDK4Omf+M/GHm6gStra8DFBR9PUR
         cqoTYvdJHJ17kya/UJsJssknu8/ygAG0GZQLc+dEIDoHKU0BEEIPtXkjRep0oW7w7rC+
         HHqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 109/156] drm/bridge: tc358767: fix timing calculations
Date: Fri,  2 Feb 2018 17:58:10 +0100
Message-Id: <20180202140845.114333952@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309619504798871?=
X-GMAIL-MSGID: =?utf-8?q?1591310047839416791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit 66d1c3b94d5d59e4325e61a78d520f92c043d645 ]

Fields in HTIM01 and HTIM02 regs should be even.
Recomended thresh_dly value is max_tu_symbol.
Remove set of VPCTRL0.VSDELAY as it is related to DSI input
interface. Currently driver supports only DPI.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-5-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -659,6 +659,14 @@ static int tc_set_video_mode(struct tc_d
 	int lower_margin = mode->vsync_start - mode->vdisplay;
 	int vsync_len = mode->vsync_end - mode->vsync_start;
 
+	/*
+	 * Recommended maximum number of symbols transferred in a transfer unit:
+	 * DIV_ROUND_UP((input active video bandwidth in bytes) * tu_size,
+	 *              (output active video bandwidth in bytes))
+	 * Must be less than tu_size.
+	 */
+	max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
+
 	dev_dbg(tc->dev, "set mode %dx%d\n",
 		mode->hdisplay, mode->vdisplay);
 	dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
@@ -668,13 +676,18 @@ static int tc_set_video_mode(struct tc_d
 	dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
 
 
-	/* LCD Ctl Frame Size */
-	tc_write(VPCTRL0, (0x40 << 20) /* VSDELAY */ |
+	/*
+	 * LCD Ctl Frame Size
+	 * datasheet is not clear of vsdelay in case of DPI
+	 * assume we do not need any delay when DPI is a source of
+	 * sync signals
+	 */
+	tc_write(VPCTRL0, (0 << 20) /* VSDELAY */ |
 		 OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
-	tc_write(HTIM01, (left_margin << 16) |		/* H back porch */
-			 (hsync_len << 0));		/* Hsync */
-	tc_write(HTIM02, (right_margin << 16) |		/* H front porch */
-			 (mode->hdisplay << 0));	/* width */
+	tc_write(HTIM01, (ALIGN(left_margin, 2) << 16) | /* H back porch */
+			 (ALIGN(hsync_len, 2) << 0));	 /* Hsync */
+	tc_write(HTIM02, (ALIGN(right_margin, 2) << 16) |  /* H front porch */
+			 (ALIGN(mode->hdisplay, 2) << 0)); /* width */
 	tc_write(VTIM01, (upper_margin << 16) |		/* V back porch */
 			 (vsync_len << 0));		/* Vsync */
 	tc_write(VTIM02, (lower_margin << 16) |		/* V front porch */
@@ -693,7 +706,7 @@ static int tc_set_video_mode(struct tc_d
 	/* DP Main Stream Attributes */
 	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
 	tc_write(DP0_VIDSYNCDELAY,
-		 (0x003e << 16) |	/* thresh_dly */
+		 (max_tu_symbol << 16) |	/* thresh_dly */
 		 (vid_sync_dly << 0));
 
 	tc_write(DP0_TOTALVAL, (mode->vtotal << 16) | (mode->htotal));
@@ -709,13 +722,6 @@ static int tc_set_video_mode(struct tc_d
 	tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
 		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
 
-	/*
-	 * Recommended maximum number of symbols transferred in a transfer unit:
-	 * DIV_ROUND_UP((input active video bandwidth in bytes) * tu_size,
-	 *              (output active video bandwidth in bytes))
-	 * Must be less than tu_size.
-	 */
-	max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
 	tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
 			   BPC_8);
 
