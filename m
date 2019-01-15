Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB1A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GPuVCr1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfAOK2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:28:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43664 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfAOK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:28:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so2085346eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7NtGTQf1/fdBYor4seKnarorUm8kafjnDkVZzMRLX8=;
        b=GPuVCr1f5nKz6Sejzayu6qGzUoOgB2Lt1JDmwsfufKXaGXnOqroVmWYs0FnCqE4Fcg
         mtmHRE5c8V9JDYfVGcmR1qUZ+/YpPoi36EwFOvCgWVuO8Anw8K+bSAAArn/X2BnI2bgj
         2Puatu5lTlJcEV7B/VULomnZeZMYN84adQrk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7NtGTQf1/fdBYor4seKnarorUm8kafjnDkVZzMRLX8=;
        b=CSoT8/DOru9O+cn4or6G6ExDl5PFaAlRZd6QmOK1gvNupvyNlu7dZssSyVXyG85kHs
         Lli7CMIkbyNaCZs2zntt8R5YL263xQ+hcQKlijfbxzhZtomM/yXbQjOAZZpceSlTuJwD
         Xvo82dM7tXPBWQSxg3yytiq5DxDH3qEbeKyDc/96DNtcpaW/+mIfxNP3qCLPUUtBgjav
         6hJdg+K2vopVZp7lbFYBaZelwFnkCA7EMWXqYeCRx5JX5GyQ1FtAzFZw0USLVX7PYaWp
         kNcmNbA4oKGaJMNZVWt5j6C8K9uZyV6FNs80QuJN38AzO5ldvFR/OCvwccECkwxdNPKg
         /l0Q==
X-Gm-Message-State: AJcUukd8xCHlpOAoxH3AdFzDdOS56iKMOwSfWO91BVW7vQwyUM3ji7D0
        EfHlAFmf/TMsqVfNwueS+rWNXw==
X-Google-Smtp-Source: ALg8bN40yQqEyp/+mUiRjwJ60qpNu5BhYQOY9LgTSfE3JfZkYSWY4lfRcaqNRm7PjoRA0uLp5guULA==
X-Received: by 2002:a17:906:101:: with SMTP id 1-v6mr2571699eje.68.1547548097212;
        Tue, 15 Jan 2019 02:28:17 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z9sm4597518edr.61.2019.01.15.02.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 02:28:16 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: [PATCH 1/2] staging/vboxvideo: Don't set FBINFO_MISC_ALWAYS_SETPAR
Date:   Tue, 15 Jan 2019 11:27:54 +0100
Message-Id: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a debug hack flag useful to work around driver bugs. That's not a
good idea for a new driver. Especially for a new drm driver.

Aside: the fbdev support should probably be converted over to the new
generic fbdev support.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 drivers/staging/vboxvideo/vbox_fb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_fb.c b/drivers/staging/vboxvideo/vbox_fb.c
index 2181c36c19ab..1da4cb7647b8 100644
--- a/drivers/staging/vboxvideo/vbox_fb.c
+++ b/drivers/staging/vboxvideo/vbox_fb.c
@@ -91,11 +91,6 @@ int vboxfb_create(struct drm_fb_helper *helper,
 	fb = &vbox->afb.base;
 	helper->fb = fb;
 
-	/*
-	 * The last flag forces a mode set on VT switches even if the kernel
-	 * does not think it is needed.
-	 */
-	info->flags = FBINFO_MISC_ALWAYS_SETPAR;
 	info->fbops = &vboxfb_ops;
 
 	/*
-- 
2.20.1

