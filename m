Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3903ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B3B20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GLPkiG6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B3B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJ0Fw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:52:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36689 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeJ0Fw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:52:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id x2-v6so2465567eds.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVerihqy0rYDSBM1Z/1k4wBvOrj/W6jfdFGnrmbOhxU=;
        b=GLPkiG6VOw9oMkJzRjytQebFwGBXp9ew5GF9BJ4U2vRz7FRujOpVkD/LbNQiY+PHgH
         EDALzxkrHC5q/rtxc8yDhMsJffYWefS9qe7NfWLv5j0GsV2mRvoQfI8BU03k8NedD6ng
         Xfql87xZeTPhTy7kbRa/vqDhd0a78Y5ajcEVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVerihqy0rYDSBM1Z/1k4wBvOrj/W6jfdFGnrmbOhxU=;
        b=JMjS5YfT/5ovkEBlfDsV7tQRlL6Fe65tjkXboDBwoHnYCmBwpfsbRseMC6dI7GwtgL
         8LygitVB9/ITN8AFgSx+SglDFheN0MixcGgD+Tvw94yK/nOYkf67aYDe1uw+TCFtkjZm
         XRcwZWdZGR5a2aPpCfi5p/9bEc+6LTdSM2k38qDvzGimJN7plD8LY97Xqmntnn+WZ3Lu
         W2CuccksAlUvmXSHI8cktFzvHrgeP1CcuAmcqM27t2YyTF0FDSvRTZCd/N/Ez0Zss+3b
         rSBHHKL3IQVMEG02AbcM11gwL7jtMjjGsUgrhn/dMmenrVt+2ixS2PCE1ZZqkXcPY2FO
         1DIg==
X-Gm-Message-State: AGRZ1gK1lCeIDXudfj0EkHfqsjmAVGNbX2KpJXDc0f479q5V4Po3n7f9
        YSluCURhOdtd08SnEr8408uEK+dKih7coA==
X-Google-Smtp-Source: AJdET5csC/zbXDA0uThICfhCsDnZo6EuA9hHG29/T4kti4iIg4HIOUThDasb5OvL6UECVLKAKCtBWw==
X-Received: by 2002:a50:b883:: with SMTP id l3-v6mr2925736ede.188.1540588429723;
        Fri, 26 Oct 2018 14:13:49 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id a40-v6sm4786220edd.61.2018.10.26.14.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 14:13:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tracing: merge seq_print_sym_short() and seq_print_sym_offset()
Date:   Fri, 26 Oct 2018 23:13:44 +0200
Message-Id: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions are nearly identical, so we can avoid some code
duplication by moving the conditional into a common implementation.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/trace/trace_output.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 6e6cc64faa38..501311dcfca6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -339,34 +339,17 @@ static inline const char *kretprobed(const char *name)
 #endif /* CONFIG_KRETPROBES */
 
 static void
-seq_print_sym_short(struct trace_seq *s, const char *fmt, unsigned long address)
+seq_print_sym(struct trace_seq *s, const char *fmt, unsigned long address,
+	      bool with_offset)
 {
 	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
 	const char *name;
 
-	kallsyms_lookup(address, NULL, NULL, NULL, str);
-
-	name = kretprobed(str);
-
-	if (name && strlen(name)) {
-		trace_seq_printf(s, fmt, name);
-		return;
-	}
-#endif
-	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, fmt, str);
-}
-
-static void
-seq_print_sym_offset(struct trace_seq *s, const char *fmt,
-		     unsigned long address)
-{
-	char str[KSYM_SYMBOL_LEN];
-#ifdef CONFIG_KALLSYMS
-	const char *name;
-
-	sprint_symbol(str, address);
+	if (with_offset)
+		sprint_symbol(str, address);
+	else
+		kallsyms_lookup(address, NULL, NULL, NULL, str);
 	name = kretprobed(str);
 
 	if (name && strlen(name)) {
@@ -424,10 +407,7 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip, unsigned long sym_flags)
 		goto out;
 	}
 
-	if (sym_flags & TRACE_ITER_SYM_OFFSET)
-		seq_print_sym_offset(s, "%s", ip);
-	else
-		seq_print_sym_short(s, "%s", ip);
+	seq_print_sym(s, "%s", ip, sym_flags & TRACE_ITER_SYM_OFFSET);
 
 	if (sym_flags & TRACE_ITER_SYM_ADDR)
 		trace_seq_printf(s, " <" IP_FMT ">", ip);
-- 
2.19.1.6.gbde171bbf5

