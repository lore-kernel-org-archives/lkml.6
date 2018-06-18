Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F5CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7DB20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oPgcYR6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7DB20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeFRIBD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:01:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39191 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933395AbeFRIA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:00:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so7752327pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19t9Afaz9F095eSpm9L0iD1w+YdH1VBIYtySLCVLpyk=;
        b=oPgcYR6+OslLH5YOBfquhkSXLh7r5IcHo/s/Z1qeCXRcmAKd0/Ph1HBcnLKaRCeTsH
         ejQeZngvzyhqzy4m9Z/J885lVNhf3tkFqZO99/I82/nHUqzo1pLNmVlRFEI7VDuBIvot
         hFTYT6L/NkTEt9C0gYYCuSGlQJx+prQw7Z6eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=19t9Afaz9F095eSpm9L0iD1w+YdH1VBIYtySLCVLpyk=;
        b=tEAt34Ircf/K4MZToWuOyfik15hRhyFjhXWrr/tJa+emjkdWqb383/3i/o9/wua/5i
         brzeuksNgEtlDDCjVMvWjvpXzW5LCJWhMx2CMFKgecqbZ6o5790+BdwIbKWcfRkPVqcp
         Y/DMPzOQ/zGF/xD6JwpipAx7cnIYvqO5hAh0z9hMF4EjVGNO9YfOeJ0qt8wj6Tdy4l6w
         abw4BrUM0V+hOmSOk4GL/xx0pjdvNZdvpPvWHGxNof7N3GhH5ffouniWJqkuyJylw/q7
         lp9CLsCApBevR18vkARtRxauvB4en4e0pOq61mUcp3pNBuKhqGXncAbe4mUN8Z95j2sM
         szSQ==
X-Gm-Message-State: APt69E1+dRTdx2trQS4Lwen4XXkGZyzTxzknpdQ9hgYur0QmDpVWBk6v
        lFwfpc967gP17SrzFEG/FlWURw==
X-Google-Smtp-Source: ADUXVKIPYly8RsZrzpK/kE6x1Ib1n2p2KmbbhpWlYY7T8l5GGRWiDjZTFu1PNVArKHWqjvHlXPzY6g==
X-Received: by 2002:a65:660a:: with SMTP id w10-v6mr9878623pgv.366.1529308857942;
        Mon, 18 Jun 2018 01:00:57 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:4:4:968c:de0d:27a3:4bef])
        by smtp.gmail.com with ESMTPSA id d9-v6sm23543236pfg.183.2018.06.18.01.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 01:00:56 -0700 (PDT)
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
        Smitha T Murthy <smitha.t@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 3/3] media: mtk-vcodec: Support VP9 profile in decoder
Date:   Mon, 18 Jun 2018 16:58:54 +0900
Message-Id: <20180618075854.12881-4-keiichiw@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618075854.12881-1-keiichiw@chromium.org>
References: <20180618075854.12881-1-keiichiw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2_CID_MPEG_VIDEO_VP9_PROFILE control in MediaTek decoder's
driver. MediaTek decoder only supports profile 0 for now.

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
2.18.0.rc1.244.gcf134e6275-goog
