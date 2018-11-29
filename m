Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB81EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872A52081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+t3zy6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872A52081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeK2TtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:49:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44293 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeK2TtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:49:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so662716pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 00:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O1oTkPJ6qrXNeDh6ydGScbRxC5yjbuUQ1NYPCDxj/lM=;
        b=g+t3zy6I97eqy6vXR1JgC0qJ4uRNIfYaFSMilJh7FKjhFf3VZoYJBep1Skw2y6+tFM
         /+sIUg2r6S1/A01sJd17/FZYr8Egc3yVztjJO2hk2hAChZr/hiZfsO4109BRiqCybxA+
         Est1cQyutH3gwPgABQBC+uWQjGrLSm5lqGJEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O1oTkPJ6qrXNeDh6ydGScbRxC5yjbuUQ1NYPCDxj/lM=;
        b=RQX+juAYxa1T+di6q5HA8V6co2mARQ2GSb++Wo5FdP55kXN15F0UqGD/hRgMrYTNeN
         hMuFG7aXwm5SQAJJpn7/BqkuK2hnBO1EIdu5dgKv4kYGWI1TXjqztjTM94BIg4V8j1m/
         e4Fby5C16X1ueuXOJzpge0exZVLOe72UxMGzONiKzpwcU7WGSSrAgvlg0VXeC2WAxjpU
         OzW7SPXqASe4ofwTyqyuxKBtkxQYSqKMFhYGw80EHbo7Ex8MINhOF8aquOi/Q1UtDjNK
         1cBNw96KWWGW4j1EBB2lowtqKO2+3u+wdG+N0X2YeWdsO1Ws5YU0TjRwg6DSA4ijA5Gy
         bThw==
X-Gm-Message-State: AA+aEWYu59A38heCmAvvbouxu5Xxr1t3AI5ORip6+VeqrR5GiBjT1qSH
        lDQLEx9FvYs+VMxwfzhwJphzPg==
X-Google-Smtp-Source: AFSGD/UECveWtMxOKiCQHDFoCzdBFt592KuxWOFfs5ClJ08kAUVtenkqlNepJc2UujYJKmv+TN2pVA==
X-Received: by 2002:a63:6c48:: with SMTP id h69mr456110pgc.139.1543481068123;
        Thu, 29 Nov 2018 00:44:28 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2322683pfl.142.2018.11.29.00.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 00:44:27 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v3 2/6] mips: remove unused macros
Date:   Thu, 29 Nov 2018 14:13:32 +0530
Message-Id: <1543481016-18500-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove NR_syscalls from asm/unistd.h as there is no
users to use NR_syscalls macro in mips kernel.

MAX_SYSCALL_NO can also remove as there is commit
2957c9e61ee9 ("[MIPS] IRIX: Goodbye and thanks for
all the fish"), eight years ago.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/asm/unistd.h | 8 --------
 arch/mips/kernel/scall32-o32.S | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c68b8ae..d7ee846 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -14,14 +14,6 @@
 
 #include <uapi/asm/unistd.h>
 
-#ifdef CONFIG_MIPS32_N32
-#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
-#elif defined(CONFIG_64BIT)
-#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
-#else
-#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #define __ARCH_WANT_NEW_STAT
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 91d3c8c..fea6edb 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -22,9 +22,6 @@
 #include <asm/war.h>
 #include <asm/asm-offsets.h>
 
-/* Highest syscall used of any syscall flavour */
-#define MAX_SYSCALL_NO	__NR_O32_Linux + __NR_O32_Linux_syscalls
-
 	.align	5
 NESTED(handle_sys, PT_SIZE, sp)
 	.set	noat
-- 
1.9.1

