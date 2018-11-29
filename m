Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBDEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A7A20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CTex0HJC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cUK+HaRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A7A20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeK3E1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:27:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK3E1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:27:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7CE0E61322; Thu, 29 Nov 2018 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543512090;
        bh=p45I95JGDyrAIpr4BFxRVR6STinZZ03gLYYIKJiDUg0=;
        h=From:To:Cc:Subject:Date:From;
        b=CTex0HJC+Fe7d/JyZ7hLAG+x86frGw/lqa3jWWfU5F5An74TfrCRIx6G7uPAk8/nR
         L+XlkbWoGr2n3rPdyjIX8U8awYG2ddSMOtx2ursRaPKS38pttMlCGdhXDDPMkpPCVl
         s3tRQbUfoYyuhSDr3FjTnvDxxjHWmO5Ut2VrvbN8=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8860161322;
        Thu, 29 Nov 2018 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543512088;
        bh=p45I95JGDyrAIpr4BFxRVR6STinZZ03gLYYIKJiDUg0=;
        h=From:To:Cc:Subject:Date:From;
        b=cUK+HaRc9HpSPdgwunsc9lOAYYPUhP95Mz5mLXFa+GMls7jAMe5f1aFoOoiXHzsA1
         Cy/1dqbkpmcrg1fHegqzefwNzcVSXPsQJ+4e4B9xIAs9ByYJAAdr+pWIKJauPQodPe
         mdfkSslk8tEcOJN95SFYsLDGnLkhrNzbXF6J4AVY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8860161322
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH v2 0/1] drm/msm/a6xx: Add interconnect support
Date:   Thu, 29 Nov 2018 10:21:23 -0700
Message-Id: <20181129172124.6851-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of [1] adding interconnect support
without OPP bindings to get maximum performance from the GPU.
Big delta here is that I stupidly confused Bps and KBps and
passed a value that overflowed the API.  Correct bandwidth
values are now passed.

[1] https://lists.freedesktop.org/archives/freedreno/2018-November/004347.html

v2: Make sure to pass values in correct units

Jordan Crouse (1):
  drm/msm/a6xx: Add support for an interconnect path

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 3 files changed, 32 insertions(+)

-- 
2.18.0

