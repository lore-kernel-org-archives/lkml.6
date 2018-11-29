Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC44C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B7120989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E3GuDkpm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jRzFjoaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B7120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeK3Ecr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:32:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeK3Ecr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:32:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 98A866060A; Thu, 29 Nov 2018 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543512400;
        bh=/rXvkS8sf9L44rAhHmEAfHNG8RE5BNgzc8IcNYNTxzU=;
        h=From:To:Cc:Subject:Date:From;
        b=E3GuDkpmgvfYKjRgch1SdpERg4zLXGaJRlS7eIO5Un9s1YR5pLzKA0OlSyZC7MNbK
         jC9m4pGsYp/FofJ0DEy8zmCpSNrpaiEsIs7uE3ot1c9C52fn0tMqW+qKKrqhgjh/Iz
         NkOZDjiEEXuw0ibEKPs3HTPUTN2rhfD+Y12TZfHc=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19A1060251;
        Thu, 29 Nov 2018 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543512399;
        bh=/rXvkS8sf9L44rAhHmEAfHNG8RE5BNgzc8IcNYNTxzU=;
        h=From:To:Cc:Subject:Date:From;
        b=jRzFjoaY4V1S4VsGLJAMRKj0v8Js+sNNn4DsEjiPeTzn3mv3gsa9J0IxA8jBiYPwN
         LCM58u4Zd5DpiV2Z0z8wrdB9EMqDlfzEQzhdCI5uponQLHmXlk18FH9rohxucq6fiF
         Miw1PzmBSOVU0jdXxYXaPBGIkQyDNp0C44oUcWe4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19A1060251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH v3 0/1] drm/msm/a6xx: Add interconnect support
Date:   Thu, 29 Nov 2018 10:26:35 -0700
Message-Id: <20181129172636.12839-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(grr - resending because I didn't actually send the correct patch.
My fingers were going faster than my brain).

This is an updated version of [1] adding interconnect support
without OPP bindings to get maximum performance from the GPU.
Big delta here is that I stupidly confused Bps and KBps and
passed a value that overflowed the API. Correct bandwidth
values are now passed.

[1] https://lists.freedesktop.org/archives/freedreno/2018-November/004347.html

v3: Actually send correct patch with correct units
v2: Make sure to pass values in correct units

Jordan Crouse (1):
  drm/msm/a6xx: Add support for an interconnect path

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 3 files changed, 32 insertions(+)

-- 
2.18.0

