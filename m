Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F5FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2215121502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="VUiwnseE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2215121502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbeHOS2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:28:43 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43888 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbeHOS2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:28:43 -0400
Received: by mail-yw1-f65.google.com with SMTP id l189-v6so1096389ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkkZFk0MFfR8CNABi+gvgDa78rBOQO1gmKKIzof0PsY=;
        b=VUiwnseEVhuGvzr8oEd0KtNORJVShzsbBZsczpSMiP0340a37uyLXAX5DKAkg2uABM
         pAMGSclHNzM7rE+10yBHTUtxE/eT6ca0U5kPk1NdE1nx8EC+ASDo8M1D3OoxCTqjLuK/
         vNPonri4jhBOQ30AaicDckXmDp9HhHFtyYLTrJx1NDFn5i0L85qXAQzJFgsoWfVSUBdN
         NBy1/BjJEZwvpD0XXRceShY2SYodQwIV8PEyTYmZFd58mUfx8n2jIfEqE16idD6tnuLX
         8rybQS7abw1Sa3Kr8FqpliK/OWNSLn9s5rZlffm3zpKdUpfe3S3X+tHUWNlTiydysUld
         TTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkkZFk0MFfR8CNABi+gvgDa78rBOQO1gmKKIzof0PsY=;
        b=eM8m2nVbkM7sF0fmsWPzwDNYy6v6SZq8cVhloClERr2wGwdP9Cu6IROPpJI1xr7Tfe
         OYrfAJxN158/IITqoQ8Ndo+rd2pKmlCTucIKccSTnOvglMC7Rtp+c6HNK2GVvcV56Nub
         J1FXtjQOn6xUKoKgP5KyUynQbXjzyTKTbexsnivcRNtm1a5CJtEYK1W/URilCy3i9kCE
         9giS9D78N9LfxRz/bvr1oq1/ENGI12p3n0KJgfcj5skYO2tMUlGQX9mbON2p3wjTPKvE
         fD+Iviuq0+Xmay7ELYuWFuhw1Fir2lTJWDyOSlkcfuOH8rAgZIqY12eKx8hnH/yg8w73
         oJ0A==
X-Gm-Message-State: AOUpUlEFYWRXkGrYcSVUxw9n93AfUOWIXBd83RgbSY1DADEOQImpu4JI
        BaXqEYXWyvRFk9TZmL7Pp7hV5Q==
X-Google-Smtp-Source: AA+uWPxoJrqBNyX+eTpQsewwxEIgPKUe0dD0kUbvwWnd5EJ+rE1xB6/y+QeXnU8Tb4jqbGKXZlu/1w==
X-Received: by 2002:a25:424d:: with SMTP id p74-v6mr15361152yba.163.1534347365211;
        Wed, 15 Aug 2018 08:36:05 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id l9-v6sm7639555ywl.32.2018.08.15.08.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 08:36:04 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: drm-misc: Change seanpaul's email address
Date:   Wed, 15 Aug 2018 11:35:29 -0400
Message-Id: <20180815153604.90152-1-sean@poorly.run>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since chromium.org is now enforcing DMARC, my mails are going to
people's spam folders. While this development might be desirable
for people I communicate with, it's undesirable for me :-)

Cc: Dave Airlie <airlied@linux.ie>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Sean Paul <sean@poorly.run>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93f189f0d60d..5eaa1c91d4a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4662,7 +4662,7 @@ F:	include/linux/vga*
 DRM DRIVERS AND MISC GPU PATCHES
 M:	Gustavo Padovan <gustavo@padovan.org>
 M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
-M:	Sean Paul <seanpaul@chromium.org>
+M:	Sean Paul <sean@poorly.run>
 W:	https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-- 
Sean Paul, Software Engineer, Google / Chromium OS

