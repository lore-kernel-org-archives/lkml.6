Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC708ECDE4A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0E820834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bSalCfYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0E820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeJ0IDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:03:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45828 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbeJ0IDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:03:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id t10-v6so2635193eds.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQ5J6xeQsLwYoMa+9jdb2O4RjYDTtyUT6mgDDwQYRMM=;
        b=bSalCfYKezv1CksRIiWpTMfHTRvmH5ZKVDA9GJZALMPXcVQqLssoI4zrrv4S8HirQT
         NRmRn8Zk2hsRkvUzVA5tEWD11TdI+AGowUCdpiuZYB7nsxJRXtMrAwbJf1BfF4BvYqeJ
         qcweWzEjH5kpzZXAzLYu+7R+fIvBueSNXkt0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQ5J6xeQsLwYoMa+9jdb2O4RjYDTtyUT6mgDDwQYRMM=;
        b=E1/zSAPBpHLAf8Lt+fP8ACmJiDFzu95ImZJWmxeyNP7bkz2B8WzRAHPmEAcy6b+SKg
         6XhHcYtdCjaxd5VFwp99mkxty22PCa/KLdGqKr/GEv//lg69Lll2M81RLfHUS9CyNjuT
         /9QTqp9ZhdRA6MMwZ4jmwWu3mNMjZaYeAaEdHgoA+EDU3JOB2W2AlWNOOwnAJQPpAI9J
         Yc5xOpszOOtmrlK9wBuw97TAEDRtqvVbW0QNRRv5geZ/HWwfRrzCfDNeasUB/GppHKYi
         KmJbasdz7zfG/ZLhkP+OcY5+G6NCfm4uAJZ5LW46KuQOdwvcNS08L8KP8roSC2bt0+Hd
         1TEA==
X-Gm-Message-State: AGRZ1gIYKebiI1YPq5NvgcA6OsTkgNQUhu8gAcqECprIZTX2rBjPoMNb
        +otSVIAz6V0womwnBDeUtyoG7w==
X-Google-Smtp-Source: AJdET5eJCfoJVkDXkFLVHaaH3IfwtK8h6+/d1UFOfaUtVXgp4SyGYvbxF4afFwr8tAIyKiV6lcri5g==
X-Received: by 2002:a50:b085:: with SMTP id j5-v6mr4618640edd.294.1540596256922;
        Fri, 26 Oct 2018 16:24:16 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3986746edc.95.2018.10.26.16.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 16:24:16 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 4/7] lib/test_printf.c: add a few fmtcheck() test cases
Date:   Sat, 27 Oct 2018 01:24:06 +0200
Message-Id: <20181026232409.16100-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026232409.16100-1-linux@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be trivial to add more test cases, once we figure out the
exact rules for being compatible or not. Perhaps we'll have to extend
the struct test with a flags element if we add flags that affect the
return value.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_printf.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 53527ea822b5..5b6ba0e817d5 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -535,6 +535,47 @@ test_pointer(void)
 	flags();
 }
 
+static void __init
+test_fmtcheck(void)
+{
+#ifdef CONFIG_FMTCHECK
+	struct test { const char *fmt; const char *tmpl; };
+	static const struct test compatible[] __initconst = {
+		{"", ""},
+		{"wlan%d", "%d"},
+		{"aa%llxbb", "cc%Lxdd%%"},
+	};
+	static const struct test incompatible[] __initconst = {
+		{"a %d b %lx", "%d %x"},
+		{"%llo", "%Lx"},
+	};
+	unsigned i;
+	const struct test *t;
+	const char *ret;
+
+	for (i = 0; i < ARRAY_SIZE(compatible); ++i) {
+		total_tests++;
+		t = &compatible[i];
+		ret = _fmtcheck(t->fmt, t->tmpl, FMTCHECK_SILENT);
+		if (ret != t->fmt) {
+			failed_tests++;
+			pr_warn("'%s' and '%s' deemed incompatible by fmtcheck()",
+				t->fmt, t->tmpl);
+		}
+	}
+	for (i = 0; i < ARRAY_SIZE(incompatible); ++i) {
+		total_tests++;
+		t = &incompatible[i];
+		ret = _fmtcheck(t->fmt, t->tmpl, FMTCHECK_SILENT);
+		if (ret != t->tmpl) {
+			failed_tests++;
+			pr_warn("'%s' and '%s' deemed compatible by fmtcheck()",
+				t->fmt, t->tmpl);
+		}
+	}
+#endif
+}
+
 static int __init
 test_printf_init(void)
 {
@@ -548,6 +589,8 @@ test_printf_init(void)
 	test_string();
 	test_pointer();
 
+	test_fmtcheck();
+
 	kfree(alloced_buffer);
 
 	if (failed_tests == 0)
-- 
2.19.1.6.gbde171bbf5

