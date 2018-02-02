Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227q+5tpauzEG6Z2s45HlEBg5bL39YT07IfinI3BYtaWMA4ju++6Z1kER9oTWy3mvhMWzwEo
ARC-Seal: i=1; a=rsa-sha256; t=1517591601; cv=none;
        d=google.com; s=arc-20160816;
        b=I4a+GINApJifSFMzrsS9eR/RGvLf4GQ7YUegabDyPLzx3O09SIzq52oCRlaJwtR6T5
         iRcOSmSINtlNe6XcHumNBuPpEagJj7NHX6GdWcKFXtPIhB3kQzMTEKtbHg7gZFDgS7rJ
         j2dKywocNjORv6FEoVSQs0a42pTdoRUGd0FML9M6wujzbiHlb+x65jsUGNyDByoeBOkK
         vVBhlvcaZ1oBMTbAw4U5I2etNk0joI0bAolY+Nt7sXrmiHHtNGTlA82oq+vqCIl375tr
         THMpbTtRuPVNPBtafcwoeakXPd09HcOOQCWmTQ+SIpBOr0UgxITPtT/4JC/JNlvRMWGY
         EwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nYGxOfTKSnsYeFIzlAPNForifqCeZmST1IBRAZiDKm8=;
        b=RmhIDU30GWvS6wEUWxtl9xFFxTTPMz4OEg37EI0MsEBlj9TFrTjQY3K9KarJaBX9aS
         ib3T7c77UokzMPUFqpXAwG0PbMfNChvJqHE+a6nZcoTd0RC+JQtTQOxtJHxq3DBVXhKc
         vTD9F0kYGTpmY4qqlQ+KrfVibdq6Aqg3Q1C0V0lRhb9ZkkOsoV7oMpaVh+bi4kVK6V1o
         bgtSV9J6gWoAGixwgX09S/S5a56eCWJqwzNq2PDvwksma3cbiLilWb4GojjF/fdFoljb
         I3E3H5kHqIlAEctQiscwxMBaxs8/Xl9WhwNIRr3c01DjZ5NvOuqgUM+fsD+G+2C58cZS
         8Oqw==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 106/156] drm/bridge: tc358767: do no fail on hi-res displays
Date: Fri,  2 Feb 2018 17:58:07 +0100
Message-Id: <20180202140844.988701967@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309715852709438?=
X-GMAIL-MSGID: =?utf-8?q?1591310130670715031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
