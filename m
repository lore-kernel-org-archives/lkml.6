Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C952C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB512084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX16ZPLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfASMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:40:33 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42994 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfASMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 07:40:33 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so18222813qtq.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 04:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l5GXRWkt9Q77FEbQeH+ZOYB+dwpTX0asXVUPkKTHWcU=;
        b=JX16ZPLJXu7WrEr5uYC0WOVsrGCSUgr5q5fZhSr0XE2ezROTO/sH7UBa/bQ+G8KnX3
         j1SPoB4/Eybj/+yppUhXQMnBBuImCTmIbKIXIO9Xc2gOc10QsJR++6akMFCO/5ysVCjp
         LNK0ABQFTMdc5nWCxLrEG4W8SraWJWDgPIfRGqQHjVuSH6PNwrzF0J2djJx9uksLBeJ6
         YfA13PPBhzeFSVk5joWZznZy4AGXL6nvNTr8SDi1D2yHg7uJogHDluiTPxMAoznZp/Oo
         z4H3VE2jadp8gZ2l/xyCowyTOzsyKuKzF07qMdrYzRyOsyOnZ1SXHTjHPGYKuwTBZuap
         efDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l5GXRWkt9Q77FEbQeH+ZOYB+dwpTX0asXVUPkKTHWcU=;
        b=H8qzpHW00hOQTp6a3ONUMksWb4gSQp8JuYFvcoXjZZl99pOEe8AkmCQSAiNND/I6ex
         5MU0azuqtCHCLJ0R8dJrjwKK1ERbntMHJpcI12ktzZ8h/L06qYAewwgn3MolR0+B2LJ2
         NzLfHxOVrIXBCw1g7/feILexa8ibwWIApyE1QKlMeWgxbGKiFQvwPelDAEWJ4EUNEP5U
         uegaWV9n+xAj2x9gxobtZi9uIXuqjACIu8kw01y2Yq8e9DKGYcw5TLo9nhs0+FemsByT
         +4Yj++juMDg7u/ngAkzwsDDlTV8Q5RGFlB7TBg1SfmQbP11b6Xt+F3c8pmMWJYW3W4FN
         eDxw==
X-Gm-Message-State: AJcUukf0GLmz5LIpYJXsPPDluacOifbwRmk+8ai382asaxD3P+5+7oav
        perR0W3PTTp9UYS7yQRXmw==
X-Google-Smtp-Source: ALg8bN62oIZOnbMBLUduQdnX1OjiMUDNWXBONMW0GhPqjlSNQ+J9Hlf347Q004zP+M/f9YR91LUmyg==
X-Received: by 2002:ac8:7153:: with SMTP id h19mr18930540qtp.92.1547901631890;
        Sat, 19 Jan 2019 04:40:31 -0800 (PST)
Received: from mwhitehe.hotspot (173-13-238-132-WashingtonDC.hfc.comcastbusiness.net. [173.13.238.132])
        by smtp.gmail.com with ESMTPSA id v57sm67210954qtv.80.2019.01.19.04.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 04:40:31 -0800 (PST)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 3.16] Backport of x86/vdso: Fix vDSO syscall fallback asm constraint regression
Date:   Sat, 19 Jan 2019 07:40:24 -0500
Message-Id: <1547901624-10766-1-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 9:07 PM tedheadster <tedheadster@gmail.com> wrote:
>
> I do not see this problem with the upstream kernel, so 3.16 probably
> needs a missing upstream patch.

This was indeed fixed by Andy Lutomirski's follow-up patch "x86/vdso: Fix vDSO syscall fallback asm constraint regression". I tested part of Andy's patch and it resolved the failure.

The 3.16 LTS kernel does not have the tools/testing/selftests/x86/test_vdso.c code, so a partial patch is indicated, unless Andy wants to provide that.

Kindly backport to 3.16 LTS series.

reported-by: Matthew Whitehead <tedheadster@gmail.com>
tested-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/vdso/vclock_gettime.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/vdso/vclock_gettime.c b/arch/x86/vdso/vclock_gettime.c
index 00b5ea4..a3d5326 100644
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -147,11 +147,11 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 
 	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[clock], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*ts)
-		: "0" (__NR_clock_gettime), "g" (clock), "c" (ts)
+		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
 		: "memory", "edx");
 	return ret;
 }
@@ -162,11 +162,11 @@ notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
 
 	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[tv], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*tv), "=m" (*tz)
-		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
+		: "0" (__NR_gettimeofday), [tv] "g" (tv), "c" (tz)
 		: "memory", "edx");
 	return ret;
 }
-- 
1.8.3.1

