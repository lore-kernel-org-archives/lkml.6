Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511CCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC40214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEOZ3jUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfA2PNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:13:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37305 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfA2PNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:13:31 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so22556309qtt.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TWtLBy/hb49JcJ7axTK/C1lManiIeaMQK/o8nwSDRAs=;
        b=fEOZ3jUeEIRaFK/06K3OVaHiTRZcnGsCAj/ZwQuPPWBoTdn1Y00FIZe/np/l/WwGmo
         Vwc1nNWrox+UZ7GjmGNBnTD7u06Q1vQURwryF7f++TemNnveTwjrQ6LRqsORayH9EOQE
         7ubFeCwkrHEJPjNvSWrzs8tr823pW4GYpUwA/hbcZV8ygjPwfDmfC8Wznxyq1kyWm9bV
         b900LOUCs5g31GyUDNUwVFdeUEcq0l5RemiwSH4FNoysCpxn8f5Z9/exYgCHZxHlKNyd
         hjOpJ0a9uGSSL3Q4o8wmaRmVgYlfUHvz6wNkfrQGDEBaSbJmFY60gt0EI27I7g+moqsk
         57Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TWtLBy/hb49JcJ7axTK/C1lManiIeaMQK/o8nwSDRAs=;
        b=QHvsZnhrhWOacFQqdFxOMVXe94W8gnjdCivQtYOVMKxjDDeYgOllv1ZvDZl9CbTEPR
         oezxpib6O7mGClz3gQf/nGJfNJEmowqO9aEjxOIIZvjEKRwhc4JwsWv3cJuvQQFLl/QP
         2OCJXqf02OjeyD6cTiThGxNhEJJa7pyQjt7YGi5v+zVGyG43OYD8cjikUraJUsWX+f5z
         FqIGDWV+HUFDj6lxpJrtpB6EtgsHxTUE6eTi+5129/h21H6Y++A2cZo1bgunsygDxrB7
         TDU74z7EAMjxQn+BYHSGbGf6PBh8ZbVwJD1kZhwlNhT0bSxuqTclCVOBByPIe/Irk+Yi
         VhDQ==
X-Gm-Message-State: AJcUukdh6iZ3BE+64jsLfWi7CwjWv7v0Lh3/9Ddi9k2Mr9mKLoCnOf0I
        4BEKikISJNgniFsycxAIMQ==
X-Google-Smtp-Source: ALg8bN7pI4HQdnGuzK8/IWLR2tH/H4IvJc+Aj+CL9lJlsbWoeiYXMGo9waMcjan0x9gNI1W3nGLQfA==
X-Received: by 2002:ac8:2614:: with SMTP id u20mr26434728qtu.28.1548774810130;
        Tue, 29 Jan 2019 07:13:30 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t123sm66387806qkc.6.2019.01.29.07.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:13:29 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH] sched/debug: initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK
Date:   Tue, 29 Jan 2019 10:12:45 -0500
Message-Id: <20190129151245.5073-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

register_sched_domain_sysctl() copies the cpu_possible_mask into
sd_sysctl_cpus, but only if sd_sysctl_cpus hasn't already been
allocated (ie, CONFIG_CPUMASK_OFFSTACK is set).  However, when
CONFIG_CPUMASK_OFFSTACK is not set, sd_sysctl_cpus is left uninitialized
(all zeroes) and the kernel may fail to initialize sched_domain sysctl
entries for all possible cpus.

This is visible to the user if the kernel is booted with maxcpus=n, or
if ACPI tables have been modified to leave cpus offline, and then
checking for missing /proc/sys/kernel/sched_domain/cpu* entries.

Fix this by separating the allocataion and initialization, and adding
a flag to initialize the possible cpu entries while system booting only.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Syuuichirou Ishii <ishii.shuuichir@jp.fujitsu.com>
Tested-by: Tarumizu, Kohei <tarumizu.kohei@jp.fujitsu.com>
---
 kernel/sched/debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index de3de997e245..9c6637f3e21d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -310,6 +310,7 @@ static struct ctl_table *sd_alloc_ctl_cpu_table(int cpu)
 
 static cpumask_var_t		sd_sysctl_cpus;
 static struct ctl_table_header	*sd_sysctl_header;
+static int register_sched_domain_sysctl_on_boot = 1;
 
 void register_sched_domain_sysctl(void)
 {
@@ -344,9 +345,12 @@ void register_sched_domain_sysctl(void)
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
+	}
 
+	if (register_sched_domain_sysctl_on_boot) {
 		/* init to possible to not have holes in @cpu_entries */
 		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
+		register_sched_domain_sysctl_on_boot = 0;
 	}
 
 	for_each_cpu(i, sd_sysctl_cpus) {
-- 
2.20.1

