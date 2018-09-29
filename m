Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEFCC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF42320666
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ia9uDrJi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GLiGELtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF42320666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeI2S27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:28:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52836 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeI2S26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:28:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6CA2B609A8; Sat, 29 Sep 2018 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538222446;
        bh=+251beCEr1xRSSBtRacwQHTrms5RiajOnsKcZfYmjfY=;
        h=From:To:Cc:Subject:Date:From;
        b=ia9uDrJi8Bn4scajGvs1z7xYYQX42qO2SV+H7xlbi3mro4jac629RagrZpkphI/Sk
         II7kzBYy18lqNU3ivnhVSW+Yz2AjTAG2W0F4NgigRrO4sxUfqVHMYSwgvN3FLK6/V5
         amAxu/1CvhmuNmeWKdPx4vm+/xTVf64zONVKmFlg=
Received: from sgorle-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sgorle@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF326602F1;
        Sat, 29 Sep 2018 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538222445;
        bh=+251beCEr1xRSSBtRacwQHTrms5RiajOnsKcZfYmjfY=;
        h=From:To:Cc:Subject:Date:From;
        b=GLiGELtBFXtitNosTwbN7akqt8WTRcgEXXv3zG3GjH8+XycOUVW6PHWUmU/neI/Uh
         XKBOjNmxzMFQ/EG99rzJ/4sHrrhBYbgbHBD1P/WkNPkjMnac9V2AYlNHdxQBzz1+a5
         9j6kiPE7OaaMOVA+MrLyxrlpIjLGDR/PzuHc1q0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF326602F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sgorle@codeaurora.org
From:   Srinu Gorle <sgorle@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sgorle@codeaurora.org
Cc:     acourbot@chromium.org, vgarodia@codeaurora.org
Subject: [PATCH v1 0/5] Venus - Decode reconfig sequence
Date:   Sat, 29 Sep 2018 17:30:27 +0530
Message-Id: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch set mainly adds logic to handle multiresolution clips
for video decode. And also added few miscellaneous fixes.

The patch set is based on top of recent Venus updates - PIL v9 patches
posted by Vikash Garodia.
This patch series to align with https://patchwork.linuxtv.org/patch/52153/ 

Comments are welcome!

Regards,
Srinu Gorle

Srinu Gorle (5):
  media: venus: handle video decoder resolution change
  media: venus: dynamically configure codec type
  media: venus: do not destroy video session during queue setup
  media: venus: video decoder drop frames handling
  media: venus: update number of bytes used field properly for EOS
    frames

 drivers/media/platform/qcom/venus/helpers.c | 210 ++++++++++++++++++++--------
 drivers/media/platform/qcom/venus/helpers.h |   4 +
 drivers/media/platform/qcom/venus/hfi.c     |   8 +-
 drivers/media/platform/qcom/venus/hfi.h     |   2 +-
 drivers/media/platform/qcom/venus/vdec.c    | 114 +++++++++++++--
 drivers/media/platform/qcom/venus/venc.c    |  20 ++-
 6 files changed, 285 insertions(+), 73 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

