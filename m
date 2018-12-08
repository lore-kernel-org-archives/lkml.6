Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D290DC07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE8D208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ksCzvV3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE8D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLHBr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 20:47:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42354 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeLHBr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 20:47:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so6617926qtq.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBTZjMKJnf0RVfVAPqiyjnReWdwRQ30PhNrhuhCUb3w=;
        b=ksCzvV3/lyGVWdT4/ZvE4BzJMSmpFT1rUm8YXYR5p88y3ARTLZVzzevQAxwBUBbtlx
         xOCEqenZu6KibJtRtBSK2sAklwUvFVHehmcF04ZOgMNvAKvwwxmR8GvTwnwfrLuOiJDu
         Hft/7Vruxl0fpysZx4k9VFDYTHhYu+J3/fM5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBTZjMKJnf0RVfVAPqiyjnReWdwRQ30PhNrhuhCUb3w=;
        b=hWEtSrs0UxDoGSTKr3E+6neSB3SIBgEgGRFNLLAqBaB7xGuWKdQdHLSoiPT1+rUAQu
         CQaX95OeNhTtNIELnQstUYO4PRtz2ahZW0oBAK644j8MAjYQDLUucnkqV4+J0imBsaCn
         WcHYeNqMZ/ZPqh4rl2c0EE7N2UIoRn8iLCHzhVfZ+T5NCJ0ZG+DJl0NIpgD4p2xmQgii
         sHdoxbp+fUjngg5mKMFgF/ek55RNzTqB8lZGyTttZY3Fzh7E34DrUDfqUJ5qXsUlT9o1
         9f2ugnrUzKyYz+JdixOKL2dpBIuKh2EItsfDDlXzPf/zstRUcb0T4/AqWPLL8zgt0MH0
         aqqw==
X-Gm-Message-State: AA+aEWYk37UcjyMr2XLwSCgWY37lsJFxGxUUrupqEMjoGVyeHhrQ0VmK
        Pl84zVtQNqoa88Jue7pv95ZjjYl/0sio8g==
X-Google-Smtp-Source: AFSGD/X6NrD/bimGvXlH7dWLKL26tlCEYpc6oeIi8ycSs/XkEJn5NQPQKWymkvwVvmETiDVw/Y9c0Q==
X-Received: by 2002:aed:25f2:: with SMTP id y47mr4154360qtc.217.1544233676532;
        Fri, 07 Dec 2018 17:47:56 -0800 (PST)
Received: from kdgwill07.nyc.corp.google.com ([2620:0:1003:510:59af:10e9:2d49:6b0a])
        by smtp.googlemail.com with ESMTPSA id 94sm5604597qks.8.2018.12.07.17.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 17:47:56 -0800 (PST)
From:   Kyle Williams <kdgwill@chromium.org>
X-Google-Original-From: Kyle Williams <kdgwill@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kdgwill@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Harry Pan <harry.pan@intel.com>,
        Emmanuel Pescosta <emmanuelpescosta099@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Dmitry Fleytman Dmitry Fleytman <dmitry.fleytman@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 2/2] USB: quirks: Disable LPM for Logitech UVC devices
Date:   Fri,  7 Dec 2018 20:47:22 -0500
Message-Id: <20181208014724.951-3-kdgwill@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181208014724.951-1-kdgwill@google.com>
References: <20181205093902.GA18633@kroah.com>
 <20181208014724.951-1-kdgwill@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Williams <kdgwill@chromium.org>

Description: Some USB device / host controller combinations seem to have
problems with Link Power management. In particular it is described that
the combination of certain Logitech uvc devices and other powered media
devices such causes 'not enough bandwidth for new device state' error.

This patch enables the USB_QUIRK_NO_LPM quirk entries for all connected
Logitech UVC devices indicating LPM should remain disabled for the device.

Signed-off-by: Kyle Williams <kdgwill@chromium.org>
---
 drivers/usb/core/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 0690fcff0ea2..bbbb7e6df958 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -440,7 +440,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 static const struct usb_device_id usb_interface_quirk_list[] = {
 	/* Logitech UVC Cameras */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x046d, USB_CLASS_VIDEO, 1, 0),
-	  .driver_info = USB_QUIRK_RESET_RESUME },
+	  .driver_info = USB_QUIRK_RESET_RESUME | USB_QUIRK_NO_LPM },
 
 	{ }  /* terminating entry must be last */
 };
-- 
2.20.0.rc2.403.gdbc3b29805-goog

