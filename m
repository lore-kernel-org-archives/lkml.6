Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C5908C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78111208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OuJEOuzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78111208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbeFNHrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:47:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38303 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754810AbeFNHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:47:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id b74-v6so2799125pfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mHz5AKgDUD0rTL77iNLGvl6AY6qKgjnmhQn6Klvek3I=;
        b=OuJEOuzt8lDtj0E9xEkgKSY5UZkP4XD54wZe4Y5QL4t/Og+bc5g7tEar5SeCYLufun
         JLPVybAvoew7qwuQhsBW5vH3RY6xhzFtt9x2/zIgMGh+UkmUHYqyKAL8ZKDFIc8rb7Ab
         lVOBmmGNizz7/zctHOKP87F+vlGiyyoX6wAsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mHz5AKgDUD0rTL77iNLGvl6AY6qKgjnmhQn6Klvek3I=;
        b=nYUm0ij48OpV+r2idAZDOTjWfYjAQ7rzWBkLobLDHMYr3gWxooH39yWZux1GLXvaF5
         pV0HRYAGIjjAgYzt/cZWuzV1Nx18WsjW4p4l6vMK5Q+AHsvTJJpVE5xjsZvlP5HmwIJc
         GS9jJw91D4XFjsaC0T17onE7C6AGxFXp1Xg4C5SqYYQEtWR6kxE1ViNQU0M4uW8YTZrH
         WdKXxqNvsiozLYZeLgq7QK4X6Qf6IhJ3G8GIDb6Er84hxvZ7DDfhGFSokWs5XgPgyhAy
         GaLyvA+oA71UZacKxbH1I732W10zJC/+XbsSV3fto/wQyjZ5jfeO2iE7/zqA5GPGjSkt
         VQ6Q==
X-Gm-Message-State: APt69E26DL3tCmXocVUPJNUQ3SR/PaAC5FKSxfZTgouZxqqyA4BCQRm+
        DS3qtcJtlaYEy0Z/fD7YhA56XsRoKUs=
X-Google-Smtp-Source: ADUXVKJFw40Sz6xHc/SJcXOQ4PGZQj47xp7ojQxee7OZbCk9N+6XY4fo0SrycVCRUadAx9NfwczUJw==
X-Received: by 2002:a65:6303:: with SMTP id g3-v6mr1370545pgv.424.1528962460873;
        Thu, 14 Jun 2018 00:47:40 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:4:4:968c:de0d:27a3:4bef])
        by smtp.gmail.com with ESMTPSA id y11-v6sm6522788pfn.92.2018.06.14.00.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 00:47:39 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        s.nawrocki@samsung.com
Subject: [PATCH v3 3/3] media: mtk-vcodec: Support VP9 profile in decoder
Date:   Thu, 14 Jun 2018 16:46:52 +0900
Message-Id: <20180614074652.162796-4-keiichiw@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180614074652.162796-1-keiichiw@chromium.org>
References: <20180614074652.162796-1-keiichiw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2_CID_MPEG_VIDEO_VP9_PROFILE control in MediaTek decoder's
driver.
MediaTek decoder only supports profile 0 for now.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 86f0a7134365..ba986232b953 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -1400,6 +1400,11 @@ int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 				V4L2_CID_MIN_BUFFERS_FOR_CAPTURE,
 				0, 32, 1, 1);
 	ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	v4l2_ctrl_new_std_menu(&ctx->ctrl_hdl,
+				&mtk_vcodec_dec_ctrl_ops,
+				V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
+				V4L2_MPEG_VIDEO_VP9_PROFILE_0,
+				0, V4L2_MPEG_VIDEO_VP9_PROFILE_0);

 	if (ctx->ctrl_hdl.error) {
 		mtk_v4l2_err("Adding control failed %d",
--
2.18.0.rc1.242.g61856ae69a-goog
