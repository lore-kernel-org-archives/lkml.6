Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B93320823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HVn2vCzV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cUGvOTrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfBDQPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:15:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfBDQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:15:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 18F016090B; Mon,  4 Feb 2019 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296952;
        bh=i/9xs5tXwe1lwQwwJZyf349mfbz+v3WCI2sDqzwHLoo=;
        h=From:To:Cc:Subject:Date:From;
        b=HVn2vCzVHnzCdgPWhNcJdzv7Nt0fBZzVdqnfoKDHfCxj908laRJvE3tFgwNV8wFbh
         zraYwe80JDFP5OaIBqi9W953/UKe5qgS50xwn7om4c4VVjWpCf0rsUtGbmgqMvljQM
         yTI7vKjOsni0ECrbj3X6UZn7wvvh2290d1/wd7/c=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09B0960134;
        Mon,  4 Feb 2019 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296950;
        bh=i/9xs5tXwe1lwQwwJZyf349mfbz+v3WCI2sDqzwHLoo=;
        h=From:To:Cc:Subject:Date:From;
        b=cUGvOTrJkasM7nqHk8FEaVzOFR3rs9u8uXugcESSDxKpjB8t1HmiW/tbVUp5TLzP1
         HRFYcbSJks4LDu5XfRamMsOAdp6bjvwAheokkJSiiGg6fcVL74zanJZMUhGSsjm3oH
         3Gyx7MsdIuBCsC7cNoBNNEUT40pr6fi+pgOiJEyQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09B0960134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 0/6] drm/msm: Improved a6xx GMU reset
Date:   Mon,  4 Feb 2019 09:15:38 -0700
Message-Id: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a stack of changes for 5.1 (if I'm not already too late). The bulk of
the changes implement a better GMU reset sequence using the new gpucc power
domain added in 5.0. If a GMU fault occurs during runtime we try to do a
standard GPU recovery and if the fault happens during GMU start then try to
fail somewhat gracefully than BUG_ON.

There will be a DT change to go along with this, but we can send that along
after the core code is merged. The downside for not having the domain
properly listed is that the runtime reset sequence probably won't work which
is no worse than it is today.

Jordan Crouse (6):
  drm/msm/a6xx: Remove unwanted regulator code
  dt-bindings: drm/msm/a6xx: Add GX power-domain for GMU bindings
  drm/msm/gpu: Attach to the GPU GX power domain
  drm/msm/a6xx: Make GMU reset useful
  msm/drm/a6xx: Turn off the GMU if resume fails
  drm/msm/a6xx: Remove an unused struct member

 .../devicetree/bindings/display/msm/gmu.txt        |  10 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 200 +++++++++++++--------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   9 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  20 +--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   3 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   1 +
 6 files changed, 144 insertions(+), 99 deletions(-)

-- 
2.7.4

