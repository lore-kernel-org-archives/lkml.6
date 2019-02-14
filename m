Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C4B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJLtWSJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395564AbfBNFYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:24:02 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38988 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfBNFYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 00:24:02 -0500
Received: by mail-yw1-f66.google.com with SMTP id k188so1869110ywa.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 21:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kdNPWkENdyVwHFX6470u3N2eCke6NGtpl7kSFCo5kh0=;
        b=RJLtWSJxbBqplzUcVnHmTz6IHOQ3IiO0XtxZWxWfC9C8GUqVUIVpfXfEQl9ow3f2Nu
         rk8dDEjSYN2kgtHIovcMOs1T7PwbUpl1bVcJ+Gj5GeFMoIiLSl1QUFGvb9zGRQNxBCbH
         rBgry4hQfIin+gd1NzQRw8l+enWhMNAD2If1Z/mMZjH80iPmJrl6lWFaYmnTQjgCAgPM
         Vd4yl100Yf4Ijgk9yLwwig8w01KdLYJv7++1SwhkPxBUt81RBijiZzJJUvLheOOulCwm
         jcYUlMnO7G3DmOwozQdOvS9lmuum4gPlcBW3EbLAA1lzZxyTZwOx/0+Na3zn/jm5hQbw
         9M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kdNPWkENdyVwHFX6470u3N2eCke6NGtpl7kSFCo5kh0=;
        b=RBc0trzZtyqTi4ZnxkcRuCsDYPHnby3z6wVbZpHECguI6rHpG+GFuEvkJHC4H8PeI2
         RyXQlFQ0vD7W86Bl3Nr3VlUHGvT1OTxV2WGuNL/+R2O46SndkbAt3j0etX3IWh7YeuGQ
         2QDG482DX0B+kZr5zB2H/Z5ZEcm61W2UH3onKYybYdYmF7ZH4BfaaRvVwn1mcGOK7G8T
         qlxRiVGwp7CsVcLrJm7Fdi+7LjBKzigYl3pPwS0TuLQxU7FPPo02/uSF/mujpm/tczct
         VRRNMB+WEBctyqcWNZy8Uxl/raQ6BZ6zfyw0lkeBCqAK86Ok4A4MgCOqExxqwXUt7+ko
         0luA==
X-Gm-Message-State: AHQUAuYRjW/IKfB3ose4GSH6iX7spUY3RStt5f58Rod+ZckDcv9/ihnT
        on8XN52/B4OQeIz7FPSgT8I=
X-Google-Smtp-Source: AHgI3Ib9pEDOG7BmDPRLmufxNDgVZqXKeIqrjwW1n2Dnq7CRd40S273hPHl5ymaaVUHK/Jg20shIJg==
X-Received: by 2002:a81:1b44:: with SMTP id b65mr1483255ywb.393.1550121841447;
        Wed, 13 Feb 2019 21:24:01 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id q11sm675909ywl.99.2019.02.13.21.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 21:24:01 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com
Cc:     Bo Yu <tsu.yubo@gmail.com>, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf trace: Fix potential USE_AFTER_FREE  problem
Date:   Thu, 14 Feb 2019 00:23:56 -0500
Message-Id: <20190214052356.26884-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Yu <tsu.yubo@gmail.com>

There is a freed pointer "evsel", so fix it.

Detected by CoverityScan, CID#1442595("Memory-illegalaccesses
(USE_AFTER_FREE)")
Fixes: 6ab3bc240ade4("perf trace: Support multiple "vfs_getname" probes")

Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b36061cd1ab8..4036b20a1067 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2515,7 +2515,7 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
 {
 	bool found = false;
-	struct perf_evsel *evsel, *tmp;
+	struct perf_evsel *evsel = NULL, *tmp;
 	struct parse_events_error err = { .idx = 0, };
 	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
 
-- 
2.11.0

