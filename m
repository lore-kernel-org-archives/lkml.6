Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F211C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B7820839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDOlfENP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B7820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeLLSgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:36:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35467 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbeLLSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:36:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so17211345ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4dZfQj97m6orxImud5MEJdclSGLyzwnb1g9Ebn+haA=;
        b=bDOlfENPPw/TLc4DlZr3C10SP5/ex7BM1Al+74hV7+AuPzIqcxmJqS3P5weqws+sjM
         JOU0gTvS3z3hjAOkCd33s3ywj6z/K3DJ52Bv0+QGVdIR0iTCMQGGuiYlM2U9pBsjTeP4
         R00Blc9T5Xbkc4kfgbl0Pwe+UUdw1ykrXei14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4dZfQj97m6orxImud5MEJdclSGLyzwnb1g9Ebn+haA=;
        b=sElkt6ew9ba2z8e2fg/Z733UhC87kR6hZQV7INnnH9Qe8a5sWLkCJWfCcdz9x1Vdjx
         iB35Vi00wzAwdO5K3fqssi+hKeDis48YUQfkjJY8QDvW8K9sEQXwU0M3I4rwZOLhsbbz
         dP+OLktkJZjrQY8Ku6UzanqRALBUJePllkXiW5X93CiVK+/LQyEa+Dof8lE0uF7t3Tva
         vunAXkoZkg/LW9SCHB/ZSDfpAq9qZuLlq/UEDzO2G9iqTfh2w90bMarx3oLCjTkJniFO
         RSPdHCzg5rNWOlK9vzJndNipfCMbeTD68U2RYhcT1bQP45tL8pLIxr0L+RvXRAKGO47p
         s4Ew==
X-Gm-Message-State: AA+aEWaoktFkzSB4pX2WH7Tb0E9FrW63RoY67r5fwqlxz34tvE9WBpS+
        ag9ovHjP6M/biDwwjC/NVAAj8w==
X-Google-Smtp-Source: AFSGD/UERtjzgGHEKDpTMesz7cIhv6Ctej//vqi4XZC013pIvGU7O0i9hxMcasgR4upJVtFYkKj3Vg==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr12650009ljk.114.1544639805366;
        Wed, 12 Dec 2018 10:36:45 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id e13-v6sm3365322ljk.53.2018.12.12.10.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:36:44 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     aryabinin@virtuozzo.com, dvyukov@google.com
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] kasan: mark file common so ftrace doesn't trace it
Date:   Wed, 12 Dec 2018 19:34:47 +0100
Message-Id: <20181212183447.15890-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When option CONFIG_KASAN is enabled toghether with ftrace, function
ftrace_graph_caller() gets in to a recursion, via functions
kasan_check_read() and kasan_check_write().

 Breakpoint 2, ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
 179             mcount_get_pc             x0    //     function's pc
 (gdb) bt
 #0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
 #1  0xffffff90101406c8 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:151
 #2  0xffffff90106fd084 in kasan_check_write (p=0xffffffc06c170878, size=4) at ../mm/kasan/common.c:105
 #3  0xffffff90104a2464 in atomic_add_return (v=<optimized out>, i=<optimized out>) at ./include/generated/atomic-instrumented.h:71
 #4  atomic_inc_return (v=<optimized out>) at ./include/generated/atomic-fallback.h:284
 #5  trace_graph_entry (trace=0xffffffc03f5ff380) at ../kernel/trace/trace_functions_graph.c:441
 #6  0xffffff9010481774 in trace_graph_entry_watchdog (trace=<optimized out>) at ../kernel/trace/trace_selftest.c:741
 #7  0xffffff90104a185c in function_graph_enter (ret=<optimized out>, func=<optimized out>, frame_pointer=18446743799894897728, retp=<optimized out>) at ../kernel/trace/trace_functions_graph.c:196
 #8  0xffffff9010140628 in prepare_ftrace_return (self_addr=18446743592948977792, parent=0xffffffc03f5ff418, frame_pointer=18446743799894897728) at ../arch/arm64/kernel/ftrace.c:231
 #9  0xffffff90101406f4 in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:182
 Backtrace stopped: previous frame identical to this frame (corrupt stack?)
 (gdb)

Rework so that the kasan implementation isn't traced.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 mm/kasan/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 0a14fcff70ed..e2bb06c1b45e 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -5,6 +5,7 @@ UBSAN_SANITIZE_generic.o := n
 UBSAN_SANITIZE_tags.o := n
 KCOV_INSTRUMENT := n
 
+CFLAGS_REMOVE_common.o = -pg
 CFLAGS_REMOVE_generic.o = -pg
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
-- 
2.19.2

