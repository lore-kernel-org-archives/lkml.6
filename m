Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641D5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E40221726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxXwGrom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfAWQWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:22:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34420 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfAWQWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:22:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so1427109plz.1;
        Wed, 23 Jan 2019 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bgdre5j+LE9CpgHKUVUp1bBs8FjOyfoJvvrGrE044rQ=;
        b=XxXwGromrOBuLGhov67dJukfZkCghvD0tLT69rPUoykZxEHrZB5vj1ys+yKpTICarG
         SmdjILrOd7ljpN5XC0WoMi8tCvy8lN+qw3nq3cUgyXAD+mcVqb+0Qx2fL+Ne0n1sDhzd
         7nSSvVZNPG5JGoPSx0a4WDB1nFrYp3PL2cuZP2G9hLB87RTX4kJDqTz1/imvv6iVarz/
         RMj2+s+VwCBIhyUMuYQ/HLKv3CMa1JaB0QmoodzbRoi5wRde5afEhz0tL9WD8LSZQTuw
         MarBMIsmWEwZ1vZiQokTY+AB/0NRhn9G0UgtXBfVabv0NJ90UtxG4gJFasLP3ehDwO1m
         EojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bgdre5j+LE9CpgHKUVUp1bBs8FjOyfoJvvrGrE044rQ=;
        b=kXr8034oP/uLmeQNEHQ8fewIDhC1Urgq5KwJVCXOGMx87ncSA8byDduIePx7LF6pN5
         LDbYHGAZyyw/UpQsamAG9eQTRxyJOy+WwVS0sEJyBcb7+E5NZH70TkEseOParH+cvHmP
         PDOIs4zBjZBMJHMHyK3DR+jHmj1eiyA6076LRdWDuoink7x/FfDymdEbZjf4qnAAecQI
         uDKvYEAv1Zdbhi4Mp/FFuuRJyBYuyQdJAaTffLfvMKGcjjFHXuMqBvbWw23hFr+USDb8
         +5YAG9BXMNdg0g8yYULMfLi+swYI1PhlY5d8vxsYN2Y1W1SXobcApgNudS0644LAHKyJ
         VwoA==
X-Gm-Message-State: AJcUukcA+bxU1ZDhoPDJ1b3GedPVQ9+9qCG3dd6F1ocgnJnPHpmYRxzz
        BfM7WRcpP4itN2XjWd06/wo=
X-Google-Smtp-Source: ALg8bN4pb3nuvWqr/2u8zhFmqaVcxwYKJR2DO1cSd9EW7HRh8Rn3u6kKn7mzGwMTpKbcfT57JxWR5A==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr2791223plc.220.1548260525286;
        Wed, 23 Jan 2019 08:22:05 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h64sm30960897pfc.142.2019.01.23.08.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 08:22:04 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / wakeup: fix comment of pm_wakeup_dev_event()
Date:   Wed, 23 Jan 2019 11:22:01 -0500
Message-Id: <20190123162201.26366-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings the kernel doc in line with the function signature.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5fa1898755a3..f1fee72ed970 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -783,7 +783,7 @@ void pm_wakeup_ws_event(struct wakeup_source *ws, unsigned int msec, bool hard)
 EXPORT_SYMBOL_GPL(pm_wakeup_ws_event);
 
 /**
- * pm_wakeup_event - Notify the PM core of a wakeup event.
+ * pm_wakeup_dev_event - Notify the PM core of a wakeup event.
  * @dev: Device the wakeup event is related to.
  * @msec: Anticipated event processing time (in milliseconds).
  * @hard: If set, abort suspends in progress and wake up from suspend-to-idle.
-- 
2.17.0

