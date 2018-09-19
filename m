Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CAECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639BB21524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hZqPOWsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639BB21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeITDov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:44:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34893 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeITDou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so6190620edq.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cj6Tz2lOvKlo2A6buUz7nxcmOz4mMvrx9YeaWu/3RNw=;
        b=hZqPOWsu/NTA70GaWyGqwHoCTwwq6I2wMjE+9nx7WIV1+dym7JZ8LQd5b423RmaYcX
         eV9bH4NC+/uGPRoynPccQ3EZxhc68796GF6932YzBC/xq1SUx+KtEtzruHYIvl6eFA8R
         DsVALm9IYPqTUhJBJqEz2A/w6AfZpNNld3ciw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cj6Tz2lOvKlo2A6buUz7nxcmOz4mMvrx9YeaWu/3RNw=;
        b=sr23OwUvE146PoLEn66TCWtBrMSHF9Qi0rsG0WSl0QPc5A8TXHPDnlt3KnQ5eSzJHU
         lvnvBupLvtCBSrbVzVg9yPPifbXjw+bDWY659s2Sy+QIBiSLcePs3EuDXpPe0VHvgPWZ
         1ktPLTmmiJ84Q9PuoHHXqzUgzK0tzaocCz6xe/vLd0shKPjAOhZBMXQhBhuF7hxIiYgm
         +cW8K6MnTDfdmsT821X+ufb4eYyP6cGMBgkehAXuYCxsIOtKKGAydpgM13JmGHFjZ+xX
         Mk0Fl9VvLzzzMD7BPg6jn0A7pYThxrM4sZIIG/TL6no8hH0fJfuxbIitJ43DbcHaJrUl
         lZ6A==
X-Gm-Message-State: APzg51APmrRMOh8l4YRc+fIwoS0C9yECNyXAvO3nO1wA572Oj63a9GcT
        cE9qJ8SllJX6xvVoWzqqe+Mg0A==
X-Google-Smtp-Source: ANB0VdYLeVHrMrtgkC3tSP7c+cPtBz9J+Pb6K1gRzFxOZ14lUXShBJtW/gWQX8PhnSTWhJFXtWx3UA==
X-Received: by 2002:a50:d512:: with SMTP id u18-v6mr63393830edi.291.1537394692683;
        Wed, 19 Sep 2018 15:04:52 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:52 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/22] linux/device.h: use DYNAMIC_DEBUG_BRANCH in dev_dbg_ratelimited
Date:   Thu, 20 Sep 2018 00:04:23 +0200
Message-Id: <20180919220444.23190-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_dbg_ratelimited tests the dynamic debug descriptor the old-fashioned
way, and doesn't utilize the static key/jump label implementation on
architectures that HAVE_JUMP_LABEL. Use the DYNAMIC_DEBUG_BRANCH which
is defined appropriately.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 8f882549edee..0d8ed2adfc73 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1503,7 +1503,7 @@ do {									\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
-- 
2.16.4

