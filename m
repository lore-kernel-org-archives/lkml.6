Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B32AC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324B82064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRC644dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324B82064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeKAWrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:47:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34879 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeKAWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:47:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id n4-v6so8411737plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8FnFEK7c/DUJ5lPLIn2rlLgYSl7jYezcz1jftODFSzI=;
        b=CRC644dYRtzlJ5RTPwelvULEPLBaDG4YEcQFhLsv/w7aCPzpphJrhhm/pvnIwFZfWQ
         2bsdiaiEikRiEJtKFwfxmioKLyLDsY/TmCjJAUsCZCxtW+H4wn+DLFHdhDC3JszAAPu3
         28OL6/OF0V1ScS03gzhk+7Ri7mMipBRkwwD6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8FnFEK7c/DUJ5lPLIn2rlLgYSl7jYezcz1jftODFSzI=;
        b=V6RpD+Vm4VCdn6AyLNDXCo+FA9TzZiRrVItw4Sq8nvLQRCnxH0iyKtWP0WUBkBVX7G
         tuGitSjuZxrKHvJoi1WvFu7W0c/wH+X7exmiXMJOhNLgHcDv9OJNbNeUALAAfo0RSCE3
         KxQt5+kcYEmRnyo81GMa9FSXTIR21CYe59xOEQiYZVxN+STNQY9cAcpm+aofqYJ0tLcA
         yQO3Q0m6N6PgxLRNQnYhA7t+j/VzWQ82HSchvabKFR/YjhLqPzRPMhDEUOnGN3PaRer3
         lo2R84DoSe9y4D2GhTFSztNvNKmkLg1gbxJp5fB/+JeTSKmOFky14hHqAO/5t/jK2TOS
         P/4A==
X-Gm-Message-State: AGRZ1gIxhBUpE+DkkS0riw+Pvert72p2t8yHboFMLSeTAYb+rZif8WbH
        E7r0tjYJp3BLoAuO14jhKwDV+w==
X-Google-Smtp-Source: AJdET5cf6kqUGj+pSFI8fu8khXI9roKGHTd1HkAe1jV0bxFkNWPRe5gE06Ybv9IqlOMq3x/scu1eQg==
X-Received: by 2002:a17:902:5a2:: with SMTP id f31-v6mr7638308plf.320.1541079863392;
        Thu, 01 Nov 2018 06:44:23 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id r23-v6sm36359299pgm.48.2018.11.01.06.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:44:22 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 2/5] alpha: remove CONFIG_OSF4_COMPAT flag from syscall table
Date:   Thu,  1 Nov 2018 19:13:34 +0530
Message-Id: <1541079817-3431-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
References: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_OSF4_COMPAT config flag from system call
table - systbls.S and to keep the same feature, add the
flag in osf_sys.c.

One of the patch in this patch series will generate the
system call table file. In order to come up with a common
implementation across all architecture, we need this change.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/kernel/osf_sys.c | 9 ++++++---
 arch/alpha/kernel/systbls.S | 5 -----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index cff52d8..4a147bf 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1343,7 +1343,6 @@ struct timex32 {
 }
 
 #ifdef CONFIG_OSF4_COMPAT
-
 /* Clear top 32 bits of iov_len in the user's buffer for
    compatibility with old versions of OSF/1 where iov_len
    was defined as int. */
@@ -1360,27 +1359,31 @@ struct timex32 {
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
1.9.1

