Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03798ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C6720834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BXS3VRB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C6720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeJ0IDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:03:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45830 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbeJ0IDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:03:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id t10-v6so2635256eds.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUV4UhVcG/AakGqgG1SR2fwK+v1//1QwRiJOscTtP5E=;
        b=BXS3VRB1j+OTug557fp1po0BE+SAyb1vYONJzOY81tpn1zNnPVsLnzKKQoHdWLdgUu
         UCx8YbF6UAWxs/+LFDtgnOxPTtGkxGvLhguO46GLUdSLXGKGofzvVjp/HxP8UXo6ySHn
         q9sRjIRAmSZzJDq7uGtuiQpRLskXWVrMClXQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUV4UhVcG/AakGqgG1SR2fwK+v1//1QwRiJOscTtP5E=;
        b=Ht3tUnzL0aSghfx8mdiOVxN+MAjXT8Mxrr2hG/pBKMx7OUeXJyYQxmeZfuEtqw/qZ/
         VUBZFB4CGdb2r1yKEI1pwZz1zAAsRxWPFXGCtkLKRmDLfMD8Bg/zZjHcDlz/UiVuZWtK
         q4PCAX+vAoOCgVUaIRofgGG9nsskaVBNih5cksrePJSwxZJpSs1QpUIBag0pdmaaZSw6
         vMrpFeOXxmke1Y6YgAV9pHB4Pq5Lg9BjaLPF/oDAo+PjebzXWV//tRGlJlHDYrmlAIuE
         qlAgfM3bIxwydx77TAejXPzUztC3IOkJVzVYsgRZ+tIhOXu2AWMnJnEsmqtaA1d8W+Bc
         Y5mA==
X-Gm-Message-State: AGRZ1gJktc03Hy/TdvKkzE8qUbl8nKQBtYydyjnIBkJTDGTTErC8N6HF
        OaA4VJJGwYfvKhZiRu0/DP/A8Q==
X-Google-Smtp-Source: AJdET5dfrxWw6PmGhxwmYYnOaNlHN0yHQoG1SS8x3O4MqKpbLxZRgPFGiRJUaIFg5u61DOxX8H6gKA==
X-Received: by 2002:a50:9724:: with SMTP id c33-v6mr4602757edb.47.1540596260146;
        Fri, 26 Oct 2018 16:24:20 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3986746edc.95.2018.10.26.16.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 16:24:19 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hwmon@vger.kernel.org
Subject: [RFC PATCH 7/7] drivers: hwmon: add runtime format string checking
Date:   Sat, 27 Oct 2018 01:24:09 +0200
Message-Id: <20181026232409.16100-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026232409.16100-1-linux@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -Wformat-nonliteral, gcc complains

drivers/hwmon/hwmon.c: In function ‘hwmon_genattr’:
drivers/hwmon/hwmon.c:282:6: warning: format not a string literal, argument types not checked [-Wformat-nonliteral]
      index + hwmon_attr_base(type));

Add a runtime check to ensure that the template indeed has a single %d
printf specifier. Using fmtcheck() also makes gcc verify that the
expression 'index + hwmon_attr_base(type)' is suitable for %d.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/hwmon/hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 33d51281272b..ec6f5f36b5fc 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -278,7 +278,8 @@ static struct attribute *hwmon_genattr(struct device *dev,
 	if (type == hwmon_chip) {
 		name = (char *)template;
 	} else {
-		scnprintf(hattr->name, sizeof(hattr->name), template,
+		scnprintf(hattr->name, sizeof(hattr->name),
+			  fmtcheck(template, "type%dwhat", 0),
 			  index + hwmon_attr_base(type));
 		name = hattr->name;
 	}
-- 
2.19.1.6.gbde171bbf5

