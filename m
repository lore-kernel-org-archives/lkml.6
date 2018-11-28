Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2AB2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TN8CsGdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2AB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeK1TOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:14:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38456 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeK1TOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:14:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so22588500lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 00:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sT28w4VqOiNSTrHJbFMJkn4OXQZ517REFZ8xfo8WT/o=;
        b=TN8CsGdFbbenE7mu/JYYtv4IVkpnM9+vR+llRyr3LjP8CTf3KXpi8JRramebxF2HdR
         FIT1M4NMjw/Pmu5aUd+e7s9Fjuwn33qwKa+i8QdEigaEvT0ZNh7e/8PEEFwis9nPOnN5
         Lqxf5craHUcP9T5vJ2OxS/lfdyWcxZ9tt8BEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sT28w4VqOiNSTrHJbFMJkn4OXQZ517REFZ8xfo8WT/o=;
        b=oriPBy6T2ZzHzHs58l6wRcBsoRH6/lG7IDMVlxTVFiUpMR/VX/nCQ5Jq6RMq50dEz8
         1r354pw5N3xDl3DUpH/2f0GqDSNj2ISNI1onF1GHpIrLEtA1eI7arT6sAAeAXWi5iB09
         tHPdZqmpLvv6rWyW4ySBWoyRnPwn064wFv9ZXH3K+UdeItpDB6ZIM5ZDQFE2LTZ9tDsK
         HJeiR8tKYQYD4bFXhYdth7jBiR/MZncPZD+55FX0jzoyp6CYjCrAcQRbc7xAugfDYfQy
         JksKMGP9UTQ0N4I8CHOghnMGkD4sJTsoX4EqFULT0DIy1KhOlXqlgg6iSRjPOYtLcGiB
         DmFQ==
X-Gm-Message-State: AA+aEWZuqELfW5ZVMrn8BmBI6xHW9d4CKdjEVa6y1jgjkBRXEDP+RJUu
        RbiU4bx+HILd57Xizkhc28AZfA==
X-Google-Smtp-Source: AFSGD/VBJPRhIHl2ylbKM+Z/W1HG233+r/WJMLHATXbaOp1KYX3nevOZ1atyLY+TJ1r5iLDz53ZPmA==
X-Received: by 2002:a2e:568b:: with SMTP id k11-v6mr22525904lje.105.1543392826029;
        Wed, 28 Nov 2018 00:13:46 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id f8sm1215827lfe.72.2018.11.28.00.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 00:13:45 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] kernel/trace: fix watchdog soft lockup
Date:   Wed, 28 Nov 2018 09:13:34 +0100
Message-Id: <20181128081334.18408-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a allmodconfig kernel for arm64 and boot that in qemu,
CONFIG_FTRACE_STARTUP_TEST gets enabled and that takes time so the
watchdog expires and prints out a message like this:
'watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]'
Each time the function ftrace_replace_code gets called it stays in that
functions loop for 41424 times.
Rework so that function cond_resched() gets called in the
ftrace_replace_code loop.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/trace/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5b4f73e4fd56..3f456921dedf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2426,6 +2426,10 @@ void __weak ftrace_replace_code(int enable)
 
 	do_for_each_ftrace_rec(pg, rec) {
 
+		/* This loop can take minutes when sanitizers are enabled, so
+		 * lets make sure we allow RCU processing.
+		 */
+		cond_resched();
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
 
-- 
2.19.2

