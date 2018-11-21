Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB8EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F15214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+VCONlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F15214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeKUXFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:05:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41185 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeKUXFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:05:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so5364539plm.8;
        Wed, 21 Nov 2018 04:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3WWMmxusDF5r9jzOUbyQU6ow39PRBSXzvrwTs4J0ls0=;
        b=H+VCONlDDqg+ewolkPxrQwitYhbB/M0akxo9L3zhaBp2los81hskcMUBY0l2hbpyMq
         7i0AhX/KA73mxw7cwDx/Ub40rXdbKo94k8IKRDk/XpGDCmtXlAJJX8OGLWqB0/cfcmS/
         6Tm+FUhyFvVzfRb1XzDi05xwElq+hq180zSirsCIf+Jy0UX8PVI1y6r/3rd/7FmwUM13
         UEdTK1KewsahdfWxJhU/R5k46nY7tA5YkC3x1QIlBjelsPiqdvQcZPCjv48irMj71YM9
         EWUDoJk5o0LnncdXvlBYkLhKu26XlfcGpV3JOaT/JvWHgRrAVfWbLYd+nnRcQLygNqW1
         m0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3WWMmxusDF5r9jzOUbyQU6ow39PRBSXzvrwTs4J0ls0=;
        b=hbj0mBSotVPjNp03LDx3p4aJWe12A0lDNrNa8dcGfXMVdEA02d2tKX0w3+cgIQGd9f
         rWgovKBYrRAcIX1zXXlu4qS+BGc149fWdzbTNZEFgpkGjxgOo2MULBDffSroo7oqEtiB
         cg/CacZ7+UbEltKABbJpLhf0FhUzsY9XmErIsXcLRbsY4ZGqclkgl9OB8rD3Tr9qeSbn
         zI4nOLS6TlBQjy5Z63EmV01ex393sHsoQt6w91Dskc9m662pNytdDnle35RrvPC2pwI6
         dbqIEmU2VHG3qKAxBycVrIB8mgnfehT1ho05zLD1cWgbPX51O7lWV/75QR/49Gs7U1Hi
         AcMg==
X-Gm-Message-State: AA+aEWYZ9QOgo7a4pd43aMcNSBQqNl7MuAJjPNXZVWZT5002J7tbl7Zd
        R3a44pxsOqWKdlOwzAcAz0Y=
X-Google-Smtp-Source: AFSGD/XqIKrsmCMf5Ux/YArs3/+WyC8tX5c96/+EGrRGJCE5pV9mQfoNj9cSpq3E+78n1p9pStZDyA==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr5793118pgb.56.1542803502625;
        Wed, 21 Nov 2018 04:31:42 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z62sm30136997pfl.33.2018.11.21.04.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 04:31:41 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc:     linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] leds: powernv: add of_node_put()
Date:   Wed, 21 Nov 2018 07:31:38 -0500
Message-Id: <20181121123138.21870-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node returned by
it and that reference needs to be dropped by its caller.bl_idle_init()
doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/leds/leds-powernv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
index b1adbd70ce2e..0b1540029034 100644
--- a/drivers/leds/leds-powernv.c
+++ b/drivers/leds/leds-powernv.c
@@ -285,6 +285,7 @@ static int powernv_led_probe(struct platform_device *pdev)
 	struct device_node *led_node;
 	struct powernv_led_common *powernv_led_common;
 	struct device *dev = &pdev->dev;
+	int rc;
 
 	led_node = of_find_node_by_path("/ibm,opal/leds");
 	if (!led_node) {
@@ -295,15 +296,20 @@ static int powernv_led_probe(struct platform_device *pdev)
 
 	powernv_led_common = devm_kzalloc(dev, sizeof(*powernv_led_common),
 					  GFP_KERNEL);
-	if (!powernv_led_common)
-		return -ENOMEM;
+	if (!powernv_led_common){
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	mutex_init(&powernv_led_common->lock);
 	powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
 
 	platform_set_drvdata(pdev, powernv_led_common);
 
-	return powernv_led_classdev(pdev, led_node, powernv_led_common);
+	rc = powernv_led_classdev(pdev, led_node, powernv_led_common);
+out:
+	of_node_put(led_node);
+	return rc;
 }
 
 /* Platform driver remove */
-- 
2.17.0

