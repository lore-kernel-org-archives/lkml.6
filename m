Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160AEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D039020883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VKZaGcot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D039020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeKHId0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:33:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34952 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbeKHId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:33:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so7962362pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 15:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hErWVvVfq+l1Lhw6i7dkgVe6YlWD+RYolV83NWx0t70=;
        b=VKZaGcotsoGjvMj3TTBlz4HOcEtdPNnWZgeUM3aWlowfVqaTmhi9siniUiaW1p+8rb
         nogd0jDNBS1Oyq0kfvToYf7x8Q7UaId0TmSOLB+KhgIhHk2VKeONqLrb6AMvEsRuyV1z
         UdxVfZ4G3DYdQBb8pXufEvCCOXLllwOReh/7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hErWVvVfq+l1Lhw6i7dkgVe6YlWD+RYolV83NWx0t70=;
        b=JO9aJvoshHe6fIl5fux9Y1aHP58v+UUF1a6aFqYbsj87nBebrFoTO8fQcvBlBeBjFV
         by4IesXwgVKg9X0O6+5pBCbmGWi+SFnHl7dd0X/bSkfVUc6Vj+k5DATW0rpSqHzdnKhE
         Q4B28sZn8ZPb4BKcllSBi9u0NnyI6IBGPv8yhazPu4HtiwadjtjGWV+jXyIauYjtGlFR
         Y9JYwoFjcQ7l/HyciUBO7Z4UlwFNdNB4y05Y3Hs0Ptq+TyXuSVZQlWC/kkSazMoCdj38
         CtdNJ8KWL8ncIQ3WyX6h7uMyzKwH1u5VORBBkM3Sa3h1jHqVR0948dMlfaUhMawOCVA/
         wEbA==
X-Gm-Message-State: AGRZ1gLZxeqhXBWm+2FcUzEl5ksVXv9dx9pszlyivm0yHQj8GO8lPhH+
        7KMkTZAvgPNULV94No5RT5mweQ==
X-Google-Smtp-Source: AJdET5df/vDiTif4GAJe3NhMKhJNqL9pfeH+3yC/10dh90FbtYvUKszmt9FbhEyL/HjcCuQ1YwWAQg==
X-Received: by 2002:a62:ce8e:: with SMTP id y136-v6mr2188499pfg.201.1541631652192;
        Wed, 07 Nov 2018 15:00:52 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id d126-v6sm1802327pgc.32.2018.11.07.15.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 15:00:50 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.co.uk>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH] input: cros_ec_keyb: fix button/switch capability reports
Date:   Wed,  7 Nov 2018 14:38:13 -0800
Message-Id: <20181107223813.178462-1-briannorris@chromium.org>
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

