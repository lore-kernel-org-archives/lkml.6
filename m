Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FECE222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hHF9WyDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfBLVmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40610 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbfBLVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so161258eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZ4+J3qclzOiT4eS0G4mZNYid/q8EGWND5FwtaRiLJ8=;
        b=hHF9WyDE2qOpSpiKv2V9o9VpxsQ8Tyea718fPZiTOnGLYLYqbzDy3UdC6NxlaEWYhV
         TevrN4gYd7No7KG51GQaGc8a63kgjFm02Jgcomz75qpeL1DN5vC4XaB39F0UxRW9oMrE
         bX+JbiaAEMhSGhv1zDfyw7LprZQVOW7uNTuBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZ4+J3qclzOiT4eS0G4mZNYid/q8EGWND5FwtaRiLJ8=;
        b=oX/t+rtAaea3dKRVK5hy1QXe1UMYtDrdG4Doh6lwsUImVH2XznQMvOh5czS9keMvEH
         89HqExOE/XSX8uVF1R1FJ7JfBmP5nfxuBBwDqlIdm8r2KMCh5M9FsRLD06uqgSTvnVyH
         4YJflWP5gmNAFu8CUt5OZPc9cCgWo3O/y73gqAR2nLpDJrJqaYnbRcqiLcJBy7qBVIxZ
         zknEs5ucb3onPdboZljmOCxaTeYryHZrjsXWR1p/N5i8Shrz2PmItu02zMRDYfmHirDU
         LdARxHQwf78yo1fCQ20bxtw2+j4PJO+6kBYldsfljOyRX0IpF1Xddw57KCYsxQK4OZhS
         drrA==
X-Gm-Message-State: AHQUAubVKimqIYS6ZwdFmRQnZzP4I3GncwT5dKvYnYj1IyyGhfL7xnLh
        Wx5ouJAPnx2rJidUoq3dXS8l9g==
X-Google-Smtp-Source: AHgI3IYrtip8cBj7kxoj867+/Ik7PgoLY01O4UY+7t1axbQcVGamLRLlzTIbsdR9qeWMs2prSy+rJw==
X-Received: by 2002:a50:a982:: with SMTP id n2mr4669797edc.236.1550007732014;
        Tue, 12 Feb 2019 13:42:12 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:42:11 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 14/14] ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
Date:   Tue, 12 Feb 2019 22:41:50 +0100
Message-Id: <20190212214150.4807-15-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With coming changes on x86-64, all dynamic debug descriptors in a
translation unit must have distinct names. The macro _dynamic_func_call
takes care of that. No functional change.

Cc: linux-acpi@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 07b9fa507824..96c4eaed9439 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -982,12 +982,8 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #else
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define acpi_handle_debug(handle, fmt, ...)				\
-do {									\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
-		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
-				##__VA_ARGS__);				\
-} while (0)
+	_dynamic_func_call(fmt, __acpi_handle_debug,			\
+			   handle, pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define acpi_handle_debug(handle, fmt, ...)				\
 ({									\
-- 
2.20.1

