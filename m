Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D75FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FD9214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVyLQeH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FD9214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeLFOaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:30:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36063 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeLFOaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:30:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so516952lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 06:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfFaW0kMx7sFXdcCyikJ0NgxZjTV+dokF1JRmsFVFPk=;
        b=RVyLQeH+kqRwID5tvGyAbJOBh5u3qUHTf2Xt6sijZFDIu6gbxbj0EzOSBH9v9e61bq
         qa8rVG3Y/cle4COZfAbbmyjVogBA06EGDJwwAvM7IaVxoHKspENpxHtofI881/FpT3hp
         JC5yE+YvhPS8GErpasd9tJwsvXrSSLu0NvTHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfFaW0kMx7sFXdcCyikJ0NgxZjTV+dokF1JRmsFVFPk=;
        b=CUhT+/qu/DDhAglUAbri3BL+q6yV1uhNOxUr8v54P82tmEOAXyWaD7fJyia8SpnFW3
         2ZATjgYORTKhg12R/k1bbUsxO0Wrka6Sr7cEWOt7NG44xpU30vH8vwjpX1pHVbKzOlXG
         9YEF4njNmDXDzoFwQ3j5al5j2Cu98wBgZX95ycTqzNXVjROoXS2SekEzaLexq2ajiCmg
         /V2Xyc7tHji3oiIz0YMArwyGkjeV0j91afj5C5uJqe7wLmyEqwdJNw+flzXpxR7ozsJc
         N7BVYCKMXbBBtfRihisBotb8pCho1bGaXMevrDZkP38/6B4dEOJFuos7imfkzG8Bchid
         Rsmg==
X-Gm-Message-State: AA+aEWbn3mQpQFScu+7hM1Gl5DHPwCuScDL2bwNGSfVddRxAogoFOYws
        Scq7a8equRKmcc8+2vVRawzY9Q==
X-Google-Smtp-Source: AFSGD/URlN8BQbZoW/3pVNVMoYvDwUCchxzj9FVyXXohcTwgvrK0TryQOvmnlD/gIFWwjGEIsxjKNQ==
X-Received: by 2002:a19:5059:: with SMTP id z25mr16690237lfj.120.1544106617016;
        Thu, 06 Dec 2018 06:30:17 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id o25sm93694lfd.29.2018.12.06.06.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 06:30:16 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] kernel/kcov.c: mark func write_comp_data() as notrace
Date:   Thu,  6 Dec 2018 15:30:11 +0100
Message-Id: <20181206143011.23719-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since __sanitizer_cov_trace_const_cmp4 is marked as notrace, the
function called from __sanitizer_cov_trace_const_cmp4 shouldn't be
traceable either.  ftrace_graph_caller() gets called every time func
write_comp_data() gets called if it isn't marked 'notrace'. This is the
backtrace from gdb:

 #0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
 #1  0xffffff8010201920 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:151
 #2  0xffffff8010439714 in write_comp_data (type=5, arg1=0, arg2=0, ip=18446743524224276596) at ../kernel/kcov.c:116
 #3  0xffffff8010439894 in __sanitizer_cov_trace_const_cmp4 (arg1=<optimized out>, arg2=<optimized out>) at ../kernel/kcov.c:188
 #4  0xffffff8010201874 in prepare_ftrace_return (self_addr=18446743524226602768, parent=0xffffff801014b918, frame_pointer=18446743524223531344) at ./include/generated/atomic-instrumented.h:27
 #5  0xffffff801020194c in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:182

Rework so that write_comp_data() that are called from
__sanitizer_cov_trace_*_cmp*() are marked as 'notrace'.

Commit 903e8ff86753 ("kernel/kcov.c: mark funcs in __sanitizer_cov_trace_pc() as notrace")
missed to mark write_comp_data() as 'notrace'. When that patch was
created gcc-7 was used. In lib/Kconfig.debug
config KCOV_ENABLE_COMPARISONS
	depends on $(cc-option,-fsanitize-coverage=trace-cmp)

That code path isn't hit with gcc-7. However, it were that with gcc-8.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 97959d7b77e2..c2277dbdbfb1 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -112,7 +112,7 @@ void notrace __sanitizer_cov_trace_pc(void)
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
 
 #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
-static void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
+static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 {
 	struct task_struct *t;
 	u64 *area;
-- 
2.19.2

