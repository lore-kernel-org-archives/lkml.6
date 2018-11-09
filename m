Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC07C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8053E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DDr55meq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8053E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeKJI4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:56:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34027 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeKJIxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so2980448ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Kaa9QT6s0Vk3CHls+9X11M7c6cCf7o8U2fTfb0Bcqg=;
        b=DDr55meqwWhStJzdS5zJztwNn7nkaJ34asmk5nvE8/o/VB6yANbcDGB2jS4OUMy9MH
         a4P9PFNdrpHBxBwJgWT2UVG6azvzcPvoAQzurUErI9wZs10uHFZV4TqC5M927FwZPBPv
         Pla+40XEMB7e3lU1302uHTNTojHqt4zG7IeUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Kaa9QT6s0Vk3CHls+9X11M7c6cCf7o8U2fTfb0Bcqg=;
        b=Rg8S33Eq5cH0WHhO5o8sURBcUl8C8MfZZz4BRrURHTA2grz0GIQtDqpCu6qiN08GDj
         ztlrkLuLzn7QtRYBOA/quFJeh1FiYyHHcIWNlph6v+5xrHSW2ze5o8a3hTmrzEFJUfFy
         cYi3JQKSGfmlQ75zVsTHSXc5dhz6NFF9r55H6egepkmt3GSTWMg8Ef/i0J+jZOteDakI
         VYvRRVwYxCfnzgrCNfni+8gH8+BpK0KNWytgz4Fk4hUZJ1aLm1MTIj30ms4FViZd2brU
         BdHi1amzGunJrXabCCDv6UjdthpW/0OAbRMDHvPDfgJxAyuCctos0oOHgPljAWwDH+dK
         ofGg==
X-Gm-Message-State: AGRZ1gL76NEoS+eFB3rbiuOkOs/L2X9rTNKbUnHDL0ojGBZhf8R71a9E
        qSLwD9mFO4E/YRRuLnDOr5vTLA==
X-Google-Smtp-Source: AJdET5cJmlRJFAiV+1ejzIq0UzDqDrPpbxi7x+VaRxdeTppxEe1VWx+niW8UUbEhQbDqQG685ydtaw==
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr6319047ljb.11.1541805060992;
        Fri, 09 Nov 2018 15:11:00 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:00 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 01/23] linux/device.h: use DYNAMIC_DEBUG_BRANCH in dev_dbg_ratelimited
Date:   Sat, 10 Nov 2018 00:09:59 +0100
Message-Id: <20181109231021.11658-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_dbg_ratelimited tests the dynamic debug descriptor the old-fashioned
way, and doesn't utilize the static key/jump label implementation on
architectures that HAVE_JUMP_LABEL. Use the DYNAMIC_DEBUG_BRANCH which
is defined appropriately.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..061cd83ac64c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1538,7 +1538,7 @@ do {									\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
-- 
2.19.1.6.gbde171bbf5

