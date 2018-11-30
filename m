Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EA3C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4AA20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hf7NYzds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4AA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeLACTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:19:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41870 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLACTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:19:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so5273770ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 07:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sn6e2y3hrDqC5F6PRoRA5dBPL+JkfPGNchhGjAsqyhg=;
        b=Hf7NYzdsmIc6gAHEOJdgMn9FEKqpFUYVf1s5w8KySpDhefcB22MF6kW3XbmiACEez1
         HV2hfJXyGxMtTxhQ4QgB9N1w1TcnvBd2Cvid6LJkfE61lw8uF5dDOjj/MCu39gv5xWp+
         BFKA63Mww/JBddGUnzn5SLq7D9t7SFm1wdLnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sn6e2y3hrDqC5F6PRoRA5dBPL+JkfPGNchhGjAsqyhg=;
        b=ctieoURxUym6Bg4OIpXYbfLiB+GYA2jXZ/DH8M3SpQRvWLhPTCL3PIDvhOrVDh+JnL
         h2OLUvSfxYOPPuC/1dnzWVBn+/qWgJKLLaCBzStL4sdO3PgNK5YtzKF0DkFz6l/GlVJz
         R84W/Mwpg8j6HKRsrtB7S4Aj4MgUu3MuqEjCG6H98ZTA/d/JgBGv2JuFXefF4NXSUImh
         j5QNzZdXbnrL9tKWzDZakwOao5dM+/N4rGPXAhtD+tIncE8NIH/RUQ29k0/te+XCwZ65
         pZbzrzVRbyJO627eQkY0jXEl4NX9NVwlw2PG+ofkeAB7hnENZgabNq0bkkmK5L8cZ+2r
         7XmQ==
X-Gm-Message-State: AA+aEWanRjAiINrxeldINJ+6GzDx65OdUmLRJopcWAPgvTvSTsN51zev
        YWO0mhQT5IU8TbmqJ38KemvQqw==
X-Google-Smtp-Source: AFSGD/WJEpxEpyZY8TB/f9eIF5AJ1VuRqInkmOD8qy4TLDhGqq3K4SiweALxfqHhJNLP8p1a5+nn5w==
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr3612440ljg.71.1543590604769;
        Fri, 30 Nov 2018 07:10:04 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id a11sm865169lfb.68.2018.11.30.07.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 07:10:04 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] arm64: ftrace: add cond_resched() to func ftrace_make_(call|nop)
Date:   Fri, 30 Nov 2018 16:09:56 +0100
Message-Id: <20181130150956.27620-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of those functions end up calling ftrace_modify_code(), which is
expensive because it changes the page tables and flush caches.
Microseconds add up because this is called in a loop for each dyn_ftrace
record, and this triggers the softlockup watchdog unless we let it sleep
occasionally.
Rework so that we call cond_resched() before going into the
ftrace_modify_code() function.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/ftrace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index de1a397d2d3f..9da38da58df7 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -130,6 +130,11 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	old = aarch64_insn_gen_nop();
 	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
 
+	/* This function can take a long time when sanitizers are enabled, so
+	 * lets make sure we allow RCU processing.
+	 */
+	cond_resched();
+
 	return ftrace_modify_code(pc, old, new, true);
 }
 
@@ -188,6 +193,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 
 	new = aarch64_insn_gen_nop();
 
+	/* This function can take a long time when sanitizers are enabled, so
+	 * lets make sure we allow RCU processing.
+	 */
+	cond_resched();
+
 	return ftrace_modify_code(pc, old, new, validate);
 }
 
-- 
2.19.2

