Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328A6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9976208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aM4nHyLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9976208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeGPKvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:51:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33538 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbeGPKvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:51:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so7281913pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OIqLEvxGHoGaz5CARvu0QXTzU2PXIGzQEJ9FoygLNZU=;
        b=aM4nHyLOCktlRQDTYz3Zp1dwuizpwBobQx8XgtbxwxMXWoNNnqTbrpmmoC0Cgkql9R
         KMvEmipiTsB2pyubaWzfj9TrdFgHWyoDelj77r24QwlQShsZphtuDINtbyYh0QOGDtjU
         ZZ2oaGqi7cj9QZhaFJ7MfCvS9AC64qxLfSl6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OIqLEvxGHoGaz5CARvu0QXTzU2PXIGzQEJ9FoygLNZU=;
        b=cOOcl+fvqTrAiGHl4szqMruikuAEn1sE0zrSPi8+hHOqjR4L+8PhWhlqz2nrI9y0zc
         +5WTtlk7lyJEN6ziOSw+TAA+ZkYL5aAw+fFmKExxA2lNl9W4AdEaYAc1AbDO3xb/DO7r
         xzjVXWv32kovvp16WsQiHTi7lbenmAkMFbVMHiPxpA8/jibMFIGHseIFsCUuLryuI7Xz
         e/DbImnmOxUgjMtoEngkv1UJu+/amrwwazMNfUT5zZRsvJCuYCROXFNz+UHBHP0+SmYp
         1zZpw6ne3f3FbDczUCaDiTbV1hNaRdlqTzyE/sSzCcjaDji8u2I6Hc/GIVI5di9CMlst
         q71Q==
X-Gm-Message-State: AOUpUlFN91TDw/v4v/sjAK+WdiJy3PPkxd8B6B7w7soZO2ytqgxA58l5
        SBFsmMX3fRTyuL+BqCy0964yEQ==
X-Google-Smtp-Source: AAOMgpc+d/W8WcYxtZB+Jjf1iXjsNmLm2YtMSMyaO6Tb52ceADqwNtN+/TDBuu+CItFRlQ2KHPhwLg==
X-Received: by 2002:a63:f953:: with SMTP id q19-v6mr4054988pgk.292.1531736678811;
        Mon, 16 Jul 2018 03:24:38 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17808087pfi.42.2018.07.16.03.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 03:24:38 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/6] alpha: Move __IGNORE* entries to non uapi header
Date:   Mon, 16 Jul 2018 15:53:53 +0530
Message-Id: <1531736638-15294-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/include/asm/unistd.h      | 5 +++++
 arch/alpha/include/uapi/asm/unistd.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index d6e29a1..1d19087 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -17,4 +17,9 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
 
+/* Alpha doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index e153ca6..3bb6ac1 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -481,9 +481,4 @@
 #define __NR_pwritev2			521
 #define __NR_statx			522
 
-/* Alpha doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _UAPI_ALPHA_UNISTD_H */
-- 
2.7.4

