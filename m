Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEFE2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jn4+ZB2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEFE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeK1TOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:14:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45961 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeK1TOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:14:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so22562995ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 00:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DndGfj+rO1QfUt/p99pUy1MhXDetTHrbF5pavq8NU8=;
        b=Jn4+ZB2O7N8A4mpqEFvOjLAnO6dDOZuQGt0wj5rPZGI3FBdD+V3Rg+WKww6xm7tGFR
         jY+2CYCjTBliu6PBMwOtv8k6uyPKB8w0jMnTfSxArxkU8MBTigDEym5tdG9fR4spqHvy
         gX+ML2II8NAZAWlP+oHDNP70wZBojfBXH7z3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DndGfj+rO1QfUt/p99pUy1MhXDetTHrbF5pavq8NU8=;
        b=XjAfZtEw2pAkkul9lEiZCWlbuGUO5+u9QQ4XqfqhAO79ahMrkJRpZcfQ9x/4XT0Cp5
         NZ08JlhJuPNXboCNq6Hwl0UaToFnlRIvyq9OwqcatCQsvSjr7FFmBNWEiJjIespHXKGK
         NgBBg3UBPaWGAUBOE1Ez5ucs1xUhZK//HCIClIYbXdDyXz05HFO9RX8ot4f+V12CID9v
         RhMyfPgt2lYtfTHCxmALDC9KgawVCAs+MKK3ngZRIOkEjgnX4q4zjTRQ2b7A/F/C9Ppl
         Ug+lNwVY+wTl+rvfZAKolW43vS+lzwjedt2U64brCnwfO8dlW0y87Y/Ugk8vudqTTzsy
         mVYQ==
X-Gm-Message-State: AA+aEWbaBPP3uXi/ZJ29Ls/H2YGzTFosU8AzqkkmjbedYfIK90xVqd9e
        eO/T7aHFgJ6zt3Y58fwU2a2W5Q==
X-Google-Smtp-Source: AFSGD/Uc2Fq4zdu9PGeTciSiWrWGVz6zq9oDSng91KES82sxhJlRH2MigrBNcC8xVTK8yWVFQGzKGA==
X-Received: by 2002:a2e:9655:: with SMTP id z21-v6mr5577591ljh.136.1543392799723;
        Wed, 28 Nov 2018 00:13:19 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id h76sm1086248lfh.58.2018.11.28.00.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 00:13:19 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     akpm@linux-foundation.org, dvyukov@google.com
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] kernel/kcov.c: mark funcs in __sanitizer_cov_trace_pc as notrace
Date:   Wed, 28 Nov 2018 09:12:39 +0100
Message-Id: <20181128081239.18317-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since __sanitizer_cov_trace_pc is marked as notrace, function calls in
__sanitizer_cov_trace_pc shouldn't be traced either. The function
ftrace_graph_caller() gets called for each function that isn't marked
'notrace', like canonicalize_ip(). This is the call trace from a run:

[  139.644550]  ftrace_graph_caller+0x1c/0x24
[  139.648352]  canonicalize_ip+0x18/0x28
[  139.652313]  __sanitizer_cov_trace_pc+0x14/0x58
[  139.656184]  sched_clock+0x34/0x1e8
[  139.659759]  trace_clock_local+0x40/0x88
[  139.663722]  ftrace_push_return_trace+0x8c/0x1f0
[  139.667767]  prepare_ftrace_return+0xa8/0x100
[  139.671709]  ftrace_graph_caller+0x1c/0x24

Rework so that the functions check_kcov_mode and canonicalize_ip that is
callef from __sanitizer_cov_trace_pc also is marked as notrace.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signen-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/kcov.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 3ebd09efe72a..97959d7b77e2 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -56,7 +56,7 @@ struct kcov {
 	struct task_struct	*t;
 };
 
-static bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
+static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
 {
 	unsigned int mode;
 
@@ -78,7 +78,7 @@ static bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
 	return mode == needed_mode;
 }
 
-static unsigned long canonicalize_ip(unsigned long ip)
+static notrace unsigned long canonicalize_ip(unsigned long ip)
 {
 #ifdef CONFIG_RANDOMIZE_BASE
 	ip -= kaslr_offset();
-- 
2.19.2

