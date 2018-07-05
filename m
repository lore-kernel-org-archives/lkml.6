Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDDDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F7B20847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbLROi+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F7B20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeGENFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:05:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54988 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbeGENFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so10960233wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7vPJ6C9yMPpfGQpi9Z8sz0LII9z4TumPUUp9BsvfwU=;
        b=HbLROi+4L0Sw6tgE44gsvKRAAmatlQ8sr/4qOvqYuxgj4yiTm7tmGvzdhPNOCWrwRZ
         ZiFJxmFclw9ALZPOZANCgljlrMye3QwFzLDGdm4t1bzSR82ozeUz2LRedNy0a5ZVOC63
         wlBuW+5pgeOPsfRKsbusJY+/B0iDn2bnjUFyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7vPJ6C9yMPpfGQpi9Z8sz0LII9z4TumPUUp9BsvfwU=;
        b=nQ+idHP+OQ9EUAh3SS2+Psm9nvtpv1McpjovctZYb8VcZmtT57o21kPexamUpXTWW4
         ezAUxfWjOCdHR/3+OdNIW3qXrPumhZr/UImFCYVkmrJiCRU44sNOWDzm+k9mJ09bKaae
         YghOMSx+ZJyiAfshmcFO+ZzUCN90uDyF1ZbW4tcanrTJMi6CxY6EDhkm5+UpW2t2kRAP
         U3/1zjHICsxw3QML6nL4+DIsRp5M9YHj90BQQc+/LO87ixT0dmzK82CM50fmpgJjZ8Aq
         6S+xwl+z6jhDKMVaJTuXL05OIzj5BjJ2xoEmxrfzlNFVGTa/L2U3pyjQ2HKZhJFHgQdx
         uspQ==
X-Gm-Message-State: APt69E2IjwP3yd0r1plz0hN9h5ZmztR8i9MzVqTwWnXFZeR86OCll7rj
        bxlJ5swiaOMpmS/STlSVEfQ6AQ==
X-Google-Smtp-Source: AAOMgpd0QOpyUJQzpqpGCWP/aSGPNUN/DjAYA1L8ClpnrPRV1+z3GPd0pGB4kGDMZO/3p533HCQp4Q==
X-Received: by 2002:a1c:15ce:: with SMTP id 197-v6mr3807155wmv.99.1530795907043;
        Thu, 05 Jul 2018 06:05:07 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:06 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 01/27] venus: hfi_msgs: correct pointer increment
Date:   Thu,  5 Jul 2018 16:03:35 +0300
Message-Id: <20180705130401.24315-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data pointer should be incremented by size of the structure not
the size of a pointer, correct the mistake.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_msgs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 90c93d9603dc..589e1a6b36a9 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -60,14 +60,14 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 			frame_sz = (struct hfi_framesize *)data_ptr;
 			event.width = frame_sz->width;
 			event.height = frame_sz->height;
-			data_ptr += sizeof(frame_sz);
+			data_ptr += sizeof(*frame_sz);
 			break;
 		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT:
 			data_ptr += sizeof(u32);
 			profile_level = (struct hfi_profile_level *)data_ptr;
 			event.profile = profile_level->profile;
 			event.level = profile_level->level;
-			data_ptr += sizeof(profile_level);
+			data_ptr += sizeof(*profile_level);
 			break;
 		default:
 			break;
-- 
2.14.1

