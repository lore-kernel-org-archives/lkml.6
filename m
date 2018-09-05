Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE637C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CEC2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="daCGVfNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CEC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIEULC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:11:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37417 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIEULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:11:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so6452834edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6EE5fUlPK5SBTrx6M5v9wCfQOcr9x9ywR/r0hbrtCs=;
        b=daCGVfNJZH9FsIHnf9gEkd6uhay4hdoPL8BuFl/G+mxWqjoopnu6jJCeUHtU9L5xmK
         RT01QrquKUXsXYY0AJ+OhM2R6F8+jRDWeuzYVBXr6/PXiIFPnm8Y4633kMVBdI10UKqs
         OZYfXDW5vPOVhAJGNSpC7P0+rE9fuHIIc2gHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6EE5fUlPK5SBTrx6M5v9wCfQOcr9x9ywR/r0hbrtCs=;
        b=J9CxVL/3cEwuy1LW4BXcMlmQ07f8q1OT0Z4WjgC4vpZ3BegIYD7sK2ZzRTEYm0QX3/
         JgKJ6PY7W+Q+9IlL48iNilyvAbSedEbnJEtFU5jHB6iYfvMp1ElMa38ciu3b3Rgdm9ZB
         Sn4kJlx9Gl/GUFOd2bkchw2vuwTi7l7CzL6C/Lt7PD8PuNvqOSmRR1N/vrw3SOX6rRMv
         dFDcUkZXCKN8jqTbxuVpOtmKIH8PUsrFaVYBk5Rq7AWOe4OVqm18iZZVfd/X+6Pn/QR3
         cilM/cm6QrPPtunJXj+cRhtqw1e1o7JoOoNNUi0/7AaCcupTmBs3sN5o6mmKLpeBcdq8
         ACgg==
X-Gm-Message-State: APzg51DuMTAA7VYz++ErVfDrHQ2W8jhlbfzwd0EAzxACucHnmzahyGtR
        l7P35pPcjhwOZKm+y8rhXmuBY/DrjzKW7w==
X-Google-Smtp-Source: ANB0VdYavHfIlPMVLJJyZuINoR0OiazM6TFim9JghCIhj1mNZeufhhwEz7vDdeIZa9fkVcGHKA3aQA==
X-Received: by 2002:a50:b764:: with SMTP id g91-v6mr44612889ede.187.1536162016538;
        Wed, 05 Sep 2018 08:40:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d3-v6sm1303404edi.80.2018.09.05.08.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 08:40:15 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Shuah Khan <shuahkhan@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] staging/fbtft: Update TODO and mailing lists
Date:   Wed,  5 Sep 2018 17:40:09 +0200
Message-Id: <20180905154009.20295-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivated by the ksummit-discuss discussion.

Cc: Shuah Khan <shuahkhan@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 MAINTAINERS                | 2 ++
 drivers/staging/fbtft/TODO | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 029baa270a11..3d50315dbe90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5624,6 +5624,8 @@ F:	lib/fault-inject.c
 
 FBTFT Framebuffer drivers
 M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+L:	dri-devel@lists.freedesktop.org
+L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fbtft/
 
diff --git a/drivers/staging/fbtft/TODO b/drivers/staging/fbtft/TODO
index 7e64c7e438f0..a9f4802bb6be 100644
--- a/drivers/staging/fbtft/TODO
+++ b/drivers/staging/fbtft/TODO
@@ -2,3 +2,7 @@
   GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
   lines from device tree, ACPI or board files, board files should
   use <linux/gpio/machine.h>
+
+* convert all these over to drm_simple_display_pipe and submit for inclusion
+  into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any new
+  drivers anymore.
-- 
2.19.0.rc1

