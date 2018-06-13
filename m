Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B238C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEE5208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/o8iHMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEE5208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935935AbeFMPJH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:09:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34311 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935694AbeFMPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so3163156wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7vPJ6C9yMPpfGQpi9Z8sz0LII9z4TumPUUp9BsvfwU=;
        b=b/o8iHMunGPtkbYsi84qKwhpRvA7FlRf0zIU5ZBlR9ixNFKvIdQl1fozVAdMeE/MOf
         eDgMGQEgCYSUay6r8SNSxmdiChMvgNP9QFi0W4pJ2C3y1T66gl9ZIWBtcrb0HAgK4zLX
         Tg3YzTu+5GYuxFRmN6V2Br/i76ni2tgZvIy2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7vPJ6C9yMPpfGQpi9Z8sz0LII9z4TumPUUp9BsvfwU=;
        b=erOmqK1eOkPaacBWt3VT1bxJhrLEUsLov682IcVkoNuCYdwEZPraf4Mfx6LwpD1BSN
         tizTRXpr2nduaO5x7CLOD4LO3x4i7l6ouPmygBQa/uPKQ8LT968js0BorJeD5/jGX6tH
         s3gUOP0zhkdOvKeFbTUqGop6DCUNjbiWcI+ey5FjlLjJNPF5WQhk2LXg0R/xCLDXZQ1L
         kVyrtVFvGAWf4w91RLP2ppYW7qbJXe5uAejJ5gwjNiOTuAfF4Hql2Od1W2/zMZubUMem
         0M3PlHAwdBWxth+EPEqrrAj/Z4Sb68WBIAz7rfCJMtze29OWWwt1DBQpV9BUkHlDmOuK
         z1xQ==
X-Gm-Message-State: APt69E3QXlokTcHse0MFc52PPi6W2o4rYV28FJjHkaJtHqiBpH44dZFm
        zb4Ezzm7SWtv8LghKRHm1fiddA==
X-Google-Smtp-Source: ADUXVKKFwF1rsVWBgw7sTHkPZ/UNhYqZzXDOLPSY1eKLL/+yBC8HuuyTSfEBBWpJWuBfwsXBR4n8SQ==
X-Received: by 2002:adf:ee0e:: with SMTP id y14-v6mr4439491wrn.63.1528902543885;
        Wed, 13 Jun 2018 08:09:03 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:03 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 01/27] venus: hfi_msgs: correct pointer increment
Date:   Wed, 13 Jun 2018 18:07:35 +0300
Message-Id: <20180613150801.11702-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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

