Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB55C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60A322507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehVya5UJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60A322507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbeKMT3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:29:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33718 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731669AbeKMT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:29:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id w22-v6so5734453plk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c74LMoBlYNH1kfJjR7peaPlz6opMjoaLwYHoSNp86IA=;
        b=ehVya5UJBRHxMYUDyk1/4DRmSWljgJu5wIMsVrprcU+Rht0N/Ixy9/a5KFFX9FaDPd
         FZIRluytttoZymX1ArpPDhelgx+bfPGeJVxIrmISLGkYDc5VWeCYdhINMLfdsfyn1TFs
         tMKQS6KgiVywkEYYigfqdwA7RGt5pOqN7eA4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c74LMoBlYNH1kfJjR7peaPlz6opMjoaLwYHoSNp86IA=;
        b=pOfSf8hsrHGSoI0d8jNVNH7GqF4cpuf1qAu5OruA8OA9qzIzInRlgFxeJQvEmkZr+B
         hOc3wOQPlYWlZiJokYEvYb4AHfMtRDOBA/xX1P6UxF5j3Y33GcZcZ0pSHPYOUyQv26Ml
         nTIorMeZJhr4iDrcla4y5ugMQp2aNXHF7HA2kAi/1UbSA3ldr6J5NYBwvLb3TJcx7UEf
         4tzp73haG7z+0Mr4tJO0a2ZA2d94Ib9gOHYrq0T8nB9Ow/24jdvJlbHfUGlFvgO0tP6I
         nsH5iMoTmZy1Iiy5VEynSvxAX6wGMnbLKUsbrFma7E036xsYC+E42raCRyQVepDtctfu
         +qMw==
X-Gm-Message-State: AGRZ1gKxEu3fqKN2KhbnykScqw/dWsNUdbQrAQmvPXwNXnzt/oxmsAqN
        2fBxonfPQtBfaaVsHkXaLObNWQ==
X-Google-Smtp-Source: AJdET5fQI/BVhTlJkoMipme24bCd0ipxw96peUlKTTIvXTnuKbkH+NY4uTrZyl7c9A+JrGqCVHRKXQ==
X-Received: by 2002:a17:902:824:: with SMTP id 33-v6mr4420361plk.107.1542101553307;
        Tue, 13 Nov 2018 01:32:33 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id u6sm19902462pgr.79.2018.11.13.01.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 01:32:32 -0800 (PST)
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
Subject: [PATCH v3 2/5] alpha: remove CONFIG_OSF4_COMPAT flag from syscall table
Date:   Tue, 13 Nov 2018 15:01:50 +0530
Message-Id: <1542101513-22010-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
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
index 5b2e8ec..59ca11d 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -132,13 +132,8 @@ sys_call_table:
 	.quad sys_osf_getrusage
 	.quad sys_getsockopt
 	.quad sys_ni_syscall
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

