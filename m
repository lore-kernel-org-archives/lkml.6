Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C956AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84621216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/THUxlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84621216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeI0UfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:35:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38249 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeI0UfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:35:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so2031652pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UzcNN6/ovybP8352J6MHOI4SHUMu3OA6FaESJfdftn8=;
        b=W/THUxlN9K6uf8cIX5N0N5C73/6kOLEAjwefJze1oio3sSAftVKMJlvjsgq7qW9Hag
         ksfkCj5SexSqbHP0PKnnyKyHw8ATvm3IRgrAU5WvRgm2dZpPu/t0oFnBqGCQZnwlLqvM
         UZFIEq88pbF14/fRDoWz4uDCGfwY0KdMhDFdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UzcNN6/ovybP8352J6MHOI4SHUMu3OA6FaESJfdftn8=;
        b=VXBLgMcPaQeQWNpEH1fKbgDCxvZyO4J6yOJzBm0GJUHDf2q3uFft0OmyWNE15Bkv9z
         falkOGuJjBxOoNazBLYQSYbDro9wsA8IfyTij3pM0LpjOWtvWELI0upxo1v+6G6LfN9K
         YKO2V0MvboJc7MG1lwvLRMJ4YQbaJOerROTCfMmO41y2Fo1jPLymqbDUWQd9ziI0IME5
         TnX/wOAX6ikTrSTmYcRAENE5FovCFvR25znaf8gWDc3Jx1kBxqOWUG8ukt0knVUDfaXO
         N8m3KI1nfBhet5U3+3J/iw5CVfrTdOPiWgxmIaCiHusEnj1J2lRzvHFo9K+op+WUp6FS
         go1A==
X-Gm-Message-State: ABuFfoi7bIoN3K+oJ64F50moPuFjEqITv8O8hBcgi/4BtrPPVl0hLP35
        DXllxm/lb+lFYIedWkmFlbl0sQ==
X-Google-Smtp-Source: ACcGV63mEVtVlU3TH2zEKoGdCpK9zYXwK51KKm+NLHT0yADkOY0fAneAT6n2f8n2YXtvtoUy6KmmfQ==
X-Received: by 2002:a63:f848:: with SMTP id v8-v6mr10368114pgj.82.1538057798051;
        Thu, 27 Sep 2018 07:16:38 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.105.186])
        by smtp.gmail.com with ESMTPSA id m20-v6sm110399pfj.171.2018.09.27.07.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:16:37 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 7/7] ia64: add __IGNORE* entries in asm/unistd.h
Date:   Thu, 27 Sep 2018 19:45:20 +0530
Message-Id: <1538057720-3392-8-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __IGNORE* entries for perf_event_open, seccomp, pkey_
mprotect, pkey_alloc, pkey_free, statx, io_pgetevents and
rseq in the file asm/unistd.h as it is correct to keep
__IGNORE* entry in non uapi header asm/unistd.h while uapi/
asm/unistd.h must hold information only useful for user
space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/include/asm/unistd.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index 397b143..a0941e6 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -26,6 +26,15 @@
 #define __IGNORE_vfork		/* clone() */
 #define __IGNORE_umount2	/* umount() */
 
+#define __IGNORE_perf_event_open
+#define __IGNORE_seccomp
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+#define __IGNORE_statx
+#define __IGNORE_io_pgetevents
+#define __IGNORE_rseq
+
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
 #include <linux/types.h>
-- 
1.9.1

