Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0500C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B3720882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W669+dd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B3720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKHIAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:00:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35152 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeKHIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:00:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so7928928pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hErWVvVfq+l1Lhw6i7dkgVe6YlWD+RYolV83NWx0t70=;
        b=W669+dd2gXUy/GLOHJHuZBiSVkD0H0R6bEkU4q2iePeJSs92MQQzGIyJL9B1q1FZlM
         h6O8RtFQxa96Dwynh57Au7XRz9gTaRM4/M0RmRDYhfDCq8leMd/uiWlz5V/b8zcF2Zt0
         uVzUhYKSEPGKuFYPq7e0D2MdKXn7cLQUsiW4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hErWVvVfq+l1Lhw6i7dkgVe6YlWD+RYolV83NWx0t70=;
        b=fliIgxt4dp6qK0dy/Q94VeOz9ACQD2Ts3j40Ln4yqi5zDHMFSuNns/FLM529hTvAPU
         KJpaHD7M3NIMCdIe+qXJZkNxEUt8GHtSIiB2a1KAFzbs+p0gm3wz1AkD889t3xrCsYs4
         dOzc/VoC7gupW/Tw5dRMe2CgLAar/nmpO2ldfNHoPqLF7nTTxHQ7/vkdQBgIrA58037R
         5hU52g+CeA3ll6PCnQzjM2atq6NH6I0GCYUXH8LfHuqRND4yi7719PIDINhXnkFw/y9b
         WRDImZVWPKrZCXz/AgxVOHtHRX7utjENStqdm7F4bLEllRVfF+hiBm8sltUnOE4F+Fma
         4dbQ==
X-Gm-Message-State: AGRZ1gIQ2j+1ALWxFIGmcGhL52Ka6+SppIe8gH294La+DXTgqZuILjBW
        5GnJIvc8MXTeETvQaNMgXAFlew==
X-Google-Smtp-Source: AJdET5fNzvFAiqFTFyKWaTgIMxcA3X+UmZK4NulEwXUrLVPTDTe403t7ZF571DOILoiMAMtHnNq0ow==
X-Received: by 2002:a63:561b:: with SMTP id k27mr1787801pgb.271.1541629653794;
        Wed, 07 Nov 2018 14:27:33 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id 89-v6sm1934373pfq.10.2018.11.07.14.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:27:32 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.co.uk>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH] input: cros_ec_keyb: fix button/switch capability reports
Date:   Wed,  7 Nov 2018 14:27:29 -0800
Message-Id: <20181107222729.170234-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros_ec_keyb_bs array lists buttons and switches together, expecting
that its users will match the appropriate type and bit fields. But
cros_ec_keyb_register_bs() only checks the 'bit' field, which causes
misreported input capabilities in some cases. For example, tablets
(e.g., Scarlet -- a.k.a. Acer Chromebook Tab 10) were reporting a SW_LID
capability, because EC_MKBP_POWER_BUTTON and EC_MKBP_LID_OPEN happen to
share the same bit.

(This has comedic effect on a tablet, in which a power-management daemon
then thinks this "lid" is closed, and so puts the system to sleep as
soon as it boots!)

To fix this, check both the 'ev_type' and 'bit' fields before reporting
the capability.

Tested with a lid (Kevin / Samsung Chromebook Plus) and without a lid
(Scarlet / Acer Chromebook Tab 10).

This error got introduced when porting the feature from the downstream
Chromium OS kernel to be upstreamed.

Fixes: cdd7950e7aa4 ("input: cros_ec_keyb: Add non-matrix buttons and switches")
Cc: <stable@vger.kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 81be6f781f0b..d56001181598 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -493,7 +493,8 @@ static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev)
 	for (i = 0; i < ARRAY_SIZE(cros_ec_keyb_bs); i++) {
 		const struct cros_ec_bs_map *map = &cros_ec_keyb_bs[i];
 
-		if (buttons & BIT(map->bit))
+		if ((map->ev_type == EV_KEY && (buttons & BIT(map->bit))) ||
+		    (map->ev_type == EV_SW && (switches & BIT(map->bit))))
 			input_set_capability(idev, map->ev_type, map->code);
 	}
 
-- 
2.19.1.930.g4563a0d9d0-goog

