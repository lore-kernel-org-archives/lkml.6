Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61437C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8736320665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WvWxRfdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8736320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeJWFJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:09:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbeJWFIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:08:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so4022093pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBL7kzRm+AuhpncrtwVUlUGI2jFAGP9j8c7KtXaIcaE=;
        b=WvWxRfdmXjkkJEie+3AqQVb0SqhLpcxb6Gt/u6TEsYEg1K9lb/EICA1Jv09ZoxzYAd
         k6fCOad9/7zf0AfKZaMgTwmKQRmV5laACtdN7L3GNKUSuZ0uz0+jTgw650O/W6eAp231
         POLXtaGYqWcS4wxkhvV3N8WF5AifY71zD+zTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBL7kzRm+AuhpncrtwVUlUGI2jFAGP9j8c7KtXaIcaE=;
        b=lcl7eKpBylZI2SOsU0fVd+sOvGXfyWbiayi7iEuXK6pDVmEwTCWGOtf+P8gIVFRiug
         sz8MeQ6msgGa2zdphGHi0EPnbkxgBjuZDsWHkXM2q6RumaS+blzM8p1YOmqAbX4z+4oZ
         dBvQToxrYEW2p2BcRBLCp+GDqT7llE/vbVbwfRVlGI8N1WZ3zzSVkdnslkoQMZuqJgAG
         DbLUFDYeJMYrWdCgsp7ctE9OOGrMqI4PC9FaAALvLqC5aafrcRuBxFQV19Vy0Vrchtan
         8EKcs0Mrl3/QSsmHLnh9lpueDy7HUIIQ3nGoxZZ4zA9pTDIvJyd01gTYSRt983lxwX35
         4IeQ==
X-Gm-Message-State: ABuFfogHjvczdkpfFLwVMJnzdn2mNUKoBLdc9f7UOuztelg5QpfoyPQx
        U6oXbjWSfAbLo+k4EKeGDySDXQ==
X-Google-Smtp-Source: ACcGV63YMycIoSi70RRH3/rYbV0oT9IDSrQ1DcBsrtc4nxcveSax6GMLdak4HCfvGACQDSF1ADW7GQ==
X-Received: by 2002:a62:75c7:: with SMTP id q190-v6mr47491226pfc.137.1540241322852;
        Mon, 22 Oct 2018 13:48:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id y144-v6sm47483001pfb.81.2018.10.22.13.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:48:42 -0700 (PDT)
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
Subject: [PATCH 3/6] drm/panel: simple: Add "no-hpd" delay for Innolux TV123WAM
Date:   Mon, 22 Oct 2018 13:46:36 -0700
Message-Id: <20181022204639.8558-3-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181022204639.8558-1-dianders@chromium.org>
References: <20181022204639.8558-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the HPD signal isn't hooked up to this panel we need a 200 ms
delay.  In the datasheet this is shown as the maximum time that HPD
will take to be asserted after power is given to the panel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 38c646fb55fd..937e97490c30 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1393,6 +1393,8 @@ static const struct panel_desc innolux_tv123wam = {
 		.height = 173,
 	},
 	.delay = {
+		.prepare = 200,
+		.prepare_delay_only_if_no_hpd = true,
 		.unprepare = 500,
 	},
 };
-- 
2.19.1.568.g152ad8e336-goog

