Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7897AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2948921A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pL0aptnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbfBQEej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 23:34:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46428 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBQEej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 23:34:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id i5so8169016qkd.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 20:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=h6TKt4Hh8+6/IGrwTZ2yYrCHynxj3jrbFVaK/gRbrTk=;
        b=pL0aptnAzBDaovLZAhnwQfZk6XWrw8F8IisW06u6EOotGY6TsujUzuZDiNyOWIQw3g
         QWZkDmkJ3a0deDcuGM+IkyZAygSZcW16keE2X1jOfsNedsbpPcW39sUPRenJDBdU4JSu
         /AYKoSPnN5GeNgAPa2IzYVxjqhrug+XllHcjFDtDUVpM/BodH/JkDqQEZtJY8dVTZdKQ
         AmO8mUJSMWJv4WwE7F40u5A7I7HvpJsK9yD5S+JS6aHL8cz+GsF9IV86iftNVHO5tklE
         jG3lXd5ciFII4jaHbolrk4d6sA+9egEIHQhEKJsg0y64o2vOix5+toSwri0r+fTBTp3s
         kh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h6TKt4Hh8+6/IGrwTZ2yYrCHynxj3jrbFVaK/gRbrTk=;
        b=puvOevJ6PFlD1U5oRSblGddQKZiUDyrAH2+X8udIoh7KW25aQDZBgftYeqfZFJsqWE
         AHganj0P3QyavgL7GSi4dVGfvku5WaTw+Z0jg5R39KeogQaHLHltX5WJGtfg/fOxZBxR
         AM1bFRrLrglFi289bZd/XJoZd0VPzC7uyoa08HkGm13XRgKNB9ng/Dbf2QIVmzPeJ+Qy
         4tZgPjjXKgLLz/GooyvJcrBNQLJyDj3DNeW2jJ1Ii60TK5XPhk9K6CDQMr/j9uhWgYgV
         eL/fHakzzfylT2qCyKb/9UfZTCn73xvtBnZrG9TWZof8HjFc/jtVAyOdJFsCbp55++J2
         68AQ==
X-Gm-Message-State: AHQUAuZdPpti5o3ZIartyQxpcrJd0Me+rCOAjTR0fgqYQ3G5tKd4vk1w
        aw1oHRb/9RMwE97aJJpEqpM6Fg==
X-Google-Smtp-Source: AHgI3IamzFPnrIQQELRtEl+dx7SsghZSgftoi3VyNxrU/X4MvX8mIGFIFEBNrCd7x5MJR3cudv0C1Q==
X-Received: by 2002:a37:4846:: with SMTP id v67mr12866022qka.267.1550378078369;
        Sat, 16 Feb 2019 20:34:38 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n62sm5118369qkf.89.2019.02.16.20.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 20:34:37 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        andreyknvl@google.com, aryabinin@virtuozzo.com,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] trace: skip hwasan
Date:   Sat, 16 Feb 2019 23:34:34 -0500
Message-Id: <20190217043434.46233-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
causes the whole system frozen on ThunderX2 systems with 256 CPUs,
because there is a burst of too much pointer access, and then KASAN will
dereference each byte of the shadow address for the tag checking which
will kill all the CPUs.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/trace/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c2b2148bb1d2..fdd547a68385 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -28,6 +28,11 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
 GCOV_PROFILE := y
 endif
 
+# Too much pointer access will kill hwasan.
+ifdef CONFIG_KASAN_SW_TAGS
+KASAN_SANITIZE := n
+endif
+
 CFLAGS_trace_benchmark.o := -I$(src)
 CFLAGS_trace_events_filter.o := -I$(src)
 
-- 
2.17.2 (Apple Git-113)

