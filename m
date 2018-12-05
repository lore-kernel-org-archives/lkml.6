Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC61C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26E9208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039494;
	bh=ejqsZY/84/dft9UfbmW2jm6kR5fadYpwVGTJR5Aefwc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1ATMeuZd9fgUwDGikj38AFDk4JmpxBdANRERh8o5FxL9ZnIC3tfqAueihI+RrZ9wX
	 kilk0pnGW98fzzkdFCPj6EZhrK84Gp1qJ8baLCVr70GReLB5yYqgw8k9orwPOrfQ+G
	 +DyZMZju87nJAvYSoN3HSpCNLnQppEdIw5y+F3Ms=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26E9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeLETvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46320 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbeLETv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:28 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so18596761oif.13;
        Wed, 05 Dec 2018 11:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QICrhOBU8T2PisormMUNd01epFjj+h80GHQhRmRoAOU=;
        b=cefk/od7hNGM7Oz+w9f6dxybGA7YsSfNg94broDlA1Eje2ExEMmiFgxZ7aanqCsGiC
         VjMCAZ/zuWCY7SQkbMEvotL1f7IKCyUtYwJnHXlQ0xV34P8UAlia8kjR+wjFnpzi9yqn
         KeZVZScEqdj8VIl0MC5HM8tv6sinbIP4C8tqWErW392fEeV9FwoJnW/CQeLhl+MpeNH0
         wFP//d0XfYE6lJSb7yh/2fjXBdoPGZaHrfZykzxSEHbO1gNJ4KmvpDYiWoZEY3g7QoYH
         /nEJn+zqXu231Dq7gSs4LozLbt9DFk4rJctu9KPNdwxqNXR512FhcfL2G2jfhOOzVIfC
         e4Gw==
X-Gm-Message-State: AA+aEWbP/LIf8OBqOKZDFkAAyjwt+Ctt3OYNmc9VcF6biC3ORwoAM6y9
        q1ltrf/BL5QFF/aAOzB5xVmICDw6Cw==
X-Google-Smtp-Source: AFSGD/VvPbw6yCp5lGcRidYRNt3VMLROhi3MK5kDSyoSQ5nVB1au0UQ5ntp9WmNVOn4bqxa2AnqauQ==
X-Received: by 2002:aca:4282:: with SMTP id p124mr15080611oia.327.1544039487106;
        Wed, 05 Dec 2018 11:51:27 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:26 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: soundbus: Remove direct OF name and type accesses
Date:   Wed,  5 Dec 2018 13:50:48 -0600
Message-Id: <20181205195050.4759-32-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert soundbus uevent and sysfs OF node name and device type usage to
use printf specifier and helper functions instead of directly accessing
the name and type pointers. This will allow the eventual removal of the
pointers.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/soundbus/core.c  |  2 +-
 sound/aoa/soundbus/sysfs.c | 34 +++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index f3076a3f7f2f..065d3a55725e 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -74,7 +74,7 @@ static int soundbus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	of = &soundbus_dev->ofdev;
 
 	/* stuff we want to pass to /sbin/hotplug */
-	retval = add_uevent_var(env, "OF_NAME=%s", of->dev.of_node->name);
+	retval = add_uevent_var(env, "OF_NAME=%pOFn", of->dev.of_node);
 	if (retval)
 		return retval;
 
diff --git a/sound/aoa/soundbus/sysfs.c b/sound/aoa/soundbus/sysfs.c
index 81da020bddef..a2d55e15afbb 100644
--- a/sound/aoa/soundbus/sysfs.c
+++ b/sound/aoa/soundbus/sysfs.c
@@ -1,18 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/stat.h>
 /* FIX UP */
 #include "soundbus.h"
 
-#define soundbus_config_of_attr(field, format_string)			\
-static ssize_t								\
-field##_show (struct device *dev, struct device_attribute *attr,	\
-              char *buf)						\
-{									\
-	struct soundbus_dev *mdev = to_soundbus_device (dev);		\
-	return sprintf (buf, format_string, mdev->ofdev.dev.of_node->field); \
-}
-
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -25,17 +17,33 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 		strcat(buf, "\n");
 		length = strlen(buf);
 	} else {
-		length = sprintf(buf, "of:N%sT%s\n",
-				 of->dev.of_node->name, of->dev.of_node->type);
+		length = sprintf(buf, "of:N%pOFn%c%s\n",
+				 of->dev.of_node, 'T',
+                                 of_node_get_device_type(of->dev.of_node));
 	}
 
 	return length;
 }
 static DEVICE_ATTR_RO(modalias);
 
-soundbus_config_of_attr (name, "%s\n");
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct soundbus_dev *sdev = to_soundbus_device(dev);
+	struct platform_device *of = &sdev->ofdev;
+
+	return sprintf(buf, "%pOFn\n", of->dev.of_node);
+}
 static DEVICE_ATTR_RO(name);
-soundbus_config_of_attr (type, "%s\n");
+
+static ssize_t type_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct soundbus_dev *sdev = to_soundbus_device(dev);
+	struct platform_device *of = &sdev->ofdev;
+
+	return sprintf(buf, "%s\n", of_node_get_device_type(of->dev.of_node));
+}
 static DEVICE_ATTR_RO(type);
 
 struct attribute *soundbus_dev_attrs[] = {
-- 
2.19.1

