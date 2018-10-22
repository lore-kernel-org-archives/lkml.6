Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F930C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAA620853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAA620853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeJVUYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:24:24 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:62590 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727787AbeJVUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:24:24 -0400
X-IronPort-AV: E=Sophos;i="5.54,412,1534789800"; 
   d="scan'208";a="214746"
Received: from ironmsg04-blr.qualcomm.com ([10.86.208.133])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Oct 2018 17:35:17 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9053"; a="1911363"
Received: from mgottam-linux.qualcomm.com ([10.204.66.66])
  by ironmsg04-blr.qualcomm.com with ESMTP; 22 Oct 2018 17:35:16 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id 7FFED3043; Mon, 22 Oct 2018 17:35:15 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH v2] media: venus: handle peak bitrate set property
Date:   Mon, 22 Oct 2018 17:35:12 +0530
Message-Id: <1540209912-24834-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max bitrate property is not supported for venus version 4xx.
Return unsupported from packetization layer. Handle it in 
hfi_venus layer to exit gracefully to venc layer.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index e8389d8..87a4414 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -1215,7 +1215,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
 	}
 	case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
 		/* not implemented on Venus 4xx */
-		break;
+		return -ENOTSUPP;
 	default:
 		return pkt_session_set_property_3xx(pkt, cookie, ptype, pdata);
 	}
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 1240855..9d086b9 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1355,6 +1355,8 @@ static int venus_session_set_property(struct venus_inst *inst, u32 ptype,
 	pkt = (struct hfi_session_set_property_pkt *)packet;
 
 	ret = pkt_session_set_property(pkt, inst, ptype, pdata);
+	if (ret == -ENOTSUPP)
+		return 0;
 	if (ret)
 		return ret;
 
-- 
1.9.1

