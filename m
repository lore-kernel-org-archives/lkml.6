Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70883C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3789E214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="K4wtyX9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3789E214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeJISiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:38:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36201 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeJIShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so1330679edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/uCUfP8SuxFhuNaARI/TcFW71fTaY9liBiNrO3IVkM=;
        b=K4wtyX9HbbnM4clYyElO+N12hLv8DughUhNjldXBOzT0z/+7dV9xXN7i0aBbwvOO4e
         tMmHCyLeLm16ddpjUN6CoGkC+h0i1LNDnATouJwatEjQeHUCMPU0xSvpce0BOeqdi79Z
         e/UYTMYeWeOGI8u/o29xSMh94lH6QNK6TMUno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/uCUfP8SuxFhuNaARI/TcFW71fTaY9liBiNrO3IVkM=;
        b=VFwm+KiSZp7QEXZ5plgCEuGUcQzlYAtty5QbHr+wt+56DH6wIKlHF5nGr8u8tCvBxW
         Kf6wyP2+JuTGr5TDagyFiDU6brT/YAVR0VbsOGzGAeF75Qb+iCFvOchDJzcfNUjlho8Q
         ZxOmKqHLlkVwVMR+dDcDEcTQAVV8oijiaU/LY7x2SbJ3L09i5pZPVmm5J5nuBAk/4+Gl
         P/fliReUPbAcIAnM1eKCncFzxgfolYLrYYjMwrVWKFlqRQoncBaE4fwt09Nyo+OBswvN
         vRMcxHqWFZyf4xaAuFi+6hEObQWnBKZjGSS97/j81K6ZSdzYJ9CIanVYQSMy/C6Ai2EN
         57kQ==
X-Gm-Message-State: ABuFfoj9aV71RnFGP73HcpA3JAlIvExuzsnC1UEWiuHsl9LsEdn4WbZh
        SRPUYm0+dTlNBcdK4rEVJjMDDw==
X-Google-Smtp-Source: ACcGV62TPVxdIvPLPUs8aRIN+0CH+3cIpKZGNS6KrJbEuvWoN2wIA0QMjytfyEVxt2T1RLI62IjFUQ==
X-Received: by 2002:a50:ba43:: with SMTP id 3-v6mr33422770eds.227.1539084036650;
        Tue, 09 Oct 2018 04:20:36 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:36 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 16/23] ACPI: remove unused __acpi_handle_debug macro
Date:   Tue,  9 Oct 2018 13:20:06 +0200
Message-Id: <20181009112013.14238-17-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DYNAMIC_DEBUG is not set, acpi_handle_debug directly invokes
acpi_handle_printk (if DEBUG) or does a no-printk (if !DEBUG). So this
macro is never used.

Cc: linux-acpi@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 21e03aa32aae..e12d5ef1a054 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -948,9 +948,6 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
 #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
 __printf(3, 4)
 void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const char *fmt, ...);
-#else
-#define __acpi_handle_debug(descriptor, handle, fmt, ...)		\
-	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
 #endif
 
 /*
-- 
2.19.1.3.g1d92a00e68

