Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91F9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78503206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IF9etCmL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jj/YAShB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78503206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeK2FcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:32:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725761AbeK2FcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:32:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 21DB4601C4; Wed, 28 Nov 2018 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543429775;
        bh=ei81HWo7Dpp6+q3denXZpXf2opNyFdYdoexeLRrE4IU=;
        h=From:To:Cc:Subject:Date:From;
        b=IF9etCmLvOqeJsIBHTg7xxItRauqVdW77d5R4wJWnsi6JeHbsn5qZ3xwyTIxsqZP8
         EUkAbNJEy+oItg+tPNIHrMlDocKmgRqaz2BZ1YpWmyFX+0d7ZvVL/TNpDufI8vyLAc
         ckcwteSd4wt5VAoAa3WXyZKo5iOEGZkXxkPd2+L8=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D8CD601C4;
        Wed, 28 Nov 2018 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543429774;
        bh=ei81HWo7Dpp6+q3denXZpXf2opNyFdYdoexeLRrE4IU=;
        h=From:To:Cc:Subject:Date:From;
        b=Jj/YAShBDC7Xx+HA6B/ortStT7Cu0Q/A+kWOwJqJFmOJBInW7AoA/6+QBxYLsnPeX
         NGDpzKexgyzvvhNlK8cdpTlBcgDs/KKAKPaoL33nLuHACpOZqr+6hZ5TZre0rl/BZj
         a8NFCbL8Z4ueVmWbKmimcGt4N1N/+IP01SVj50kU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D8CD601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 0/1] drm/msm/a6xx: Add interconnect support
Date:   Wed, 28 Nov 2018 11:29:28 -0700
Message-Id: <20181128182929.19925-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I heard at LPC that there was some confusion that the OPP bindings [1]
were needed to land interconnect support. They aren't.

There is a two step process for the SDM845 GPU. First we need a vote (any vote)
because the default bus settings are way too bad for any reasonable
performance.

The next step after that would be to scale the bus request based on the
frequency in order to save power. For that we *do* need a solution but that
can be calmly discussed separately.

This patch accommodates the first step. It cranks the bus to max for GPU
activity and turns it off when the GPU goes to sleep. Hopefully this can
alleviate the confusion and help interconnect land that much quicker.
After that, we can calmly re-introduce the OPP discussion.

This patch depends on interconnect support [2].

[1] https://patchwork.kernel.org/patch/10577303/
[2] https://patchwork.kernel.org/patch/10701287/

Jordan Crouse (1):
  drm/msm/a6xx: Add support for an interconnect path

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 3 files changed, 32 insertions(+)

-- 
2.18.0

