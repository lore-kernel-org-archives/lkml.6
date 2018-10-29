Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711BFC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A9C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VBRq7Db0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A9C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeJ3H0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:26:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37798 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3H0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:26:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id u12-v6so5908017eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0TMULYWAamnD66B9ZDQhbM4Rhn4WfDPouzUnM8QRGw=;
        b=VBRq7Db00xStAHfo5DVL2imkyKh9OP4KiCMP/C93E8Im5+qB5CuyrAqo6rUTynMRCa
         4e5d5g8sNfkwOI/tCZHVhRwZUM1Zel4DbHeyoA3hBbMyZSOliIlegsQP1HmAw2twanyH
         YX0SnlBfaRZvaC9O+4HgFGVAlVZiDtOCbQ0nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0TMULYWAamnD66B9ZDQhbM4Rhn4WfDPouzUnM8QRGw=;
        b=Aj4yphujYyoml+Hb0eFZjel6806uhrw1BfFauziI1TYmoDTEdOZ6qP5rqA30Lm2trV
         hZKRv+WQSfKqKUXz7VtCXGdXmfwRMPB6sLDhoJE5zM1dMN0auKRTHaXZS7Qs98/BcSGs
         9IwFDci3geNxnxnvOD5+NhX4G7jVoUqsddafP0xDTISJ/AqF8W7fBwTjJvsRyznBEiDj
         1OjCxPY2r8t+D8EBOH4GBgwTigIPxgLa0uG1a1zYSmwQOsf4OIAgPBv1zSHmkmWIw8o4
         m3zooLz1xJYmxlCZSYbds6oj0fI9V//AEKjFkvCD86oV5TYsil+MzfA1YIkzf+B3hDfN
         q7xA==
X-Gm-Message-State: AGRZ1gJ6PvtPazvE6WwVjRbJSbr2t0mLQ0Dr4Snng4N7vjeRGHcEMHKs
        vT7MNEZCzS2tEzAVoYrdzhRJ0g==
X-Google-Smtp-Source: AJdET5fhDjtWcMRB3e2/9cCYin6hIdhdpa7xy4G1EFfh0n/DAhMedVYdDqnzler5qX3JyndJZfXNQw==
X-Received: by 2002:a17:906:d1d8:: with SMTP id bs24-v6mr11471684ejb.193.1540852548554;
        Mon, 29 Oct 2018 15:35:48 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id h3-v6sm7146380ede.42.2018.10.29.15.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 15:35:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] tracing: avoid -Wformat-nonliteral warning
Date:   Mon, 29 Oct 2018 23:35:41 +0100
Message-Id: <20181029223542.26175-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181029223542.26175-1-linux@rasmusvillemoes.dk>
References: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
 <20181029223542.26175-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with -Wformat-nonliteral, gcc complains

kernel/trace/trace_output.c: In function ‘seq_print_sym’:
kernel/trace/trace_output.c:356:3: warning: format not a string literal, argument types not checked [-Wformat-nonliteral]
   trace_seq_printf(s, fmt, name);

But seq_print_sym only has a single caller which passes "%s" as fmt, so
we might as well just use that directly. That also paves the way for
further cleanups that will actually make that format string go away
entirely.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/trace/trace_output.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 85ecd061c7be..f06fb899b746 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -339,8 +339,7 @@ static inline const char *kretprobed(const char *name)
 #endif /* CONFIG_KRETPROBES */
 
 static void
-seq_print_sym(struct trace_seq *s, const char *fmt, unsigned long address,
-	      bool offset)
+seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 {
 	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
@@ -353,12 +352,12 @@ seq_print_sym(struct trace_seq *s, const char *fmt, unsigned long address,
 	name = kretprobed(str);
 
 	if (name && strlen(name)) {
-		trace_seq_printf(s, fmt, name);
+		trace_seq_printf(s, "%s", name);
 		return;
 	}
 #endif
 	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, fmt, str);
+	trace_seq_printf(s, "%s", str);
 }
 
 #ifndef CONFIG_64BIT
@@ -407,7 +406,7 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip, unsigned long sym_flags)
 		goto out;
 	}
 
-	seq_print_sym(s, "%s", ip, sym_flags & TRACE_ITER_SYM_OFFSET);
+	seq_print_sym(s, ip, sym_flags & TRACE_ITER_SYM_OFFSET);
 
 	if (sym_flags & TRACE_ITER_SYM_ADDR)
 		trace_seq_printf(s, " <" IP_FMT ">", ip);
-- 
2.19.1.6.gbde171bbf5

