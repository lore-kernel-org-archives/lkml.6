Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960FC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB23321473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+mq15ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB23321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeJDQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:30:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43250 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeJDQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id p34-v6so6262819lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ek/Go3WlBsQ4c2NtPtu5kOup11GClkajSoz+r83Kk+Y=;
        b=U+mq15ao1Y/GGfHjRg2DBeLdwhuv7ycg3BNxapG9DMq44i707SxHPMQm8EEIGSCIuZ
         8PYGUjjJxvCVpkTuRlIfI/49vglUOuNlphp4OMfifr9/RwVH+BBc7lizWph+sXsBlZhe
         3E7J241tsCWlx/woL1DPN3WRJji9dBis3xYeOCT54HDBNBZi1pgJgR4a8LLYxsfIyxUG
         dWvHWgK3MIzeQTH87b+/ein4PzCYZOKPe9sb5g2PpDezSqfvWUnIOhgkcBxOQPaE69Ki
         pJGQcwzs6BzJcMdvZSpJowIlCwBSlABmXdfK1ATn7axRD1MiEYP+UkegMSMdUcfYvEJY
         tWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Ek/Go3WlBsQ4c2NtPtu5kOup11GClkajSoz+r83Kk+Y=;
        b=pjECrKtVmEq0COEbH2z4ekUV9IJfztqDhIfcjF2zZLHJaTRJ9Jpf8qsTiXqdE26tob
         mrIlw5hgR1bR4gyzN4Ht7O0VID7aGWGLaIMZxke1Xq93ZEHvajcnIgC3/ISb24LiJLyh
         z4+j6jRzU+ZwTZt9pexh9TGRduarsEpf973kegalh/Wq7LK+50BL+y2UQo/84GPEECfw
         LVw3OxbD/+S7h+kGuJ7+RuJQ0AJKECh7AWCycYg67OVXdcQ2if+gYSnylqlbmNwxZS7P
         eQ3SHPGKkltki1qRgykAjwDURXBGvGD1Sze/EL6sV5kD1gSJ1nifnVG7XPIYVzS1xYnZ
         lPuQ==
X-Gm-Message-State: ABuFfoj7JXA2xK5BKAK0CD0kRptLOhVva+rpw+6TYLUpgxpE+JHC1UxC
        pzh5t0th6YVyE7sKIhLdizM=
X-Google-Smtp-Source: ACcGV62/yGhchPba2cgOKO8zCyP01o2ODmp2xbw/47vKQBlv1NP5xUcH4hT7yZrVL/hBi0AV4LWpoA==
X-Received: by 2002:a19:2c86:: with SMTP id s128-v6mr3236638lfs.153.1538645906524;
        Thu, 04 Oct 2018 02:38:26 -0700 (PDT)
Received: from localhost.localdomain (df8yyyyyyyyyyygn-tkvt-3.rev.dnainternet.fi. [2001:14ba:2700::157f:8223])
        by smtp.gmail.com with ESMTPSA id f128-v6sm899738lff.40.2018.10.04.02.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:38:26 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 6/7] staging: vc04_services: Drop unused parameters from vchi_connect()
Date:   Thu,  4 Oct 2018 12:37:46 +0300
Message-Id: <20181004093747.21750-7-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two parameters which are never used and all where all callers
just pass in dummy values anyway.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c       |  2 +-
 .../staging/vc04_services/bcm2835-camera/mmal-vchiq.c |  2 +-
 drivers/staging/vc04_services/interface/vchi/vchi.h   |  4 +---
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c    | 11 ++---------
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index bc48a74a6be6..781754f36da7 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -183,7 +183,7 @@ int bcm2835_new_vchi_ctx(struct device *dev, struct bcm2835_vchi_ctx *vchi_ctx)
 		return -EIO;
 	}
 
-	ret = vchi_connect(NULL, 0, vchi_ctx->vchi_instance);
+	ret = vchi_connect(vchi_ctx->vchi_instance);
 	if (ret) {
 		dev_dbg(dev, "failed to connect VCHI instance (ret=%d)\n",
 			ret);
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 074a4acc196d..cc2d9933b969 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -1831,7 +1831,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 		return -EIO;
 	}
 
-	status = vchi_connect(NULL, 0, vchi_instance);
+	status = vchi_connect(vchi_instance);
 	if (status) {
 		pr_err("Failed to connect VCHI instance (status=%d)\n", status);
 		return -EIO;
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 5c5bb6ddd9ce..95d9da078f46 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -100,9 +100,7 @@ extern int32_t vchi_initialise(VCHI_INSTANCE_T *instance_handle);
 
 extern int32_t vchi_exit(void);
 
-extern int32_t vchi_connect(VCHI_CONNECTION_T **connections,
-			    const uint32_t num_connections,
-			    VCHI_INSTANCE_T instance_handle);
+extern int32_t vchi_connect(VCHI_INSTANCE_T instance_handle);
 
 //When this is called, ensure that all services have no data pending.
 //Bulk transfers can remain 'queued'
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 9235a974dae4..c3223fcdaf87 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -490,9 +490,7 @@ EXPORT_SYMBOL(vchi_initialise);
 /***********************************************************
  * Name: vchi_connect
  *
- * Arguments: VCHI_CONNECTION_T **connections
- *            const uint32_t num_connections
- *            VCHI_INSTANCE_T instance_handle)
+ * Arguments: VCHI_INSTANCE_T instance_handle
  *
  * Description: Starts the command service on each connection,
  *              causing INIT messages to be pinged back and forth
@@ -500,15 +498,10 @@ EXPORT_SYMBOL(vchi_initialise);
  * Returns: 0 if successful, failure otherwise
  *
  ***********************************************************/
-int32_t vchi_connect(VCHI_CONNECTION_T **connections,
-	const uint32_t num_connections,
-	VCHI_INSTANCE_T instance_handle)
+int32_t vchi_connect(VCHI_INSTANCE_T instance_handle)
 {
 	VCHIQ_INSTANCE_T instance = (VCHIQ_INSTANCE_T)instance_handle;
 
-	(void)connections;
-	(void)num_connections;
-
 	return vchiq_connect(instance);
 }
 EXPORT_SYMBOL(vchi_connect);
-- 
2.18.0

