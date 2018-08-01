Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C09C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABC020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJMXHZuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABC020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbeHAJn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:43:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41098 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbeHAJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:43:57 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so8409926ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5amHDmg026JB1zJ+Ct9rVxm5mNHAXQC5qrpdWEXy5zI=;
        b=CJMXHZuF272lx6p1FY4vncZVgCLe5vB5pCCZOhKzIKR+dFmQ2r/BxKJRfYB5oeQUzz
         VfrsvDDunR3HDwVvUEILpaMpzgfFeDVqwu77PXdIdQY4qWW3tbsFqyEKw3rpPSiUKb9N
         Tkh+9w1KLuhKxTJCChfXdSjEJ38fv0SFB19+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5amHDmg026JB1zJ+Ct9rVxm5mNHAXQC5qrpdWEXy5zI=;
        b=ivtDGLPqS5zVTl8zW1P2CuSYLQ/S0FnWrMak6/x8S3N7dXqwbwtP4Psnz1AtWpvXKU
         /wySeG5rDwxRHLP+cmEAEz0uNcSScxdSeB2aR3OP9JOMez+ZGDu+jfSlWpb0LgY9VCFM
         GAcH39/JPxnfuO2ewY4uCXZhRTAwu6pXj7a3nKeMmraR8uSkGTWHNvfwJek0n9IS+jga
         S2rq2XYLNmKCGlA7JoyiwwgVbf/BYW19LnkoA4bagcoWNucbWbuRcvjLyBldFRyINVQ9
         hmI8JRop2F2SFlkSVtSxnsuMPgbYytevSsjwm7JrS3NRuBKShRxFJtqYj+JrUhABmj8j
         gcUQ==
X-Gm-Message-State: AOUpUlFM31tO6DEoDCmPpLLdpB5eCdMCuA6P3Db4IqHCvTkDjCUa6sqV
        nXUEgVDzusqTcN6wSwvu6VSnVQ==
X-Google-Smtp-Source: AAOMgpe4dG4Mhg85GoOTnrcvSX+CAMg7n12TVTHFvRU1htzsZHK6fyHUfc3Rxd0Lbj/UG1OjjZFSJA==
X-Received: by 2002:a17:902:b785:: with SMTP id e5-v6mr23561403pls.339.1533110371491;
        Wed, 01 Aug 2018 00:59:31 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r81-v6sm28580218pfa.18.2018.08.01.00.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 00:59:30 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v13 01/16] asm-generic: add kexec_file_load system call to unistd.h
Date:   Wed,  1 Aug 2018 16:58:05 +0900
Message-Id: <20180801075820.3753-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial user of this system call number is arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index df4bedb9b01c..acea91e49523 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -736,9 +736,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_kexec_file_load 294
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
-- 
2.18.0

