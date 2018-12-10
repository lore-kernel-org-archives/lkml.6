Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71326C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F55620821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544434220;
	bh=DpYN9AzvA5MEPNdk5HvCEPgrtGa2DDf7RqD/Qpo8Eyg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a+5JXc8jJktdhKRkxu4nPYxr/eD7Jd9F6XYM/uh3j2rH5P0NmZSmGyTdD9wn3/gEn
	 V/8sQrnKZGdxsApg1DT0faKRgfOpdWRLfQKhNb1FcwWioKsUtt/KJoy/M3F+L0RR5D
	 GmV/d88MpGlzqWKgg2eVi6621EaQtFojGJ4ymKZc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F55620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeLJJaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbeLJJaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:30:16 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFDB20821;
        Mon, 10 Dec 2018 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544434213;
        bh=DpYN9AzvA5MEPNdk5HvCEPgrtGa2DDf7RqD/Qpo8Eyg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FtjA33LOawcGVWkqO14/lBMTl2HK4vl3VOeqBS8Pa4otNGmd0pzaxk4HDKfccH2IQ
         EC33yLjPHDpP1XLxr5u5wz8/DH8KJ1dmxVmoDlnu1t/3kUwcbnvl4dxTzyhW3eJ14D
         PQ6B8WyQzXgd7pIYK3ET5CD2L2aQptdvJsNqsMwE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] led: triggers: Initialize LED_INIT_DEFAULT_TRIGGER if trigger is brought after class
Date:   Mon, 10 Dec 2018 10:29:59 +0100
Message-Id: <1544434201-14190-4-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544434201-14190-1-git-send-email-krzk@kernel.org>
References: <1544434201-14190-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger driver can be initialized after the LED class device driver.  In
such case led_trigger_set_default() won't be called and flag
LED_INIT_DEFAULT_TRIGGER should be set from led_trigger_register().

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/led-triggers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 9421222ca7a0..c67b044ae0af 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -252,8 +252,10 @@ int led_trigger_register(struct led_trigger *trig)
 	list_for_each_entry(led_cdev, &leds_list, node) {
 		down_write(&led_cdev->trigger_lock);
 		if (!led_cdev->trigger && led_cdev->default_trigger &&
-			    !strcmp(led_cdev->default_trigger, trig->name))
+			    !strcmp(led_cdev->default_trigger, trig->name)) {
+			led_cdev->flags |= LED_INIT_DEFAULT_TRIGGER;
 			led_trigger_set(led_cdev, trig);
+		}
 		up_write(&led_cdev->trigger_lock);
 	}
 	up_read(&leds_list_lock);
-- 
2.7.4

