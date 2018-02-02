Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226oZOhRMXhLKDZ8gbccxylY4llkNhZCUt4WJnPOXQ3e5JAZ86hTWcJRv2uyVrFHiQcCrRGZ
ARC-Seal: i=1; a=rsa-sha256; t=1517591603; cv=none;
        d=google.com; s=arc-20160816;
        b=vRwCyg/RtFfgbaPQtYAHKb6EXYW3Zb17HjF2KFVhPmMgLPWptOY/VsZVRN6N+wiXAl
         sBKivNMKFNrLF4Bfempa1QWX8COJj0zryGLzjDfPtGDGRvz0JOUSNkB2clVEjD+PTTS7
         ZDC/e8AEVQ/zBSR5psbQ8e8CpFJeZjmqFcTYPxizWTmQNhm5yN9bAxcNdgyGIaPA9Beu
         rxInTGQ5HRDonIQC23Nn/rME2pi5a/Ks8NyGwOPo16ZCRrfP9SWjppGqSTBH5+CAf53T
         Nunmsy6/z0XmVDLQGtVIbIg93Shu95Of1DTDlQRHsBaXdY9A29/Q0fr+LvLjzjnGA+5V
         5Mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Odkk6+T04KCeu4laKjQZ/ndqXRHPUQW/iWAq6DAmXWU=;
        b=q0ukNkmlRWt9PlLpf5nemw/P6t7E9vNTsrAVA1Qkv/tuKx+ZgOhzfusEpbWkyIAF3u
         BBfHwkR37oqHUR/aq45jNGFemyfGflr/7foSZ4U/rhBfK/wcSGIxmnp1B4ntFt9ssh5k
         Db2umJF96HWrsoUNTQnXzXs9PaVTigdU03hLt3hsC+hv55CazDEjoVKBtFopI2O8Sn0a
         /gBPPazDtXY47zN4C53PwUcw7CCCrOUvkP5KGn9DolsEFyaqmFd6ZqWShHg2smzDmVRc
         mCw6l6tbMelOgDPtQ00tD94sczbiZcBvHCQRie66OSNfw1aZpFAS0QjCOCqvTvniF2kl
         C+6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrzej Hajda <a.hajda@samsung.com>,
	Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 107/156] drm/bridge: tc358767: filter out too high modes
Date: Fri,  2 Feb 2018 17:58:08 +0100
Message-Id: <20180202140845.029544497@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309718911970272?=
X-GMAIL-MSGID: =?utf-8?q?1591310133414892788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit 99fc8e963a4c0203dba26a77cf737db6081bca14 ]

Pixel clock limitation for DPI is 154 MHz. Do not accept modes
with higher pixel clock rate.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-3-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1103,7 +1103,10 @@ static bool tc_bridge_mode_fixup(struct
 static int tc_connector_mode_valid(struct drm_connector *connector,
 				   struct drm_display_mode *mode)
 {
-	/* Accept any mode */
+	/* DPI interface clock limitation: upto 154 MHz */
+	if (mode->clock > 154000)
+		return MODE_CLOCK_HIGH;
+
 	return MODE_OK;
 }
 
