Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A913C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95DC20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRUjNA5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95DC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLKKhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:37:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46920 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKKhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:37:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so10348441lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ICbV7kzlI528WMoFmSsq88P2SQAOymySwYHXUg1CDQ=;
        b=SRUjNA5ayLs39A+dNy1FwW2A9TYKJMLCQSAVEOrlcbxapbR3r6sdecoy7lCBTMnuBo
         VLuChpHXx0kU+L5oywp0oiPgFTfqkyunPZZ+OJlYwY0jYpGyjD4i554qhmtsVooRzI+p
         rDFJh+FFdfBu1RTThoDEY8fEtEVSyHafUUGXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ICbV7kzlI528WMoFmSsq88P2SQAOymySwYHXUg1CDQ=;
        b=I/80UIrCV2BaAa2OWEWjFQW4e9WrkQ0wunZT/70xBd+gU4W/cpS0cUqsxhaa+HB+iw
         9LrhutED5MhTxeDEk0jwhuEP+dCXBk3Na/pr8TR/Zi8P3kMDQF7S2qNV81sXE0P9UZfL
         eMgnVa8GOQYq4QFfUbGfP0jCMy8X3Jjc9wRVMXdHecbgPkMC45kvYAWPWQUWfEwPlbEQ
         gZvFR3MP65ZOY9K6uLyFVNuZQTFa9MkF3Q0H/cIY4MULxrRpH8h+KXEmKxOaD5xvbZHK
         8Gxom337MzCLvC/qH4ppn1mKTcl3yn5foROpZbI3VnbYuW2obC/2FGMAXDKidjUGxY+E
         fZZw==
X-Gm-Message-State: AA+aEWbdYvg3RGaBQmvoY74m8EYZlptJEXl07DUG04803Dzm+6BOa1Fk
        4t9Fx6+vHjGEJoi7O4szlPEumqevYcwUaw==
X-Google-Smtp-Source: AFSGD/VlcWcAxL+yp0Kfdb5nQpSHYRrdlX/G1braOl+Y1F7wApKq13FW6QHPjryrkLvZHWxGF4oNzQ==
X-Received: by 2002:a19:4e59:: with SMTP id c86mr9471367lfb.132.1544524658206;
        Tue, 11 Dec 2018 02:37:38 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id y81-v6sm2659583lje.30.2018.12.11.02.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:37:37 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     aryabinin@virtuozzo.com
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] kasan: mark kasan_check_(read|write) as 'notrace'
Date:   Tue, 11 Dec 2018 11:37:33 +0100
Message-Id: <20181211103733.22284-1-anders.roxell@linaro.org>
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

Rework so that kasan_check_read() and kasan_check_write() is marked with
'notrace'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 mm/kasan/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 03d5d1374ca7..71507d15712b 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -95,13 +95,13 @@ void kasan_disable_current(void)
 	current->kasan_depth--;
 }
 
-void kasan_check_read(const volatile void *p, unsigned int size)
+void notrace kasan_check_read(const volatile void *p, unsigned int size)
 {
 	check_memory_region((unsigned long)p, size, false, _RET_IP_);
 }
 EXPORT_SYMBOL(kasan_check_read);
 
-void kasan_check_write(const volatile void *p, unsigned int size)
+void notrace kasan_check_write(const volatile void *p, unsigned int size)
 {
 	check_memory_region((unsigned long)p, size, true, _RET_IP_);
 }
-- 
2.19.2

