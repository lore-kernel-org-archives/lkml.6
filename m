Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224iGaGojMXHTTOsM9RjYnt67fBOPvKet4e+P5t99pT0ZKbn8lrfzKeR1xgQYWECZ8a6gaGz
ARC-Seal: i=1; a=rsa-sha256; t=1517591205; cv=none;
        d=google.com; s=arc-20160816;
        b=sNXCprO8JhowcHKjeCHB6P0qAUK1tjK/oR8sAOmG+sbpDbqYZC19hQYsfr77BV4S87
         ekKxJLwaTO0E12q6M9XsJD+o3ZfcmB4EMwgIM3DE/wDKEmmFBd6NXOd3p0G14wG/OsR6
         Sw+tPPS8gfeH+g72PYvZjvu7fjbWlvA/qUrruVcEKWnczd9PI8opGFvO7arGcEiKAFQe
         YCvEvD4OP9NmMOOwRRk1/25KoI0b7rBcuJj/fOw2lBTXwe2MaqOtERHyhq+/NHgkYXkq
         gJZyKDf35eooRCegRH9p3wiaLX9cVamhc/wEYGmDLkrxtNjUxA9mjJuCmBJ30405dVPB
         yybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aHq5udxkgcQbbPyVlwSnX8jJBC3qqMrKh+RmtpvttGI=;
        b=FVwUWXz6rFbGGTvbf2B8ZVt/gr43ro0Gc/L5yJ1dHfuon4VGB01uf5/2EfeltEPyjv
         i5FoFFON/pnEGZCnI80CHWwn5wzhqwg8G7INtmW0bC3yneO3Xud45hpqVlq0f6QzxhXf
         3pXulHsSKV/Z1dVEyT8Rnb2spNReHS2Aofss5u2weIz4/Du6bCFmM2oqDdmZU+uzdrsS
         QFyjclPf/dXzz57K9m2KpKkZq6XwiH5Gib0uuekomNrMMtKEGxeYFGH0F2GHrSV8g/Eo
         dFqrB5nPxge1Le1Xs0rL93FZO31JaLx7VYAI4aM0MbKq0O291EY4nuc2uHxVi2Ms7sM4
         6gfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 54/86] drm/bridge: tc358767: do no fail on hi-res displays
Date: Fri,  2 Feb 2018 17:58:14 +0100
Message-Id: <20180202140827.266152758@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309715852709438?=
X-GMAIL-MSGID: =?utf-8?q?1591309715852709438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit cffd2b16c01c3431a7a7dd62e722af33490fc436 ]

Do not fail data rates higher than 2.7 and more than 2 lanes.
Try to fall back to 2.7Gbps and 2 lanes.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-2-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -603,8 +603,15 @@ static int tc_get_display_props(struct t
 	ret = drm_dp_link_probe(&tc->aux, &tc->link.base);
 	if (ret < 0)
 		goto err_dpcd_read;
-	if ((tc->link.base.rate != 162000) && (tc->link.base.rate != 270000))
-		goto err_dpcd_inval;
+	if (tc->link.base.rate != 162000 && tc->link.base.rate != 270000) {
+		dev_dbg(tc->dev, "Falling to 2.7 Gbps rate\n");
+		tc->link.base.rate = 270000;
+	}
+
+	if (tc->link.base.num_lanes > 2) {
+		dev_dbg(tc->dev, "Falling to 2 lanes\n");
+		tc->link.base.num_lanes = 2;
+	}
 
 	ret = drm_dp_dpcd_readb(&tc->aux, DP_MAX_DOWNSPREAD, tmp);
 	if (ret < 0)
@@ -637,9 +644,6 @@ static int tc_get_display_props(struct t
 err_dpcd_read:
 	dev_err(tc->dev, "failed to read DPCD: %d\n", ret);
 	return ret;
-err_dpcd_inval:
-	dev_err(tc->dev, "invalid DPCD\n");
-	return -EINVAL;
 }
 
 static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
