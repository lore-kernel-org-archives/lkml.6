Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C90C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59A720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awiOEaaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfAODil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:38:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46533 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAODil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:38:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so610182pfe.13;
        Mon, 14 Jan 2019 19:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pbG8RCn3EcU3T71tJXbEuPRA6jWnrxO5wD15kUiK8zo=;
        b=awiOEaaOqFx+cL/95bHzh9/HB/8ISynAokWTXyzyDP7+vQSfjvIrE7rrB+2CNzrFqM
         tNB44eEUcILankjFyM3clLTYOhdihtAudVQghHapfeSSZ0LIKfY07czCv1acWllzVztS
         eQ/cE/qF42KPtl+fsmhZqvMJBUpgGHtReKVv5HdSy8cCYwxbNqwT8HUZnHua7HSyk7a6
         wDVZ3Xj5Gm+DrAjw/n4GZCh5PuLzu9G/GdgnLOnNhdKJmMTVb0OIKbPcS/Gbbij7QCbY
         +ZksANMcjHaE5nLdMG4KWNPmClwNAyQtkCKUbITTnFRqM/JcVP78AINb5G499JuF8ixs
         dNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pbG8RCn3EcU3T71tJXbEuPRA6jWnrxO5wD15kUiK8zo=;
        b=KCMrKINAmhY0OQdDHye+/UzOGYlbZWyCbTChuVfCk70hpwu8lQUPgblhtfUSP0bP7J
         E0RPte6aixOQua3mGacKVtunrX4p68t8L6CJy9qj/Lm4Ut+MOwjblKVFrxQQttsM3hvv
         e9hBck11VHAbvuMnYwzw/83paJimX81z+G+rYd/8dnW0huYkoZEjcD6gyVX9JM8InZAo
         4Z9o9/HPyU85K2j+vFjAfTeRzhRIq7B+NYS3PU+Zz3QmoAQRoLNdQjg9cdBH72hnfXp9
         qZxE9ri3Yz7tBf6NSpw1c+IT9jbRZfN27tEghjMx8f+8iBnxOw3+qksa90Rjgq62rjcG
         An+Q==
X-Gm-Message-State: AJcUukfgGFwjp6B/j7iNkYRnFe6156pwxz732bTmuO42SmmyMzLAiUkq
        5DRfsDJJUw3kh26ltGQqw4A=
X-Google-Smtp-Source: ALg8bN7rLZucp7Lcg9Q7fWuNYdmNA/ZLePw6UTauS/xA8JJ1sV0WFCElL+WUSORxOubItackmmJlrQ==
X-Received: by 2002:a63:da14:: with SMTP id c20mr1755173pgh.233.1547523519813;
        Mon, 14 Jan 2019 19:38:39 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id j21sm2128457pfn.175.2019.01.14.19.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 19:38:38 -0800 (PST)
Date:   Mon, 14 Jan 2019 19:38:36 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: cherryview: fix Strago DMI workaround
Message-ID: <20190115033836.GA150475@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, hopefully 3rd time is a charm. We tried making that check
DMI_BIOS_VERSION and DMI_BOARD_VERSION, but the real one is
DMI_PRODUCT_VERSION.

Fixes: 86c5dd6860a6 ("pinctrl: cherryview: limit Strago DMI workarounds to version 1.0")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197953
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1631930
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 9b0f4b9ef482..8efe8ea45602 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1507,7 +1507,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_Strago"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1515,7 +1515,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1523,7 +1523,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1531,7 +1531,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
 	},
 	{}
-- 
2.20.1.97.g81188d93c3-goog


-- 
Dmitry
