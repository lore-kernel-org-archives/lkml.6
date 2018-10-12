Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F694C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A272075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXQ6yJRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A272075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeJLRSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:18:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35037 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbeJLRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:18:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so12728539wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fj+7EoEdVPROEqPaaG3k8BtrrHPDYAMQc/zQGLYJ0t8=;
        b=VXQ6yJRVEGzFs3tcOo+33WTBXBsxRo5HPSNg32M+O9PIIHQoDxPTe1TxWj63Tz2EEV
         b4rL19ViM2cjdpzkt6isBzkQfzLmU/0UyXLV5wmYcAYiB7K09O5vtWdTaXn8MJZHFkxL
         /t3Hn1FOCpidszentyDMZz7Th1UNIoCYRbQjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fj+7EoEdVPROEqPaaG3k8BtrrHPDYAMQc/zQGLYJ0t8=;
        b=JL9uRWi0c7N31mLcMFEb1zpjI7H7btOXo3maoCEu4ADCdowQdibfMzZjMYpdunLJDC
         DnJcuIw1ngkgNTc/9ru72OBfciAW5aafKFv9q5tSPNR/9/dF0hLhic4lfEFnyg6HXFku
         N3SEXoF4Qa+fdGiWZxzzeWFcopqdfD3TwAiYNsXsnO0WIwGXJLjoEioe22nklo3dQw/h
         lqpKRLDWmyCxR92MDuwOjB3fAXmFaZWSyBU7Ho8Z0q00l9eo8R+2WybmcSLWd0mYppBB
         CK20m21pY+5IhH6vui+eUcbQ4s04Emn1GIoZaQGlzmDBiMtY8dFgsjuL6burjIk1xr1s
         Z68Q==
X-Gm-Message-State: ABuFfoiq844QR/7EfHJ0mWYPPYXkvXlPunUpUqZIxkZWo25UasTLxneo
        Qtg+JJogoinCh2b0KHeep9ZSYQ==
X-Google-Smtp-Source: ACcGV62J2KgqQiCLwTdRmTlkgPbMKTrMQn6JdL634pBuJ6y5WUS8vWlHhexZZ0a8q6HoURKS5UATUQ==
X-Received: by 2002:adf:fdc2:: with SMTP id i2-v6mr4984383wrs.276.1539337620952;
        Fri, 12 Oct 2018 02:47:00 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1087:9ad4:c93a:12ce:b821:38d7])
        by smtp.gmail.com with ESMTPSA id s7-v6sm8430203wmd.0.2018.10.12.02.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 02:47:00 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH] drm/sti: make crct disable atomic
Date:   Fri, 12 Oct 2018 11:46:38 +0200
Message-Id: <20181012094639.1585-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wait until the next vblank to be sure that crtc has been disabled.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/sti/sti_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
index 5824e6aca8f4..61c2379fba87 100644
--- a/drivers/gpu/drm/sti/sti_crtc.c
+++ b/drivers/gpu/drm/sti/sti_crtc.c
@@ -40,6 +40,8 @@ static void sti_crtc_atomic_disable(struct drm_crtc *crtc,
 	DRM_DEBUG_DRIVER("\n");
 
 	mixer->status = STI_MIXER_DISABLING;
+
+	drm_crtc_wait_one_vblank(crtc);
 }
 
 static int
-- 
2.15.0

