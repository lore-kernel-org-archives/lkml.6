Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D800C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085012145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Awggy/OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085012145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeLACSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:18:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44229 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeLACSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:18:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so5258732lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 07:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cevKt/iVwCRv9xli91T/QyVSDidq+ft7LMiFzNhTbQc=;
        b=Awggy/OCtNUr8kqjtPE28UJFmBPZvDO48FDcUcWjDpeHWrRglJpug7qXTQQCvQ05ER
         3mxRE/+7bidUJDNjqD7hHAVoV43JehZ2xsPfFjbcEKATeafqVHOrvmCANLYzYuDpH3r8
         rPB9SO9J5Zarads+PxHl3nlT9XF8dBjrwROTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cevKt/iVwCRv9xli91T/QyVSDidq+ft7LMiFzNhTbQc=;
        b=Yevo2sukd7UB+jOY1fCTKTwN2tZlHoN5bXoyRUaghAYpoAer9m+ESB6jLCHC8Q8LYG
         ykOZpXqNelxuKE1aH+xKfhzF+SVRrlUrQRxkkGarEVWw3AZK24m1wMrJbl+lAIJ32OHl
         r1DFah7AmyfgTOeuI6mNkBMqxYx953ACq7mRVQDGCwgpZd/q3Wb4ymn/wi3SvgBKzDOU
         XLktI8Su/fD5PASwL3jNEwwG/t1GUSVH+OOCuHUazckcdP0+W4Xmdrq9Ts2AeB6/UYp5
         PetGyc5TKBuEgSLxEwyrB48yGRbcHhPqd+NXZJiMeZjQUJb6u0AzUtBeZ1Sshcr/zczl
         jkTw==
X-Gm-Message-State: AA+aEWYcvsbJglj2870DOpjgWyEM1tilCkXj1kvzTqnhGVFuofYOhibk
        OyP3BwgRZ8MQ1Gedac/crKEpwQ==
X-Google-Smtp-Source: AFSGD/VpYrmoJeyL8d7+PEaIv5jYwhLzngu/YEuvShEtkOCRXOuRE9OyVVKm+SuLrVdW6w4L5WrvSw==
X-Received: by 2002:a2e:568b:: with SMTP id k11-v6mr4225309lje.105.1543590553021;
        Fri, 30 Nov 2018 07:09:13 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id o26sm912850lfl.18.2018.11.30.07.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 07:09:12 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     keescook@chromium.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
Date:   Fri, 30 Nov 2018 16:08:59 +0100
Message-Id: <20181130150859.27366-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function graph tracing recurses into itself when stackleak is enabled,
causing the ftrace graph selftest to run for up to 90 seconds and
trigger the softlockup watchdog.

Breakpoint 2, ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
200             mcount_get_lr_addr        x0    //     pointer to function's saved lr
(gdb) bt
\#0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
\#1  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
\#2  0xffffff8008555484 in stackleak_track_stack () at ../kernel/stackleak.c:106
\#3  0xffffff8008421ff8 in ftrace_ops_test (ops=0xffffff8009eaa840 <graph_ops>, ip=18446743524091297036, regs=<optimized out>) at ../kernel/trace/ftrace.c:1507
\#4  0xffffff8008428770 in __ftrace_ops_list_func (regs=<optimized out>, ignored=<optimized out>, parent_ip=<optimized out>, ip=<optimized out>) at ../kernel/trace/ftrace.c:6286
\#5  ftrace_ops_no_ops (ip=18446743524091297036, parent_ip=18446743524091242824) at ../kernel/trace/ftrace.c:6321
\#6  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
\#7  0xffffff800832fd10 in irq_find_mapping (domain=0xffffffc03fc4bc80, hwirq=27) at ../kernel/irq/irqdomain.c:876
\#8  0xffffff800832294c in __handle_domain_irq (domain=0xffffffc03fc4bc80, hwirq=27, lookup=true, regs=0xffffff800814b840) at ../kernel/irq/irqdesc.c:650
\#9  0xffffff80081d52b4 in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:205

Rework so we mark stackleak_track_stack as notrace

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/stackleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index e42892926244..5de3bf596dd7 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -102,7 +102,7 @@ asmlinkage void stackleak_erase(void)
 	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
 }
 
-void __used stackleak_track_stack(void)
+void __used notrace stackleak_track_stack(void)
 {
 	/*
 	 * N.B. stackleak_erase() fills the kernel stack with the poison value,
-- 
2.19.2

