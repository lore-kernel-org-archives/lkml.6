Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC201C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7C8218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jS2vtOqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAaT2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfAaT2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so1774086pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aVzH3++K/2N/bei/W7brwrZIoSH+2V+4aNBxSbRjbq4=;
        b=jS2vtOqYqLE/UAH85ZVuBHyHcP6KJfCYF/kd2GCumX7Km1JENVatuWyLBZXwtUcZ78
         uuJWTV92JL0DWP/oclQZqlxzCj8+Wr4Yg+P1AZUMQQh/uwJYs9eTqMszVYOeXuU3VhMk
         tqo7aPoLoLPUsQkRcbW/K1+4phYfubMX5KMoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aVzH3++K/2N/bei/W7brwrZIoSH+2V+4aNBxSbRjbq4=;
        b=f9k5u/E2BNGS9nZxpEYK59+uUZIGqv4b4mamwAD49lh48NDDxOttzYUf47/MT38RmT
         Vgy4lNtsynFoGQil0P8tweoU0rIRLrCUME378UfOoz9odiaO9TiX6FCqZFQwC0B1TNfS
         ma/O8GvMzyW/u6l/ucKbSbSMmUEbe235JFeeyT6wGYBgKqj6UjauIoK2aJTBfgah5z9j
         gymVxb5p2PtZ3hwd0h+tWb1u+wGrDpZsoHQhtkMNB8zuriveBXey40kQuhMh2LWGHrRC
         9t3EYrTx0aA4zuAvxizAm36U1lLuG6KfvgO92kMcDIcO+xDg+9XXaUcvQfPhJvciEi4d
         V8zg==
X-Gm-Message-State: AJcUukef71PQXO7MRPLXP5aGt5rupHQvC5uech0gSwuqTUCIDaIzdv/L
        FKg6KD0Kcolk6/vyxDdniCUkEw==
X-Google-Smtp-Source: ALg8bN5Pa1G5uAAreLJUsvnXuKXoqnB/OuhYT6/cS4vJiBDbtX21eMh64bYx4cARh8Y2v53zKN5yuA==
X-Received: by 2002:a63:a553:: with SMTP id r19mr32449265pgu.53.1548962900998;
        Thu, 31 Jan 2019 11:28:20 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:20 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Garnier <thgarnie@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/27] x86: relocate_kernel - Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:11 -0800
Message-Id: <20190131192533.34130-5-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only absolute references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 11eda21eb697..3320368b6ec9 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -208,7 +208,7 @@ identity_mapped:
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
+	movabsq	$virtual_mapped, %rax
 	pushq	%rax
 	ret
 
-- 
2.20.1.495.gaa96b0ce6b-goog

