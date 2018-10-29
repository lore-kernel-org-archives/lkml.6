Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762A5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3677F205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NrsaEPlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3677F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbeJ3H0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:26:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35721 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbeJ3H0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:26:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id d6-v6so707150edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BcQzitC/GAJVzh3IaKZIiXIrPfLwvD2pcPTqUj6vSI=;
        b=NrsaEPlBebh5T+XppYf++3x9u0PAkyZ/zkAjUv7DRIFvQN9NN3NDuP8y6XwNsywzwT
         I1d2qrvxLrNtXODaXpcT/6vvGVj0P0wcUsV/jueUIwzCyrED8VL7uWBcVg/abtfA6fGJ
         sc7S8I2C3z1ye6+gcLzS2Z12e2/jSQOiX2Pjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BcQzitC/GAJVzh3IaKZIiXIrPfLwvD2pcPTqUj6vSI=;
        b=P0jEJaQhIsoXLrr8a9unFGCoh+9yd/2TW37CjYNVkX0eJYOfnGpfOu381UT1Bo1wpZ
         QBW0yeyVyCbbC0NrcComH+ie+ofkBEy2MkUICwdY0c9Rk2DK7eV0+Y6+V6zUVgrSwSYG
         TzCfHk5+kj44WITRZOlTlaWaKWixdtNHR1qqzQRpS097P84/uRvuyJ72rARsIPS1Kliv
         OpDlkssRljbx4WngIPzwoqK4aYvP61FhJN50xoPHvBOeK4S62DYezURwJvzF39Jf8gqj
         foH6BbXgHg7yO4Bzj2SGhm/h5gdaO+upBogEUlduUk1Gnk23Et1qSDUj2OXPTzT42x71
         HRwA==
X-Gm-Message-State: AGRZ1gKuwBVJ20nxzLE+FeywvDycvlQw+y/cGQ7thh1TIqHCmE7Btx4s
        aObju9QslWslGfD6i0btQkWFAA==
X-Google-Smtp-Source: AJdET5f6aaUDjXnDaEYs97uZX4gLYACZXeysFyYvUl0EvJWLFhySrxppn1OAKKD37KDrRXCClKWGGg==
X-Received: by 2002:a17:906:1551:: with SMTP id c17-v6mr11732912ejd.32.1540852549761;
        Mon, 29 Oct 2018 15:35:49 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id h3-v6sm7146380ede.42.2018.10.29.15.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 15:35:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] tracing: simplify printf'ing in seq_print_sym
Date:   Mon, 29 Oct 2018 23:35:42 +0100
Message-Id: <20181029223542.26175-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181029223542.26175-1-linux@rasmusvillemoes.dk>
References: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
 <20181029223542.26175-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_seq_printf(..., "%s", ...) can be done with trace_seq_puts()
instead, avoiding printf overhead. In the second instance, the string
we're copying was just created from an snprintf() to a stack buffer, so
we might as well do that printf directly. This naturally leads to moving
the declaration of the str buffer inside the CONFIG_KALLSYMS guard,
which in turn will make gcc inline the function for !CONFIG_KALLSYMS (it
only has a single caller, but the huge stack frame seems to make gcc not
inline it for CONFIG_KALLSYMS).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/trace/trace_output.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index f06fb899b746..54373d93e251 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -341,8 +341,8 @@ static inline const char *kretprobed(const char *name)
 static void
 seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 {
-	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
+	char str[KSYM_SYMBOL_LEN];
 	const char *name;
 
 	if (offset)
@@ -352,12 +352,11 @@ seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 	name = kretprobed(str);
 
 	if (name && strlen(name)) {
-		trace_seq_printf(s, "%s", name);
+		trace_seq_puts(s, name);
 		return;
 	}
 #endif
-	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, "%s", str);
+	trace_seq_printf(s, "0x%08lx", address);
 }
 
 #ifndef CONFIG_64BIT
-- 
2.19.1.6.gbde171bbf5

