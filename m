Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DCC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B282082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dRduGlHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B282082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeKCGJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:09:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34446 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKCGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:09:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so2871117eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsUXgZjuBhUd8jfvImQkPQsOtCla19b3F/9FCIkvJSI=;
        b=dRduGlHJeHjfxOrTTXH18BxAJe1ka3WPEnLHotYhR4108ntPg2JuM2xGFNGME3XwEk
         3ap3W0S7qCvNWAotHVJutfznAxd7lKFba15VfvGBbro7QkOa1Gcu9m/T+mm0Y6ubSysU
         1GKj6t8GuOWj4Q2OC9DVYsY79maA+QSHDep+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsUXgZjuBhUd8jfvImQkPQsOtCla19b3F/9FCIkvJSI=;
        b=dU+GgzXbd4UMU9RtzdcdxNC/yGW0tiFpcY3mdqpeRxyGoFyZa2vgOqx1i93bHXDHan
         BaH62xYVZlurWhc7l4jhbVTMtC7BHkIqH6F2IextK4hyKzJJO4JhNcWkWbQwH36HeFXS
         wKpXmjlvcr8Pu/nSQVj9CeuUurByTzv2uZDl4IpDBxXHPaKUnvcWgRgFfLzZEss+bn0P
         KWlG18ZArxzwKFOebzxHPN+GkuypZS2pDAlkzNd2IK4Fz8Uvg7cfLyQ3WN1cYRpsduoK
         GKr7saxkgqNL93mpuH4hRM9inrqTDlva8pNAhzSmZr21UDYrTKDrE8SKr5SvRRkgvDhl
         b9hw==
X-Gm-Message-State: AGRZ1gLBOlZCDjHCmpimKrMgCq9cPwvn3td8uwvgkhZc7PWD1VMoUGlg
        rabfSSnBK5YxGulpNrWEBaP65Q==
X-Google-Smtp-Source: AJdET5cyQpHNbQ76udrqe8ECyz1mRO0czpOaTmKv++fJrHZigMmHZvAye6V8jq/Yzl4lZrhF4i2HoQ==
X-Received: by 2002:a50:ae44:: with SMTP id c62-v6mr9705873edd.271.1541192444083;
        Fri, 02 Nov 2018 14:00:44 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id r26-v6sm144527edq.22.2018.11.02.14.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 14:00:43 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Maninder Singh <maninder1.s@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matteo Croce <mcroce@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bloat-o-meter: ignore __addressable_ symbols
Date:   Fri,  2 Nov 2018 22:00:25 +0100
Message-Id: <20181102210030.8383-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since __LINE__ is part of the symbol created by __ADDRESSABLE, almost
any change causes those symbols to disappear and get reincarnated, e.g.

add/remove: 4/4 grow/shrink: 0/3 up/down: 32/-171 (-139)
Function                                     old     new   delta
__addressable_tracing_set_default_clock8649       -       8      +8
__addressable_tracer_init_tracefs8631          -       8      +8
__addressable_ftrace_dump8383                  -       8      +8
__addressable_clear_boot_tracer8632            -       8      +8
__addressable_tracing_set_default_clock8650       8       -      -8
__addressable_tracer_init_tracefs8632          8       -      -8
__addressable_ftrace_dump8384                  8       -      -8
__addressable_clear_boot_tracer8633            8       -      -8
trace_default_header                         663     642     -21
tracing_mark_raw_write                       406     355     -51
tracing_mark_write                           624     557     -67
Total: Before=63889, After=63750, chg -0.22%

They're small and in .discard, so ignore them, leading to more useful

add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-139 (-139)
Function                                     old     new   delta
trace_default_header                         663     642     -21
tracing_mark_raw_write                       406     355     -51
tracing_mark_write                           624     557     -67
Total: Before=63721, After=63582, chg -0.22%

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/bloat-o-meter | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index a923f05edb36..8c965f6a9881 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -32,6 +32,7 @@ def getsizes(file, format):
                 if name.startswith("__mod_"): continue
                 if name.startswith("__se_sys"): continue
                 if name.startswith("__se_compat_sys"): continue
+                if name.startswith("__addressable_"): continue
                 if name == "linux_banner": continue
                 # statics and some other optimizations adds random .NUMBER
                 name = re_NUMBER.sub('', name)
-- 
2.19.1.6.gbde171bbf5

