Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418C0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1539620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4suD/Ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfAaT2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43655 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbfAaT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so1913196plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/QIeKF6YLTG+0NkDsQbFayB5HHWNSAQl1KhPy/Dd4o=;
        b=c4suD/OucmLKGFeVJSgSLQORzfP33u5kEC8q+QIx4/77Qg82IS0ordMJztWAgvHj4T
         qPgZPQwBLEQsoXqcSqh319tibA0R03mUz4NmtqjkelKZS7r5ufcY6Xvoz+9KjHz9esbg
         WDnYp1WC6qeEzD5YBY0nzd3Zsn4f0pOXQhyRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/QIeKF6YLTG+0NkDsQbFayB5HHWNSAQl1KhPy/Dd4o=;
        b=CoZz3hYuzMXwu1yy1kqi0tegpikKL3PfrAYRTvGBO9SshnnsivUNXsft9spsK8V54R
         JuLKauqqrXW4aZPakxxnjiG6puXCSgUVaA/kB+IS0aA4FErK8EMf0vEryVRXO8U2+iAt
         3t70N6/trB3RAjgbAhbuHVMoBR9Irwm/uIq3OxGhA0maMtmdcfPj9Z6CjntN8vKwVAIT
         m/iv6SCwtEf3sHYXjKKO3c+5c4AHYLTZr0XGi1MIQQRJr+qcsrYxYH4zMlR3VtU3kEOd
         dz8xLdmuMJ8dbzxVgoNTeyWB+PPLXdFb+wg6nH3IwZmhRgIHbvAcwHQFuY5zjgkugr8U
         DZAg==
X-Gm-Message-State: AJcUukcq0S+rh68Im8PnvBAHEVdh/jSsk4fMQ1wZt6zfv8pQWOzjHyfy
        qaDxe5z6uQfflmSwnfHkB3kyDw==
X-Google-Smtp-Source: ALg8bN41rKozfud78vwYyYHT7MTbwudqVtaMeqoD2zkPilNdE3hOM7BUA/a43EWinItZbfGAD1niZQ==
X-Received: by 2002:a17:902:bc44:: with SMTP id t4mr35754208plz.260.1548962913472;
        Thu, 31 Jan 2019 11:28:33 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:32 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/27] x86/alternatives: Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:19 -0800
Message-Id: <20190131192533.34130-13-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly options to work with pointers instead of integers.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/alternative.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4c74073a19cc..f5d6fe1d294b 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -233,7 +233,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
 	asm volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: output : [old] "X" (oldfunc), [new] "X" (newfunc), ## input)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
@@ -246,8 +246,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input)
+		: [old] "X" (oldfunc), [new1] "X" (newfunc1),		      \
+		  [new2] "X" (newfunc2), ## input)
 
 /*
  * use this macro(s) if you need more than one output parameter
-- 
2.20.1.495.gaa96b0ce6b-goog

