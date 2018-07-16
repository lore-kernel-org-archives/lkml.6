Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E5FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E210B208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E210B208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGPTc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:32:29 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36086 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeGPTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:32:29 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ff8ma-0003RH-Eg; Mon, 16 Jul 2018 15:03:40 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, efault@gmx.de, kernel-team@fb.com,
        mingo@kernel.org, dave.hansen@intel.com
Subject: [PATCH v6 0/7] x86,tlb,mm: make lazy TLB mode even lazier
Date:   Mon, 16 Jul 2018 15:03:30 -0400
Message-Id: <20180716190337.26133-1-riel@surriel.com>
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

v6 addresses the comment and Signed-off-by issues pointed out by Ingo.

On memcache workloads on 2 socket systems, this patch series seems
to reduce total system CPU use by 1-2%. On Song's netbench tests,
CPU use in the context switch time is about cut in half.

These patches also provide a little memory savings by shrinking
the size of mm_struct, especially on distro kernels compiled with
a gigantically large NR_CPUS.


