Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9503DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651CA20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HW/VHAsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfAaT21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45092 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfAaT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so1760934pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t98eZgNJ2OkyyNH9A8MpeSnzy29Cs+lIwR0Rp4VGB6w=;
        b=HW/VHAsBZB0Ih7lqa7vjMKtbjc+7OGoPezauGIeesyeanLr+q30X9OK3QeR9YVk4xz
         2WufnXCZB78r1+TH6iO51nlpT0Wra47AQTWd+eujU43Ab//LjiJllZgF8hDmdkY4+vdy
         J0hS/vmtobX95SFIx0XXmVqRg7UZvz7aHH5e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t98eZgNJ2OkyyNH9A8MpeSnzy29Cs+lIwR0Rp4VGB6w=;
        b=dNMnux+W7hf7ra24/qfU2jqg/3w6qRgz+iakbsB586/XjJb5oJSJFMI2WIU8k1tSQO
         qbHXNvdOg/CzItmUoNuP524NuxXpN1q7Q5ED11iU/+mmo0Niqli7cn2Z7kmvUxR/LE7c
         1NAQJYXMJ8Obcf24B8aYVRSTWiSZZACWz4G9y9qrQxiQ52FMLIizPsz5+xLpIYMTaEDJ
         gBpsYgYch+hgVabg4O0hdOKgZi1sWadHX4I2AyFlzwXF9MU86q5eCdA6fqjtms83IEd7
         0wJl9tQBofDieAgSPuVRGBvamPMBqekaXFOqTtlviE4lOY5fy4rc18DiCUlVEaqpaMtJ
         zbKw==
X-Gm-Message-State: AJcUukey3ks4gpHz2HfFqVVUQIwyR27xCcpMNMZqa6BwXhvpuZlwUs0C
        XMAoAhi3G487THmWrNLOlXLz0A==
X-Google-Smtp-Source: ALg8bN5N23wLrMRUc7q9Z8s3OLuB2c8KXsOa/9j2qqS+O8yzM4KO/sF7FbbrILEgTsQ+4zbvEl2zMg==
X-Received: by 2002:a63:101:: with SMTP id 1mr32666055pgb.152.1548962904015;
        Thu, 31 Jan 2019 11:28:24 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:23 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Garnier <thgarnie@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/27] x86: pm-trace - Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:13 -0800
Message-Id: <20190131192533.34130-7-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change assembly to use the new _ASM_MOVABS macro instead of _ASM_MOV for
the assembly to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/pm-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
index bfa32aa428e5..972070806ce9 100644
--- a/arch/x86/include/asm/pm-trace.h
+++ b/arch/x86/include/asm/pm-trace.h
@@ -8,7 +8,7 @@
 do {								\
 	if (pm_trace_enabled) {					\
 		const void *tracedata;				\
-		asm volatile(_ASM_MOV " $1f,%0\n"		\
+		asm volatile(_ASM_MOVABS " $1f,%0\n"		\
 			     ".section .tracedata,\"a\"\n"	\
 			     "1:\t.word %c1\n\t"		\
 			     _ASM_PTR " %c2\n"			\
-- 
2.20.1.495.gaa96b0ce6b-goog

