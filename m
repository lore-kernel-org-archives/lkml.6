Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C218C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4411020872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlf7+xIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfAKBRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:17:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39287 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfAKBRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:17:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so5583729pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 17:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pBrZ3CioDf9IPnu/iao9blT0tnYCjnN+XUWIYCmnjVI=;
        b=dlf7+xIONI6JaeCr8BxqmLQXVnJ/3Il58Z3oHS0X5j688A5xlpM18FUDkNb+ICs0Ux
         QfhaWjixCTKBWuOPDLU2Puee/o0ollIgBSS7kpri8euDCc9ZpypPkZA4SkrF+3KdfKrm
         xUm8OyG2U5WIpRWCh8s4py/JMzLtjq9iE5RVfSYPEldPIaSgdxcXQ0Fwz/Wyd8t44n+n
         ShTxsFs3/fq9PsdY6/UgdS9a2y1oJgdbYpEQFA1N/6uea8uLyhelz6r+SavatbSYggMN
         uWeU2Z6urDdtL71avRcbGsGVjRkw3XFwt0FvrwnElrroTeJf9ZQ3rh60JXiC2aH5Xwjt
         HQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pBrZ3CioDf9IPnu/iao9blT0tnYCjnN+XUWIYCmnjVI=;
        b=cZ03uDwXXpM5xgCfl2O3OWHIPlLmjkmTuK0w2tIzTXfKmiS/yTZ8IAud8Nkw7Fv5SW
         FiJAKeVkoIQymCMG1MuY6DaE85JzHjjIH6imQwkYdUxu6oZrl8ywGPReiL/2nYt4UMA5
         YQO2mD+HOmFWPfa/s8ytQtN1SkLRrpjuSO6xfDgPO0a+eTCc0QyAjx7PlmMXrI8Iw2O7
         FBZ/SFEGvJBp62JV0O79enT1qfYGIOcHQ4+MbgOwNSKeCDzcRkx1XcBt1FaUW8YBUPxz
         YhxAqN18eXHyiZwkePX9jFOLkIfnacWpA5uz5A8tPC4P/Q6l5jTBk+9hDqPgAMwqkCNO
         MGRg==
X-Gm-Message-State: AJcUukcA6i/lktaMFIGQY4JCHz4iCraTG4px1hanV1sfjqOR943cVfer
        WO9odsVUMi2qr//JOwaUVuYta1LNAEOS2A==
X-Google-Smtp-Source: ALg8bN6xHkb+R89hc+bzgrI1nBBCvO1djpQnbcNJb4y33X7QX0osetByPWxSxAF5EH3H9ICQqYQAWA==
X-Received: by 2002:a62:6047:: with SMTP id u68mr12252161pfb.239.1547169440216;
        Thu, 10 Jan 2019 17:17:20 -0800 (PST)
Received: from localhost ([104.133.9.99])
        by smtp.gmail.com with ESMTPSA id x12sm96711363pgr.55.2019.01.10.17.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 17:17:19 -0800 (PST)
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, ak@linux.intel.com,
        kan.liang@intel.com, jolsa@redhat.com, acme@redhat.com
Subject: [PATCH] perf/core: fix perf_proc_update_handler() bug
Date:   Thu, 10 Jan 2019 17:17:16 -0800
Message-Id: <1547169436-6266-1-git-send-email-eranian@google.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_proc_update_handler() handles /proc/sys/kernel/perf_event_max_sample_rate
syctl variable.  When the PMU IRQ handler timing monitoring is disabled, i.e,
when /proc/sys/kernel/perf_cpu_time_max_percent is equal to 0 or 100,
then no modification to sysctl_perf_event_sample_rate is allowed to prevent
possible hang from wrong values.

The problem is that the test to prevent modification is made after the
sysctl variable is modified in perf_proc_update_handler().

You get an error:

$ echo 10001 >/proc/sys/kernel/perf_event_max_sample_rate
echo: write error: invalid argument

But the value is still modified causing all sorts of inconsistencies:

$ cat /proc/sys/kernel/perf_event_max_sample_rate
10001

This patch fixes the problem by moving the parsing of the value after
the test.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..e5ede6918050 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -436,18 +436,18 @@ int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos)
 {
-	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-
-	if (ret || !write)
-		return ret;
-
+	int ret;
+	int perf_cpu = sysctl_perf_cpu_time_max_percent;
 	/*
 	 * If throttling is disabled don't allow the write:
 	 */
-	if (sysctl_perf_cpu_time_max_percent == 100 ||
-	    sysctl_perf_cpu_time_max_percent == 0)
+	if (write && (perf_cpu == 100 || perf_cpu == 0))
 		return -EINVAL;
 
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret || !write)
+		return ret;
+
 	max_samples_per_tick = DIV_ROUND_UP(sysctl_perf_event_sample_rate, HZ);
 	perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
 	update_perf_cpu_limits();
-- 
2.7.4

