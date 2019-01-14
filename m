Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52466C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFE120656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSx68K5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfANUoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:44:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42977 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfANUoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:44:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so439763wrx.9;
        Mon, 14 Jan 2019 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tINskAOSN2QPN6hfBcEmRWZQ3qB/w4in6szGvz0cmes=;
        b=HSx68K5suQsFcXRZdjJPkLPF8YuMaoiMqnIIh9PGVbH7wOUrE9PIQxTZDB0hSSDe3j
         uYNALxeDW+Si1XZ9OMs6qK6Y6zYR972NvlNbceIqrhY+YtzCVv5zIMaFvAug701HTV2G
         OaYvGsIb+08AlaIcVJixnDcgUJxl3TjWi+i8zewkgLAY4D+lxhVBK82MjndMP/fyloDp
         JfewSjtsw+KesxwFWQ4xdAk0wmEye6P4xoSZP/Z+kydC8rUo8/hVyQSvyq9CEtrQYAb0
         klGBovh3692WJl/NpnREIlHMrrHFJpCVbj7u9TnWvkgrH9ffJJw+z3PDTgzDNP6OQGGH
         182A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tINskAOSN2QPN6hfBcEmRWZQ3qB/w4in6szGvz0cmes=;
        b=qFE/uJYsAXPX0WA3XM85bybK6pofXqlHXHPvbCt8LqXIQbMXXX1GlPjwrpsA2dyty3
         wmL+a2qU1dxDdIbjsdhgltJMJDRjt5UD9FgGgbY0r8wSMsd0pJeLvbBlRg53m6DZw7W7
         OJz7nUIRSJvV/GeXIC0IJgfj+gOGBgvq5bVypiPHDgKxv9thJt08VzW0nqVaGOJorLU0
         l2oQ4JTzd4roSEFIy0rsAgJt8LAVBAkbdl462OY237IBoBUfypZ4F1uMprAuplVrMBcz
         hCvgoOqv2RYB6iZe1apusaozR6Cp7b28gHE+XK5P3Y+MTZcp5NVUPJPBtUdnRcACkubD
         R3AA==
X-Gm-Message-State: AJcUukdsqauhmjSjqQ3O8KEEkUwc1FTxMeuzA3SIBLPU3uvHPLaszR1q
        4LtOHmeOosRQ+loOI2Wq+Ze10XgdUDg=
X-Google-Smtp-Source: ALg8bN4kX6JV1nzgWApM3sj7f8hZjXFd0V0pl9Y5W2i6IqG+lpfJKkG0nLyRgw8RKjALbGE3ASbPuw==
X-Received: by 2002:adf:f984:: with SMTP id f4mr241149wrr.234.1547498656722;
        Mon, 14 Jan 2019 12:44:16 -0800 (PST)
Received: from planxty.redhat.com ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id h17sm71158913wrt.59.2019.01.14.12.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:44:16 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     Joe Korty <Joe.Korty@concurrent-rt.com>
Cc:     Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "julia @ ni . com" <julia@ni.com>,
        "tglx @ linutronix . de" <tglx@linutronix.de>,
        "oleg @ redhat . com" <oleg@redhat.com>,
        "linux-rt-users @ vger . kernel . org" 
        <linux-rt-users@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Makefile: ssdd: Incoroporate ssdd into the rt-tests Makefile
Date:   Mon, 14 Jan 2019 21:43:58 +0100
Message-Id: <20190114204358.15550-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incoroporate ssdd into the rt-tests build

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 06f399cc629d..16cd2f9bdd03 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,8 @@ sources = cyclictest.c \
 	  svsematest.c  \
 	  cyclicdeadline.c \
 	  deadline_test.c \
-	  queuelat.c 
+	  queuelat.c \
+	  ssdd.c
 
 TARGETS = $(sources:.c=)
 LIBS	= -lrt -lpthread
@@ -86,6 +87,7 @@ VPATH	+= src/lib:
 VPATH	+= src/hackbench:
 VPATH	+= src/sched_deadline:
 VPATH	+= src/queuelat:	
+VPATH	+= src/ssdd:
 
 $(OBJDIR)/%.o: %.c | $(OBJDIR)
 	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
@@ -146,6 +148,9 @@ hackbench: $(OBJDIR)/hackbench.o
 queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
+ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
+
 LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
 $(OBJDIR)/librttest.a: $(LIBOBJS)
 	$(AR) rcs $@ $^
-- 
2.20.1

