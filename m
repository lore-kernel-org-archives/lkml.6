Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71068C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F94C21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F94C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJIWQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:16:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:16:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99ExFje1081005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 07:59:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99ExF251081002;
        Tue, 9 Oct 2018 07:59:15 -0700
Date:   Tue, 9 Oct 2018 07:59:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-c3f7f2c7eba1a53d2e5ffbc2dcc9a20c5f094890@git.kernel.org>
Cc:     tglx@linutronix.de, riel@surriel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        luto@kernel.org
Reply-To: luto@kernel.org, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          riel@surriel.com, tglx@linutronix.de
In-Reply-To: <20180926035844.1420-4-riel@surriel.com>
References: <20180926035844.1420-4-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] smp: use __cpumask_set_cpu in on_each_cpu_cond
Git-Commit-ID: c3f7f2c7eba1a53d2e5ffbc2dcc9a20c5f094890
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c3f7f2c7eba1a53d2e5ffbc2dcc9a20c5f094890
Gitweb:     https://git.kernel.org/tip/c3f7f2c7eba1a53d2e5ffbc2dcc9a20c5f094890
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Tue, 25 Sep 2018 23:58:40 -0400
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:11 +0200

smp: use __cpumask_set_cpu in on_each_cpu_cond

The code in on_each_cpu_cond sets CPUs in a locally allocated bitmask,
which should never be used by other CPUs simultaneously. There is no
need to use locked memory accesses to set the bits in this bitmap.

Switch to __cpumask_set_cpu.

Cc: npiggin@gmail.com
Cc: mingo@kernel.org
Cc: will.deacon@arm.com
Cc: songliubraving@fb.com
Cc: kernel-team@fb.com
Cc: hpa@zytor.com
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180926035844.1420-4-riel@surriel.com
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d86eec5f51c1..a7d4f9f50a49 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -682,7 +682,7 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 		preempt_disable();
 		for_each_online_cpu(cpu)
 			if (cond_func(cpu, info))
-				cpumask_set_cpu(cpu, cpus);
+				__cpumask_set_cpu(cpu, cpus);
 		on_each_cpu_mask(cpus, func, info, wait);
 		preempt_enable();
 		free_cpumask_var(cpus);
