Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A4ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33FB2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TmIAGDRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33FB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeJ0G67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:58:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39122 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJ0G67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:58:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5-v6so2561748eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ewiRyybG1pcGviYelYKsnMTfQ7SaNG5WePJOmWnhPU=;
        b=TmIAGDRDwxcbUFbWKoAjrkHElWqz+tRX0R20flq0GDQZ9+Ars8Y6o79rNnsic3Vj2v
         6qHgeofP70t8Fpxd1UsvAPr6n8sZus5zWJQYnp5DP9ZNuLvwWAaVbnMgR6slrlXIJP3q
         VrDC7A8GdoyFz4DUQafu77WkWNbhEd9XO8/pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ewiRyybG1pcGviYelYKsnMTfQ7SaNG5WePJOmWnhPU=;
        b=ZvGeSRASXAd4nNpP4J0LKP+oS46wp22Y9B9D/uScKeC5aX8tXo8QkkM7eKQ/ArPNpB
         WcQt8cThVU+8/Hu1wN6hVEiDaWYTiB1ecuJ6YHluxLwQV9pVw3yanPJ+b2bVZ8oOAgHC
         hDPUHv4L2cXLyd+g+mdcUc8iRZCjxmgPcVgnWt6wlYTPHLOW2meJ/db/cCRvReRx8V9l
         B+sCkmTgtMcddwzWvVTCfcq909MU4ZEIFsCOPMGVfDwkPep6RV/kfwTo3Gn/FFcsmTfB
         bTmhdxnvd4l8vhEXMwK1H56edrYu3BD2mNWxJJ7tcDFNamq9wH+13rilQXGWjjwKVubl
         CETg==
X-Gm-Message-State: AGRZ1gLO1ZDzrC7p+EKlJw13n6ePPAIiT1oq496mf18gDwf3D4qQFvzp
        JrF4n7oYe/JIajrd+o6PR3M2+g==
X-Google-Smtp-Source: AJdET5cwPTkEr1FlBWxhokHTclJxacJI8oo16TTNu54rpW8Z+gFdXjI0H99gq5ix8V56HBSfOUEjvA==
X-Received: by 2002:a50:f5ad:: with SMTP id u42-v6mr4435071edm.68.1540592410670;
        Fri, 26 Oct 2018 15:20:10 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e7-v6sm1790223ejt.23.2018.10.26.15.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 15:20:09 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: traps.c: use format string with panic() call
Date:   Sat, 27 Oct 2018 00:20:04 +0200
Message-Id: <20181026222004.14193-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with -Wformat-nonliteral gives

arch/x86/kernel/traps.c:334:2: warning: format not a string literal and no format arguments [-Wformat-nonliteral]
  panic(message);

handle_stack_overflow can only be called from two places (kernel/traps.c
and via inline asm in mm/fault.c), in both cases with a string not
containing format specifiers, but we might as well silence this warning
using "%s" as format string.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 8f6dcd88202e..9b7c4ca8f0a7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -306,7 +306,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 	die(message, regs, 0);
 
 	/* Be absolutely certain we don't return. */
-	panic(message);
+	panic("%s", message);
 }
 #endif
 
-- 
2.19.1.6.gbde171bbf5

