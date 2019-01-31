Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1896C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ECA218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bqhNakyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfAaT22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37983 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfAaT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so1781241pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+msRGHiW9AVXafKQg9tGuz9CnhI1ID7nH2oXzVzjU0I=;
        b=bqhNakyuO33LAFGgG6cqMeLXPDxKIHzip1hRQIYu50cK9Ue5B/Y15EmxWLlDAefokB
         NfjO8ESlMhhYe5IURjGUPSJMGGHVwBxNPfev2NUcQ6JMrv3k3301WjaiiIdzGCrd7Y1d
         XAQw4slXPL95B5LGQf8xZZzTVLFshkZErhaD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+msRGHiW9AVXafKQg9tGuz9CnhI1ID7nH2oXzVzjU0I=;
        b=dnWccIqcLkOB93KKUY9rGYu5c+uRStYX1KIw05wKIXu8TP8Yq7f7KVU08CEXg2A/OF
         tOfitJYiO4hdAJ4tUGHno8LfsOn2khHvagedh8pxYGZV6jzq5bY5MJO5F2QzqAsjam+6
         D5A8pNoj6iSJTvBzF9aTVTt1SEWpYcMOGtPab7apKqaqllziphk0biXlGkES5v5df1wD
         LIuVJ5B4fg0B5J4VJ31MWawmTZRKSRbbwcXeHWOWZBJ+LAMahkxHiEoPj2IaaSACwj2z
         wk52JqcnI3hoaz+6eJE7sio19fi0JiEcWvn246bMvvPvgZRfDMFbFatAz509xL6tOsaO
         KWGA==
X-Gm-Message-State: AJcUukeZ2R5fLSTiAAq7cnjZIH8QX3t07c2wnU/ujQtKuTXadfhZrxsS
        usZcYCoVfGlgDDJua1KtvZD6iA==
X-Google-Smtp-Source: ALg8bN4JsNz/i98QK2PXucwDlB/G2YTSi2BtFWASptrAaqUNVrgsUx1zirlFWc5mHg5Xm466INwihw==
X-Received: by 2002:a63:2744:: with SMTP id n65mr32490610pgn.65.1548962906138;
        Thu, 31 Jan 2019 11:28:26 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:25 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Garnier <thgarnie@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/27] x86/CPU: Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:14 -0800
Message-Id: <20190131192533.34130-8-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible. Use the new _ASM_MOVABS macro instead of
the 'mov $symbol, %dst' construct.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/processor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 33051436c864..ce9851bf6778 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -723,11 +723,13 @@ static inline void sync_core(void)
 		"pushfq\n\t"
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
-		"pushq $1f\n\t"
+		"movabsq $1f, %q0\n\t"
+		"pushq %q0\n\t"
 		"iretq\n\t"
 		UNWIND_HINT_RESTORE
 		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT
+		: : "cc", "memory");
 #endif
 }
 
-- 
2.20.1.495.gaa96b0ce6b-goog

