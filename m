Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227buqd2oOtIg6cllBMY2Evs23IEXDl71XdSV2qjju5mU9aiyRAvxSanBMtEvVndSiCO+Ndf
ARC-Seal: i=1; a=rsa-sha256; t=1517591120; cv=none;
        d=google.com; s=arc-20160816;
        b=Rr7rmPEMUQNy/6LouP18hdoy2ZW1p2QdSpm7+kH0bXfanvDwNxuJj/b0R34uqLDLHb
         JojGbOnC9MYUMN2rYm5jV0laTqPJgODl6sBJd2Jdya+v0c2dbMJkkKyr1tgHYUjs4SGA
         Ft4fCQ2eZxkzBbFFoYXtTbRtRyoabNQ2C5JaYWdqpE7L0D28cWZCInPBhg5w8IXg1dny
         jHPav0HeLif23ge5SFFA8P+DETWEV67dfHJHEAMc3QYCe+yiGAHF3qixDSTIFGq/rgeI
         MzpYRaHPicBFBT8hBbOqyAQo7+aOWWtm++SgZzjgMLRl67O41/vbpraTGK++oQtRZAFC
         0xxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r/o6F9o7exx6J8q/dNXpWALCaXwV77ZoKI9VJy3msMQ=;
        b=Ta1AhZzwP4nsgwq+OXB5l4CvEBQuNEHW83itEC8OoLoIW4LjTSOI/tqeMIVcj3ZqUv
         GpoEHhZ6wIrQh2TJ4wehXLg0Q4+goFvstA11LLRld3dNwiZ0xJXbb0bJSPTv6s5L6J57
         5soOKqTG2k86JtGcfW/dH491wFOQJc0+pj/kmtNXWWRuVWEbfIuKqi1Vl0HCC9jbUTMD
         p45sMUG5UEGH9LlFWNNoVZ/o+6hOxtwVqwInt6iK0M6aEZZ4tG0NbKplwVgmaH6GM5Dp
         DYJpSMClA9n9WNmRAEg13tCBgEykCZbyoFjlhAHYrg8YEd3Wt//rSNhFnKvsDuTX1tZF
         iODw==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 59/86] drm/bridge: tc358767: fix 1-lane behavior
Date: Fri,  2 Feb 2018 17:58:19 +0100
Message-Id: <20180202140827.987254394@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309627030283501?=
X-GMAIL-MSGID: =?utf-8?q?1591309627030283501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit 4dbd6c03fbf88299c573d676838896c6e06aade2 ]

Use drm_dp_channel_eq_ok helper

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-7-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -819,8 +819,6 @@ static int tc_main_link_setup(struct tc_
 	unsigned int rate;
 	u32 dp_phy_ctrl;
 	int timeout;
-	bool aligned;
-	bool ready;
 	u32 value;
 	int ret;
 	u8 tmp[8];
@@ -965,16 +963,15 @@ static int tc_main_link_setup(struct tc_
 		ret = drm_dp_dpcd_read_link_status(aux, tmp + 2);
 		if (ret < 0)
 			goto err_dpcd_read;
-		ready = (tmp[2] == ((DP_CHANNEL_EQ_BITS << 4) | /* Lane1 */
-				     DP_CHANNEL_EQ_BITS));      /* Lane0 */
-		aligned = tmp[4] & DP_INTERLANE_ALIGN_DONE;
-	} while ((--timeout) && !(ready && aligned));
+	} while ((--timeout) &&
+		 !(drm_dp_channel_eq_ok(tmp + 2,  tc->link.base.num_lanes)));
 
 	if (timeout == 0) {
 		/* Read DPCD 0x200-0x201 */
 		ret = drm_dp_dpcd_read(aux, DP_SINK_COUNT, tmp, 2);
 		if (ret < 0)
 			goto err_dpcd_read;
+		dev_err(dev, "channel(s) EQ not ok\n");
 		dev_info(dev, "0x0200 SINK_COUNT: 0x%02x\n", tmp[0]);
 		dev_info(dev, "0x0201 DEVICE_SERVICE_IRQ_VECTOR: 0x%02x\n",
 			 tmp[1]);
@@ -985,10 +982,6 @@ static int tc_main_link_setup(struct tc_
 		dev_info(dev, "0x0206 ADJUST_REQUEST_LANE0_1: 0x%02x\n",
 			 tmp[6]);
 
-		if (!ready)
-			dev_err(dev, "Lane0/1 not ready\n");
-		if (!aligned)
-			dev_err(dev, "Lane0/1 not aligned\n");
 		return -EAGAIN;
 	}
 
