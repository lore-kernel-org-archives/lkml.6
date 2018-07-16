Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC03ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398B2208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DV77A1Xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398B2208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbeGPKva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:51:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35418 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGPKv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:51:29 -0400
Received: by mail-pl0-f66.google.com with SMTP id w3-v6so1939545plq.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqx6+HVyTwzi/G2p/wSX/U5PscpYTK71wMljHdL85IQ=;
        b=DV77A1XzrXuA1OKNKPvXD3Hf6DYVDpcD03aJP6qZs/dcYRAdVt29sFT4BcM5FF01Q3
         lmTXnFqKgXgc/hcd3aLkxaNmv4i3cxij9n+liS+8WaA08B1QejY1eZJZ2llVZgNa0nOc
         s4CkSbAxWUvYjjYrraESsa1WGQFk72Y8Zx98c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqx6+HVyTwzi/G2p/wSX/U5PscpYTK71wMljHdL85IQ=;
        b=Rgl4K3AAiKNUZ0HU/kBn3o6MPWQka1L2O2KsG7sRe2xXfd3WdROf0XDCWDe6/DBjNo
         VTQz6JJSRdm765WP3v3iJPjJT9OxzhDHXjiu5Tu5//tnxFvRNtHO5voaeSoy3Uff3By9
         LCigzUlqcKsLqtsLCRg7NmlrXRNxJGvlUWVLYz/QqmqCF1wuQxG5SuGp6KQ/IIjwe/4S
         er6LwOvN9kvO/N5JuLJrA/0RrOgLxHotG1WjlBpqVUNLi7V/VQGxj7FPDlyOJb1a2YBW
         Gwt2jTg6p1oCQb63dbyAkEa9/Ywc8O23JCVM4PHBi/LGg7ioMbyrrx9wboO7LOOcwn4Y
         b5YA==
X-Gm-Message-State: AOUpUlG1cpIicD9GRkPWCbzLrL5RTQXvK2jHVXSGKRipe2Ynzff6pgXT
        Dqdsxhx8v2YwAFBnhcQ3uupkUA==
X-Google-Smtp-Source: AAOMgpePzdxTQnjc0+CgMtyO9hO71KG80YoShPcGhQJYzcSP/zjTVOJk58g/pXaiM6QFVv35szPPLQ==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr715820plb.108.1531736684778;
        Mon, 16 Jul 2018 03:24:44 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17808087pfi.42.2018.07.16.03.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 03:24:44 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 2/6] alpha: Add CONFIG_OSF4_COMPAT for compat syscall support
Date:   Mon, 16 Jul 2018 15:53:54 +0530
Message-Id: <1531736638-15294-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the CONFIG_OSF4_COMPAT check from systbls.S and
kept it in osf_sys.c, so it will provide the same system
call support. To do so, we can keep a generic formatted
system call table file across all architectures.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/kernel/osf_sys.c | 9 ++++++---
 arch/alpha/kernel/systbls.S | 5 -----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 6e92175..696a6b7 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1349,7 +1349,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 
 #ifdef CONFIG_OSF4_COMPAT
-
 /* Clear top 32 bits of iov_len in the user's buffer for
    compatibility with old versions of OSF/1 where iov_len
    was defined as int. */
@@ -1366,27 +1365,31 @@ osf_fix_iov_len(const struct iovec __user *iov, unsigned long count)
 	}
 	return 0;
 }
+#endif
 
 SYSCALL_DEFINE3(osf_readv, unsigned long, fd,
 		const struct iovec __user *, vector, unsigned long, count)
 {
+#ifdef CONFIG_OSF4_COMPAT
 	if (unlikely(personality(current->personality) == PER_OSF4))
 		if (osf_fix_iov_len(vector, count))
 			return -EFAULT;
+#endif
+
 	return sys_readv(fd, vector, count);
 }
 
 SYSCALL_DEFINE3(osf_writev, unsigned long, fd,
 		const struct iovec __user *, vector, unsigned long, count)
 {
+#ifdef CONFIG_OSF4_COMPAT
 	if (unlikely(personality(current->personality) == PER_OSF4))
 		if (osf_fix_iov_len(vector, count))
 			return -EFAULT;
+#endif
 	return sys_writev(fd, vector, count);
 }
 
-#endif
-
 SYSCALL_DEFINE2(osf_getpriority, int, which, int, who)
 {
 	int prio = sys_getpriority(which, who);
diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index 1374e59..fcf2f60 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -132,13 +132,8 @@ sys_call_table:
 	.quad sys_osf_getrusage
 	.quad sys_getsockopt
 	.quad alpha_ni_syscall
-#ifdef CONFIG_OSF4_COMPAT
 	.quad sys_osf_readv			/* 120 */
 	.quad sys_osf_writev
-#else
-	.quad sys_readv				/* 120 */
-	.quad sys_writev
-#endif
 	.quad sys_osf_settimeofday
 	.quad sys_fchown
 	.quad sys_fchmod
-- 
2.7.4

