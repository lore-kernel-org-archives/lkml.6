Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1DEC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0F22523
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhaMwSNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD0F22523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933996AbeFUXB2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:01:28 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38421 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933887AbeFUXB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:01:27 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so2075319pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7eLzWAmmXuwjezq0sPFwoY5PsCylUJ1NVRF5r7fwXBE=;
        b=DhaMwSNypiX4Odfv3cAOXKlWl6o9SbgdW8Cq9M041mvpa9+wyNIM1xJZCMGdl0z4lZ
         PjxJZ2oDfsW0corLMAbyEiZLY0G7iXRjmCEZ1NzBgoNKCJrQLyFEipZa7KRgZJBpIlw5
         7JYgUeGzTj/RP4GrbAiPr8zdMo+O/aHhuJo/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7eLzWAmmXuwjezq0sPFwoY5PsCylUJ1NVRF5r7fwXBE=;
        b=LgGH94bFmQ37dnUN/Og4VOBC17Xw0m/1UoNDeiP14cvykuK2SHwIiUEh3LW7aRmPeF
         68QCcED98HHMGiCXS9W3KwJ+2m42TpebcmzNcCk1qPjLcjZ4ZkP7tQBOhd6j+VAo2TLk
         Iewalk0ojF3H99A5x8KxFXT/qKU+1weI3kJ/vNwh4LMH/3m44OMgnvhv/PuLSgYm2ohH
         mzZSSiRfgMip5obf6Bxilrct/jLxigS38VIEB9iu2uaRMTT+Jw7ZrQkU5dxzxvyH4SUG
         2yzY/4eU+zQIs+u3onPduNaeWh4Q9sEvrn+SvPxjLideMN9hnRajHOYPa9YIDckZq1l6
         8Qrw==
X-Gm-Message-State: APt69E22g0s1ygFjYpLCIziN5eIpLFRJthwsoMD0mwPMpf/RTF5+4Cbi
        Fj77GJ9atHH1kUobypKDJTGT87u9yGE=
X-Google-Smtp-Source: ADUXVKLwTg9NZKb8B7gzciR6opiLCQ1NPsvS51crwg2oro8Y4GgaoblKJ8pFOaHiOulFYoszCwClZA==
X-Received: by 2002:a65:5d4a:: with SMTP id e10-v6mr21293827pgt.25.1529622085259;
        Thu, 21 Jun 2018 16:01:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id y69-v6sm16060507pfi.108.2018.06.21.16.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 16:01:24 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Griffin <peter.griffin@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH] drm: kirin: Remove useless "Scale not support" error message
Date:   Thu, 21 Jun 2018 16:01:16 -0700
Message-Id: <1529622076-20386-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver doesn't support scaling, but when an atomic test is done
it repeatedly spits out this warning which isn't particularly useful.

So just remove the error message.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 2269be9..bb77420 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -859,7 +859,6 @@ static int ade_plane_atomic_check(struct drm_plane *plane,
 		return PTR_ERR(crtc_state);
 
 	if (src_w != crtc_w || src_h != crtc_h) {
-		DRM_ERROR("Scale not support!!!\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4

