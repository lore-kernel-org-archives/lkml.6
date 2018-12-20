Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B7C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D588217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLZUR3ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbeLTRUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:30 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43619 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbeLTRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so2379110eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJ3Thc+Tk49RI7tfOaoX7lNqDe2TvDSrwqm2GBO1DoE=;
        b=oLZUR3igaZA/j8Ua4saKR7f2Nx8U2k7STmLx4RdmnuFsk8f55SdRkR3ChE3jp9xx9q
         Qd+Je2gVL4CR5iPTEU+vCf5npWGTASxiJ8OC6U3WU5Gd0nHLhtitwSOJrTBw3C1nooJ9
         2rFJfnE9f2cSqtACRjQexBGcC4CEB+bF1c3wmXPY0zP5nzo1OiiiCkNJzkz41f87IlX5
         Jn+fnNpbIostHtZMLYmHYt/9DJtDLqh0ZO+drbATuXvEc1n6qGyDadaDNfye5B395DTU
         esG80CZ8jOpY/Gcm1x2lHgdq240UZ0eh/NSwyh0yo9fypEuNP0zaQj5sXYVbg8zKt3KC
         5gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJ3Thc+Tk49RI7tfOaoX7lNqDe2TvDSrwqm2GBO1DoE=;
        b=TQjZE05FslaorHbBmU2Nwce9Yr8qkgbZ90CIdkj5vZ8Cq4g6eIR4ZDLWjdia38jAIG
         k5KsJMzzjpxbg6iIda2o74nivzc/YMyWOoOyU78Ijza00iNJRTZgC4LyPi50sx7aEtKk
         cstdcsGdrkmW8fgjCvcmZTErYj4vDlT/fwvmpdX5ma5EqpPS4d81EOZa+YDG68TW1yq5
         3Luplz1ypHrkT6FKy0G/tT+eel3LoaI+j5ZFycD9Pp1l/6rB8HPntp7Hkt+KfstWBga3
         JVWjqxsPeE+NcMe1RrSy/NfrP610HxOWNpd9Kb4e6BJcnMsQg6NUqAiyUD6/YtTbrcxN
         UAaw==
X-Gm-Message-State: AA+aEWbiQJZTJazMdqV5KBfkUWe3Cetuhb5IxTFCD1gEZHKQmnE9rDgw
        0ktKfdDDUYitGqaUhZBgDhY=
X-Google-Smtp-Source: AFSGD/WGIXaqj9olWnckJZz7B2v3oUbXmImvaahuQjBLwaSCotzH+o7FkUpBOeYQeSF0dINJR9Vs4Q==
X-Received: by 2002:a50:90b7:: with SMTP id c52mr24601934eda.31.1545326426393;
        Thu, 20 Dec 2018 09:20:26 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s19-v6sm3321684ejz.2.2018.12.20.09.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:25 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 14/19] mailbox: omap: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:57 +0100
Message-Id: <20181220172002.9016-15-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220172002.9016-1-thierry.reding@gmail.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix build failure reported by the kbuild test robot

 drivers/mailbox/omap-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index db66e952a871..ca50177a33f2 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -486,7 +486,7 @@ static int omap_mbox_register(struct omap_mbox_device *mdev)
 	list_add(&mdev->elem, &omap_mbox_devices);
 	mutex_unlock(&omap_mbox_devices_lock);
 
-	ret = mbox_controller_register(&mdev->controller);
+	ret = devm_mbox_controller_register(mdev->dev, &mdev->controller);
 
 err_out:
 	if (ret) {
@@ -508,8 +508,6 @@ static int omap_mbox_unregister(struct omap_mbox_device *mdev)
 	list_del(&mdev->elem);
 	mutex_unlock(&omap_mbox_devices_lock);
 
-	mbox_controller_unregister(&mdev->controller);
-
 	mboxes = mdev->mboxes;
 	for (i = 0; mboxes[i]; i++)
 		device_unregister(mboxes[i]->dev);
-- 
2.19.1

