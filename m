Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E035BC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145BD2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544434216;
	bh=K8KFsFKJSF5CBRUwpMIArydybGxtUPRO7ung0m0khnc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kg9PaXYfe1QuEnPdNsowQ2v6Sy0ouyaft+8jMNPO0nSywSzlyUnOdk2Rof74WE1qk
	 WCB5A0kPazOofU4MburBasPEBY+KyS4Om6QfU5muB9NieA/zwLYTGHGeT06St9IcHC
	 +yprMCtYV/TVWvD5xPOgj93naCrOHtpTVnscfh3c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145BD2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeLJJaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:30:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeLJJaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:30:10 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300C320855;
        Mon, 10 Dec 2018 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544434209;
        bh=K8KFsFKJSF5CBRUwpMIArydybGxtUPRO7ung0m0khnc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nKEt857grMOK6EY7ELfD9xfS12NoEyFrXxjBGHA5d/eqZ3uaNMYRkDcwHAzcSBxop
         lojW6/MK/TuQtZN8E72KAH4gqJK7hd0Y8bu/+lgToOjgwVG3/y5+gglsSARe/QP6KF
         OoP/FyaWDqyU/LhUDo6xsyHRA8TsUZbG6DrQdNKg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] led: triggers: Break the for loop after default trigger is found
Date:   Mon, 10 Dec 2018 10:29:57 +0100
Message-Id: <1544434201-14190-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544434201-14190-1-git-send-email-krzk@kernel.org>
References: <1544434201-14190-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Anaszewski <jacek.anaszewski@gmail.com>

It is of no avail to continue iterating through registered
triggers in the led_trigger_set_default() after the trigger to set
has been found. Add "break" statement to fix this omission.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/led-triggers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 17d73db1456e..52b12e601ebe 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -200,8 +200,10 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
 	down_read(&triggers_list_lock);
 	down_write(&led_cdev->trigger_lock);
 	list_for_each_entry(trig, &trigger_list, next_trig) {
-		if (!strcmp(led_cdev->default_trigger, trig->name))
+		if (!strcmp(led_cdev->default_trigger, trig->name)) {
 			led_trigger_set(led_cdev, trig);
+			break;
+		}
 	}
 	up_write(&led_cdev->trigger_lock);
 	up_read(&triggers_list_lock);
-- 
2.7.4

