Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26E8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8864020867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNS16U3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8864020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeLACTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:19:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39790 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLACTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:19:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so5270247ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 07:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85KCfW3nCq0jcrH/zFnUuLUEVTX2XkKXX7xHs/xruHs=;
        b=WNS16U3TAIi5WGm5/3zTJ2oj/8f7Bw4KwTRN0E//6gsK3l1u34sRnv6d5ZG5z5zWQ7
         PcZ0kyC6Szpe2UqHpD/LQk4EH5yKVxrozSKWpPRqkjoH8OkCZzyBcQSUUm/zNktPBV3V
         MTh5lTnssACP+mGsV8MK2EJAH5IBj+JFqmSg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85KCfW3nCq0jcrH/zFnUuLUEVTX2XkKXX7xHs/xruHs=;
        b=sYWyLdqTNbPUPYh3IC/n8eFjlzOCXYFm9FyjK1koqN/U51Is90FXUNDzGmjJ5jqhF7
         6Tp5l25Fzeb++OMNSNdFxoEV3j58PHZx5OaF9E7LZ6j/glATOX7GxNFka6l78DJvrKkL
         LYXaM3EkXNMENkPLWXapRPQSvF4vZCuK7E/9B8IjkOcDjpshY0akEGeV+o9/ui/TujCI
         meqYWU0KBB7uIHP2tsxfTzCpF4ZETBGVeJ9zhskpCAzc2Z5lnhZK93S+Qk7qAOe6q/GK
         AHnrwcjAIOJtpuKzRxxPimbhg4jZmCWeCT9Kt+ewTLzqnCP5ejk6RvK6vW8sS6Ddgd3C
         x5Qw==
X-Gm-Message-State: AA+aEWaj2XUUid9f9Qf94hcBymAeVDNf3/Rg2HdzBTBiJe8uGdF2C8CF
        JHoOBFBHTmvGKusSCrdEsQL+MA==
X-Google-Smtp-Source: AFSGD/XiXiNiOaeLEUQYh09lGs4UYroBPv8sdQvKtrB54ACrUz6h8+MIjRencTE8CpHxNyL66BEz1A==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr4448681ljj.102.1543590581488;
        Fri, 30 Nov 2018 07:09:41 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id m13-v6sm858237ljg.56.2018.11.30.07.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 07:09:40 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     keescook@chromium.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] tracing: instruct KCOV not to track tracing files
Date:   Fri, 30 Nov 2018 16:09:35 +0100
Message-Id: <20181130150935.27493-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have KCOV enabled and running ftrace startup tests we end up in
a softlockup. Kcov and ftrace tracing each other makes it really slow:

[  275.141388] Testing tracer wakeup_dl:  PASSED
[  304.738345] Testing tracer function_graph:
[  716.236822] watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [ksoftirqd/0:9]

Rework so that we don't let KCOV look at tracing files. Could probably
be more selective here, but in in general letting KCOV and ftrace check
each isn't the best idea.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/trace/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f81dadbc7c4a..c7c73b976103 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -6,6 +6,11 @@ ifdef CONFIG_FUNCTION_TRACER
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
 
+# If instrumentation of this dir is enabled, the function tracer gets really
+# slow. Probably could be more selective here, but note that files related
+# to tracing.shouldn't be traced anyway.
+KCOV_INSTRUMENT		:= n
+
 ifdef CONFIG_FTRACE_SELFTEST
 # selftest needs instrumentation
 CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)
-- 
2.19.2

