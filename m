Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69932C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178AA20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178AA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbeG1XWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:22:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44050 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731299AbeG1XWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:22:13 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjXA0-0000QZ-Hg; Sat, 28 Jul 2018 17:54:00 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, luto@kernel.org,
        x86@kernel.org, vkuznets@redhat.com, mingo@kernel.org,
        efault@gmx.de, dave.hansen@intel.com, will.daecon@arm.com,
        catalin.marinas@arm.com, benh@kernel.crashing.org
Subject: [PATCH 0/10] x86,tlb,mm: more lazy TLB cleanups & optimizations
Date:   Sat, 28 Jul 2018 17:53:47 -0400
Message-Id: <20180728215357.3249-1-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements the cleanups suggested by Peter and Andy,
removes lazy TLB mm refcounting on x86, and shows how other architectures
could implement that same optimization.

The previous patch series already seems to have removed most of the
cache line contention I was seeing at context switch time, so CPU use
of the memcache and memcache-like workloads has not changed measurably
with this patch series.

However, the memory bandwidth used by the memcache system has been
reduced by about 1%, to serve the same number of queries per second.

This happens on two socket Haswell and Broadwell systems. Maybe on
larger systems (4 or 8 socket) one might also see a measurable drop
in the amount of CPU time used, with workloads where the previous
patch series does not remove all cache line contention on the mm.

This is against the latest -tip tree, and seems to be stable (on top
of another tree) with workloads that do over a million context switches
a second.

