Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3B0C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51382088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SAszeI1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51382088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeG1Fkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 01:40:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43619 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeG1Fkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 01:40:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so2374165pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 21:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0kmeoUjd9ifvLd2RRGIY0zKeh3atDFAMWw6uk7yfqc=;
        b=SAszeI1XUI1AErPBGQz2Q4auXPngDk9H8PGSfdUaygo70jS1QY3ttL2BTlLkLNl7Pb
         g+5hXb3H3K5S24s556tREkTWfUQ3w0bXq+Y4FPWiVpsXBy9KLRmfCJKp4947lUmWHWpD
         ZRtTgW0jS+FnbXZpNlLMy0izIyBAvIPJierxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0kmeoUjd9ifvLd2RRGIY0zKeh3atDFAMWw6uk7yfqc=;
        b=UWxaF/dMWUCwAeu7RS0ljCXq3ZGK8xoKJt2eOCtg535w5KMfRklSei4b5xfZPXPvqa
         6f1fUVwYvyyLhSglbedl8UVfki9aluG9ibJIluGVzOAaQ19xZyJdIlCr7mTCA+Jk166o
         +SEbYAS7XUrhVYnynIU6ZxfYtpUunSjR+JuudCtCftkEMn5os/NzPhsqyNuPOJXJc/4r
         hURin0icQl994XYkY6ZUn64dAIukfGpSVRzfA9hAUQ+KopWU3QBnHfZwNpeEWcS+p5Vn
         tfkSypXHTmTGNAUgcxTDvv8qWgKMtiVqgN60AWyvKm6GtlxN5rXsfeWznf1eLs06rNiH
         4avA==
X-Gm-Message-State: AOUpUlEMEtSTRR0HxDjol2OnkCQlH+twWIVTNJaxhcMwZgeLv43ri/eV
        ATPWl9GmFwseaXlk5SW+L2IN16HjCEw=
X-Google-Smtp-Source: AAOMgpctzNtYTCYqtuzdhjkpcwnc8c8aoWdWfU3zBN3AuquKtiQyChcv7YKvocAZmK7Yjp72JUYtzA==
X-Received: by 2002:a63:686:: with SMTP id 128-v6mr8361568pgg.338.1532751356781;
        Fri, 27 Jul 2018 21:15:56 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id n185-v6sm271864pfn.160.2018.07.27.21.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 21:15:56 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH URGENT for ftrace/core] lockdep: Fix error due to incorrect pointer return
Date:   Fri, 27 Jul 2018 21:15:41 -0700
Message-Id: <20180728041541.247520-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The 0-day bot caught an issue which all my tests missed (will add it
into my tests) where this_cpu_ptr is incorrectly returning the wrong
pointer from get_lock_stats. Fix it.

Fixes: f4ac253a8df0 ("lockdep: use this_cpu_ptr instead of get_cpu_var stats")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a6a6b7eb4b82..03bfaeb9f4e6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -249,7 +249,7 @@ void clear_lock_stats(struct lock_class *class)
 
 static struct lock_class_stats *get_lock_stats(struct lock_class *class)
 {
-	return &this_cpu_ptr(&cpu_lock_stats)[class - lock_classes];
+	return &this_cpu_ptr(cpu_lock_stats)[class - lock_classes];
 }
 
 static void lock_release_holdtime(struct held_lock *hlock)
-- 
2.18.0.345.g5c9ce644c3-goog

