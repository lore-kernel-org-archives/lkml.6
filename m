Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225c2dAR/nagneAHUzjnDyEVFu3boBTTpEqLICtx8DPHoBwACijYJja+bZ2h0kdBcPeiTt6y
ARC-Seal: i=1; a=rsa-sha256; t=1517591208; cv=none;
        d=google.com; s=arc-20160816;
        b=yrzTEshuZKvzP8UzSl5XINN93qEf76Qd9MWbZPg/vo///JTEDZEl74smQ9q2gxFj6R
         1hwefpOJGbOy1NljUi63f3xsoSlgy4pPB8q6HnrH3w3PAX0qBEYkz40w1DnDO+l5U2+f
         5Slk8WiDrKFRbsgFIFzmASjlNc+s4+/vB2ASTQeQo2gEg4BQ04+dIAQgqoD6JXZvquk8
         swH8VPNyC2QmaAlXE4vJTe0FqLpq1TWG8pc2cQrGRkXobKAmvVrrg31SI6XUMBdUPG5P
         +atnPBG90/SMJs2K5EtrYor5F9gVvc2wYotqC2pVdDzd70Ay0O88wmrVp2u200ZLtumh
         toBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sL7bVvNYQIhdvcJIAF01hoF8Wj35cc+v2a1PAlNoC7A=;
        b=z2OojimdM/nbEntp3MqTdwv8gBBjFxY8gRTgThwW45pd7iCb4MXx66UpXVvC/EY87v
         ekO8c/MVrzrybbvYSecbPVJRd9F78aSOak3QMDbuwXh73MNj3GVOBjI59Mm34ZEREhDz
         xzYxiA3iD/7L++miCX8V/3GA6qMlNXPzYitKRwQzIQipoz1SOBBIjdQkiSzeM1n6DdI5
         2UKS/2gRmv31wYfY3FFQKudUDpev0sx895Kt61NzFhOk+uEZsPLHSwkUysIm6/tdGdIQ
         N0ajqLNffX8TM+lp9B84sz6P6eejl97fXWhMGO4usruKTv3bHoCBe8UZNSLGwyFXzOxI
         gSSw==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 55/86] drm/bridge: tc358767: filter out too high modes
Date: Fri,  2 Feb 2018 17:58:15 +0100
Message-Id: <20180202140827.398049136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309718911970272?=
X-GMAIL-MSGID: =?utf-8?q?1591309718911970272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit 99fc8e963a4c0203dba26a77cf737db6081bca14 ]

Pixel clock limitation for DPI is 154 MHz. Do not accept modes
with higher pixel clock rate.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-3-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1109,7 +1109,10 @@ static bool tc_bridge_mode_fixup(struct
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
 
