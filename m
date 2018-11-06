Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F817C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D238C20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X6s7olJm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bOHTHhTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D238C20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeKFPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:33:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbeKFPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:33:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7316660316; Tue,  6 Nov 2018 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541484621;
        bh=f5AB1iGI5di9YNUBEzqtoGEyGn/IQd9ivvTjrrB1Hj8=;
        h=From:To:Cc:Subject:Date:From;
        b=X6s7olJmo1OsgkFJWHtlyPLPYpMPAlLg470j47tbbBwrlk7bZGac9gSPQtu0JqliT
         epOkx0VQ/GEPt9osg0Cfp+vcbBEUXj9cpR5xZWji/TOA97YOB3I8hXL+Y21U6pW7H4
         WLiTKb2/6KGRjyegE7HP93tSshVIkAfyg4HPJ1t0=
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71EF3602F4;
        Tue,  6 Nov 2018 06:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541484620;
        bh=f5AB1iGI5di9YNUBEzqtoGEyGn/IQd9ivvTjrrB1Hj8=;
        h=From:To:Cc:Subject:Date:From;
        b=bOHTHhTG8cWeSlneLzLjytQ5OnQrJHS61W3S+VYwz9Qq77nXX7n6t3lcneVEtHQBh
         256iMX/wxh0BBPAt77CJ95cJF5dAQ3PLYKCI/BsXB6i/VThGG5+aE2BYsMj8M0q3ws
         unkopXAAYwPvxYnIe5ueF557JVHaLCi9m+cfCk/4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71EF3602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        chris@chris-wilson.co.uk, jcrouse@codeaurora.org,
        robdclark@gmail.com, linux-kernel@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH 1/3] drm/msm: use kvmalloc for ring data in gpu crashstate
Date:   Tue,  6 Nov 2018 11:40:04 +0530
Message-Id: <1541484606-20813-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ringbuffer data to capture at crashtime can end up being large
sometimes, and the size can vary from being less than a page to the
full size of 32KB. So use the kvmalloc variant that perfectly fits the bill.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 141062f..c93702d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -406,7 +406,7 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state)
 				size = j + 1;
 
 		if (size) {
-			state->ring[i].data = kmalloc(size << 2, GFP_KERNEL);
+			state->ring[i].data = kvmalloc(size << 2, GFP_KERNEL);
 			if (state->ring[i].data) {
 				memcpy(state->ring[i].data, gpu->rb[i]->start, size << 2);
 				state->ring[i].data_size = size << 2;
@@ -445,7 +445,7 @@ void adreno_gpu_state_destroy(struct msm_gpu_state *state)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(state->ring); i++)
-		kfree(state->ring[i].data);
+		kvfree(state->ring[i].data);
 
 	for (i = 0; state->bos && i < state->nr_bos; i++)
 		kvfree(state->bos[i].data);
-- 
1.9.1

