Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020ABC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D16B2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WgxGVzF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D16B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJBETa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:19:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37364 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeJBETa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:19:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so10381506pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHH0t8ofznxRGeFXKG9ao40jT0T1DkgvkRQUK37UXkE=;
        b=WgxGVzF+K1at9Jb60KBgSXfso8ompP6V7hsAQojDFQOJocgKdmMT0rnAgd4FZcLRna
         Tq3jUsMIpHKBI38IF+g7ub4VpnjZePju8YDy6yzLew56bcWZxT2IDwVzSHMLEXw1BJzs
         /sRu3ucQ2J8gdhTds+mUp3XhQwO6HueIWowXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHH0t8ofznxRGeFXKG9ao40jT0T1DkgvkRQUK37UXkE=;
        b=W6Lf8o4LOuvn0m0iHPkAGakkkhIemXtXdrr3+NjiK83u8BM3DAJpkC71O2/32gFK/A
         t9ETb4sErsiYmJ8U+vSiq7fBI4Ecn72SQfSxlWpkGHSFe4RUfF6IkFsG+eO0dXOD4XaH
         3+cD3wVjSoXYIfqr7HCYhmvUs18C38gzF15ldBJbx6XXeQyhUtryp3E05ICY65avOh9t
         9mY87C4wRWkPKQEYBjHhwgEELY+RNqTlyq5hdPa2AQu0g2vgz9tNL11TSYH+3pzrkREj
         UBJjdv34dh8OhbLfGAI7i/DhXe3HL6PmhiAVpvkLpKFXpAqZ8JE19YXrQo8r5/B8dLQa
         C0aw==
X-Gm-Message-State: ABuFfoivg+/kFwy4fJcaTPZ7cDi2C73kPzqjF7lJghUaqM2TNfJaRoQa
        OXq3ppjSsDmlQy7JpjXHTsuyukasUmY=
X-Google-Smtp-Source: ACcGV62vIXjyRNVnROrT4ZvytPDM9yCsjNmfG2mbtvsX1J981/Sa+0OmRUy6KOq9iRrB0r067WvGkw==
X-Received: by 2002:a62:2fc1:: with SMTP id v184-v6mr13297477pfv.115.1538429981177;
        Mon, 01 Oct 2018 14:39:41 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id j191-v6sm22131704pfc.136.2018.10.01.14.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:39:40 -0700 (PDT)
From:   Dmitry Torokhov <dtor@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 1/2] mfd: cros: add "base attached" MKBP switch definition
Date:   Mon,  1 Oct 2018 14:39:36 -0700
Message-Id: <20181001213937.8774-1-dtor@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a "base attached" switch definition to the MKBP protocol that
is used by Whiskers driver to properly determine device state (clamshell
vs tablet mode).

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

Lee, I was wondering if it woudl be OK for cros_ec_commands.h to be
merged through HID tree.


 include/linux/mfd/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 20ee71f10865..5fd0e429f472 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2132,6 +2132,7 @@ struct ec_response_get_next_event_v1 {
 /* Switches */
 #define EC_MKBP_LID_OPEN	0
 #define EC_MKBP_TABLET_MODE	1
+#define EC_MKBP_BASE_ATTACHED	2
 
 /*****************************************************************************/
 /* Temperature sensor commands */
-- 
2.19.0.605.g01d371f741-goog

