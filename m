Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C11C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F39C206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMY31ieN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeLPVn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:43:57 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35730 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeLPVn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:43:57 -0500
Received: by mail-yw1-f67.google.com with SMTP id h32so4454180ywk.2;
        Sun, 16 Dec 2018 13:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bwVsWfSOkHXisZL6Xc4MoMxw3RY51YJz4Sl3LpEOmkw=;
        b=OMY31ieNevhcW0U7sGXVmBZHyDN989kLngfx89x7rlx8MSSt9npnfyoKy1G0p3RY9a
         20bPMwtsJY1rBbgmCqD5M7L3pw44WD6tcq1DymBf7d6w7LfckhvcdDF98+fpqr+fsJBj
         hyFHXUZ9v39+YKTn8O4VD75d7VFTXl9gObACWMa0mEArOfUhHK+V/SdZQlOsULbzrZZX
         DZlsburJBLXmt3vlXlqR1qmuZojqmXcJJ3id4Ur/4AN57pGY7OphsQnNcOh7MRXjzwKO
         QpdR9ilmjbxrA4pl9IZlAbqb0SEMtNLcJpyqQoHMcB7ZEcvHXtbOjq/LWNSEq4Sb6uvj
         DNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bwVsWfSOkHXisZL6Xc4MoMxw3RY51YJz4Sl3LpEOmkw=;
        b=lfIo7D/0l3JiC7v272K4ah9aB22IunVoLDfcgg5uTX6rC+nIGOvVssEuM08OjEYLDU
         WeB7y5WD5VBjWUCdDdzRuW12Jr4s37j1HusiEPHAIStNar9HVROgzwQ+iPUxoKzVzD08
         vwx08C55J/aJMtLGgg+H/Qx6ZbXOpc6OMpwV+LqMOeraPAoFIa3BcOr22BL7QeSPrFOx
         wLJiWmTKHQjGftQCkuyLMZpJkjDjEMJyupFoppMHMQQhiLbRYYTmu7cu6lj78vFMdUXW
         jREUiwT4EyNYZlWTPHmEDQ/9eEt6RVFxTo/7MHVVlKREkys3ZzCfsX3BBGbv1uQlKR5Y
         rgJg==
X-Gm-Message-State: AA+aEWZJJayqONYBKSUge2Vsu9OysUZdTyqwZvU8TNtSwxF8RRKILYTN
        wpvJi2onENbXIUcIYhI1FvP4Vsrt
X-Google-Smtp-Source: AFSGD/WZ9hk7kHV0CbgmBsB5OZsvQERgdRKFxwlq3DbqvOwsWWeZauy7Sb+W5qT/PWeHfLNGYJbjSg==
X-Received: by 2002:a81:a355:: with SMTP id a82mr10862027ywh.445.1544996636315;
        Sun, 16 Dec 2018 13:43:56 -0800 (PST)
Received: from ubuntu ([67.191.186.148])
        by smtp.gmail.com with ESMTPSA id u132sm3212511ywc.11.2018.12.16.13.43.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 13:43:55 -0800 (PST)
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     marvin24@gmx.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org
Subject: [PATCH] Staging: nvec: nvec: fixed check style issues
Date:   Sun, 16 Dec 2018 13:43:54 -0800
Message-Id: <1544996634-10427-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced udelay() by the preferred usleep_range() function.

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/staging/nvec/nvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 08027a3..6f35f92 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -626,7 +626,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 		break;
 	case 2:		/* first byte after command */
 		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
-			udelay(33);
+			usleep_range(0, 33);
 			if (nvec->rx->data[0] != 0x01) {
 				dev_err(nvec->dev,
 					"Read without prior read command\n");
@@ -713,7 +713,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 	 * We experience less incomplete messages with this delay than without
 	 * it, but we don't know why. Help is appreciated.
 	 */
-	udelay(100);
+	usleep_range(0, 100);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

