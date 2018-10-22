Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7D4C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2239020663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nqXfSozc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2239020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeJWFIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:08:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34226 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbeJWFIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:08:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id f78-v6so14731681pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4oR4ZDStg+E8v2cNbJRHjDjC6miXn++j6pN4qN/OJI=;
        b=nqXfSozcAlJrz1vA+akqt+4QjA8aOz/5RxsauYp28eURs/+12vol0mT8/oWCjXuEKF
         R5fyotPtUyZgAikNitKS/QGtlX2Ia1PmQF5HQWajN4zcPEekkwJb4N/Ghz2kC7axxTPq
         H21xkrnPG2bkX0BylaE7Q3h38kpErbrrTGrW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4oR4ZDStg+E8v2cNbJRHjDjC6miXn++j6pN4qN/OJI=;
        b=Q7STu71j/KlpGI1m777PaZTP29DTToKOjOvkU+P6C9zrsptToM5FgtfCDBjfsxtPYo
         shpCtE0jta2BqLwHYUaii2Pv3byeLTGuqB+lPqfRKzrLI+LAhXe6vjhwvvz5VWa1hH3l
         Job76seClpQHx8jCXT7HUaKeaI9QKOaiPwg6xwAOPrdJkk+2ymzhuQmRh7XrjKjuMCt5
         o2tUM3H15mK+5g0ouQPC6M6zj/lZpj2QrZHmsWctwga+Noz/qayt2urd+VzJ2QDUvCqf
         yp+aHic1SZhyNaEqfoAuibBNpGGFAWOyOQc2lX9/jzmsEC5i1trq/aTrGYQtqCgJx0tz
         OUFA==
X-Gm-Message-State: ABuFfohT61yXpKmle25qWzcK/pKrcCKAOYBmvPrsPfY6Up/PFmoV9Ktb
        h7xYdks9JmdrPmu6Kg2vj2xhNQ==
X-Google-Smtp-Source: ACcGV63u11X6gLB9SFur48dm4ZHAR463bY0tjVxvEDCR4idABHAPtyeTVUOGrN34Y4N7CbIYt2JyAA==
X-Received: by 2002:a62:8685:: with SMTP id x127-v6mr24358904pfd.252.1540241321478;
        Mon, 22 Oct 2018 13:48:41 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id y144-v6sm47483001pfb.81.2018.10.22.13.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:48:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] drm/panel: simple: Support panels with HPD where HPD isn't connected
Date:   Mon, 22 Oct 2018 13:46:35 -0700
Message-Id: <20181022204639.8558-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181022204639.8558-1-dianders@chromium.org>
References: <20181022204639.8558-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some eDP panels that are designed to be always connected to a board
use their HPD signal to signal that they've finished powering on and
they're ready to be talked to.

However, for various reasons it's possible that the HPD signal from
the panel isn't actually hooked up.  In the case where the HPD isn't
hooked up you can look at the timing diagram on the panel datasheet
and insert a delay for the maximum amount of time that the HPD might
take to come up.

Let's add support in simple-panel for this concept.

At the moment we will co-opt the existing "prepare" delay to keep
track of the delay and we'll use a boolean to specify that a given
panel should only apply the delay if the "no-hpd" property was
specified.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..38c646fb55fd 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -63,12 +63,15 @@ struct panel_desc {
 	 *           turn the display off (no content is visible)
 	 * @unprepare: the time (in milliseconds) that it takes for the panel
 	 *             to power itself down completely
+	 * @prepare_delay_only_if_no_hpd: The prepare delay should only be done
+	 *                                if we know Hot Plug Detect isn't used.
 	 */
 	struct {
 		unsigned int prepare;
 		unsigned int enable;
 		unsigned int disable;
 		unsigned int unprepare;
+		bool prepare_delay_only_if_no_hpd;
 	} delay;
 
 	u32 bus_format;
@@ -79,6 +82,7 @@ struct panel_simple {
 	struct drm_panel base;
 	bool prepared;
 	bool enabled;
+	bool no_hpd;
 
 	const struct panel_desc *desc;
 
@@ -215,7 +219,8 @@ static int panel_simple_prepare(struct drm_panel *panel)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
 
-	if (p->desc->delay.prepare)
+	if (p->desc->delay.prepare &&
+	    (!p->desc->delay.prepare_delay_only_if_no_hpd || p->no_hpd))
 		msleep(p->desc->delay.prepare);
 
 	p->prepared = true;
@@ -305,6 +310,8 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	panel->prepared = false;
 	panel->desc = desc;
 
+	panel->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
+
 	panel->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(panel->supply))
 		return PTR_ERR(panel->supply);
-- 
2.19.1.568.g152ad8e336-goog

