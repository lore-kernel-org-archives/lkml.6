Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24A3C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BC220835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bC61NBjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BC220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeJNVGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:06:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44450 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeJNVGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:06:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so18147064wra.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7rk7nET3rv10X6UFsonWmDDg5xB784tUbjvoqunsV1U=;
        b=bC61NBjpubeR1t2BHtLf6u7vBS2c2uAKUFPOXNeJcWWGxLhyzDeNU+CKO1KFA+02vF
         IYgxVqBLtyYH0885nGhUPqJF8OytCihpVwWKdHyF2alj4dIVSJIw7QMeUAmBjhhxsvIC
         nsl+O589NrYlwBohdFQL8n9abH8fxnepmQrrolqgCd7L+YQDB5vJ4aUAZfzVWjkpyISz
         P2ssvY/r9odnbhDltLHe9smwSRMkRYTOCFaSIzHJZ3Yx+MypSjQU9Z78WTaN8S7H2ceu
         tqOAuRWFSZlAJLvJTIJhX+7bGJn3QEER8XESBik7/s+OgfjAJyze28zJBhnIJ6oiGHVa
         23qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7rk7nET3rv10X6UFsonWmDDg5xB784tUbjvoqunsV1U=;
        b=XpnvT0WEhie5633kHmXHIJM5gNxQYsqrc8BWCztftFtiv2IAVxIal8hEZszT+UfSPi
         l2H3hysMFh0GhwvkudPHb2/21sT4O93jrfpE/9g/QY1V7jJBEK01JKPw39IVv02pgw0V
         IuGweb3Q61tUUSF040eqMgHwYRLjbzdGghDji0OowuABYWm2I1qxh0hYX8bPpfO679yV
         5edWoUKie/eJM4fnfYfBUDr9FMRsirXlsMJHM29LtPsfPqQ7pp31VvtCdkPQJjm5Kb9a
         U1PWIU0gg+y+hZOAmD8eeK1aqXFHygIbYh17nJd++iTx5hBOXSkuqejIHv2djpdtJoNv
         oX/A==
X-Gm-Message-State: ABuFfoiqX/yy8QUlQJXBx6dllBwm0RMe3v88Mt1P6LaFtMWHpCmZTiJQ
        R0EXDn6yHtq8TbRAR/Hq19J+j6s9tyOMLw==
X-Google-Smtp-Source: ACcGV60AokLTp3hpH5XKLDT34TuMDIzU2+cvL/Q06XQ7Odiy2UO/mtzYUcqANb44G84tffQclkXo0A==
X-Received: by 2002:adf:a481:: with SMTP id g1-v6mr12117458wrb.167.1539523543894;
        Sun, 14 Oct 2018 06:25:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id a11-v6sm10550050wrp.3.2018.10.14.06.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 06:25:43 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/2] sysctl: handle overflow for file-max
Date:   Sun, 14 Oct 2018 15:25:10 +0200
Message-Id: <20181014132510.25943-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181014132510.25943-1-christian@brauner.io>
References: <20181014132510.25943-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when writing

echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0. That quickly
crashes the system. Let's detect the overflow and set to ULONG_MAX in
this case effectively capping the value.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/sysctl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a9409375380c..a3e4321b8ffa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long one_ul = 1;
+static unsigned long ulong_max = ULONG_MAX;
 static int one_hundred = 100;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
@@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.extra2		= &ulong_max,
 	},
 	{
 		.procname	= "nr_open",
@@ -2789,17 +2791,20 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 		unsigned long val;
 
 		if (write) {
-			bool neg;
+			bool neg, overflow;
 
 			left -= proc_skip_spaces(&p);
 
 			err = proc_get_long(&p, &left, &val, &neg,
 					     proc_wspace_sep,
-					     sizeof(proc_wspace_sep), NULL);
+					     sizeof(proc_wspace_sep), NULL,
+					     &overflow);
 			if (err)
 				break;
 			if (neg)
 				continue;
+			if (overflow && max)
+				val = *max;
 			val = convmul * val / convdiv;
 			if ((min && val < *min) || (max && val > *max))
 				continue;
-- 
2.17.1

