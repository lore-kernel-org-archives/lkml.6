Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6ECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B262077C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhsxV/6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B262077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbeKOBO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:14:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45340 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKOBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:14:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so11720174lfa.12;
        Wed, 14 Nov 2018 07:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=626/10rHUOSNuXi5VpUD/Kp1SV4jxeh1LQtfvhL+K9g=;
        b=QhsxV/6Q9EHCqfYThAj+lgKhsodwg4ZN3Y2/xJnq0/HXUOOgN4kXylkZX7lTqUwuaf
         tEgr0og1k5/8mo+osp1ukOtJf9jNQV8JdbJavIU0CfT+cabtesu/S9TA/u+QNatx8HkE
         +L5wFvtV9ok2b55Q3lywhR72gqsvGenyUsuZl2YyZpPxoOnLF7icshq/AUTLmGTBRDfK
         hvdMLiliUXdg51U/bYB4BtTk7omJMmGDClzm8I/OOIhIwBDO+yVXrZBHBZ6khkFAyCLH
         VLu89A/I8r8wPlgtdybYoi11UR9zxtWDQZY/UZ8f41QRy9Kxeys+VZQSm5pGi3Bs5oIs
         C/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=626/10rHUOSNuXi5VpUD/Kp1SV4jxeh1LQtfvhL+K9g=;
        b=SjHEh+I6GDoRKTrglgEzMrC8K/1/MgwlH4LpdEFSrw2ikDWRD2zGXNiy3uIO/TFPOe
         sT60WrskSTvGEHJl4QWj4DcgViW7//RwcP4PdVpYozMtV6IMzyZtRTBdjVEM02lt6u4f
         I9srlqpvOgszECmrCZNC92KNNDXnLz2x/yodQspUbgvucIfUV+TZYErQXl2MokkIyl2f
         BJR9mMGF7Iz96IWTuvyntXmoODf7OMSn2g8oWZ6MAGruf/TgUV+QBQPMMcuIQXc7NS4p
         eiseJ5cqnmqgXf0ZfpKkUy/BIK0ldmTwY9UwYR3sKewt8xt4boTQuykE6KK7yWcNNq92
         7i/w==
X-Gm-Message-State: AGRZ1gLNLqiAgyWlY3JFy0BXzM2nNpyf7I/EZm2lsKk8GjhaeQa9cnWp
        iqrXPtVDPShHVSZZVTfUU6w=
X-Google-Smtp-Source: AJdET5cpj+IjED+FAF0vsZi2yicjBCIIq4v8kxvXhilyh+SN7YI2y+m1JHD3DjsF5S56yz6eSIX0sw==
X-Received: by 2002:a19:ae03:: with SMTP id f3mr1364289lfc.86.1542208248897;
        Wed, 14 Nov 2018 07:10:48 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id j126sm3969819lfe.10.2018.11.14.07.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:10:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gMwoX-00058X-E4; Wed, 14 Nov 2018 16:10:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] serdev: use zero to indicate infinite write timeout
Date:   Wed, 14 Nov 2018 16:09:01 +0100
Message-Id: <20181114150904.19653-2-johan@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
References: <20181114150904.19653-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use zero to indicate infinite timeout for the synchronous
serdev_device_write() helper.

This allows drivers to specify an infinite timeout without knowing about
serdev implementation details, while also allowing the same timeout
argument to be used for both serdev_device_write() and
serdev_device_wait_until_sent().

Note that passing zero to the current helper makes no sense; just call
the asynchronous serdev_device_write_buf() directly instead.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 9db93f500b4e..c7d637d2bc56 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 
@@ -235,10 +236,12 @@ int serdev_device_write(struct serdev_device *serdev,
 	struct serdev_controller *ctrl = serdev->ctrl;
 	int ret;
 
-	if (!ctrl || !ctrl->ops->write_buf ||
-	    (timeout && !serdev->ops->write_wakeup))
+	if (!ctrl || !ctrl->ops->write_buf || !serdev->ops->write_wakeup)
 		return -EINVAL;
 
+	if (timeout == 0)
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
 	mutex_lock(&serdev->write_lock);
 	do {
 		reinit_completion(&serdev->write_comp);
-- 
2.19.1

