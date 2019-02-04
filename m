Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28564C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC532075D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bXd0PeHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfBDKbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:31:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42554 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfBDKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:31:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so10737349edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 02:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4wTKnOgP4rC65t4u4/L1NAvyD43YhgKinUOE/N1OUs=;
        b=bXd0PeHFiMZ/vYKQxju9BqSIgH4BcT39JkYHRonTnOX5wSOAvSmBQ+51ZsV/3jpo9O
         z4iI4AS5R2zH8ArqDQwfGn7dSaqm3d/FEQLokFvD/LseajApaL6vP3qrIZByOwQNecPN
         kmINuSTt5Nu03Ohzd0rl8KqvwFNcjOeIVYL40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4wTKnOgP4rC65t4u4/L1NAvyD43YhgKinUOE/N1OUs=;
        b=uPn3W6uj2WCdRN3mayOviYyPXWIHhjMbc0CDmTC1lAls5dj2LRl92UXCI1hBQ+n2dO
         8AmEwv6CGU+h80Pye/r5pkFpFvwa8GEP5ETp394e0KbrVO5nEEd4a2bBcsNlTyRSa1Dq
         7UaUGD9XP3QTae5JqRnPq9pst5RsGxcXcItJBuiGcGgjvGRimPju+8yTkFB8eSTlWFln
         Sy5Q7CbRZ4ESRl+nll0X4kHbgVPKZHMsevFPtqb8UdbLpGLIOEbMQD30Hd3rH0DcOccn
         QnvStq4TeVW+B7Bo68lfGOCaXfUT1TGSRF2OXXOUxNBU2mYqZdqqvOZZmO+2sli17KL+
         Ht7A==
X-Gm-Message-State: AJcUukcjBonp9RCiN/RgXNO7A01Qgv5ihC21Cnrv5WLr+4ikZM6/hmpD
        l/KnveK7DgvqsqQbC4uABgCzMQ==
X-Google-Smtp-Source: ALg8bN7KY2HQx1CJoWORNTt5nYUODpPngWETBF5sIwot9QjuAlIgQeOPFBgE7VVPzZKJH9Uf6enDfw==
X-Received: by 2002:a50:ce0f:: with SMTP id y15mr48187983edi.207.1549276280285;
        Mon, 04 Feb 2019 02:31:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s46sm4253691edd.9.2019.02.04.02.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 02:31:19 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Emil Velikov <emil.velikov@collabora.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>
Subject: [PATCH 1/2] staging/vboxvideo: don't set dev_priv_size = 0
Date:   Mon,  4 Feb 2019 11:31:13 +0100
Message-Id: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler already clears this for us.

More important, someone might look what this is actually used for,
and freak out about the dragon staring back at them.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Emil Velikov <emil.velikov@collabora.com>
Cc: Fabio Rafael da Rosa <fdr@pid42.net>
---
 drivers/staging/vboxvideo/vbox_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vboxvideo/vbox_drv.c b/drivers/staging/vboxvideo/vbox_drv.c
index b0d73d5fba5d..43c3d0a4fa1a 100644
--- a/drivers/staging/vboxvideo/vbox_drv.c
+++ b/drivers/staging/vboxvideo/vbox_drv.c
@@ -222,7 +222,6 @@ static void vbox_master_drop(struct drm_device *dev, struct drm_file *file_priv)
 static struct drm_driver driver = {
 	.driver_features =
 	    DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_ATOMIC,
-	.dev_priv_size = 0,
 
 	.lastclose = drm_fb_helper_lastclose,
 	.master_set = vbox_master_set,
-- 
2.20.1

