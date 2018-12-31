Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C5CC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C242921783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGAyddH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLaN07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:26:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43748 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeLaN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:26:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so18296923lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wO4JS+ZuQ6bHEVrOuqAIQJ1Zu4o/xltpmEy7FTjQePY=;
        b=gGAyddH0DjKlwGuoGZBGUT8v/EQU+WI9Gb3rVA/d8LyRBqJ+eI8yTxuAtSbeI1bOnR
         rfrcSSKBYciQhazKgajTVdxmH7pA+VfpLfF/Y1hPMBWgL9HN9rZOgFDIsERcySrWatb4
         WldGOX7fsxCh1bu7jPZNo1rNp3FJIvZ5IS8VeEO4cFm27gQlwgBXo8793F6zxZe13H5b
         PcS0K8n4i7K9iobWOPZQ9sno4UFmM4BpU0gRwjkyAB5VSuCdxPaBSIl78semKh8I0eN5
         w2aUlmiEOtTQZCScEDS+CnSH3bek1nktW9Fd1N/QUeCwugDLNdFdjBNxI+S7N2PA9oo+
         nx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wO4JS+ZuQ6bHEVrOuqAIQJ1Zu4o/xltpmEy7FTjQePY=;
        b=CEgj9gBWpva23XavyZ6Dtb7u06ldNiXv/rWvYN53BrbADNZqLNS6VEMHdXOHbP6iPe
         2S2cGG0oHgh6IwyyqwepJg8j9VrVuu5quuUmaABjgRTgp/E/xvV+Lr6LvSowPLv6N5lG
         i3hAuzNfU28pJg5VQGyATGiQu22ry7aKXjlj9G67HWHItItGJodpvbWMr2Y14Jwznwt6
         /QVQ9IsamJlJUsvmo4krbWr4MwPNePFAwJZN0OIW+PNxKoRdgU8Dvc78mBWNZopq1H7k
         8BfSx5cjredEhhHjhjpyaPyzMDOoagHc7YXEHe6GLIc7d+yozKMWQ6fHMF+qFnW7kHmA
         g9BQ==
X-Gm-Message-State: AA+aEWaoLj1hEM6mo3N2c/pHVyOrO+y+wNtIzt+s90GfP9ql4dAxuGgy
        lwB2knXqAwAayzVIs2dMp5U=
X-Google-Smtp-Source: AFSGD/Wuc+2piJdLfvkLsQzVS7WIoTJCDI+DHFrAOwf5FjMNbEm7nIdn0meYbZs4sh7XkFadz3yU6A==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr19680379lfb.140.1546262815567;
        Mon, 31 Dec 2018 05:26:55 -0800 (PST)
Received: from localhost.localdomain (mm-142-13-214-37.mogilev.dynamic.pppoe.byfly.by. [37.214.13.142])
        by smtp.gmail.com with ESMTPSA id y23-v6sm10162231ljk.95.2018.12.31.05.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 05:26:54 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v2 1/3] vmalloc: export __vmalloc_node_range for CONFIG_TEST_VMALLOC_MODULE
Date:   Mon, 31 Dec 2018 14:26:38 +0100
Message-Id: <20181231132640.21898-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181231132640.21898-1-urezki@gmail.com>
References: <20181231132640.21898-1-urezki@gmail.com>
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
index cfea25be7754..50ccb8bdfad8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1764,6 +1764,15 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return NULL;
 }
 
+/*
+ * This is only for performance analysis of vmalloc and stress purpose.
+ * It is required by vmalloc test module, therefore do not use it other
+ * than that.
+ */
+#ifdef CONFIG_TEST_VMALLOC_MODULE
+EXPORT_SYMBOL(__vmalloc_node_range);
+#endif
+
 /**
  *	__vmalloc_node  -  allocate virtually contiguous memory
  *	@size:		allocation size
-- 
2.11.0

