Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCC6ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6420B21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nPqzb0BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6420B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeJTE1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:27:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38436 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeJTE1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:27:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so13247046pll.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMdWozsdXVjUEKyRAJeDLJEom6q5Exv1pHWt7qF5ZiM=;
        b=nPqzb0BOL6Ymae/PfZ251oOFWNDISM+Z4Vo5sitiK0dwLYv9uOR/suU2GqkmINYsb1
         naksXkExXhhZcmmhQQzv3BvtiqI7L7zOc7EsboWiul3KrAqcCxs/isQ+aYGN3V3mAwxF
         LiF2uXCvfi6Zi2AhtZQ6fEPbYmXBE+xokzuco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMdWozsdXVjUEKyRAJeDLJEom6q5Exv1pHWt7qF5ZiM=;
        b=qSnY8XqCSe1JY8yTs6yIYKXfQBwc2E0WY9yp6deFDM9npsb/SCbpLxzUD3bRldLT7O
         Td63O1sgJ4QK5H1fk51AxBK88m5+M2Wie316v8Giyx97cH4PHpn9QeLZs8OSdhqANO/H
         iSs8yhoaAj06ZMTAhm+Os3e3hC4U0+VC2rso99GUAB+TFf5B7i33WC0A6yfc+iAVEk3i
         hObzmwMhNShUBmftlXPC5M3u6piemMXSrHjn4tt1KieYqAFPmQrAZvkc/+KMOt2idm9o
         ujZq2zXY7Cl//+iWBFGHUPvlYmBt6X1WeMfym4jNMWHFBE+ZzUXWa9UoDHUuP3wD4+Ro
         FPMQ==
X-Gm-Message-State: ABuFfohSGO9emr1O0WpaFgSEOC2Jx7K4Uba5lkSpCVYNQ+y+0RFSl5wp
        aRJwr/5mWYhzHS+gXfQ2iye6qPfHDA0=
X-Google-Smtp-Source: ACcGV604hIcC7dA3C1ysPHg9aCVDOqjxmVIWoJ9ZrdGSyRCZ8QVzB3yXfruNrobjvdLNBzpy8RARsw==
X-Received: by 2002:a17:902:3fe4:: with SMTP id a91-v6mr35363027pld.187.1539980408689;
        Fri, 19 Oct 2018 13:20:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id i184-v6sm38281573pfg.88.2018.10.19.13.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 13:20:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sandeep Panda <spanda@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, jsanka@codeaurora.org,
        ryandcase@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH 2/2] drm/bridge: ti-sn65dsi86: Allow DT to set "HPD delay"
Date:   Fri, 19 Oct 2018 13:19:40 -0700
Message-Id: <20181019201940.138179-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181019201940.138179-1-dianders@chromium.org>
References: <20181019201940.138179-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's solve the mystery of commit bf1178c98930 ("drm/bridge:
ti-sn65dsi86: Add mystery delay to enable()").  Specifically the
reason we needed that mystery delay is that we weren't paying
attention to HPD.

Looking at the datasheet for the same panel that was tested for the
original commit, I see there's a timing "t3" that times from power on
to the aux channel being operational.  This time is specced as 0 - 200
ms.  The datasheet says that the aux channel is operational at exactly
the same time that HPD is asserted.

Scoping the signals on this board showed that HPD was asserted 84 ms
after power was asserted.  That very closely matches the magic 70 ms
delay that we had.  ...and actually, in my esting the 70 ms wasn't
quite enough of a delay and some percentage of the time the display
didn't come up until I bumped it to 100 ms.

To solve this, we tried to hook up the HPD signal in the bridge.
...but in doing so we found that that the bridge didn't report that
HPD was asserted until ~280 ms after we powered it (!).  This is
explained by looking at the sn65dsi86 datasheet section "8.4.5.1 HPD
(Hot Plug/Unplug Detection)".  Reading there we see that the bridge
isn't even intended to report HPD until 100 ms after it's asserted.
...but that would have left us at 184 ms.  The extra 100 ms
(presumably) comes from this part in the datasheet:

> The HPD state machine operates off an internal ring oscillator. The
> ring oscillator frequency will vary [ ... ]. The min/max range in
> the HPD State Diagram refers to the possible times based off
> variation in the ring oscillator frequency.

