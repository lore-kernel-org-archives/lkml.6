Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863C5208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaNvG3rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863C5208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeFTP0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:26:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38954 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeFTPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:24:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so3730485wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0SdcYFgQOnNQJBlnlcaX0uJ4bOsKrRicmvs7y9kVSAg=;
        b=RaNvG3rpL9QFAwkfOD4I9SM046U787iU3B85YRqsuN5Yeu23YI522cJzYBjAfTBtEN
         lh+/9ZLiM1S0yf08/mT9u5qCYDldPMDKr8yJb2ZiZDu/Eh6oZYXAW+p8L6noF1rH5T1n
         Q0opphjG2XPih7UnNTJ6XTtOdspP5rVTGYw03vEoK0wHQGMPdqxq3CEdQFpvW3ODCa14
         rLuflyTTE+/VuGes4koZIsMrqS2/Yl+KzPpnfH+35T1fgVBq1747fWhUpnGDNnj7sKrc
         Gx81x4z25O5vYT2j2Tol7tkYXN6GgNp4w6BsyB7BDMMM9Pxu/4IGnS4Lm132kM9tB+Q1
         hqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0SdcYFgQOnNQJBlnlcaX0uJ4bOsKrRicmvs7y9kVSAg=;
        b=rPUIDgITd1hBdOmEAmmeXmD9ut3CGQfuIbJr1+MCTyn4p/cKdkkLTSp+JKn51S0ajV
         jJFrbtJGzqF18ClG9I52W9IQukYOmYmpdAyrD+TPyb3RilqFWmjw+uP/nJA30wQokqgS
         W4xpd/I6PgSdDqxkenyCpT2q9nsolCjma7GFu3aGBtrlbsAtNNRYAGhz9HdQl/KzGmSf
         us1Q4Rlms4RZlcQHK+CUfC0941hHH7oBw7+E0sgnpGlaauxYz9hh07N7B7u726QF2JaY
         koXKm8C5dTS2rGCXq6v1cn2ZpXt8H00ZfwjHZMZ/GyE7vjgMfQ7LgLIcckUnBdKoLjWv
         JyBA==
X-Gm-Message-State: APt69E2P3cTCjX3YteGt7uhV9gdTBPskn9Q5KDHxJGlp6KH752cHUQfh
        ZlqPeDIQLGrvtYWBYsx/miSeFA==
X-Google-Smtp-Source: ADUXVKLXT94yC0cFozFu3kmSJDBexRMscv440Gy63zDsomyYjwP//+06z4JAxvYtKPL1B+wvy3NnwQ==
X-Received: by 2002:adf:aca7:: with SMTP id o36-v6mr1408574wrc.258.1529508275965;
        Wed, 20 Jun 2018 08:24:35 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3959244wrm.65.2018.06.20.08.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:24:34 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v4 4/7] mm, arm64: untag user addresses in mm/gup.c
Date:   Wed, 20 Jun 2018 17:24:23 +0200
Message-Id: <1203c510e5c34e97e5940688df075d69429e94de.1529507994.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529507994.git.andreyknvl@google.com>
References: <cover.1529507994.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Here we also need to handle the case of tagged user
pointers.

Add untagging to gup.c functions that use user pointers for vma lookup.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index b70d7ba7cc13..5bb351c91989 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -666,6 +666,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -820,6 +822,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

