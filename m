Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C069C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEBC2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEBC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbeKQIZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:25:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37278 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:25:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so22737419oth.4;
        Fri, 16 Nov 2018 14:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LaouoqkD3ttluPI7bXedx27zbuxr7w/ViN2uhOKU2JI=;
        b=ni1kn6iv8c0+pzoDpszOuIt5+wBxTSuwNoOINPjf6W1pavuKiqZ0YiYe3exYY+w0NE
         L2f6MpVbtakMu8lnT3qZDLLAQOpS+zRK2GcbXlYJPJXaKPsVeH03CrigJvqnJmV9BGNj
         pYjuoQ4cGLhXq76H2/M7j56tbhXHnOs3HSiD1/MzkZW47+vAdJO5lnxnJc3c83IrQQ25
         V2sCZnz0hWGCQhsTx04reLOQeiYzK704vB/8Js+syrRv0fGQZJQgtDHtsKCd43PWnOjB
         Evv532zuMutsO2kL+pI96zecRgTXn+eOa+gitUormvoEbNqwhIniDjYha+/Rk360eE/D
         D8HQ==
X-Gm-Message-State: AGRZ1gLScCWQmjj7r7Sqs+4GzvXiPO1Ul8zQwPtAY/VNxPZaIOBVulu2
        quzxF62XJTGFBfpsK6w7weTX2mh9vQ==
X-Google-Smtp-Source: AJdET5fPipeCIPit29eBQPrgdNSohEJJIo1/QR3fNnAra6GS7aOMTtVm5gZ08+xFYAVVwLgHU9kJ9A==
X-Received: by 2002:a9d:738a:: with SMTP id j10mr7731660otk.188.1542406281963;
        Fri, 16 Nov 2018 14:11:21 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id p204-v6sm12142631oib.25.2018.11.16.14.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:11:21 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jaroslav Kysela <perex@perex.cz>,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: aoa: Use device_type helpers to access the node type
Date:   Fri, 16 Nov 2018 16:11:04 -0600
Message-Id: <20181116221104.23024-8-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Replace the open coded iterating over child nodes with
for_each_child_of_node() while we're here.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/fabrics/layout.c | 4 ++--
 sound/aoa/soundbus/core.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 1eddf8fa188f..3a23fd032611 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1008,8 +1008,8 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 		return -ENODEV;
 
 	/* by breaking out we keep a reference */
-	while ((sound = of_get_next_child(sdev->ofdev.dev.of_node, sound))) {
-		if (sound->type && strcasecmp(sound->type, "soundchip") == 0)
+	for_each_child_of_node(sdev->ofdev.dev.of_node, sound) {
+		if (of_node_is_type(sound, "soundchip"))
 			break;
 	}
 	if (!sound)
diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index 70bcaa7f93dd..f3076a3f7f2f 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -78,7 +78,7 @@ static int soundbus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (retval)
 		return retval;
 
-	retval = add_uevent_var(env, "OF_TYPE=%s", of->dev.of_node->type);
+	retval = add_uevent_var(env, "OF_TYPE=%s", of_node_get_device_type(of->dev.of_node));
 	if (retval)
 		return retval;
 
-- 
2.19.1

