Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2561C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4C322ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4C322ACC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeGFV5I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:57:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35224 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeGFV5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:57:07 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbYir-0003ql-MH; Fri, 06 Jul 2018 17:57:01 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com, hpa@zytor.com
Subject: [PATCH v4 0/7] x86,tlb,mm: make lazy TLB mode even lazier
Date:   Fri,  6 Jul 2018 17:56:51 -0400
Message-Id: <20180706215658.18018-1-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song noticed switch_mm_irqs_off taking a lot of CPU time in recent
kernels, using 1.9% of a 48 CPU system during a netperf run. Digging
into the profile, the atomic operations in cpumask_clear_cpu and
cpumask_set_cpu are responsible for about half of that CPU use.

However, the CPUs running netperf are simply switching back and
forth between netperf and the idle task, which does not require any
changes to the mm_cpumask if lazy TLB mode were used.

Additionally, the init_mm cpumask ends up being the most heavily
contended one in the system, for no reason at all.

Making really lazy TLB mode work again on modern kernels, by sending
a shootdown IPI only when page table pages are being unmapped, we get
back some performance.

v4 of the series has a few minor cleanups; no functional changes since v3

On memcache workloads on 2 socket systems, this patch series seems
to reduce total system CPU use by 1-2%. On Song's netbench tests,
CPU use in the context switch time is about cut in half.

These patches also provide a little memory savings by shrinking
the size of mm_struct, especially on distro kernels compiled with
a gigantically large NR_CPUS.


