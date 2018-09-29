Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ACBC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D599B2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CBz7PkcR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SJ6GeSdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D599B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeI2S3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:29:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeI2S3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:29:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C4357609A8; Sat, 29 Sep 2018 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538222465;
        bh=iXCfK9aOM52GK3s6zuZjO0C42P/1OJbKV7Q83ZSNahk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBz7PkcRocL/Bc/vmT2/gZ/mE2aH43btYSncPLQZE1Nr6iKjsnHH6aEoDjfRzQGDP
         /Sq02qzWSVLTSTgGNw/n7xukS8a4jS+pii0HjxXxUisfW2ANMYzkVMzYQmOYOMtmys
         PcVpHbZDJAvcGO6avDUDGG2x6CVkBvYqzxdCnu9E=
Received: from sgorle-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sgorle@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3C7460C61;
        Sat, 29 Sep 2018 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538222464;
        bh=iXCfK9aOM52GK3s6zuZjO0C42P/1OJbKV7Q83ZSNahk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJ6GeSdR5/tlTQPc/lmxQFWOnPAatdU6rvoccZJErsIYcwURqC3Hs3q5muD+2l7XD
         p5mcjQY3PEkVOWu2UNm7KXPZFZ7usc4caihMVJ051rXRJxYirnDDCttp9rZNQPVsw6
         8Sfsig6DX1QlW/g+SnS92gffqBZMgLWHqPeF6X/8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3C7460C61
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sgorle@codeaurora.org
From:   Srinu Gorle <sgorle@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sgorle@codeaurora.org
Cc:     acourbot@chromium.org, vgarodia@codeaurora.org
Subject: [PATCH v1 5/5] media: venus: update number of bytes used field properly for EOS frames
Date:   Sat, 29 Sep 2018 17:30:32 +0530
Message-Id: <1538222432-25894-6-git-send-email-sgorle@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- In video decoder session, update number of bytes used for
  yuv buffers appropriately for EOS buffers.

Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 311f209..a48eed1 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -978,7 +978,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 
 		if (vbuf->flags & V4L2_BUF_FLAG_LAST) {
 			const struct v4l2_event ev = { .type = V4L2_EVENT_EOS };
-
+			vb->planes[0].bytesused = bytesused;
 			v4l2_event_queue_fh(&inst->fh, &ev);
 		}
 	} else {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