Given that the 280 ms we'll end up delaying if we hook up HPD is
_slower_ than the 200 ms we could just hardcode, for now we'll solve
the problem by just allowing boards to hardcode a value.  If someone
using this part finds that they can get things to work more quickly by
actually hooking up HPD that can always be a future patch.

One last note is that I tried to solve this through another way: In
ti_sn_bridge_enable() I tried to use various combinations of
dp_dpcd_writeb() and dp_dpcd_readb() to detect when the aux channel
was up.  In theory that would let me detect _exactly_ when I could
continue and do link training.  Unfortunately even if I did an aux
transfer w/out waiting I couldn't see any errors.  Possibly I could
keep looping over link training until it came back with success, but
that seemed a little overly hacky to me.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 45 ++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index f8a931cf3665..5deed667480c 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -93,6 +93,7 @@ struct ti_sn_bridge {
 	struct clk			*refclk;
 	struct drm_panel		*panel;
 	struct gpio_desc		*enable_gpio;
+	int				panel_hpd_delay_ms;
 	struct regulator_bulk_data	supplies[SN_REGULATOR_SUPPLY_NUM];
 };
 
@@ -459,16 +460,37 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	int ret;
 
 	/*
-	 * FIXME:
-	 * This 70ms was found necessary by experimentation. If it's not
-	 * present, link training fails. It seems like it can go anywhere from
-	 * pre_enable() up to semi-auto link training initiation below.
+	 * The timing diagram of some eDP panels says that you're supposed to
+	 * wait for HPD to be asserted before the aux channel is operational.
 	 *
-	 * Neither the datasheet for the bridge nor the panel tested mention a
-	 * delay of this magnitude in the timing requirements. So for now, add
-	 * the mystery delay until someone figures out a better fix.
+	 * While we could configure the bridge to report the HPD signal to us
+	 * and add a delay here until the HPD is asserted, it turns out that's
+	 * slower than just hardcoding the max delay from the panel in some
+	 * cases.  Why?
+	 *
+	 * The sn65dsi86 datasheet says that it only reports the debounced
+	 * HPD signal to software.  It will tell software about HPD assertion
+	 * as quickly as 100 ms after it's asserted, but sometimes it might
+	 * take 400 ms because it's timed with a very inaccurate ring
+	 * oscillator.  In practice it was measured at 200 ms on at least
+	 * one system.
+	 *
+	 * On a particular panel, HPD was asserted 84 ms after power was given.
+	 * This same panel specified that HPD would always be asserted within
+	 * 200 ms of applying power.  Thus on this panel with the measured
+	 * 84 ms to assert HPD + the 200 ms measured debounce we'd wait 284 ms
+	 * which is 84 ms longer than just hardcoding the sleep.
+	 *
+	 * For now we don't know of any cases where paying attention to HPD
+	 * is better than hardcoding the value.  Thus for now only support the
+	 * hardcoded delay and print a warning if it wasn't specified.  Later
+	 * one could imagine improving the driver to enable HPD support if
+	 * panel-hpd-delay-ms wasn't specified in the device tree.
 	 */
-	msleep(70);
+	if (pdata->panel_hpd_delay_ms >= 0)
+		msleep(pdata->panel_hpd_delay_ms);
+	else
+		DRM_WARN("HPD not supported; consider a hardcoded delay\n");
 
 	/* DSI_A lane config */
 	val = CHA_DSI_LANES(4 - pdata->dsi->lanes);
@@ -656,6 +678,7 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
 {
 	struct ti_sn_bridge *pdata;
 	int ret;
+	u32 val;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		DRM_ERROR("device doesn't support I2C\n");
@@ -712,6 +735,12 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	if (!of_property_read_u32(pdata->dev->of_node,
+				  "ti,panel-hpd-delay-ms", &val))
+		pdata->panel_hpd_delay_ms = val;
+	else
+		pdata->panel_hpd_delay_ms = -1;
+
 	pm_runtime_enable(pdata->dev);
 
 	i2c_set_clientdata(client, pdata);
-- 
2.19.1.568.g152ad8e336-goog

