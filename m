Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124FD20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+HWVfa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfACOWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:22:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37605 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfACOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:22:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so29825251ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 06:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssv6BkHkmIpFCTqBy2LTU9LUeIInJoLd32GH+CfwWhs=;
        b=e+HWVfa3PL55xx5EF1eIIOluacFaR6jo0mr53G3qBkSFeXDQ154XLjSvh5wOPS5uz8
         pFwzfMljHnbKio7LKzAPybraydJyKA03IFw6jGyLVp7yhk/1hENfdk7BL/VuArlAcEnI
         5sUhe6knELbDjqVZo9iaT924+dKEiAH6dCEdjTjoixwGeFcxdBsH3mOlzS7kw0gnQXhI
         mDLWe9V+/uky/m92Fb3+XpSvQkDrxIE8NSQVCjHv1duFpeT/Aic6NZg0JTHx6SmbJuzk
         6zIbL2ladU36itGM/yxih1qsxRZVS5VztZfvtIKz6G5wnZUc+z40dDaS4/ihjU0DTTfp
         k1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssv6BkHkmIpFCTqBy2LTU9LUeIInJoLd32GH+CfwWhs=;
        b=HyccZNuwRvMXqoyHqNtTyvDUvDTv7Tmtgijh/4PfU1/BFNht83qvMrSrnqCwWBBqVY
         bdV2Skf3Q9unv3poZGoj1m5xTzVgabU+o022DF87o4eBdqJU/BPG6LT6WrU1bApISxQ8
         5HciXRGfOg3VLsqdtCy3MYK5YDs1brZ0mmcf0p5jxLm9LPTDzAA6BOGA/E3v4MGnyHuR
         L+5nPLsllBL4HUIM92ArHm4RaBI0ZDFtfW9cLebDotWB3Yh3UiUuGsg7a7Y2MMDL8fD2
         l2peQ4JjjbhGGpJYnlE1RJONcCEBRQI8hieAJVwoGHn6cI7rNzJjXCX43wNBnRqRftcB
         THHw==
X-Gm-Message-State: AJcUuke/QtC4vpZHBjz2TY9JuITpO4cN+4b7hlD1638auUETjB4C3dYp
        BCkpGJAgxck7rcRc2YW1Jq8=
X-Google-Smtp-Source: ALg8bN4ewekoLlYdfq5wN4BApo8S7pATw+y9U7s+PEyoChINuZwuQH2YanF+4bsjQvi4Nc4sbnrLyg==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr23157355lje.171.1546525353100;
        Thu, 03 Jan 2019 06:22:33 -0800 (PST)
Received: from localhost.localdomain ([37.212.195.0])
        by smtp.gmail.com with ESMTPSA id b25sm10594690lfa.96.2019.01.03.06.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 06:22:32 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC PATCH 1/3] vmalloc: export __vmalloc_node_range for CONFIG_TEST_VMALLOC_MODULE
Date:   Thu,  3 Jan 2019 15:21:06 +0100
Message-Id: <20190103142108.20744-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190103142108.20744-1-urezki@gmail.com>
References: <20190103142108.20744-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export __vmaloc_node_range() function if CONFIG_TEST_VMALLOC_MODULE is
enabled. Some test cases in vmalloc test suite module require and make
use of that function. Please note, that it is not supposed to be used
for other purposes.

We need it only for performance analysis, stressing and stability check
of vmalloc allocator.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 97d4b25d0373..1c512fff8a56 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1768,6 +1768,15 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return NULL;
 }
 
+/*
+ * This is only for performance analysis of vmalloc and stress purpose.
+ * It is required by vmalloc test module, therefore do not use it other
+ * than that.
+ */
+#ifdef CONFIG_TEST_VMALLOC_MODULE
+EXPORT_SYMBOL_GPL(__vmalloc_node_range);
+#endif
+
 /**
  *	__vmalloc_node  -  allocate virtually contiguous memory
  *	@size:		allocation size
-- 
2.11.0

