Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489E3ECDE4A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5EE20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gUOvbV2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5EE20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeJ0Fw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:52:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35406 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeJ0Fw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:52:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id e2-v6so2470060edn.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9ghwwNP3fUgNRH6ub3NmZCaTgbCJARCSdOkGMjts88=;
        b=gUOvbV2AjuuzN+odL0rivzx0goLkwk9G3+2P/i4y+8sPbgXdzdVKM04CVfQEHVGETW
         8hGzupEA3eEnM9JEc8PykkIvtHc64LR3BjDLajUrGGkGbFuqm1GWBesmOuT0cVupW+Aa
         KCdQhBp0/5Iy1ysRC3OO2dWnfUdmdf/zqKHxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9ghwwNP3fUgNRH6ub3NmZCaTgbCJARCSdOkGMjts88=;
        b=PMFtygbNhJTtjAZYsmHfFMl47FSEcw94e4xIl+DDlcxdjECy9SmKqH6vktGI9/wCzs
         /mID8U9+hMqn/2J3s0mczCf5FpZlvgu56XTGtCJbgG4HevCFsKNZ/ep406zBcrECsGzJ
         Fis+QEzduzc4UGLXMuMyiZrV9FBJvcIKSISucAvJkLQi3kPaFw2NqX1QeUBkiwwB930O
         Zs8YBAsSInSFqiH1lwqdhzSLCMxXccPkdFFd1Cj9dzZ+CDXMUkvsMWvBoWDN60a2DnZw
         VtNxtEtz7P5rFmYy0+mr/qJJ96c2d0D1V009NLTw3kmlhvBidCNYzzUoEMRbP6tYSPTU
         PUVA==
X-Gm-Message-State: AGRZ1gLYUt7bNr8RbJp8cVY8aqJcYRXE3paaF3EV1EzXjPoMKHcy3KZ4
        YN/AZT8M8DjBka1y47JW/ynHhfxUVoHtTg==
X-Google-Smtp-Source: AJdET5fvU9/iQ8fVisAIEz9ND4pevPZB2I1nDgVv65XC9bLmtYPOKkx1WHd1/C8rdR+BclKP/58uwA==
X-Received: by 2002:a50:be4c:: with SMTP id b12-v6mr4414210edi.46.1540588432007;
        Fri, 26 Oct 2018 14:13:52 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id a40-v6sm4786220edd.61.2018.10.26.14.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 14:13:51 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tracing: simplify printf'ing in seq_print_sym
Date:   Fri, 26 Oct 2018 23:13:46 +0200
Message-Id: <20181026211347.2442-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
References: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
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
index 7417ce5fe4bb..0f96262d23be 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -341,8 +341,8 @@ static inline const char *kretprobed(const char *name)
 static void
 seq_print_sym(struct trace_seq *s, unsigned long address, bool with_offset)
 {
-	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
+	char str[KSYM_SYMBOL_LEN];
 	const char *name;
 
 	if (with_offset)
@@ -352,12 +352,11 @@ seq_print_sym(struct trace_seq *s, unsigned long address, bool with_offset)
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

