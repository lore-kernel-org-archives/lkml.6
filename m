Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42DBECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6324020854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfrCPhuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6324020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeGUUE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44607 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so14098076wrt.11;
        Sat, 21 Jul 2018 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cQnpQ5ukIwhaXpqaMQiYbTqwtfXwfw7nbJ/+Aug88sk=;
        b=IfrCPhuwMPV/ySeuyoxkn4RKROasvdUJ6EFsbIDmtHJPXIxNWABCdFfA/PlfEsPmNy
         IOeqc7Dbk2nejKCxuRWUcv0vXpOR4hrDNH6nyBUa//NiH3zlvWjuKASHXGED2xpRGyU8
         Fj0PohWCBpSqpDyVyimHO6NcCXEKvX6wCN8hZoNN0W9Mt5yIxfIb/vKMBYbIintkSUgZ
         y1DTfd4MaS/lmRVBJ0T+/Mb8rNOo0uZHXjDJJMVEaITucI8SnvpGxE00/pzlXSJkP+sq
         LQoaT+8mnMp7WwfNCo9LgQDuVd6BjcVcw2sh3LrssM60t9INzZFcm9nYT1wUQaMsVi0o
         a23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cQnpQ5ukIwhaXpqaMQiYbTqwtfXwfw7nbJ/+Aug88sk=;
        b=nvx7092eMAVeR3B8DmizZMe4QTAvjBO/ghbr/eaCEh2GqSavHfXOTK3u6phjtbzsxd
         KgYfRxOJnQCWDckG2/H13DEVnqDfmEa5/C7p1cb8NXIPEHE8t9fR7/et2VicbvxLNUHf
         wj/g0UwWR7vsFyrfQ7m5PRZCfhjIoy9jHZ0NgX1bNPZuywMOBOnIlJ8modUDgbpJfPwv
         tk4OuYIMGOpU3izZw0LrYZSoNSXG6ExC+6arCl32G5mRsJavtmItK8tXlX1t5c3VjbBz
         gJhWaG2prwctylg2J4UbFuC4T4Z7VwBC+XyewaztcIXBPHOn98EV5C3aiyJuOTkD2GLu
         cv9g==
X-Gm-Message-State: AOUpUlEfNLaGqZxpve7Fjt8vL99saVQDvhFU8a08SbTfiqTsrWMHk+DU
        jMnhTKTWHUI+vux/BPvKWt58rJJSYxBrdzZAZ7Y=
X-Google-Smtp-Source: AAOMgpdGgOkUqFNs910D/Gwd1byNXl1T0kP16LTG0VnQUD1tTYFy2H4lF2tzY6rlwXzh8rI5AjxA/Q==
X-Received: by 2002:adf:8481:: with SMTP id 1-v6mr4679308wrg.34.1532200241841;
        Sat, 21 Jul 2018 12:10:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:10:41 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] touchscreen: elants: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:45 +0530
Message-Id: <20180721191029.25658-4-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+		.dattr = __ATTR(_field, S_IRUGO,			\

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index d21ca39b0fdb..9717b7c3bb6f 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1000,8 +1000,8 @@ static ssize_t show_iap_mode(struct device *dev,
 }
 
 static DEVICE_ATTR_WO(calibrate);
-static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw);
+static DEVICE_ATTR(iap_mode, 0444, show_iap_mode, NULL);
+static DEVICE_ATTR(update_fw, 0200, NULL, write_update_fw);
 
 struct elants_version_attribute {
 	struct device_attribute dattr;
@@ -1016,7 +1016,7 @@ struct elants_version_attribute {
 	 __ELANTS_FIELD_SIZE(_field))
 #define ELANTS_VERSION_ATTR(_field)					\
 	struct elants_version_attribute elants_ver_attr_##_field = {	\
-		.dattr = __ATTR(_field, S_IRUGO,			\
+		.dattr = __ATTR(_field, 0444,			\
 				elants_version_attribute_show, NULL),	\
 		.field_offset = offsetof(struct elants_data, _field),	\
 		.field_size = __ELANTS_VERIFY_SIZE(_field),		\
-- 
2.17.1

