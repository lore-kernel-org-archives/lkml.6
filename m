Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A58D20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AP0Ic7Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfAWKkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:40:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40856 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfAWKk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:40:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so1429017wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=naLY3DB0fFEF8+rWJZdD/W2PWV9f5z/z6JViBOnJMqA=;
        b=AP0Ic7Dw6nbX4EKdi7eU2eD9LCpW+dpTatSpIiS2Q1A3NR7W3Q8/URmgmw0IHd2yeR
         C0qVa7293afRu1eo7qa0ibm4KzFdLuOUc8BMYSAkV26oC9duPuh9kGOni1aKensDY/RC
         XYhFo5GCXynz5jByS374zHWrLWMpNGtrYL4aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=naLY3DB0fFEF8+rWJZdD/W2PWV9f5z/z6JViBOnJMqA=;
        b=Oo45ZFcrHfxe1fEuUO0naJp7W3kUN+0TDYHh4PGFPH5ZVf98ThytXKH2RXVK8qFaMo
         d1G0bipIS4yNdwu6lKX1mG9Ge7PazyvMjttMi71016ds7O2Tq7hf9pc9ftFHJRJMqj6F
         TMUVFgoV8VdSsPhREBAPTl8JwA06yPwNFvXLQwJXzW2Zne8XxfNTFFKIYRyByfT7ABmH
         ZkLfMZPj9eyi2DQCdBi7xIV+TjNG3qbT0XDsFIned1QwTntDPlqyp1H5GVi9evdjwikg
         zQd2MmJ0SeAmGbztjaUUv4c78cVDOYqO0suhsoypqkXuzHY9V9ZU5J3vJlMKJX1z/zxF
         RMVg==
X-Gm-Message-State: AJcUukc/au+PaaVoCHfgG6OF7fbfAThiwpRNIWC82m/gHOVjtn8XcAUC
        8+e+cvxVx6NU9LcDBt3La5JRyA==
X-Google-Smtp-Source: ALg8bN6Eu+1iHB3IH61SXRZhLMWr+urYzCcDTEH7aZ3k0QveqDjZcd49XYdOjBMBZ062rIrndu99tw==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr2098756wmb.107.1548240026882;
        Wed, 23 Jan 2019 02:40:26 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id b18sm84525211wrw.83.2019.01.23.02.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:40:26 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 4/4] venus: helpers: drop setting of timestamp invalid flag
Date:   Wed, 23 Jan 2019 12:39:49 +0200
Message-Id: <20190123103949.13496-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123103949.13496-1-stanimir.varbanov@linaro.org>
References: <20190123103949.13496-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zero timestamp is really valid so fix that mistake by
dropping the code which checks for zero timestamp.

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
Tested-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index e436385bc5ab..5cad601d4c57 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -439,9 +439,6 @@ session_process_buf(struct venus_inst *inst, struct vb2_v4l2_buffer *vbuf)
 	fdata.flags = 0;
 	fdata.clnt_data = vbuf->vb2_buf.index;
 
-	if (!fdata.timestamp)
-		fdata.flags |= HFI_BUFFERFLAG_TIMESTAMPINVALID;
-
 	if (type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		fdata.buffer_type = HFI_BUFFER_INPUT;
 		fdata.filled_len = vb2_get_plane_payload(vb, 0);
-- 
2.17.1

